Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3338329329F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 03:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389827AbgJTBIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 21:08:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:24329 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389817AbgJTBIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 21:08:04 -0400
IronPort-SDR: hgTymlrbtXTnxubDHnckYBOQo0vWF07d8XvnjW9nbr+/mjPCg/L/teWrgDqeHQt35DP936OUlM
 D03PYm2GJwaA==
X-IronPort-AV: E=McAfee;i="6000,8403,9779"; a="167247885"
X-IronPort-AV: E=Sophos;i="5.77,395,1596524400"; 
   d="scan'208";a="167247885"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 18:08:03 -0700
IronPort-SDR: KtUiuPv3DeeaNCPUqoVk/zRvwwfzIBmBwwkDWRcalwGmS/57mVltrH5gE9Hq3eJk4/w0CQk2hv
 PVtzojj0MDXQ==
X-IronPort-AV: E=Sophos;i="5.77,395,1596524400"; 
   d="scan'208";a="532840585"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.160])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 18:08:02 -0700
Date:   Mon, 19 Oct 2020 18:08:01 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Martin Radev <martin.b.radev@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] x86/boot/compressed/64: Introduce sev_status
Message-ID: <20201020010801.GA24746@linux.intel.com>
References: <20201019151121.826-1-joro@8bytes.org>
 <20201019151121.826-2-joro@8bytes.org>
 <20201020005925.GA24596@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020005925.GA24596@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 05:59:25PM -0700, Sean Christopherson wrote:
> On Mon, Oct 19, 2020 at 05:11:17PM +0200, Joerg Roedel wrote:
> > From: Joerg Roedel <jroedel@suse.de>
> > 
> > Introduce sev_status and initialize it together with sme_me_mask to have
> > an indicator which SEV features are enabled.
> > 
> > Signed-off-by: Joerg Roedel <jroedel@suse.de>
> > ---
> >  arch/x86/boot/compressed/mem_encrypt.S | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
> > index dd07e7b41b11..0effd58f0095 100644
> > --- a/arch/x86/boot/compressed/mem_encrypt.S
> > +++ b/arch/x86/boot/compressed/mem_encrypt.S
> > @@ -71,6 +71,8 @@ SYM_FUNC_END(get_sev_encryption_bit)
> >  SYM_FUNC_START(set_sev_encryption_mask)
> >  #ifdef CONFIG_AMD_MEM_ENCRYPT
> >  	push	%rbp
> > +	push	%rax
> > +	push	%rcx
> 
> There's no need to save/restore RAX and RCX, they are callee save.  This
> function is only called from C, so I doubt it's using a custom ABI.

Gah, *caller* save.  Feedback stands, my English notwithstanding.
