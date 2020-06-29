Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D782520CB6D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 03:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgF2Bbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jun 2020 21:31:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbgF2Bbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 21:31:46 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCE8320760;
        Mon, 29 Jun 2020 01:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593394306;
        bh=Ixv42zagfGZIEDNq4U3wKAFoD1bkkegEHSprOtjQStI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NnGgTB+CbTXjBK1BNyUZr413XjFoQwM5KfaBVDPtkFkCulbx/2B84Ta+2Bxed110K
         O5Zv5LFdlBWLRzGQ92/bVSE5HXIKs4FhG2u1kQOseqmVLTht6nlsFUz5SB8TLYXuk5
         j8tzwFrPCxT1RdyS9yV4hWloKGL/3fmSBF9l32A8=
Date:   Sun, 28 Jun 2020 18:31:43 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     axboe@fb.com, hch@lst.de, sagi@grimberg.me, baolin.wang7@gmail.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] nvme-pci: Move the sg table allocation/free into
 init/exit_request
Message-ID: <20200629013143.GA1778220@dhcp-10-100-145-180.wdl.wdc.com>
References: <4eedad1efab91f4529de19e14ba374da405aea3f.1593340208.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4eedad1efab91f4529de19e14ba374da405aea3f.1593340208.git.baolin.wang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 28, 2020 at 06:34:46PM +0800, Baolin Wang wrote:
> Move the sg table allocation and free into the init_request() and
> exit_request(), instead of allocating sg table when queuing requests,
> which can benefit the IO performance.

If you want to pre-allocate something per-request, you can add the size
to the tagset's cmd_size.

But this is adding almost 4k per request. Considering how many requests
we try to allocate, that's a bit too large to count on being available
or sequestor for this driver.
