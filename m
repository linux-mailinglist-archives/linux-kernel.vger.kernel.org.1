Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2241B4F5A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 23:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgDVV0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 17:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgDVV0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 17:26:11 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C620C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 14:26:11 -0700 (PDT)
Received: from zn.tnic (p200300EC2F0DC10035D7F52705C6D57D.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:c100:35d7:f527:5c6:d57d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7B2511EC0D10;
        Wed, 22 Apr 2020 23:26:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1587590769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=X97GDs7zUOOEwi+VzwvV8BMbJR1hFYVTTX0qpebTCh0=;
        b=ErRlwMxXmkcWC7xLafWBUtoif4ZttGvQ0ELm/XvU5Z891wTqTziknSEADz8tUwlEeYGBPz
        D0qCO31lhiMMXfdNuBKxujfuzKrtg6VnjdWCIAhJ25oA3Lm7ZkrjSr5h/OY6/DcC5rLZU9
        o2Y9HvznpSD/GLbk6z3Pghskc1C3+i8=
Date:   Wed, 22 Apr 2020 23:26:05 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Michael Matz <matz@suse.de>, Jakub Jelinek <jakub@redhat.com>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] x86: fix early boot crash on gcc-10
Message-ID: <20200422212605.GI26846@zn.tnic>
References: <20200417090909.GC7322@zn.tnic>
 <CAKwvOdnFXPBJsAUD++HtYS5JiR2KmX73M5GAUe-tvX-JYV7DaA@mail.gmail.com>
 <CAKwvOdmNwNwa6rMC27-QZq8VDrYdTQeQqss-bAwF1EMmnAHxdw@mail.gmail.com>
 <20200417190607.GY2424@tucnak>
 <CAKwvOdkkbWgWmNthq5KijCdtatM9PEAaCknaq8US9w4qaDuwug@mail.gmail.com>
 <alpine.LSU.2.21.2004201401120.11688@wotan.suse.de>
 <20200422102309.GA26846@zn.tnic>
 <CAKwvOd=Dza3UBfeUzs2RW6ko5fDr3jYeGQAYpJXqyEVns6DJHg@mail.gmail.com>
 <20200422192113.GG26846@zn.tnic>
 <CAKwvOdkbcO8RzoafON2mGiSy5P96P5+aY8GySysF2my7q+nTqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdkbcO8RzoafON2mGiSy5P96P5+aY8GySysF2my7q+nTqw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 02:05:13PM -0700, Nick Desaulniers wrote:
> s/functions/statements/
> or
> s/functions/function calls/
> 
> Sorry to be pedantic and bikeshed a comment! *ducks*

Yeah, you beter duck! :-P

> With that you can add my:
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Ok ok, will fix.

> Filed: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=94722
> (Maybe a link to that might be helpful in the comment, for future
> travelers? But I don't feel strongly about that either way, and
> trust+defer to your judgement).

Here's an answer to that, also from upthread:

https://lkml.kernel.org/r/20200316180303.GR2156@tucnak

Btw lore.kernel.org has this cool mbox.gz feature:

https://lore.kernel.org/lkml/20200316180303.GR2156@tucnak/t.mbox.gz

This way, you can grep the whole thread, open it with a proper mail
program etc. Very useful for catching up on threads.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
