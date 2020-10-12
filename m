Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A694828C24E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 22:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgJLU1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 16:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgJLU1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 16:27:04 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC47EC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:27:03 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id s7so18810064qkh.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xnzP63dYFUACzs4P/vR52kPPuEFcl8NjXjS4LexgAN0=;
        b=kCRS6a2wraeE1XpLHBCaFnj13617RReTZWkNSIHsYQ1rTzi7GEzyAAhUroMOZW+P3K
         WWGdmIiUyeOG8n34oAyZaEK+etuYx4CAskhtet3P6MSbh+EwfjHUP0auxzsuhZfyLdot
         eJZ8ZBNYEqYkf5pd7MU+K9p9BMG+840Gd2fqrFYNnDgFPfIO2JyulX8TtdKVlUcjrRBb
         U2AvlOJUj/O171r3wfjaST8UiRvp+/mLb66+Y6K4Mve2naeBQc6IA5OB1+/ICjzYm14P
         Wts3jBUpHpt627K9/3tdoTc9RhCe5I1/v3TPZX7MnPN5tox8gVYioPs3FZQph2dKbjRl
         dkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=xnzP63dYFUACzs4P/vR52kPPuEFcl8NjXjS4LexgAN0=;
        b=m2IAWi7UYCdAALhC+KPHEqp+pWudPsanl9wZoPTkgyZoC73/1XX9dvN0fd5s7pXO8E
         Jw2HFYq4S6e66UE5NgU+7nbLGChuTi1i+3JkdSdYDAtvycSEkleQspjqaHW58a2OXCzZ
         Stf2QfzKdgdgGgnFyxxfIwHi40AUmvojwIqRC0+xICOEW8uh7gmVrvKLRh7MhCf48kuE
         rwg7YFmPYtGmuxhAaFi5xbfd0RlAyMylKN36URW5wuurPdKMukx+VwTYree6LSysmsyH
         Rb9+eBVPQ295gY7R0BHzJHHRCGwwvv95Vwwx1/bEP18ap5MQzW7pdQy+SDOR42XPBB+e
         krjg==
X-Gm-Message-State: AOAM532OyojwTJNu1lRRM4YrEGltstLQwBr+uoBFXbWJtmREhhqAC+PQ
        mfrkj9/ZtjsYzVdsveiLkH8=
X-Google-Smtp-Source: ABdhPJzEe81p3SiRTNoMLlCHVLr8vJEM2JeDj7rsV5IWjWqabGtP2+CUJ8nFRjQzKQ1T5v6ZXJsY7w==
X-Received: by 2002:a05:620a:2054:: with SMTP id d20mr9405676qka.175.1602534422947;
        Mon, 12 Oct 2020 13:27:02 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id f3sm9338112qkl.134.2020.10.12.13.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 13:27:02 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 12 Oct 2020 16:27:00 -0400
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Borislav Petkov <bp@suse.de>, Uros Bizjak <ubizjak@gmail.com>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] x86/asm updates for v5.10
Message-ID: <20201012202700.GA818459@rani.riverdale.lan>
References: <20201012110557.GK25311@zn.tnic>
 <CAHk-=wiVoLoZS1v9SCQzH4mkpz6akE3pPrHPxM2hamOXPcaW9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiVoLoZS1v9SCQzH4mkpz6akE3pPrHPxM2hamOXPcaW9w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 11:11:35AM -0700, Linus Torvalds wrote:
> On Mon, Oct 12, 2020 at 4:06 AM Borislav Petkov <bp@suse.de> wrote:
> >
> > * Use XORL instead of XORQ to avoid a REX prefix and save some bytes in
> > the .fixup section, by Uros Bizjak.
> 
> I think this one is actually buggy.
> 
> For the 1-byte case, it does this:
> 
>      __get_user_asm(x_u8__, ptr, retval, "b", "=q");
> 
> and ends up doing "xorl" on a register that we told the compiler is a
> byte register (with that "=q")

It's not the "q", but the size of the l-value specified that tells the
compiler what to use. So x_u8__ does make it use a byte register, and it
would even with an "r" constraint. I think "q" is there only in case you
want to access the low byte of a bigger operand, to force the compiler
to use only a,b,c,d in 32-bit mode.

> 
> Yes, it uses "%k[output]" to turn that byte register into the word
> version of the register, but there's no fundamental reason why the
> register might not be something like "%ah".
> 
> Does the "xorl" work? Does it build? Yes, and yes.
> 
> But maybe %al contains SOMETHING ELSE, and it now clears that too,
> because the asm is basically doing something completely different than
> what we told the compiler it would do.
> 
> Now, afaik, gcc (and presumably clang) basically almost never use the
> high byte registers. But I still think this patch is fundamentally
> wrong and conceptually completely buggy, even if it might work in
> practice.
> 
> Also, I'm going to uninline this nasty __get_user() function anyway
> for 5.10, so the patch ends up being not just wrong, but pointless.
> This is not some kind of hot code that should be optimized, and the
> extra byte is not a lot to worry about.
> 
> Annoying. Because the other patch in this pull request is fine, and
> people want it.
> 
> But I'm going to skip this pull request, because I really think it's
> dangerously and subtly buggy even if there might not be any case that
> matters in reality.
> 
>                    Linus
