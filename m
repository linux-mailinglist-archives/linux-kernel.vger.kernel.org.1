Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA5F285D0B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 12:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgJGKjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 06:39:40 -0400
Received: from verein.lst.de ([213.95.11.211]:36915 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbgJGKjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 06:39:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id F1B656736F; Wed,  7 Oct 2020 12:39:36 +0200 (CEST)
Date:   Wed, 7 Oct 2020 12:39:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Stefan Haberland <sth@linux.ibm.com>, hch@lst.de, axboe@kernel.dk,
        hoeppner@linux.ibm.com, linux-s390@vger.kernel.org,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] s390/dasd: remove ioctl_by_bdev calls
Message-ID: <20201007103936.GA24327@lst.de>
References: <20200519142259.102279-1-sth@linux.ibm.com> <20200519142259.102279-3-sth@linux.ibm.com> <5c815b8a-7d77-5c69-9191-d09cc433f5ff@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c815b8a-7d77-5c69-9191-d09cc433f5ff@de.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 11:34:17AM +0200, Christian Borntraeger wrote:
> 
> On 19.05.20 16:22, Stefan Haberland wrote:
> > The IBM partition parser requires device type specific information only
> > available to the DASD driver to correctly register partitions. The
> > current approach of using ioctl_by_bdev with a fake user space pointer
> > is discouraged.
> > 
> > Fix this by replacing IOCTL calls with direct in-kernel function calls.
> > 
> > Suggested-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
> > Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
> > Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
> 
> FWIW, this broken the ibm-partition code for virtio-blk, when CONFIG_DASD=m.

What are the symptoms?
