Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2704125D56B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 11:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbgIDJvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 05:51:22 -0400
Received: from 8bytes.org ([81.169.241.247]:41042 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgIDJvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 05:51:19 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 931DF3D5; Fri,  4 Sep 2020 11:51:18 +0200 (CEST)
Date:   Fri, 4 Sep 2020 11:51:17 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Torsten Hilbrich <torsten.hilbrich@secunet.com>,
        Wendy Wang <wendy.wang@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix NULL pointer dereference in
 dev_iommu_priv_set()
Message-ID: <20200904095117.GQ6714@8bytes.org>
References: <20200903065132.16879-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903065132.16879-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 02:51:32PM +0800, Lu Baolu wrote:
> ---
>  drivers/iommu/intel/iommu.c | 100 ++++++++++++++++++++----------------
>  1 file changed, 55 insertions(+), 45 deletions(-)

Applied for v5.9, thanks.

