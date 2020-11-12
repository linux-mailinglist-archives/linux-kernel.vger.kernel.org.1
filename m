Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325872B0B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 18:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgKLRgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 12:36:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:52174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgKLRgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 12:36:37 -0500
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA570206CA;
        Thu, 12 Nov 2020 17:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605202597;
        bh=62n+3qAQC/6pRGdolxF8eh1RRuxn+EPmo03iIszC2mY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oFMsnNC08E3xNKjAJdF9XvQggRV+d/ZTTnyuA+kv7rhlqb5xxzc/cdc53XZB7kAFR
         sOL+e6cixjCZ3sA0eoY36K8pMaDrwPlI1Dub8jjWLyRJJkJBe+rY39xN9aAfvYNtms
         Wl4ioiq/T/ouYRW+eQ4ErB8cabgDriZtHIRw4CSg=
Date:   Thu, 12 Nov 2020 09:36:34 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 0/2] nvme-pic: improve max I/O queue handling
Message-ID: <20201112173634.GA2626470@dhcp-10-100-145-180.wdc.com>
References: <20201112082302.82441-1-schnelle@linux.ibm.com>
 <20201112145325.GC2573679@dhcp-10-100-145-180.wdc.com>
 <10908f20-7e18-e967-76dd-1a38e216b378@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10908f20-7e18-e967-76dd-1a38e216b378@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 04:45:35PM +0100, Niklas Schnelle wrote:
> You got to get something wrong, I hope in this case it's just the subject
> of the cover letter :D

I suppose the change logs could be worded a little better :)

> Thanks for the review, I appreciate it. Might be getting ahead of
> myself but I'm curious who would take this change through their
> tree if accepted?

The linux-nvme tree is located here:

  http://git.infradead.org/nvme.git

Christoph is currently handling patch commits there.
