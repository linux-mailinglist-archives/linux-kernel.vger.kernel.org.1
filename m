Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36782A3154
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 18:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgKBRUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 12:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbgKBRUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:20:03 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64636C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 09:20:02 -0800 (PST)
Received: from zn.tnic (p200300ec2f086a00fa513bf50e741c79.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:6a00:fa51:3bf5:e74:1c79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9A57F1EC036C;
        Mon,  2 Nov 2020 18:20:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1604337600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uRfIFKTqbFjQdtD3KD5XPQvsfyUsfYoM6HmZVK91m0I=;
        b=qucR1wv8OHrPn75plR8Cl7p9nyJ253cjCTV/ClGU7BoOSTNNfIjQGGtXSqR8NuKs/kyTb3
        IAtUu/5evsMK12ofCkFO9NIDvDWOOQqzmwnrQJR6tOQDUNKEzbRiouW3AkDi1J2X/iNV8Z
        JQPYVcJzmDeiXHlTjHr/kJtcHauHwy4=
Date:   Mon, 2 Nov 2020 18:19:50 +0100
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
Message-ID: <20201102171950.GF15392@zn.tnic>
References: <20201019061803.13298-1-shuo.a.liu@intel.com>
 <20201019061803.13298-5-shuo.a.liu@intel.com>
 <20201102145657.GD15392@zn.tnic>
 <20201102160901.GU2672@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201102160901.GU2672@gate.crashing.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 10:09:01AM -0600, Segher Boessenkool wrote:
> I think that will work for x86_64.  But it won't matter much, most of
> the time you give an immediate number.

Yeah, my question is more along the lines of "is this constraint somehow
special, i.e., 'ir' (and not 'm') or can it be whatever, i.e., 'g'"?

> It is a tiny bit neater of course (if anyone still remembers what "g"
> is, you cannot use it much these days).

Oh I always remember what it is because it is right there in the docs:

"6.47.3.1 Simple Constraints

...

‘g’	Any register, memory or immediate integer operand is allowed,
	except for registers that are not general registers."

;-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
