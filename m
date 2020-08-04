Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6875523B6F0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 10:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbgHDIlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 04:41:11 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38159 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726233AbgHDIlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 04:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596530469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UPWrZPY2tCatq3YfkH4vc2wJlD6QQa6/byy70189PQ0=;
        b=UPHJTVxSwH334H5yudUD+ojoHU4s7Rc2yOG3PeCzJfDwy8vbdaudMfCoHhAY894CJV7XHw
        rK+X/xmD2ukVSJu2r+eugNwen2UdhsJQ6Tk7lCYZJY+7AXvwzk4E3VpbHZGNZlkk1R+7Wh
        re8tOz6kIRl6Spo+RT/iQmx1FzN5afw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-kZw6m6UZOKqF8QBlq6GAqQ-1; Tue, 04 Aug 2020 04:41:04 -0400
X-MC-Unique: kZw6m6UZOKqF8QBlq6GAqQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6662D80BCBC;
        Tue,  4 Aug 2020 08:41:03 +0000 (UTC)
Received: from T590 (ovpn-13-169.pek2.redhat.com [10.72.13.169])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7895388D58;
        Tue,  4 Aug 2020 08:40:46 +0000 (UTC)
Date:   Tue, 4 Aug 2020 16:40:41 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Wang Qing <wangqing@vivo.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers\block: Use kobj_to_dev() API
Message-ID: <20200804084041.GB1958244@T590>
References: <1591945856-14749-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591945856-14749-1-git-send-email-wangqing@vivo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 03:10:56PM +0800, Wang Qing wrote:
> Use kobj_to_dev() API instead of container_of().
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  mode change 100644 => 100755 drivers/block/virtio_blk.c
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 9d21bf0..c808405
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -630,7 +630,7 @@ static struct attribute *virtblk_attrs[] = {
>  static umode_t virtblk_attrs_are_visible(struct kobject *kobj,
>  		struct attribute *a, int n)
>  {
> -	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct device *dev = kobj_to_dev(kobj);
>  	struct gendisk *disk = dev_to_disk(dev);
>  	struct virtio_blk *vblk = disk->private_data;
>  	struct virtio_device *vdev = vblk->vdev;
> -- 
> 2.7.4
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

