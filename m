Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514F128BF71
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 20:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404157AbgJLSL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 14:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730322AbgJLSLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 14:11:55 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7675AC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 11:11:55 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id a9so19277180lfc.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 11:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=APvCR81d2hsCRE8d93iR5IJ6VoWmDP6Sd07Qtx7ztAY=;
        b=ajA6jGFD1565DLMI9D7lePL4+erBlXYH85Kb8ZIKS24mHntwKMM2MNwB+Bk43dV0J/
         Z4uwxRRP2mU2qpcp8tGxyq+ja7Xgq8yQVEigbbjwTeNASrTyUiYD95F6DbH7duMnpbU6
         QGa6k+bTMqNOi/QQDOgDAnwsRMEfkBE/942GM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=APvCR81d2hsCRE8d93iR5IJ6VoWmDP6Sd07Qtx7ztAY=;
        b=VSc/haBMXeFSiqT+9xHeeJ84XJXbalRIVmQgFZdiYLeR4dinnrTugXk7RMUNOfvu3F
         LKCZRZsVWPGh19yAH6ufKxV2P/t2o9oFoSBzB8p1/YfHwreVTfUB/hTxQx75jKGrFYnh
         ljzSi9XhRShibF2HvSguHjvwimh1pJn0aR3FGnpUtc33nEelO9IDjEKg0kTsKW6bOeWg
         h3wf/vVTwIV7589yt+MIYEgdswl4jYXIKLfyreQbrVrRI6DiLI2j/AUKA45jPLrMB+YL
         NHxRppToVjFb46ttG6jvsakqBs/sTOFhijvU+m9N+acD6EogesnwyvBH9VGXJWcAKlBY
         p61w==
X-Gm-Message-State: AOAM533tJWgPmT5vsVKdDCSrNRnYtSdIEB7ykJxyDvRhzGG3+XUoK0lq
        /6GKTDZzZuC/dSzt5XvMw56oEMbAM9pQbg==
X-Google-Smtp-Source: ABdhPJxieFN+G/UCDa7fFOdvQcfv6sSph91eGi5+zDmpxVIuoY9i8qoZN0ZwdwPlAAnZ4kZEmK629g==
X-Received: by 2002:a05:6512:3b1:: with SMTP id v17mr7982622lfp.262.1602526313261;
        Mon, 12 Oct 2020 11:11:53 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id m132sm2104913lfa.34.2020.10.12.11.11.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 11:11:51 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id a7so18187736lfk.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 11:11:51 -0700 (PDT)
X-Received: by 2002:ac2:5f48:: with SMTP id 8mr2531215lfz.344.1602526311213;
 Mon, 12 Oct 2020 11:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <20201012110557.GK25311@zn.tnic>
In-Reply-To: <20201012110557.GK25311@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Oct 2020 11:11:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVoLoZS1v9SCQzH4mkpz6akE3pPrHPxM2hamOXPcaW9w@mail.gmail.com>
Message-ID: <CAHk-=wiVoLoZS1v9SCQzH4mkpz6akE3pPrHPxM2hamOXPcaW9w@mail.gmail.com>
Subject: Re: [GIT PULL] x86/asm updates for v5.10
To:     Borislav Petkov <bp@suse.de>, Uros Bizjak <ubizjak@gmail.com>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 4:06 AM Borislav Petkov <bp@suse.de> wrote:
>
> * Use XORL instead of XORQ to avoid a REX prefix and save some bytes in
> the .fixup section, by Uros Bizjak.

I think this one is actually buggy.

For the 1-byte case, it does this:

     __get_user_asm(x_u8__, ptr, retval, "b", "=q");

and ends up doing "xorl" on a register that we told the compiler is a
byte register (with that "=q")

Yes, it uses "%k[output]" to turn that byte register into the word
version of the register, but there's no fundamental reason why the
register might not be something like "%ah".

Does the "xorl" work? Does it build? Yes, and yes.

But maybe %al contains SOMETHING ELSE, and it now clears that too,
because the asm is basically doing something completely different than
what we told the compiler it would do.

Now, afaik, gcc (and presumably clang) basically almost never use the
high byte registers. But I still think this patch is fundamentally
wrong and conceptually completely buggy, even if it might work in
practice.

Also, I'm going to uninline this nasty __get_user() function anyway
for 5.10, so the patch ends up being not just wrong, but pointless.
This is not some kind of hot code that should be optimized, and the
extra byte is not a lot to worry about.

Annoying. Because the other patch in this pull request is fine, and
people want it.

But I'm going to skip this pull request, because I really think it's
dangerously and subtly buggy even if there might not be any case that
matters in reality.

                   Linus
