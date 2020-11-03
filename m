Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A268C2A4388
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 11:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgKCKyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 05:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbgKCKyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 05:54:45 -0500
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCB7C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 02:54:45 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C5D563A5; Tue,  3 Nov 2020 11:54:43 +0100 (CET)
Date:   Tue, 3 Nov 2020 11:54:42 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Intel-gfx@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/7] Convert the intel iommu driver to the dma-iommu
 api
Message-ID: <20201103105442.GD22888@8bytes.org>
References: <20200927063437.13988-1-baolu.lu@linux.intel.com>
 <e999e371-6d36-ffea-542f-a5f4b230b0ed@linux.intel.com>
 <c2af9a9d-1cae-b8f7-a0b3-880574060a23@linux.intel.com>
 <8bac9e91-36a0-c1d6-a887-4d60567ac75a@linux.intel.com>
 <3f5694f3-62f9-cc2b-1c2b-f9e99a4788c1@linux.intel.com>
 <1ce5b94a-38b3-548e-3b1a-a68390b93953@linux.intel.com>
 <82dab98e-0761-8946-c31c-92f19a0615b4@linux.intel.com>
 <99a0d1eb-7fde-dff4-225f-92b68fbf7620@linux.intel.com>
 <160439750572.8460.14782978404889004150@jlahtine-mobl.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160439750572.8460.14782978404889004150@jlahtine-mobl.ger.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 03, 2020 at 11:58:26AM +0200, Joonas Lahtinen wrote:
> Would that work for you? We intend to send the feature pull requests
> to DRM for 5.11 in the upcoming weeks.

For the IOMMU side it is best to include the workaround for now. When
the DRM fixes are merged into v5.11-rc1 together with this conversion,
it can be reverted and will not be in 5.11-final.

Regards,

	Joerg
