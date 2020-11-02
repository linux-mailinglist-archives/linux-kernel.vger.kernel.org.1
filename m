Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3932A2D7B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgKBO5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgKBO5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:57:14 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DBBC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 06:57:13 -0800 (PST)
Received: from zn.tnic (p200300ec2f086a00a8f166ce5a4f9471.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:6a00:a8f1:66ce:5a4f:9471])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 36F051EC0304;
        Mon,  2 Nov 2020 15:57:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1604329031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Uj21yLNOOWDgKG84369bmD5RvFVamSFmduJiyx5/LGk=;
        b=S7FYYk9mQZ/USXWKims1X0pCrretNRgZeL0TsEt9dC+19m/zsTXx7N6jefwe9TN+AqR8vN
        38xm0DZOPBaXuAauavdFQuAblYf1Ep9Zzydfih9GADZ4p9PFkxkhqOv74XgximYk9btidA
        mJu9tugPorIIRLBzOv4gU1/8PUI0CUY=
Date:   Mon, 2 Nov 2020 15:56:57 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     shuo.a.liu@intel.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
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
        Nick Desaulniers <ndesaulniers@google.com>,
        Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v5 04/17] x86/acrn: Introduce hypercall interfaces
Message-ID: <20201102145657.GD15392@zn.tnic>
References: <20201019061803.13298-1-shuo.a.liu@intel.com>
 <20201019061803.13298-5-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201019061803.13298-5-shuo.a.liu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 02:17:50PM +0800, shuo.a.liu@intel.com wrote:
> +static inline long acrn_hypercall0(unsigned long hcall_id)
> +{
> +	long result;
> +
> +	asm volatile("movl %1, %%r8d\n\t"
> +		     "vmcall\n\t"
> +		     : "=a" (result)
> +		     : "ir" (hcall_id)
			^^

Not "irm"? Or simply "g" in that case?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
