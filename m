Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E652C7D6F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 04:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgK3DdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 22:33:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41533 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727387AbgK3DdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 22:33:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606707117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I0HRTFCFoP29oy6MJspA5BbLf81O/XKx0AAg815vRN8=;
        b=PD3GIFW2NQOq5dkQdsyWJinlG2bIlQixXO4aYhykWZYmpho+BkRz/O9iEyfZXmbGLv9fEl
        EaHHxooQQylCavhZE1MEM1RMQz1ZGvUP0deAWG8kBT3WvJpc70JXKzbzyLEuk8Yikqzetj
        OxEOZaJNmqNeIvaTHR2UYUvjpVLhpVg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-wqITtZ1iMMKoCD3kiCzHrA-1; Sun, 29 Nov 2020 22:31:55 -0500
X-MC-Unique: wqITtZ1iMMKoCD3kiCzHrA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2215880EDB5;
        Mon, 30 Nov 2020 03:31:54 +0000 (UTC)
Received: from [10.72.13.173] (ovpn-13-173.pek2.redhat.com [10.72.13.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 36A6710016F4;
        Mon, 30 Nov 2020 03:31:44 +0000 (UTC)
Subject: Re: [PATCH v2 17/17] vdpa: split vdpasim to core and net modules
To:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <20201126144950.92850-18-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <ce5f1f8b-a0e2-5c3f-2e49-48e0379d1bba@redhat.com>
Date:   Mon, 30 Nov 2020 11:31:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201126144950.92850-18-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/26 下午10:49, Stefano Garzarella wrote:
> From: Max Gurtovoy<mgurtovoy@nvidia.com>
>
> Introduce new vdpa_sim_net and vdpa_sim (core) drivers. This is a
> preparation for adding a vdpa simulator module for block devices.
>
> Signed-off-by: Max Gurtovoy<mgurtovoy@nvidia.com>
> [sgarzare: various cleanups/fixes]
> Signed-off-by: Stefano Garzarella<sgarzare@redhat.com>
> ---
> v2:
> - Fixed "warning: variable 'dev' is used uninitialized" reported by
>    'kernel test robot' and Dan Carpenter
> - rebased on top of other changes (dev_attr, get_config(), notify(), etc.)
> - left batch_mapping module parameter in the core [Jason]
>
> v1:
> - Removed unused headers
> - Removed empty module_init() module_exit()
> - Moved vdpasim_is_little_endian() in vdpa_sim.h
> - Moved vdpasim16_to_cpu/cpu_to_vdpasim16() in vdpa_sim.h
> - Added vdpasim*_to_cpu/cpu_to_vdpasim*() also for 32 and 64
> - Replaced 'select VDPA_SIM' with 'depends on VDPA_SIM' since selected
>    option can not depend on other [Jason]
> ---
>   drivers/vdpa/vdpa_sim/vdpa_sim.h     | 103 +++++++++++++
>   drivers/vdpa/vdpa_sim/vdpa_sim.c     | 222 +--------------------------
>   drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 171 +++++++++++++++++++++
>   drivers/vdpa/Kconfig                 |  13 +-
>   drivers/vdpa/vdpa_sim/Makefile       |   1 +
>   5 files changed, 290 insertions(+), 220 deletions(-)
>   create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim.h
>   create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim_net.c


Looks good, consider there are some still some questions left. I will 
probably ack for the next version.

Thanks

