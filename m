Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB83A24A8E8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 00:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgHSWK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 18:10:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbgHSWK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 18:10:57 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A70A20658;
        Wed, 19 Aug 2020 22:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597875056;
        bh=YCqLLdMlClmtbX7ozswq1RrxODCoI7jS14uTBQkK9lU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l2KAf9hWOD5P1WCcGocpelxUAm0L0iUSL1V2bOxQE1gPLzi7zcPtv7wFPSjDiaZlm
         O7aZKNAhexykXE80reGA5RIoIXt4WoUx46s8mFjd3z3IYD6psCgA3YpS+yYWYJc+17
         DE/HtAqlkkDW3zRIEliFkbN9IeIVVxczRyDqtqXs=
Date:   Wed, 19 Aug 2020 15:10:54 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     David Fugate <david.fugate@linux.intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Kanchan Joshi <joshi.k@samsung.com>,
        "Damien.LeMoal@wdc.com" <Damien.LeMoal@wdc.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>,
        david.fugate@intel.com
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200819221054.GB26818@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com>
 <20200818071249.GB2544@lst.de>
 <b52854fe11640a5a5f54e08b1d3c7a556f97aad5.camel@linux.intel.com>
 <9fa64efe-8477-5d33-20ed-9619a9fe8d70@kernel.dk>
 <d19605da52eb7aa3eb4132ad1781b5fbf636a8a0.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d19605da52eb7aa3eb4132ad1781b5fbf636a8a0.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 03:54:20PM -0600, David Fugate wrote:
> On Wed, 2020-08-19 at 13:25 -0600, Jens Axboe wrote:
> > It's not required, the driver will function quite fine without it. If
> > you
> > want to use ZNS it's required. 
> 
> The NVMe spec does not require Zone Append for ZNS; a *vendor-neutral*
> Linux driver should not either. 

The spec was developed over the course of years with your employer's
involvement, and the software enabling efforts occurred in parallel. The
"optional" part was made that way at the final hour, so please align
your expectations accordingly.
 
> Agreed, but this standard needs to be applied equally to everyone.
> E.g., harmless contributions such as 
> https://lore.kernel.org/linux-nvme/20200611054156.GB3518@lst.de/ get
> rejected yet clear spec violations from maintainers are accepted?
> type of behavior encourages forking, vendor-specific drivers, etc.
> which is somewhere I hope none of us want to go.

You're the one who left that thread dangling. You offered to have your
firmware accommodate the Intel sponsored feature that makes your patch
unnecessary in the first place. Your follow up made no sense and you
have not responded to the queries about it.
