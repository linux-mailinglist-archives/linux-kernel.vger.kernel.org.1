Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA7E1AC0ED
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 14:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635241AbgDPMTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 08:19:11 -0400
Received: from verein.lst.de ([213.95.11.211]:51210 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2635208AbgDPMTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 08:19:05 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A893A68BEB; Thu, 16 Apr 2020 14:19:01 +0200 (CEST)
Date:   Thu, 16 Apr 2020 14:19:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Yufen Yu <yuyufen@huawei.com>, Christoph Hellwig <hch@lst.de>,
        axboe@kernel.dk, tj@kernel.org, bvanassche@acm.org, tytso@mit.edu,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] bdi: add a ->dev_name field to struct
 backing_dev_info
Message-ID: <20200416121901.GA26483@lst.de>
References: <20200416071519.807660-1-hch@lst.de> <20200416071519.807660-4-hch@lst.de> <5bfcd35a-2463-3769-be93-911c4e3c38bb@huawei.com> <20200416120223.GI23739@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416120223.GI23739@quack2.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 02:02:23PM +0200, Jan Kara wrote:
> Yes, that can indeed happen. E.g. I remember that drivers/scsi/sd.c calls
> device_add_disk() + del_gendisk() repeatedly for one request_queue and that
> would result in leaking the name (and possibly cause use-after-free
> issues).

Sd calls device_add_disk once in ->probe, and del_gendisk once in
sd_remove.  Note that sd_probe allocates a new scsi_disk structure and
a new gendisk everytime, but it does indeed reuse the request_queue
and thus bdi.

> I think dev_name has to be just a static array inside
> backing_dev_info which gets overwritten on reregistration. The question is
> how big should be this array... Some grepping shows that 40 bytes should be
> enough for everybody except fs/vboxsf/super.c which puts 'fc->source' into
> the name which can be presumably rather large. Anyway, I'd make it 40 and
> just truncate it case in case it does not fit. bdi_dev_name() is used for
> informational purposes anyway...

We could just make it a variable sized array at the end of the structure
and size it based on the len.
