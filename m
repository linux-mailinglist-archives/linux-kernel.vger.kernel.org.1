Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3319E2D0A3E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 06:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgLGFfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 00:35:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33875 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725681AbgLGFfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 00:35:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607319238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XACq9GWCmmo6NXYAQTYpk91pnPXTw+WCfYd579095OU=;
        b=efXLcUGUdMjxvUN3QAptWWN/9gqOo0YGiLqPsiYvn/98YDvtkqEE2fl7etmQRZtwGD6dnk
        a/IBF88LwPsK+2oNeAY2cGu4K0GL4xpgQl2E42OShge2QedZx0yDwbrIPGmecm2JxTmAd2
        SAWV1sC7J+Iridcovqp/YNMAjUupFA8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-AGD0Oix3O_6b2Zn17OlPFg-1; Mon, 07 Dec 2020 00:33:53 -0500
X-MC-Unique: AGD0Oix3O_6b2Zn17OlPFg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 885B6803638;
        Mon,  7 Dec 2020 05:33:52 +0000 (UTC)
Received: from [10.72.13.171] (ovpn-13-171.pek2.redhat.com [10.72.13.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5042610016F5;
        Mon,  7 Dec 2020 05:33:43 +0000 (UTC)
Subject: Re: [PATCH v3 19/19] vdpa: split vdpasim to core and net modules
To:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Oren Duer <oren@nvidia.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Max Gurtovoy <mgurtovoy@nvidia.com>,
        Shahaf Shuler <shahafs@nvidia.com>, Eli Cohen <elic@nvidia.com>
References: <20201203170511.216407-1-sgarzare@redhat.com>
 <20201203170511.216407-20-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <767b99ba-4062-ccb9-7eba-f00bb371eaaf@redhat.com>
Date:   Mon, 7 Dec 2020 13:33:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201203170511.216407-20-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/12/4 上午1:05, Stefano Garzarella wrote:
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
>   drivers/vdpa/vdpa_sim/vdpa_sim.h     | 105 +++++++++++++
>   drivers/vdpa/vdpa_sim/vdpa_sim.c     | 224 +--------------------------
>   drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 171 ++++++++++++++++++++
>   drivers/vdpa/Kconfig                 |  13 +-
>   drivers/vdpa/vdpa_sim/Makefile       |   1 +
>   5 files changed, 292 insertions(+), 222 deletions(-)
>   create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim.h
>   create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim_net.c


Acked-by: Jason Wang <jasowang@redhat.com>


