Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C7A206A5C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 04:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388562AbgFXC6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 22:58:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387985AbgFXC6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 22:58:20 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45DC320874;
        Wed, 24 Jun 2020 02:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592967499;
        bh=mCGxMz5JRutifyW8eb22QKPlYT5lYUCRi0U6QOFPEo8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2wQWPkcjjQnenLVYjOK70XdZ/+IoYk9ARNizFA0WZrpofzP+mwQyrS/9CAM4kUc7H
         /wT3DwcPFHr84HhyLjAsRV6Ji2p9LVirxsNMvXNAXTkspK1+cG5STeu/SIFVPFrXer
         IubGHumJLVBBNe0fhjOJoLUYW/9wVuO4FJT4Nm9E=
Date:   Tue, 23 Jun 2020 19:58:17 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>, axboe@fb.com,
        sagi@grimberg.me, baolin.wang7@gmail.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] nvme-pci: Add controller memory buffer supported
 macro
Message-ID: <20200624025817.GC1291930@dhcp-10-100-145-180.wdl.wdc.com>
References: <cover.1592916850.git.baolin.wang@linux.alibaba.com>
 <eab18c7696ea0e34a6ab0371d7d17ad45d1566ce.1592916850.git.baolin.wang@linux.alibaba.com>
 <20200623162751.GA4846@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623162751.GA4846@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 06:27:51PM +0200, Christoph Hellwig wrote:
> On Tue, Jun 23, 2020 at 09:24:33PM +0800, Baolin Wang wrote:
> > Introduce a new capability macro to indicate if the controller
> > supports the memory buffer or not, instead of reading the
> > NVME_REG_CMBSZ register.
> 
> This is a complex issue.  The CMBS bit was only added in NVMe 1.4 as
> a backwards incompatible change, as the CMB addressing scheme can lead
> to data corruption.  The CMBS was added as part of the horribe hack
> that also involves the CBA field, which we'll need to see before
> using it to work around the addressing issue.  At the same time we
> should also continue supporting the legacy pre-1.4 CMB with a warning
> (and may reject it if we know we run in a VM).

Well, a CMB from an emulated controller (like qemu's) can be used within
a VM. It's only if you direct assign a PCI function that CMB usage
breaks.
