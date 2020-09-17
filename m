Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D060426DAF1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 14:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgIQMAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 08:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgIQL10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:27:26 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145C1C061788
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 04:27:20 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BsZSM4Dglz9sTW; Thu, 17 Sep 2020 21:27:15 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        iommu@lists.linux-foundation.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Christoph Hellwig <hch@lst.de>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200818221126.391073-1-bauerman@linux.ibm.com>
References: <20200818221126.391073-1-bauerman@linux.ibm.com>
Subject: Re: [PATCH v3] powerpc/pseries/svm: Allocate SWIOTLB buffer anywhere in memory
Message-Id: <160034200698.3339803.12661483575080905618.b4-ty@ellerman.id.au>
Date:   Thu, 17 Sep 2020 21:27:15 +1000 (AEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Aug 2020 19:11:26 -0300, Thiago Jung Bauermann wrote:
> POWER secure guests (i.e., guests which use the Protection Execution
> Facility) need to use SWIOTLB to be able to do I/O with the hypervisor, but
> they don't need the SWIOTLB memory to be in low addresses since the
> hypervisor doesn't have any addressing limitation.
> 
> This solves a SWIOTLB initialization problem we are seeing in secure guests
> with 128 GB of RAM: they are configured with 4 GB of crashkernel reserved
> memory, which leaves no space for SWIOTLB in low addresses.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/pseries/svm: Allocate SWIOTLB buffer anywhere in memory
      https://git.kernel.org/powerpc/c/eae9eec476d13fad9af6da1f44a054ee02b7b161

cheers
