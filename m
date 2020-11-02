Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C77A2A3313
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 19:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgKBSen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 13:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgKBSel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 13:34:41 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FDBC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 10:34:41 -0800 (PST)
Received: from zn.tnic (p200300ec2f086a00fa513bf50e741c79.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:6a00:fa51:3bf5:e74:1c79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 091CF1EC0249;
        Mon,  2 Nov 2020 19:34:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1604342079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6gyIuFjrxWqj7ZZQ8QrJgmiKLdEe27h5YwOXM77j2B0=;
        b=Y5tPVUz30nIF1a/NLWGSYuzdeEtjRmjfIS2zr2mOfn/90LLk8rG/+Ei3EmriT1pnznuP+E
        VFRKV8Q/7a0W8zWjD9XKIzjLdPr187+Z7Ok0wRqv7i9bMJ8bl8C+FqbXT6rjs6kNOsOHCa
        nm3xYADoRBvHTFpZQXKmQZ/gh6WTpPM=
Date:   Mon, 2 Nov 2020 19:34:30 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     shuo.a.liu@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Yakui Zhao <yakui.zhao@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengwei Yin <fengwei.yin@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v5 04/17] x86/acrn: Introduce hypercall interfaces
Message-ID: <20201102183430.GG15392@zn.tnic>
References: <20201019061803.13298-1-shuo.a.liu@intel.com>
 <20201019061803.13298-5-shuo.a.liu@intel.com>
 <20201102145657.GD15392@zn.tnic>
 <20201102160901.GU2672@gate.crashing.org>
 <20201102171950.GF15392@zn.tnic>
 <20201102181000.GX2672@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201102181000.GX2672@gate.crashing.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 12:10:00PM -0600, Segher Boessenkool wrote:
> movl works for moving anything g->r.

Right.

> This is not true for most insns, and not for most architectures at
> all (usually loading from memory has a separate mnemonic; moving an
> immediate number often as well (and it does not usually allow *every*
> immediate anyway, not even all numbers!)

So I've heard from other architectures. Every arch has its own problems.
:-)

> Most people do not read the documentation, they just copy from (bad)
> examples (and arguably, any example you do not really understand is a
> bad example).

Unfortunately.

> (It does not allow *all* memory and *all* constants, btw...  And the
> condition for registers is not really "general register", whatever that
> means...

I think that means general purpose registers. I.e., it won't use, say
FPU, XMM or whatever special regs.

What does the asm() parsing code in gcc do for "g"? There should be
some logic which constraints what register is valid...

> I hope no one ever told you our documentation does not have white
> lies!)

I have convinced myself of this a couple of times already so I either go
ask our gcc friends or go look straight at gcc source. It is useful to
know folks which hack on it so that I can ask them stupid questions and
not go off into the weeds, trying to figure out what the documentation
says.

But hey, if that gets the documentation improved, that's a win-win
situation right there. Might even make people copying from bad examples
to go look at the docs first...

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
