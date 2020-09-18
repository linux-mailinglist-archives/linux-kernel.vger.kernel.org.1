Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3143A2707AE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 23:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgIRVAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 17:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgIRVAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 17:00:53 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31FDC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 14:00:53 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id cy2so3704979qvb.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 14:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZJ8zmvc17bX9xj6+//ug0LM49mqv1RsrDk1L3tNk8ec=;
        b=iy16vZfUztyOxKq/IfHgI7kJQtwerpgo53nlcxG4i0DEjyExYJZzcnvYLRZ7dv41C/
         uaQhCPGAqENb++afLCD1je++48JWOwmrzYv5ZAFoyTwgXdm9/MfkK+nNwmlrqsPEUIFS
         zpCLZ5gN6euxSAl7cguwqsDnmWIOHXSTa7tWW9LroF3wpSYyN9+nqnEuCdJHyxsWH8b4
         B3L5cm6Ix6jRaOz5BL3uee+vaatoD1sR8m0nUX1jABVjFRbamQg1/5dhtEb+DPXQbdfa
         CXkwTnbSwjfJoV7dqbHFgbgUyf/wpRRr1YFNZiUoCyNmUm7jcQCOJ/xUpUVxo8z42uUm
         p+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ZJ8zmvc17bX9xj6+//ug0LM49mqv1RsrDk1L3tNk8ec=;
        b=nT3k7oD0Tml6S9O9a2xlvYPzCjVzidxMXSTkqoswdUc8T742etVV8/xpMXbfQcinm8
         e+pMQygpbflA1Me4p+dd1n7VW1hbH6DO860UBukmN2gTJJHbUlSMWaPTdqkV7DvWt36N
         ia6j52io/ancPAW+myEPU0x5MTVOlYOmWKdawK7V6KcAryacv9VknEng0yNF466mygz2
         F0WXD6uSL44soYXipvcOPLB8UZ3L+5lnkO9RTSPEYemnp/o/PQI3UbVpXDynkRISvXkL
         v0DZIpd3aKSayLJCm/rHaHCvj9hjazVpWwMsKIO3OU/XR/r2S4ujIRzGeOX0IH7anku1
         BKRg==
X-Gm-Message-State: AOAM532UNq7l4gWi80CxCT6iFVI3C71ZIm3yFPOpZuquDRE/l+gHxIzH
        VTXkhB76vH/iohTS/3Ch/m0=
X-Google-Smtp-Source: ABdhPJzjxkT9OR9uM81+L5YyaGQDJOqg7HbRZA/dBjiHRdtdxqwZ4ZxPjLW83OKSBGbwtd/RgqjGbA==
X-Received: by 2002:a0c:8246:: with SMTP id h64mr19332976qva.54.1600462852729;
        Fri, 18 Sep 2020 14:00:52 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id y69sm2877429qkb.52.2020.09.18.14.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 14:00:52 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 18 Sep 2020 17:00:50 -0400
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [GIT PULL] percpu fix for v5.9-rc6
Message-ID: <20200918210050.GA2953017@rani.riverdale.lan>
References: <20200917204514.GA2880159@google.com>
 <CAHk-=whXpv0KJvpL153dhUaRgSjzT8H4dD85hRw-fAwXvXnKAA@mail.gmail.com>
 <20200918162305.GB25599@embeddedor>
 <CAHk-=wjH+OH08yjp=LpexkUnGp0Ogusk3WX0G7Q+Lh7Anfr21A@mail.gmail.com>
 <20200918193426.GA15213@embeddedor>
 <CAHk-=wg=vvSf3M9O1VkwyYB4D4W6XS2AHVpQn6hEQY+usWrKGg@mail.gmail.com>
 <20200918200252.GH32101@casper.infradead.org>
 <CAHk-=wiNjJGhAMBwYixwkADpNharvcuOG-AMCdii1q_Xo_Ky_A@mail.gmail.com>
 <20200918202909.GA2946008@rani.riverdale.lan>
 <CAHk-=wh-ryuY7KBNWr1n+kgQ5_CHB3-X+od-djBV4W-1kQFokA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wh-ryuY7KBNWr1n+kgQ5_CHB3-X+od-djBV4W-1kQFokA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 01:40:44PM -0700, Linus Torvalds wrote:
> On Fri, Sep 18, 2020 at 1:29 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > In general (i.e. outside the implementation of the macro itself), what
> > is the preferred way of getting the size of just the header?
> >   1) offsetof(typeof(s),flex)
> >   2) struct_size(s, flex, 0)
> 
> I think those two should end up being equivalent.

Yeah, but it would be good to standardize on one of them.

> 
> >   3) sizeof(s)
> 
> This works right now, but exactly *because* it works, we're not seeing
> the questionable cases.
> 
> Of course, _also_ exactly because it just silently works, I also don't
> know if there may be thousands of perfectly fine uses where people
> really do want the header, and a "sizeof()" is simpler than
> alternatives 1-2.
> 
> It's possible that there really are a lot of "I want to know just the
> header size" cases. It sounds odd, but I could _imagine_ situations
> like that, even though no actual case comes to mind.

I'm asking because I just added an instance of (3) and want to know if I
should change it :)

The case was when you have a function that got passed a pointer and a
size, and wants to verify that the size covers the structure before
accessing its fields. If the function only needs the "fixed" fields, it
feels a little unnatural to use (1) or (2) when the flex member is
otherwise not going be accessed at all.

> 
> >   4) new macro that's easier to read than 1 or 2, but makes it clear
> >      what you're doing?
> 
> I don't think this would have any real advantage, would it?

The advantage is documenting that you do mean the header size, i.e.
something like struct_header_size(s).

> 
> Now what might be good is if we can make "struct_size()" also actually
> verify that the member that is passed in is that last non-sized
> member. I'm not sure how to do that.
> 
> I know how to check that it's *not* that last unsized member (just do
> "sizeof(s->flex)", and it should error), but I don't see how to assert
> the reverse of that).
> 
> Because that kind of "yes, we actually pass in the right member" check
> would be good to have too.
> 
>               Linus

You could just assert that offsetof(typeof(s),flex) == sizeof(s), no? It
would also make sure that someone doesn't try to use struct_size() with
a 1-sized array member.
