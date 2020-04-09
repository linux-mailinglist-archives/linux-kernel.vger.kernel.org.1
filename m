Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 544451A3B0F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 22:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgDIUEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 16:04:55 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33665 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgDIUEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 16:04:55 -0400
Received: by mail-lj1-f194.google.com with SMTP id q22so1091445ljg.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 13:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uNxSVyIGdaSTr0lywTyA2DSe6ffIyDbX6ysZP8sCQHU=;
        b=VHdaI9F2b94QbcEW3FTvBCL1X8t5Kxv3xHYG1y/drJJib7CVtztF9I6Na7ybMVJ827
         u5LxYnpsHzUd6oa4D6rh0TGzUqKsASlIAeq8+IIshnJ+XRaDMSMBTMcSjsclg32h+X9h
         0P8y05H/E0Y5AgTPYk48DrvCyc6FnUlPR197g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uNxSVyIGdaSTr0lywTyA2DSe6ffIyDbX6ysZP8sCQHU=;
        b=VqKTYCx+wPFklX0HcFkqb7HPeHBLc+2deCjShrTTEe02LPtclAuVpyO+YVyNxJfpJo
         edcVidfnghTiByOdQakxcuC8JuJ5VJU54oEcIl1veLfPpJDK1nBO2r5jVBsC7tID4Sk6
         3k74ww9v+weNj1c8ls/LtWtg9FU6GxwFJhDpwccf+q0FN49yxZwBAw6ZCdPp1SCoae8U
         Bxlalv9Gy4gkBLslVuGGEdWtJ3ZePybp4/IsVdfBZzmvr3+unTbF084snZ71pLkL6C5d
         viW4+sQQK0Krc0PNXs0wtNsLw8c60wxfncFey0w9XQVP111XILvPGrZaS+wep3z65wNw
         23iA==
X-Gm-Message-State: AGi0PuYg9hfC+xpd2haX1UODoy/DsFAVJUGeOyWf1tiXc0yRx2x2JB5f
        U3/DbtLXw7h7THV+R+cId1kfKDxK3eo=
X-Google-Smtp-Source: APiQypJXbrR+vfhaiNbPFr4/CDiS/fcSb/42l7wJyZoFDdnz+2RJQiRF8pnN5BJGRB3RQ8a1hc7NiQ==
X-Received: by 2002:a2e:9c4:: with SMTP id 187mr903993ljj.89.1586462692438;
        Thu, 09 Apr 2020 13:04:52 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id 83sm46345lfn.30.2020.04.09.13.04.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 13:04:51 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id r24so1060245ljd.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 13:04:51 -0700 (PDT)
X-Received: by 2002:a2e:8652:: with SMTP id i18mr922513ljj.265.1586462690881;
 Thu, 09 Apr 2020 13:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <87blobnq02.fsf@x220.int.ebiederm.org> <87lfnda3w3.fsf@x220.int.ebiederm.org>
 <CAHk-=wjxyGCj9675mf31uhoJCyHn74ON_+O6SjSqBSSvqWxC1Q@mail.gmail.com>
 <87blo45keg.fsf@x220.int.ebiederm.org> <CAHk-=whES-KCO6Bs93-QBK1tS5CfiWSi+v5D1a7Sc1TD5RFoaA@mail.gmail.com>
 <87v9maxb5q.fsf@x220.int.ebiederm.org> <CAHk-=wih4BqW7GTLaYxewynuT-iFHrXroip0wNo0CyPtmYGUow@mail.gmail.com>
 <87y2r4so3i.fsf@x220.int.ebiederm.org> <CAHk-=wjhAvv6s_7OVeZJiHaY7bBrHyiPTkSpq-TLr6qxYqxUUw@mail.gmail.com>
 <CAHk-=wi0jrKv9x6vJ9FDgTrSUbdbZYDX-79T-E87C48MGSn5=g@mail.gmail.com>
 <87wo6or3pg.fsf@x220.int.ebiederm.org> <AM6PR03MB51708FD4226E07AB7CB0D6A7E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wjaoYM4gXdAyYY=u8PaYj2LXUvcfp=8DKum8f1DM+Ws0A@mail.gmail.com>
 <AM6PR03MB5170F924EA69A81D79BD0929E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whMKC5F-=QQP=fCNRuTF+ZGiNtLEKvx7KekpK1JtrwDhw@mail.gmail.com>
 <CAHk-=whJ8khGBqfqh6ZmHsKjcyyBLm5xgkgLW_AC_=82iFBWoQ@mail.gmail.com> <AM6PR03MB51700B243E34BF4A59FF33CFE4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB51700B243E34BF4A59FF33CFE4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Apr 2020 13:04:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
Message-ID: <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 9, 2020 at 12:57 PM Bernd Edlinger
<bernd.edlinger@hotmail.de> wrote:
>
> The use case where this may happen with strace
> when you call strace with lots of -p <pid> arguments,
> and one of them is a bomb. strace stuck.

Yeah, so from a convenience angle I do agree that it would be nicer to
just not count dead threads.

You can test that by just moving the

                /* Don't bother with already dead threads */
                if (t->exit_state)
                        continue;

test in zap_other_threads() to above the

                count++;

line instead.

NOTE! That is *NOT* the correct true fix. I'm just suggesting that you
try if it fixes that particular test-case (I did not try it myself -
because .. lazy)

If Oleg agrees that we could take the approach that we can share a
signal struct with dead threads, we'd also need to change the
accounting to do that notify_count not when the signal struct is
unlinked, but when exit_state is first set.

I'm not convinced that's the right solution, but I do agree that it's
annoying how easily strace can get stuck, since one of the main uses
for strace is for debugging nasty situations.

                Linus
