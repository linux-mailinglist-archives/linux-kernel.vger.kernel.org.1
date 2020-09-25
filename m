Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D90C278F8F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 19:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbgIYRYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 13:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbgIYRYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 13:24:40 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C016C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 10:24:40 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0b3a00329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:3a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 907061EC03D2;
        Fri, 25 Sep 2020 19:24:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601054678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wsN5KaQFUeoGFENhkKTOGl0h1OOEIgB+lB2dmKG1Xtk=;
        b=TSze4ZThKnrQafsps8NRW/sc3xH7o5/MrIfiSewPfLm3BjHC3AcSBnxY3qSqxMsIzbFRVk
        mTqN5Fjgm1nO90lybQkBS/7FPAy+z0EOJqDdISpV7jXBvygPejU2XYSDqYhG4SKyFtC95A
        ttoRtszpt+ZVTPYVwK5IaxB/cTB9Phw=
Date:   Fri, 25 Sep 2020 19:24:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] tools/x86: add kcpuid tool to show raw CPU
 features
Message-ID: <20200925172437.GM16872@zn.tnic>
References: <1600752470-43179-1-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1600752470-43179-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 01:27:50PM +0800, Feng Tang wrote:
> +++ b/tools/arch/x86/kcpuid/cpuid.txt
> @@ -0,0 +1,58 @@
> +# Leaf 00H
> +
> +LEAF[00000000],SUBLEAF[00],EAX[ 31:0],max_basic_leafs, Max input value for supported subleafs
> +
> +
> +# Leaf 01H
> +
> +LEAF[00000001],SUBLEAF[00],EAX[  3:0],stepping, Stepping ID
> +LEAF[00000001],SUBLEAF[00],EAX[  7:4],model, Model
> +LEAF[00000001],SUBLEAF[00],EAX[ 11:8],family, Family ID
> +LEAF[00000001],SUBLEAF[00],EAX[13:12],processor, Processor Type
> +LEAF[00000001],SUBLEAF[00],EAX[19:16],model_ext, Extended Model ID
> +LEAF[00000001],SUBLEAF[00],EAX[27:20],family_ext, Extended Family ID

Yeah, this looks good but how about we simplify and ease the parsing
even more? I.e., make it a real csv:

# Table row names:
# LEAF,SUBLEAF,register_name,bits,short name, long name

0x1,0,EBX,7:0,brand,Brand Index
0x1,0,EBX,15:8,clflush_size,CLFLUSH line size (value * 8) in bytes
0x1,0,EBX,23:16,max_cpu_id,Maxim number of addressable logic cpu ID in this package
...

Yeah, this way it might not be as readable but the format is pretty simple and
everybody knows .csv so....

We can even do vertical alignment for better readability:

#     LEAF,SUBLEAF,register,  bits,short name, long name
         1,	 0,	EBX,   7:0,brand,Brand Index
         1,	 0,	EBX,  15:8,clflush_size,CLFLUSH line size (value * 8) in bytes
     	 1,	 0,	EBX, 23:16,max_cpu_id,Maxim number of addressable logic cpu ID in this package
0x80000000,	12,	EAX,     3,eee, EEE

and can keep it in tabellary form this way. The parsing code should
asimply split on ',' and ignore whitespace.

Thoughts?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
