Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64342D427C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 13:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731834AbgLIMz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 07:55:28 -0500
Received: from mail.skyhub.de ([5.9.137.197]:58362 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728543AbgLIMz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 07:55:28 -0500
Received: from zn.tnic (p200300ec2f0f48006cdc67c2e76428ce.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:4800:6cdc:67c2:e764:28ce])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A98A11EC04C1;
        Wed,  9 Dec 2020 13:54:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607518486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=s58KPrB1ihI+LMGijJBh7kVxdsHPRujydS8Yr1KZJyY=;
        b=Htb9TGJEGhuSw/R+TpMSxdmZPvhSikcKi8AIQj8RbWm9l88XAx2w/W8ZJ2i5sAjtj8KEYG
        wXw9R1XLmsnpXZzsInt10YECgG1qVJdI5e5fsSXQhFcuthXHC3BhwPY3tU4jZfZx8raG4t
        hcvWBa4iGyjqon+QKyP6FeMSAcyqAIo=
Date:   Wed, 9 Dec 2020 13:54:42 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ashish Kalra <ashish.kalra@amd.com>
Cc:     konrad.wilk@oracle.com, hch@lst.de, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, luto@kernel.org,
        peterz@infradead.org, dave.hansen@linux-intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        brijesh.singh@amd.com, Thomas.Lendacky@amd.com, Jon.Grimm@amd.com,
        rientjes@google.com
Subject: Re: [PATCH v8] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201209125442.GC18203@zn.tnic>
References: <20201207231057.26403-1-Ashish.Kalra@amd.com>
 <20201209110115.GA18203@zn.tnic>
 <20201209122907.GA6258@ashkalra_ubuntu_server>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201209122907.GA6258@ashkalra_ubuntu_server>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 12:29:07PM +0000, Ashish Kalra wrote:
> As i mentioned in the main comments above, this cannot be called in
> mem_encrypt_init() as that breaks reserve_crashkernel() which depends
> on SWIOTLB buffer size

Please elaborate how does it break.

> and is called before mem_encrypt_init(), therefore, it needs to be
> called from setup_atch() before reserve_crashkernel().

I know you have your requirements what needs to be called when like all
the other vendors who want to run stuff early in a particular order but
our boot init order is a single fragile mess. So this better be done
right!

Also,

[    0.016630] software IO TLB: swiotlb_adjust:
[    0.017005] reserve_crashkernel:
[    0.050523] software IO TLB: swiotlb_init:

this looks strange - we're doing a swiotlb size adjust before init.

It probably makes sense as in: adjust the size before the SWIOTLB is
initialized so that it uses the correct size but this better be spelled
out.

> I believe that other memory encryption architectures such as s390 are
> also looking for something similar to be available.

Until you have something more palpable than belief, "let the others
extend it when they really need it." as I already mentioned.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
