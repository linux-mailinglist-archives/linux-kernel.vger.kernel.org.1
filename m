Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441B42A4BD1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 17:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgKCQot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 11:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbgKCQos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 11:44:48 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB42C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 08:44:48 -0800 (PST)
Received: from zn.tnic (p200300ec2f10e0004a3cb1c0cad06673.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:e000:4a3c:b1c0:cad0:6673])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7CB6C1EC0409;
        Tue,  3 Nov 2020 17:44:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1604421886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kHPovhnqHMCTcejBo7y2+nKdhZ/uufKL0+QgRoVLm1o=;
        b=fYLPfMpZZpNMzYJMvxXKGVD16IOdbDW8fYrFFh5Wer1NRFTI3CWSlOCYIEfUWE0ycHytyC
        cl71XJCRFW4y/dIl7DEsAl9s8/LzzOnBZxnuwbw+KocdYmsTZAeB8hpd8RHNy02aISviCR
        cq+k0i6g2DbNYYnfnqc3bZBg9KvUYzA=
Date:   Tue, 3 Nov 2020 17:44:35 +0100
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
Message-ID: <20201103164435.GB4111@zn.tnic>
References: <20201019061803.13298-1-shuo.a.liu@intel.com>
 <20201019061803.13298-5-shuo.a.liu@intel.com>
 <20201102145657.GD15392@zn.tnic>
 <20201102160901.GU2672@gate.crashing.org>
 <20201102171950.GF15392@zn.tnic>
 <20201102181000.GX2672@gate.crashing.org>
 <20201102183430.GG15392@zn.tnic>
 <20201102200113.GY2672@gate.crashing.org>
 <20201102225439.GI15392@zn.tnic>
 <20201102231809.GC2672@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201102231809.GC2672@gate.crashing.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 05:18:09PM -0600, Segher Boessenkool wrote:
> That is invalid actually: local register asm as input to an inline asm
> should use *that* register!
> 
> This is all correct until LRA ("reload").  Not that "movl %xmm0,$eax"
> works, but at least it screams its head off, as it should.

Screams how?

It builds fine without a single peep with -Wall here.

Btw, that's a MOVD - not a MOVL. MOVD can do xmm -> gpr moves. And
singlestepping it with gdb does, well, something, which is clearly
wrong but nothing complains:

=> 0x555555555131 <main+12>:    movd   %xmm0,%eax

and %xmm0 has:

(gdb) p $xmm0
$2 = {v4_float = {0.99000001, 0, 0, 0}, v2_double = {5.2627153433055495e-315, 0}, v16_int8 = {-92, 112, 125, 63, 
		  ^^^^^^^^^^

so that is correct.

    0 <repeats 12 times>}, v8_int16 = {28836, 16253, 0, 0, 0, 0, 0, 0}, v4_int32 = {1065185444, 0, 0, 0}, v2_int64 = {
    1065185444, 0}, uint128 = 1065185444}

Then:

movd   %xmm0,%eax
rax            0x3f7d70a4

and that's the hex representation of the 0.99 float.

and that same value goes into %r8d:

mov    %eax,%r8d
r8             0x3f7d70a4

:-)

> Yes.  But GCC doing what you should have said instead of doing what you
> said, is not good.

Oh well, should I open a low prio bug, would that help?

I probably should test with the latest gcc first, though...

> Now if only we had time to document what we wrote!  We *do* write docs
> to go with new code (maybe not enough always), but no one spends a lot
> of time on documenting the existing compiler, or with a larger view than
> just a single aspect of the compiler.  Alas.

The problem every big project has.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
