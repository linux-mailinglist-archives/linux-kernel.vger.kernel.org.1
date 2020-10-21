Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2F5294EF7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 16:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443306AbgJUOqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 10:46:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51549 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2442690AbgJUOqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 10:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603291559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NaMXT/y4BrbebVGe8E7alCrveFoprjBwvt8pmethQp0=;
        b=Vlqs9FqTX6rXo+9IRb9w/V13MOAkOfNK6pAQmN0FljZl77aqd/PNd3WQKpVh7FSuQf/+XG
        YXBIGo+TE85EvcJotYrGs7osSwwIK7KFLozFDiZJ7Ng1AbqVO6vzlC6IXeqtQhIW0MTdQg
        FvQ0kpsD97u8M72lu1ZvGSpdhAAHroc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-QbOWxe5gOm6-jglYJVbKgA-1; Wed, 21 Oct 2020 10:45:55 -0400
X-MC-Unique: QbOWxe5gOm6-jglYJVbKgA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EC7464162;
        Wed, 21 Oct 2020 14:45:53 +0000 (UTC)
Received: from redhat.com (ovpn-115-38.ams2.redhat.com [10.36.115.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C5F719930;
        Wed, 21 Oct 2020 14:45:47 +0000 (UTC)
Date:   Wed, 21 Oct 2020 10:45:44 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, rob.miller@broadcom.com,
        lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com,
        shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com,
        gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com
Subject: Re: [PATCH 0/4] vDPA: API for reporting IOVA range
Message-ID: <20201021104508-mutt-send-email-mst@kernel.org>
References: <20200617032947.6371-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617032947.6371-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 11:29:43AM +0800, Jason Wang wrote:
> Hi All:
> 
> This series introduces API for reporing IOVA range. This is a must for
> userspace to work correclty:
> 
> - for the process that uses vhost-vDPA directly to properly allocate
>   IOVA
> - for VM(qemu), when vIOMMU is not enabled, fail early if GPA is out
>   of range
> - for VM(qemu), when vIOMMU is enabled, determine a valid guest
>   address width
> 
> Please review.
> 
> Thanks

OK so what is the plan here? Change begin-end->first-last and repost?

> Jason Wang (4):
>   vdpa: introduce config op to get valid iova range
>   vdpa_sim: implement get_iova_range bus operation
>   vdpa: get_iova_range() is mandatory for device specific DMA
>     translation
>   vhost: vdpa: report iova range
> 
>  drivers/vdpa/vdpa.c              |  4 ++++
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 11 +++++++++++
>  drivers/vhost/vdpa.c             | 27 +++++++++++++++++++++++++++
>  include/linux/vdpa.h             | 14 ++++++++++++++
>  include/uapi/linux/vhost.h       |  4 ++++
>  include/uapi/linux/vhost_types.h |  5 +++++
>  6 files changed, 65 insertions(+)
> 
> -- 
> 2.20.1

