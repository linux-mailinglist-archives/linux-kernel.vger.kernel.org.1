Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D772B8CA0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 08:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgKSHy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 02:54:27 -0500
Received: from verein.lst.de ([213.95.11.211]:37888 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbgKSHy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 02:54:27 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5338667373; Thu, 19 Nov 2020 08:54:23 +0100 (CET)
Date:   Thu, 19 Nov 2020 08:54:22 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     konrad.wilk@oracle.com, hch@lst.de, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        luto@kernel.org, peterz@infradead.org, dave.hansen@linux-intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        brijesh.singh@amd.com, Thomas.Lendacky@amd.com, jon.grimm@amd.com,
        rientjes@google.com
Subject: Re: [PATCH v5] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201119075422.GA15840@lst.de>
References: <20201118201243.18510-1-Ashish.Kalra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118201243.18510-1-Ashish.Kalra@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 08:12:43PM +0000, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> For SEV, all DMA to and from guest has to use shared
> (un-encrypted) pages. SEV uses SWIOTLB to make this
> happen without requiring changes to device drivers.
> However, depending on workload being run, the default
> 64MB of SWIOTLB might not be enough and SWIOTLB
> may run out of buffers to use for DMA, resulting
> in I/O errors and/or performance degradation for
> high I/O workloads.

FYI, you can use up 73 chars for your commit log.  This looks rather
compressed.
