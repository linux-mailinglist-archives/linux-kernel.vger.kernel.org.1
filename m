Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D902426959A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 21:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgINTZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 15:25:22 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41648 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgINTZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 15:25:20 -0400
Received: from zn.tnic (p200300ec2f09260089ebb5f4b84dd95c.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:2600:89eb:b5f4:b84d:d95c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 264B51EC0593;
        Mon, 14 Sep 2020 21:25:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600111519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kR4nOLZKKMG9ABqKtCK+wPeLMHx2mjIWcwysWLS4COs=;
        b=gnuP2iOdu1c/oi+BPLzEjpOg6v7KYFcBSqANMcJp2ekMO+eohvlwHsLKsE+htqnmFsxl/u
        OWY/tas3cbbTiADdrR7SQD8gXcqIWX7J8hu53zR7KFViT+ffxE8gPvGPOdFLOrWfPLYiZB
        16i/tHesK6hVA0UXilB5sPXnR+8Q8Jg=
Date:   Mon, 14 Sep 2020 21:25:18 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu@lists.linux-foundation.org
Subject: Re: [PATCH v7 9/9] x86/mmu: Allocate/free PASID
Message-ID: <20200914192518.GH680@zn.tnic>
References: <1598540794-132666-1-git-send-email-fenghua.yu@intel.com>
 <1598540794-132666-10-git-send-email-fenghua.yu@intel.com>
 <20200907111843.GC16029@zn.tnic>
 <20200914183715.GA437309@otcwcpicx6.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200914183715.GA437309@otcwcpicx6.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 06:37:15PM +0000, Fenghua Yu wrote:
> get_xsave_addr() will not return NULL because xsave->header.xfeatures has
> XFEATURE_MASK_PASID set.

Ah, you're setting it in the line above.

> I will remove the unnecessary check "if (ppasid_state)" to optimize
> the function and add a comment on why the check is unnecessary.

Ok.

> I addressed all of your comments and will send out the updated series soon.
> 
> Thank you very much for your review!

You're welcome and thanks!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
