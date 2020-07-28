Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E83230930
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 13:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbgG1LxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 07:53:05 -0400
Received: from verein.lst.de ([213.95.11.211]:47978 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729191AbgG1LxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 07:53:04 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 85FB568B05; Tue, 28 Jul 2020 13:53:02 +0200 (CEST)
Date:   Tue, 28 Jul 2020 13:53:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        will@kernel.org, ganapatrao.kulkarni@cavium.com,
        catalin.marinas@arm.com, iommu@lists.linux-foundation.org,
        linuxarm@huawei.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, prime.zeng@hisilicon.com,
        huangdaode@huawei.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Steve Capper <steve.capper@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v4 2/2] arm64: mm: reserve per-numa CMA to localize
 coherent dma buffers
Message-ID: <20200728115302.GB793@lst.de>
References: <20200723131344.41472-1-song.bao.hua@hisilicon.com> <20200723131344.41472-3-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723131344.41472-3-song.bao.hua@hisilicon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks ok to me, but before I pick the series up in the dma-mapping tree
I really want an ACK from the arm64 maintainers.
