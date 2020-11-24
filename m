Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 365532C21C2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 10:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731531AbgKXJiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 04:38:46 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43162 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731507AbgKXJin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:38:43 -0500
Received: from zn.tnic (p200300ec2f0e360052021be21853ebf1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:3600:5202:1be2:1853:ebf1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CE42E1EC0529;
        Tue, 24 Nov 2020 10:38:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606210721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mIxQeGPd5ay/UcAwPgNBuQ42UymVxYGQUjrVO6RwKWQ=;
        b=E6jhhwVoW/NqalShXB4DbazzDfcgmyJayc5KYXVkeB8CMqqMLHVxBSIrgilA2M0GYiHEnx
        WVDJpaWLhKXqdS8GYi2v8gYrAvW6YHGCa3G5texvNNLmu77ZCuHqarUkTAPB90Hiy1cQoI
        rY4yXG5THYW6gbbgiFs/MdYplMmcCj8=
Date:   Tue, 24 Nov 2020 10:38:37 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kalra, Ashish" <Ashish.Kalra@amd.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "hch@lst.de" <hch@lst.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dave.hansen@linux-intel.com" <dave.hansen@linux-intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Grimm, Jon" <Jon.Grimm@amd.com>,
        "rientjes@google.com" <rientjes@google.com>
Subject: Re: [PATCH v6] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201124093837.GD4009@zn.tnic>
References: <20201119214205.11062-1-Ashish.Kalra@amd.com>
 <20201123170647.GE15044@zn.tnic>
 <20201123175632.GA21539@char.us.oracle.com>
 <20201123225631.GA16055@ashkalra_ubuntu_server>
 <20201124090431.GC4009@zn.tnic>
 <EF13C80C-42DC-4B51-8AF8-2C1D3859B490@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <EF13C80C-42DC-4B51-8AF8-2C1D3859B490@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 09:25:06AM +0000, Kalra, Ashish wrote:
> But what will be the criteria to figure out this percentage?
>
> As I mentioned earlier, this can be made as complicated as possible by
> adding all kind of heuristics but without any predictable performance
> gain.
>
> Or it can be kept simple by using a static percentage value.

Yes, static percentage number based on the guest memory. X% of the guest
memory is used for SWIOTLB.

Since you use sev_active(), it means the size computation is done in the
guest so that SWIOTLB size is per-guest. Yes?

If so, you can simply take, say, 5% of the guest memory's size and use
that for SWIOTLB buffers. Or 6 or X or whatever.

Makes sense?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
