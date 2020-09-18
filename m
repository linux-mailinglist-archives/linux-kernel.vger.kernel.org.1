Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B14270734
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 22:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgIRUlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 16:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgIRUlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 16:41:03 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C87DC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 13:41:03 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id a19so7612079ilq.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 13:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zQJsMUBUH1rRWO3srepDjolJw233J5qBV1esDpsMte0=;
        b=Ucxy8AMpaTBz1vIbcCX1grgPVCFNbATgxM5UumcQAyP06cFkZzWPmHVwfLh7iIY0XN
         5aKj2UZ2jXFEdHPMpXsQfftNcVbI26Q3YGly9XUChwPeu4mi/qcH2q3EgG9EI/fxCS9v
         3yiYpw2C8TNlrT1Sw8d28NTCKS0ybLuACCd1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zQJsMUBUH1rRWO3srepDjolJw233J5qBV1esDpsMte0=;
        b=o6Yhl5B9P35tBNOmnERoOEgKXjUrRk4PlKLuFJ/5U4uN/2lJJooNR0JZXw3vefzE3L
         BLOLjV+AmgeFl0Gv3rS7RNV/QrNaA59i9OXsv/pqxDbpEUFrIvKEpYjbNVh31aXCdt8V
         Gl8SIT6xcTVqdnaOUoxVNauAGFpVWtytXKz0YSaxELSTpelssj742vR52pbXGxNlwehA
         Mlxkt/WPMimmetH10+jLIG3EMK3G/sYr1knfDSuum4XPSjfM3kpBcHHh4YIuB9UZTwLj
         enjRSF/2YqWE1WbDmdpXMIaQDiNvfVcs42bu4373PK7R3ggbs01Ca407/OfVKrK30Zqu
         nOhg==
X-Gm-Message-State: AOAM532eRWz1cYfbAvNVgYGdLq9U+B71cXQQDkAAnH18NGoAwYgSr8rN
        rIUuQ+9YX3KVUGV+sz9Us/9DpzG24D7+rg==
X-Google-Smtp-Source: ABdhPJxzSBtxqAjCi7jMklowysMlSXbiZDNoRGL8bokMWNDPWmURfGZ/+0y6CZ/enw7LJYTN8TrjxA==
X-Received: by 2002:a05:6e02:bd4:: with SMTP id c20mr13773651ilu.138.1600461661997;
        Fri, 18 Sep 2020 13:41:01 -0700 (PDT)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com. [209.85.166.53])
        by smtp.gmail.com with ESMTPSA id f22sm930856ilf.56.2020.09.18.13.41.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2020 13:41:00 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id g7so8379881iov.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 13:41:00 -0700 (PDT)
X-Received: by 2002:a6b:7717:: with SMTP id n23mr29111497iom.151.1600461660527;
 Fri, 18 Sep 2020 13:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200917204514.GA2880159@google.com> <CAHk-=whXpv0KJvpL153dhUaRgSjzT8H4dD85hRw-fAwXvXnKAA@mail.gmail.com>
 <20200918162305.GB25599@embeddedor> <CAHk-=wjH+OH08yjp=LpexkUnGp0Ogusk3WX0G7Q+Lh7Anfr21A@mail.gmail.com>
 <20200918193426.GA15213@embeddedor> <CAHk-=wg=vvSf3M9O1VkwyYB4D4W6XS2AHVpQn6hEQY+usWrKGg@mail.gmail.com>
 <20200918200252.GH32101@casper.infradead.org> <CAHk-=wiNjJGhAMBwYixwkADpNharvcuOG-AMCdii1q_Xo_Ky_A@mail.gmail.com>
 <20200918202909.GA2946008@rani.riverdale.lan>
In-Reply-To: <20200918202909.GA2946008@rani.riverdale.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Sep 2020 13:40:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh-ryuY7KBNWr1n+kgQ5_CHB3-X+od-djBV4W-1kQFokA@mail.gmail.com>
Message-ID: <CAHk-=wh-ryuY7KBNWr1n+kgQ5_CHB3-X+od-djBV4W-1kQFokA@mail.gmail.com>
Subject: Re: [GIT PULL] percpu fix for v5.9-rc6
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 1:29 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> In general (i.e. outside the implementation of the macro itself), what
> is the preferred way of getting the size of just the header?
>   1) offsetof(typeof(s),flex)
>   2) struct_size(s, flex, 0)

I think those two should end up being equivalent.

>   3) sizeof(s)

This works right now, but exactly *because* it works, we're not seeing
the questionable cases.

Of course, _also_ exactly because it just silently works, I also don't
know if there may be thousands of perfectly fine uses where people
really do want the header, and a "sizeof()" is simpler than
alternatives 1-2.

It's possible that there really are a lot of "I want to know just the
header size" cases. It sounds odd, but I could _imagine_ situations
like that, even though no actual case comes to mind.

>   4) new macro that's easier to read than 1 or 2, but makes it clear
>      what you're doing?

I don't think this would have any real advantage, would it?

Now what might be good is if we can make "struct_size()" also actually
verify that the member that is passed in is that last non-sized
member. I'm not sure how to do that.

I know how to check that it's *not* that last unsized member (just do
"sizeof(s->flex)", and it should error), but I don't see how to assert
the reverse of that).

Because that kind of "yes, we actually pass in the right member" check
would be good to have too.

              Linus
