Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC246222623
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 16:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbgGPOr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 10:47:57 -0400
Received: from verein.lst.de ([213.95.11.211]:35004 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726963AbgGPOr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 10:47:56 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DE15068BFE; Thu, 16 Jul 2020 16:47:53 +0200 (CEST)
Date:   Thu, 16 Jul 2020 16:47:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com,
        robin.murphy@arm.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
Subject: Re: [PATCH] dma-coherent: switch to bitmap_zalloc() in
 dma_init_coherent_memory()
Message-ID: <20200716144753.GA24439@lst.de>
References: <1b02b07b-617e-bc5c-8619-7a46fba5a512@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b02b07b-617e-bc5c-8619-7a46fba5a512@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to nvme-5.9.
