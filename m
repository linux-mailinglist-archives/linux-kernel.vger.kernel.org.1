Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16171270807
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 23:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgIRVSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 17:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgIRVSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 17:18:41 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE52C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 14:18:41 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id y4so6189888ljk.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 14:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gW6J35G/dtu0lRot+wO7D3GCux7aBPJGLPsj5jdXvLs=;
        b=W1aGW+4WsnUDs5fIzfvjirVNDuNgVOe3fbcpZi2dJFxkGtB34cLeAmrt80m2ID1Cgh
         hIAiqxJtsgOTRL/viG7eHS9Jb5RikD31JBg+iMpW5RMI+3vi47F4dTpblCfHkay/Zg2W
         T8IVoonLN7ONYTh6VrIvQGHNmvSWJGbRgHOGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gW6J35G/dtu0lRot+wO7D3GCux7aBPJGLPsj5jdXvLs=;
        b=tGVPPj73DvitV9pW4ycMWOPxX0s8UF1NH3Vp6wcaQFY5Ke9UGUQYfLTYZyEjeLELl1
         QOuLstkm+uKrQPmnYS5Tq4x5x6GRlSp26Uk6xR6pnjTxVliXbLr+sPYZtlMPcWgPQ6F4
         tyTqSMp/3coKTksHFF/Xb4PXveUm3HqFQucuqHzuaU5q7qX0pePuPes/Oca5+hQ059ru
         X2zzCxlT4wU03gJxW/GtGdRfNOObAipzsHYyvisWJFCm7G8KUxKDf/V8mYhyPe3LEksR
         h6vkFJnpNbUMWOKSwecZS37M81v7syXwrDReUmrgJiIHUcrjfm5IniO2D2upcIWrZN/G
         mZzg==
X-Gm-Message-State: AOAM532G3yHB8O3gD/4EWCEQCbbKmhjPNInPBsfkhh96lJJ3ld9Cuev/
        eV+W8Va8rUFQWsHhZHhEs6tQnR9OtZLfCQ==
X-Google-Smtp-Source: ABdhPJw8N1pwI1R9c7FxFuYQGDMZ+GA2rAD1STuhAnbne6GW79AQm+4guyE6uim7pT7WUvkpMbEWeA==
X-Received: by 2002:a2e:9a4a:: with SMTP id k10mr11616937ljj.355.1600463918676;
        Fri, 18 Sep 2020 14:18:38 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id v25sm826840ljh.102.2020.09.18.14.18.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2020 14:18:37 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id q8so7592218lfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 14:18:37 -0700 (PDT)
X-Received: by 2002:ac2:4a6a:: with SMTP id q10mr10536957lfp.534.1600463916853;
 Fri, 18 Sep 2020 14:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200917204514.GA2880159@google.com> <CAHk-=whXpv0KJvpL153dhUaRgSjzT8H4dD85hRw-fAwXvXnKAA@mail.gmail.com>
 <20200918162305.GB25599@embeddedor> <CAHk-=wjH+OH08yjp=LpexkUnGp0Ogusk3WX0G7Q+Lh7Anfr21A@mail.gmail.com>
 <20200918193426.GA15213@embeddedor> <CAHk-=wg=vvSf3M9O1VkwyYB4D4W6XS2AHVpQn6hEQY+usWrKGg@mail.gmail.com>
 <20200918200252.GH32101@casper.infradead.org> <CAHk-=wiNjJGhAMBwYixwkADpNharvcuOG-AMCdii1q_Xo_Ky_A@mail.gmail.com>
 <20200918202909.GA2946008@rani.riverdale.lan> <CAHk-=wh-ryuY7KBNWr1n+kgQ5_CHB3-X+od-djBV4W-1kQFokA@mail.gmail.com>
 <20200918210050.GA2953017@rani.riverdale.lan>
In-Reply-To: <20200918210050.GA2953017@rani.riverdale.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Sep 2020 14:18:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgyKF9vnac3mw6v-Bo5D8X-rcrkF=BsZ2jX+OveGkGgBw@mail.gmail.com>
Message-ID: <CAHk-=wgyKF9vnac3mw6v-Bo5D8X-rcrkF=BsZ2jX+OveGkGgBw@mail.gmail.com>
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

On Fri, Sep 18, 2020 at 2:00 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> You could just assert that offsetof(typeof(s),flex) == sizeof(s), no?

No, because the whole point is that I want that "sizeof(s)" to *WARN*.

It's a nonsensical thing to do. That 's' has no statically known size.

The C standard is being very confused here, in that it tries to claim
that the flexible arrays are somehow fundamentally different from a
zero-sized one. But then it acts as if they are exactly the same wrt
sizeof() and structure copies.

It should warn, exactly because right now it causes potential bugs
like the one that started this thread.

You can't have both "zero-sized arrays are bad and shouldn't be used"
and "flexible arrays are good, and work exactly like zero-sized
arrays".

Either zero-sized arrays are bad or they aren't. And if they are bad,
then flexible arrays shouldn't work *exactly* like them apart from
some UBSAN warnings.

See my point?

             Linus
