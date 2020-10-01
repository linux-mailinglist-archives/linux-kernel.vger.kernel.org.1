Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C1727FED6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 14:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731961AbgJAMRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 08:17:05 -0400
Received: from 8bytes.org ([81.169.241.247]:47172 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731846AbgJAMRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 08:17:05 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 56D492C3; Thu,  1 Oct 2020 14:17:03 +0200 (CEST)
Date:   Thu, 1 Oct 2020 14:17:02 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>,
        David Woodhouse <dwmw2@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Intel-gfx@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/7] Convert the intel iommu driver to the dma-iommu
 api
Message-ID: <20201001121701.GB30426@8bytes.org>
References: <20200927063437.13988-1-baolu.lu@linux.intel.com>
 <e999e371-6d36-ffea-542f-a5f4b230b0ed@linux.intel.com>
 <c2af9a9d-1cae-b8f7-a0b3-880574060a23@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2af9a9d-1cae-b8f7-a0b3-880574060a23@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu,

On Tue, Sep 29, 2020 at 08:11:35AM +0800, Lu Baolu wrote:
> I have no preference. It depends on which patch goes first. Let the
> maintainers help here.

No preference on my side, except that it is too late for this now to
make it into v5.10. Besides that I let the decission up to you when this
is ready. Just send me a pull-request when it should get into the
iommu-tree.

Regards,

	Joerg
