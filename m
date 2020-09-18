Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D59626ED54
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 04:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbgIRCSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 22:18:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34261 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729372AbgIRCST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 22:18:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600395499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fScXCn92Z2M4f5AGmAC2C4Z0ZYGJptb/Xy5j5iRbW78=;
        b=ByDmbHL3FHuSOEdaWNdsHFKLmGA48ZtOti1gA9+mnYc6u/UBznam2+dWqayBKLTvJN1vOE
        k6ywfMb9h6r51OPNZwJRKyKnSEljFAY/m/GlzrUS/tuwOb0IK/XyWfAFWgazjZoT/0zlE1
        0J+r1FtIAHg7JFkfhrrkt2VpF6ZOj8A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-PPTSZXiXN8q1jnpCMVT9Rg-1; Thu, 17 Sep 2020 22:18:16 -0400
X-MC-Unique: PPTSZXiXN8q1jnpCMVT9Rg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C417C10BBED9;
        Fri, 18 Sep 2020 02:18:15 +0000 (UTC)
Received: from [10.72.13.167] (ovpn-13-167.pek2.redhat.com [10.72.13.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 63F0555765;
        Fri, 18 Sep 2020 02:18:08 +0000 (UTC)
Subject: Re: [vhost next 0/2] mlx5 vdpa fix netdev status
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     lulu@redhat.com
References: <20200917121320.GA98085@mtl-vdi-166.wap.labs.mlnx>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <c3b9f21c-11ae-b192-be5b-4a3bc0338712@redhat.com>
Date:   Fri, 18 Sep 2020 10:18:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200917121320.GA98085@mtl-vdi-166.wap.labs.mlnx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/9/17 下午8:13, Eli Cohen wrote:
> Hi Michael,
>
> the following two patches aim to fix a failure to set the vdpa driver
> status bit VIRTIO_NET_S_LINK_UP thus causing failure to bring the link
> up. I break it to two patches:
>
> 1. Introduce proper mlx5 API to set 16 bit status fields per virtio
> requirements.
> 2. Fix the failure to set the bit
>
> Eli Cohen (2):
>    vdpa/mlx5: Make use of a specific 16 bit endianness API
>    vdpa/mlx5: Fix failure to bring link up
>
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)


Acked-by: Jason Wang <jasowang@redhat.com>


