Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D4827A840
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 09:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgI1HHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 03:07:39 -0400
Received: from mga11.intel.com ([192.55.52.93]:6365 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbgI1HHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 03:07:39 -0400
IronPort-SDR: D0N9pGVTQhF6KaycFVd8tbGxZypXzb+uuSy22fKoST4cwR/eq5yE7ZxTml6UHlEVzF4CjvdpV8
 dQgZuGSAZ8vw==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="159296060"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="159296060"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 00:07:34 -0700
IronPort-SDR: Qo7TQYM3g4SpETW39J5RkSSUvIcO8OSVY7xpvDFnp9/enQCqwwWV0HVcJ7TT1zCKNt27kkeHPS
 hfahxlNcm/8w==
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="488455940"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.107])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 00:07:29 -0700
Date:   Mon, 28 Sep 2020 15:07:23 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] tools/x86: add kcpuid tool to show raw CPU
 features
Message-ID: <20200928070723.GA25109@shbuild999.sh.intel.com>
References: <1600752470-43179-1-git-send-email-feng.tang@intel.com>
 <20200925172437.GM16872@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925172437.GM16872@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 07:24:37PM +0200, Borislav Petkov wrote:
> On Tue, Sep 22, 2020 at 01:27:50PM +0800, Feng Tang wrote:
> > +++ b/tools/arch/x86/kcpuid/cpuid.txt
> > @@ -0,0 +1,58 @@
> > +# Leaf 00H
> > +
> > +LEAF[00000000],SUBLEAF[00],EAX[ 31:0],max_basic_leafs, Max input value for supported subleafs
> > +
> > +
> > +# Leaf 01H
> > +
> > +LEAF[00000001],SUBLEAF[00],EAX[  3:0],stepping, Stepping ID
> > +LEAF[00000001],SUBLEAF[00],EAX[  7:4],model, Model
> > +LEAF[00000001],SUBLEAF[00],EAX[ 11:8],family, Family ID
> > +LEAF[00000001],SUBLEAF[00],EAX[13:12],processor, Processor Type
> > +LEAF[00000001],SUBLEAF[00],EAX[19:16],model_ext, Extended Model ID
> > +LEAF[00000001],SUBLEAF[00],EAX[27:20],family_ext, Extended Family ID
> 
> Yeah, this looks good but how about we simplify and ease the parsing
> even more? I.e., make it a real csv:
> 
> # Table row names:
> # LEAF,SUBLEAF,register_name,bits,short name, long name
> 
> 0x1,0,EBX,7:0,brand,Brand Index
> 0x1,0,EBX,15:8,clflush_size,CLFLUSH line size (value * 8) in bytes
> 0x1,0,EBX,23:16,max_cpu_id,Maxim number of addressable logic cpu ID in this package
> ...
> 
> Yeah, this way it might not be as readable but the format is pretty simple and
> everybody knows .csv so....
> 
> We can even do vertical alignment for better readability:
> 
> #     LEAF,SUBLEAF,register,  bits,short name, long name
>          1,	 0,	EBX,   7:0,brand,Brand Index
>          1,	 0,	EBX,  15:8,clflush_size,CLFLUSH line size (value * 8) in bytes
>      	 1,	 0,	EBX, 23:16,max_cpu_id,Maxim number of addressable logic cpu ID in this package
> 0x80000000,	12,	EAX,     3,eee, EEE
> 
> and can keep it in tabellary form this way. The parsing code should
> asimply split on ',' and ignore whitespace.
> 
> Thoughts?
 
Thanks, it looks good to me. One thing is in v2 we supported ',' in the
long name field, but that's minor as we could avoid using it in .csv 

- Feng

> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
