Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5208A26E10C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 18:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgIQQps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 12:45:48 -0400
Received: from verein.lst.de ([213.95.11.211]:56986 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728606AbgIQQoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 12:44:24 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0651268BFE; Thu, 17 Sep 2020 18:44:21 +0200 (CEST)
Date:   Thu, 17 Sep 2020 18:44:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Thomas Tai <thomas.tai@oracle.com>
Cc:     konrad.wilk@oracle.com, m.szyprowski@samsung.com, hch@lst.de,
        robin.murphy@arm.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] dma-direct: Fix potential NULL pointer dereference
Message-ID: <20200917164420.GA5959@lst.de>
References: <1600289466-23805-1-git-send-email-thomas.tai@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600289466-23805-1-git-send-email-thomas.tai@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to the dma-mapping for-next tree.
