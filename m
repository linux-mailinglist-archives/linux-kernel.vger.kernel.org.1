Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8A824A8AF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 23:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgHSVm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 17:42:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbgHSVmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 17:42:51 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97A952067C;
        Wed, 19 Aug 2020 21:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597873371;
        bh=pinhTPqoqxH2L+AXIWvBK5hfDh/tddhsdx7m0Akw4vk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AEuC7bxpfxQb5NULJo7ameLMi/uRkCDBFssg2Hh9Ph/nCuIth358SMN0YUN207pZC
         CRLee7W5b83xTup6n9ZwhSREsQek5bjjgoIWNMn/nhs9P5SPlaV9RW+TpuGWaKXKW0
         khJL2F8teLty+rZYfHxwczK5xb/U1f7+B0pkSIQs=
Date:   Wed, 19 Aug 2020 14:42:48 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     David Fugate <david.fugate@linux.intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Kanchan Joshi <joshi.k@samsung.com>,
        "Damien.LeMoal@wdc.com" <Damien.LeMoal@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200819214248.GA26769@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com>
 <20200818071249.GB2544@lst.de>
 <b52854fe11640a5a5f54e08b1d3c7a556f97aad5.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b52854fe11640a5a5f54e08b1d3c7a556f97aad5.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 01:11:58PM -0600, David Fugate wrote:
> Intel does not support making *optional* NVMe spec features *required*
> by the NVMe driver. 

This is inaccurate. As another example, the spec optionally allows a
zone size to be a power of 2, but linux requires a power of 2 if you
want to use it with this driver.

> Provided there's no glaring technical issues

There are many. Some may be improved through a serious review process,
but the mess it makes out of the fast path is measurably harmful to
devices that don't subscribe to this. That issue is not so easily
remedied.

Since this patch is a copy of the scsi implementation, the reasonable
thing is take this fight to the generic block layer for a common
solution. We're not taking this in the nvme driver.
