Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947EE2DDDD2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 06:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732609AbgLRFWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 00:22:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55387 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725290AbgLRFWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 00:22:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608268835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=94PrZx6Z4+qP5Gaz/7jmhZepyks5QupCBhkE6trvHVw=;
        b=O87eEFzKzgxb+vgxGPoir8xze2xtWFzVDNsCW5j3ZyQx5v8UZUaCg4e7vlTva77Y3YLJaP
        pc862I/W0rkh2fqY1soeOl1iWNDfaLff7jgWOKv4PlXUrlQWZCCQ6cJYCPLuwpeOU7J4+Q
        c7pYjuagBDtRJ/kRebac3IwuECbA/0Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-KcdK9ONvOK-xU_LaUCn9uQ-1; Fri, 18 Dec 2020 00:20:33 -0500
X-MC-Unique: KcdK9ONvOK-xU_LaUCn9uQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0842107ACE3;
        Fri, 18 Dec 2020 05:20:32 +0000 (UTC)
Received: from [10.72.12.111] (ovpn-12-111.pek2.redhat.com [10.72.12.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0812910021B3;
        Fri, 18 Dec 2020 05:20:23 +0000 (UTC)
Subject: Re: [PATCH -next] vdpa: Mark macaddr_buf with static keyword
To:     Zou Wei <zou_wei@huawei.com>, mst@redhat.com
Cc:     sgarzare@redhat.com, mgurtovoy@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1608256295-69649-1-git-send-email-zou_wei@huawei.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <93257e41-f0d6-11d7-678e-9b94a55ce3cd@redhat.com>
Date:   Fri, 18 Dec 2020 13:20:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1608256295-69649-1-git-send-email-zou_wei@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/12/18 上午9:51, Zou Wei wrote:
> Fix the following sparse warning:
>
> drivers/vdpa/vdpa_sim/vdpa_sim_net.c:36:4: warning: symbol 'macaddr_buf' was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>   drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> index c10b698..f048242 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> @@ -33,7 +33,7 @@ static char *macaddr;
>   module_param(macaddr, charp, 0);
>   MODULE_PARM_DESC(macaddr, "Ethernet MAC address");
>   
> -u8 macaddr_buf[ETH_ALEN];
> +static u8 macaddr_buf[ETH_ALEN];
>   
>   static struct vdpasim *vdpasim_net_dev;


Acked-by: Jason Wang <jasowang@redhat.com>



>   

