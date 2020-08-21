Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39D724D061
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 10:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgHUIKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 04:10:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbgHUIKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 04:10:13 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E92C02078D;
        Fri, 21 Aug 2020 08:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597997412;
        bh=qX/evmdyLK0MMeOBByOd+vTc2QcFXtXoIG/jEVYRUAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NcxlmvsALJcFwVcLYljKXG0X+KQdeuK59GzNX0woZipVxIidrTWl+2SPNxT0Rr3d/
         WAWhKDJXUDEQdE3ufBnv/tD3xaE62x+myh3d++Y+M7etdiDzZ8fz3EyTYAevqZZxxG
         jpwJcsBBPDtuEV/rNGfhYxI0ZGiuXnlN25Otx1LQ=
Date:   Fri, 21 Aug 2020 09:10:08 +0100
From:   Will Deacon <will@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Barry Song <song.bao.hua@hisilicon.com>, m.szyprowski@samsung.com,
        robin.murphy@arm.com, ganapatrao.kulkarni@cavium.com,
        catalin.marinas@arm.com, iommu@lists.linux-foundation.org,
        linuxarm@huawei.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, huangdaode@huawei.com
Subject: Re: [PATCH v6 0/2] make dma_alloc_coherent NUMA-aware by per-NUMA CMA
Message-ID: <20200821081007.GB20060@willie-the-truck>
References: <20200821022615.28596-1-song.bao.hua@hisilicon.com>
 <20200821061918.GA28559@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821061918.GA28559@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 08:19:18AM +0200, Christoph Hellwig wrote:
> FYI, as of the last one I'm fine now, bit I really need an ACK from
> the arm64 maintainers.

Going through the dreaded backlog this morning...

Will
