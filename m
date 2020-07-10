Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B48F21BC21
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 19:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgGJRXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 13:23:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbgGJRXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 13:23:23 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74D2520725;
        Fri, 10 Jul 2020 17:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594401803;
        bh=rAuE9jeGeeqGhOCjOngLXVOcRpO0n8j8ZAoZml36l+k=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=GCGvc7A2swdSgZQM9VLG6v6Isa3U81e3H+SQmUSOjoXi7vktetME438dMXRJ34H42
         aHNMQA5n4X6fIhkjfedVLzGsZTRHDfLQzo6Rgey4siWO2M2zMc4v1OOqc5/8LkhvZ0
         kmIReJDrRl+BKA5/P1OJYrcEUZELDKqQOgt+LAAk=
Date:   Fri, 10 Jul 2020 10:23:22 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     "Michael S. Tsirkin" <mst@redhat.com>
cc:     Stefano Stabellini <sstabellini@kernel.org>, jgross@suse.com,
        Peng Fan <peng.fan@nxp.com>, konrad.wilk@oracle.com,
        jasowang@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Christoph Hellwig <hch@infradead.org>,
        iommu@lists.linux-foundation.org, linux-imx@nxp.com,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] xen: introduce xen_vring_use_dma
In-Reply-To: <20200701172219-mutt-send-email-mst@kernel.org>
Message-ID: <alpine.DEB.2.21.2007101019340.4124@sstabellini-ThinkPad-T480s>
References: <20200624050355-mutt-send-email-mst@kernel.org> <alpine.DEB.2.21.2006241047010.8121@sstabellini-ThinkPad-T480s> <20200624163940-mutt-send-email-mst@kernel.org> <alpine.DEB.2.21.2006241351430.8121@sstabellini-ThinkPad-T480s>
 <20200624181026-mutt-send-email-mst@kernel.org> <alpine.DEB.2.21.2006251014230.8121@sstabellini-ThinkPad-T480s> <20200626110629-mutt-send-email-mst@kernel.org> <alpine.DEB.2.21.2006291621300.8121@sstabellini-ThinkPad-T480s> <20200701133456.GA23888@infradead.org>
 <alpine.DEB.2.21.2007011020320.8121@sstabellini-ThinkPad-T480s> <20200701172219-mutt-send-email-mst@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the late reply -- a couple of conferences kept me busy.


On Wed, 1 Jul 2020, Michael S. Tsirkin wrote:
> On Wed, Jul 01, 2020 at 10:34:53AM -0700, Stefano Stabellini wrote:
> > Would you be in favor of a more flexible check along the lines of the
> > one proposed in the patch that started this thread:
> > 
> >     if (xen_vring_use_dma())
> >             return true;
> > 
> > 
> > xen_vring_use_dma would be implemented so that it returns true when
> > xen_swiotlb is required and false otherwise.
> 
> Just to stress - with a patch like this virtio can *still* use DMA API
> if PLATFORM_ACCESS is set. So if DMA API is broken on some platforms
> as you seem to be saying, you guys should fix it before doing something
> like this..

Yes, DMA API is broken with some interfaces (specifically: rpmesg and
trusty), but for them PLATFORM_ACCESS is never set. That is why the
errors weren't reported before. Xen special case aside, there is no
problem under normal circumstances.


If you are OK with this patch (after a little bit of clean-up), Peng,
are you OK with sending an update or do you want me to?
