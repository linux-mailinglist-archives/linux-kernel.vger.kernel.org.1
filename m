Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97EB2B2D07
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 13:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgKNMKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 07:10:18 -0500
Received: from verein.lst.de ([213.95.11.211]:50183 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726625AbgKNMKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 07:10:17 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id BCB4268AFE; Sat, 14 Nov 2020 13:10:14 +0100 (CET)
Date:   Sat, 14 Nov 2020 13:10:14 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH] dma-pool: no need to check return value of
 debugfs_create functions
Message-ID: <20201114121013.GB21068@lst.de>
References: <1604743392-21601-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604743392-21601-1-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied.
