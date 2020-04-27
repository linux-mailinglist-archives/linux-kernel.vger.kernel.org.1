Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9441BA6F7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 16:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgD0OyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 10:54:09 -0400
Received: from verein.lst.de ([213.95.11.211]:48747 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727010AbgD0OyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 10:54:08 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6822068C7B; Mon, 27 Apr 2020 16:54:06 +0200 (CEST)
Date:   Mon, 27 Apr 2020 16:54:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Martijn Coenen <maco@android.com>
Cc:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org
Subject: Re: [PATCH v3 3/9] loop: Switch to
 set_capacity_revalidate_and_notify()
Message-ID: <20200427145406.GC5490@lst.de>
References: <20200427074222.65369-1-maco@android.com> <20200427074222.65369-4-maco@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427074222.65369-4-maco@android.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 09:42:16AM +0200, Martijn Coenen wrote:
>  	struct block_device *bdev = lo->lo_device;
>  
> -	set_capacity(lo->lo_disk, size);
>  	bd_set_size(bdev, size << SECTOR_SHIFT);
> +
>  	/* let user-space know about the new size */
> -	kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);
> +	set_capacity_revalidate_and_notify(lo->lo_disk, size, false);

I'd drop the comment as that is pretty explicit with
set_capacity_revalidate_and_notify.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
