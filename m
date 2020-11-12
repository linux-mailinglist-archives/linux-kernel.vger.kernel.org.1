Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700B32B07D8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 15:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbgKLOxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 09:53:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:58502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgKLOxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 09:53:30 -0500
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC25020872;
        Thu, 12 Nov 2020 14:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605192809;
        bh=/KlAWNAD1+tCSwffPMeMfbxtqiL9CCu/YpbwvOwXbAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XHXS4JsK9KcSqUL53gxBe0I5Ye7FAJB+vXCaW9PnkTMOBtYLg6FyiBsaS/oJkSBFT
         JpdUJCFvblA70JyHGQSRfQ5waI7nqiPwsn9+NTiB8KUZXJnMo0yJBXqBtILUWHpFfp
         qhJ04+7XMoJReY++YMN80dPYrgnHiT2FSjHR+Mvs=
Date:   Thu, 12 Nov 2020 06:53:25 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 0/2] nvme-pic: improve max I/O queue handling
Message-ID: <20201112145325.GC2573679@dhcp-10-100-145-180.wdc.com>
References: <20201112082302.82441-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112082302.82441-1-schnelle@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 09:23:00AM +0100, Niklas Schnelle wrote:
> while searching for a bug around zPCI + NVMe IRQ handling on a distro
> kernel, I got confused around handling of the maximum number
> of I/O queues in the NVMe driver.
> I think I groked it in the end but would like to propose the following
> improvements, that said I'm quite new to this code.
> I tested both patches on s390x (with a debug config) and x86_64 so
> with both data center and consumer NVMes.
> For the second patch, since I don't own a device with the quirk, I tried
> always returning 1 from nvme_max_io_queues() and confirmed that on my
> Evo 970 Pro this resulted in about half the performance in a fio test
> but did not otherwise break things. I couldn't find a reason why
> allocating only the I/O queues we actually use would be problematic in
> the code either but I might have missed something of course.

I don't think you missed anything, and the series looks like a
reasonable cleanup. I suspect the code was left over from a time when we
didn't allocate the possible queues up-front.

Reviewed-by: Keith Busch <kbusch@kernel.org>
