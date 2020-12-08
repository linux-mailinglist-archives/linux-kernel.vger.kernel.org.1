Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3362D203C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 02:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgLHBmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 20:42:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46398 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726190AbgLHBmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 20:42:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607391642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CbTa3TS2UPjpV8MBdJe1uQo9hhOnX7CWEPeQVSLOHRo=;
        b=Fkm5gTcFpnKfCEpA0Jr6O77U3GPNlUP1GfDNZpCk3bJW/bXdSLMlJCEIqn/1NRfV3/739e
        KkSOR4SXnSLWBElutysDBU332j3YkiWm2yxbmYOs3pt01OF6mpWPrlyURClj8GTQwj4+YO
        oZvNG39KtCydje3Q+VmYlgmhdR9OYAw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-XgKGoatqPX-f8kPrH1Xf1Q-1; Mon, 07 Dec 2020 20:40:39 -0500
X-MC-Unique: XgKGoatqPX-f8kPrH1Xf1Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30AF0800D55;
        Tue,  8 Dec 2020 01:40:37 +0000 (UTC)
Received: from T590 (ovpn-13-16.pek2.redhat.com [10.72.13.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3345A5C22B;
        Tue,  8 Dec 2020 01:40:24 +0000 (UTC)
Date:   Tue, 8 Dec 2020 09:40:19 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Qian Cai <cai@redhat.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        John Garry <john.garry@huawei.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/3] blk-mq/nvme-loop: use nvme-loop's lock class for
 addressing lockdep false positive warning
Message-ID: <20201208014019.GB1059392@T590>
References: <20201203012638.543321-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203012638.543321-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 09:26:35AM +0800, Ming Lei wrote:
> Hi,
> 
> Qian reported there is hang during booting when shared host tagset is
> introduced on megaraid sas. Sumit reported the whole SCSI probe takes
> about ~45min in his test.
> 
> Turns out it is caused by nr_hw_queues increased, especially commit
> b3c6a5997541("block: Fix a lockdep complaint triggered by request queue flushing")
> adds synchronize_rcu() for each hctx's release handler.
> 
> Address the original lockdep false positive warning by simpler way, then
> long scsi probe can be avoided with lockdep enabled.
> 
> V2:
> 	- add reviewed-by
> 	- adjust commit log of patch 3
> 
> Ming Lei (3):
>   blk-mq: add new API of blk_mq_hctx_set_fq_lock_class
>   nvme-loop: use blk_mq_hctx_set_fq_lock_class to set loop's lock class
>   Revert "block: Fix a lockdep complaint triggered by request queue
>     flushing"
> 
>  block/blk-flush.c          | 30 +++++++++++++++++++++++++-----
>  block/blk.h                |  1 -
>  drivers/nvme/target/loop.c | 10 ++++++++++
>  include/linux/blk-mq.h     |  3 +++
>  4 files changed, 38 insertions(+), 6 deletions(-)
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Qian Cai <cai@redhat.com>
> Cc: Sumit Saxena <sumit.saxena@broadcom.com>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Kashyap Desai <kashyap.desai@broadcom.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Hannes Reinecke <hare@suse.de>
> -- 
> 2.28.0
> 

Hello Jens,

Ping...

-- 
Ming

