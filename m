Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8752B2D1D16
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgLGWPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:15:18 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46462 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbgLGWPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:15:18 -0500
Received: from zn.tnic (p200300ec2f0a3800f6520bb83eb81f06.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:3800:f652:bb8:3eb8:1f06])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 11BD01EC04EE;
        Mon,  7 Dec 2020 23:14:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607379277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Rkvk+tzMIUc9fRrgCdg7JlUw13jU6Cv+oUVq0qn37qY=;
        b=PEPqdsuzsgBeFOD7Ka5of9/9LVryQOc6UH3w4GvPK0ff/fo4ANHkJ3Sbza3a0gG8cWoLta
        YTs34+wFQIYPo63XBaXaaE3RXpY/BfYxxS+32wqyTJqe5CnDl++EFR2Eza0dA7Vertw1b0
        BodPMOzs0N1vF5ETWVxcrBDNELIwemk=
Date:   Mon, 7 Dec 2020 23:14:33 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ashish Kalra <ashish.kalra@amd.com>
Cc:     konrad.wilk@oracle.com, hch@lst.de, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, luto@kernel.org,
        peterz@infradead.org, dave.hansen@linux-intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        brijesh.singh@amd.com, Thomas.Lendacky@amd.com, Jon.Grimm@amd.com,
        rientjes@google.com
Subject: Re: [PATCH v7] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201207221433.GI20489@zn.tnic>
References: <20201203032559.3388-1-Ashish.Kalra@amd.com>
 <20201207121007.GD20489@zn.tnic>
 <20201207220624.GB6855@ashkalra_ubuntu_server>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201207220624.GB6855@ashkalra_ubuntu_server>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 10:06:24PM +0000, Ashish Kalra wrote:
> This is related to the earlier static adjustment of the SWIOTLB buffers
> as per guest memory size and Konrad's feedback on the same, as copied
> below : 
> 
> >>That is eating 128MB for 1GB, aka 12% of the guest memory allocated statically for this.
> >> 
> >> And for guests that are 2GB, that is 12% until it gets to 3GB when 
> >> it is 8% and then 6% at 4GB.
> >> 
> >> I would prefer this to be based on your memory count, that is 6% of 
> >> total memory.

So no rule of thumb and no measurements? Just a magic number 6.

Btw, pls trim the rest of the mail when you reply. Like I just did.
There's no need to leave text which you're not responding to, quoted.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
