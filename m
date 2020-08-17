Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACEA2466C5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 14:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbgHQM7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 08:59:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:59708 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgHQM7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 08:59:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9FBAAAAB0;
        Mon, 17 Aug 2020 12:59:35 +0000 (UTC)
Date:   Mon, 17 Aug 2020 14:59:08 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Chenfeng <puck.chen@hisilicon.com>,
        Joerg Roedel <joro@8bytes.org>, linuxarm@huawei.com,
        Wei Xu <xuwei5@hisilicon.com>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        John Stultz <john.stultz@linaro.org>, mauro.chehab@huawei.com,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/16] IOMMU driver for Kirin 960/970
Message-ID: <20200817125908.GB4167@suse.de>
References: <cover.1597650455.git.mchehab+huawei@kernel.org>
 <20200817082106.GA16296@infradead.org>
 <20200817112725.26f1b7d6@coco.lan>
 <20200817093703.GA2258686@kroah.com>
 <20200817124617.303bb4a9@coco.lan>
 <20200817105345.GA3483231@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817105345.GA3483231@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 12:53:45PM +0200, Greg Kroah-Hartman wrote:
> You can always do this just fine, as one single patch.  You do know
> about the co-developed-by: line, right?

Agreed. Please keep the main iommu driver in one patch and use
co-developed-by. This makes it easier for me to review it and provide
feedback. And please Cc me on the whole patch-set for v2.

Thanks,

	Joerg
