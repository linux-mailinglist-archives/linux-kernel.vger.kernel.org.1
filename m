Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D01267BAF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 19:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbgILRxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 13:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgILRw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 13:52:56 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C23C061573
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 10:52:54 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id v196so9584390pfc.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 10:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZJWVbxwmVf7uUMaGVZo3BQQo5Jazluk1UrwwdBjkHmw=;
        b=UZY2d137piTMNuzV/0Z6/oItnjEw6vMYBhwe5UuGuBoDKob/YtgyRScI5mwzKAO5HR
         /ZBbxn1P8Q7sj9Vu/IGbroiGGy37cCiE3u/0Kf02idM11eiQw9r2m6sSuLjoxr83KDUc
         CFQuzJcFIswTTCoie+1pw1b8+h2tH4B6I3HDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZJWVbxwmVf7uUMaGVZo3BQQo5Jazluk1UrwwdBjkHmw=;
        b=bNuGKm8PZM5K82zSU5t53pQ1fsE9hEADHPRuL8Ryo2lm/a/vDQpKCZWq6CophD8XJw
         pbC9OO1sPJjk9/NZDEOV6niUD66Lmg1P//EI9aVQxA6f2HrsgUKdNgVsAFNJc70AgaKS
         qK24DkOeFNlT5zef/1yY0PeRT3VJ7vQbZ6Djs5BnGzpmupFcx/4KKNvyNwDW7OeAwxbq
         t6kFLzBXJ/Nd1D+EgpV4Q3hEbr3Z2fBBdtCGFwFnez1iKnC/KofUqbtHPUj/ypJUSqj1
         D0n1Ic7poxArf7j0Tu/eqKbgvAQ3UH/yzy4S4s0ZIBFei5HXV9nVSzGqZrgAieq8tpVi
         GTLQ==
X-Gm-Message-State: AOAM532vLai6/gU4IeMvC032wkYoyhJNCi3uCVWxm0UfUg2+tjCsifLO
        1/wBwo3t6qhyyvRGDdAAcTM6N+vRIKy0fKrC
X-Google-Smtp-Source: ABdhPJzC47OY66VZNml98zJG7d2z5kBEYDA7V8eLk08i5s3CS4UCvsLzw29b4a9e4zEvyXGCgPedHA==
X-Received: by 2002:a63:4822:: with SMTP id v34mr5428240pga.342.1599933174294;
        Sat, 12 Sep 2020 10:52:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x9sm6106149pfj.96.2020.09.12.10.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 10:52:53 -0700 (PDT)
Date:   Sat, 12 Sep 2020 10:52:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        syzbot <syzbot+7ffc7214b893651d52b8@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, Andy Lutomirski <luto@kernel.org>
Subject: Re: WARNING in syscall_exit_to_user_mode
Message-ID: <202009121050.0D9CAB95@keescook>
References: <00000000000018a47605af074c7d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000018a47605af074c7d@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 03:39:19AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f4d51dff Linux 5.9-rc4
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12a4e7cd900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a9075b36a6ae26c9
> dashboard link: https://syzkaller.appspot.com/bug?extid=7ffc7214b893651d52b8
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122d7335900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13cea1a5900000
> 
> Bisection is inconclusive: the issue happens on the oldest tested release.
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=162247cd900000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=152247cd900000
> console output: https://syzkaller.appspot.com/x/log.txt?x=112247cd900000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+7ffc7214b893651d52b8@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> syscall 56 left IRQs disabled

This WARN appears reachable. :)

I also see on the dashboard these other problems with the new entry
code:

https://syzkaller.appspot.com/bug?extid=d4336c84ed0099fdbe47
https://syzkaller.appspot.com/bug?extid=c4af95386364bc59b13e

I can't tell if any of these have been looked at yet, though.

-- 
Kees Cook
