Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83EC2DDF77
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 09:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733016AbgLRIRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 03:17:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28267 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728212AbgLRIRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 03:17:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608279340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yJQNuWN6HgmUgv+RsZbi92+/+MM37ldG2zXD3RbUN9s=;
        b=Xbv8GTf5FtUOvs4iRAsmSsM5tBlUwXmXYapd/ftHlNEYdC2xyb3pOJIaP9727V65bqRJbY
        R8jTKCeFV13+ZWjNDty79mPP5s/IINhhOelWjwpTTR7/Bc+TT5LgSPL6Pqq2qRbzPzJLmn
        4txXbL3b6vnMlmNEiQU89jHACJOCFdY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-qvQDpxyQMZ-GZo4KfyMmCg-1; Fri, 18 Dec 2020 03:15:37 -0500
X-MC-Unique: qvQDpxyQMZ-GZo4KfyMmCg-1
Received: by mail-wr1-f72.google.com with SMTP id b8so812938wrv.14
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 00:15:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yJQNuWN6HgmUgv+RsZbi92+/+MM37ldG2zXD3RbUN9s=;
        b=QerCBFK4vOyiZzvp1zaGtNJjkjg2YTcbi2znzuCRpOizyCKHDkIWA87AifaWLjc+7E
         ICw03r6TCMYJ9NdvFVvpiiL1v700Hmwbw4/wEs1lZ1GUnSOeufPEa8l+XDYvChEkIErS
         h9jVq3dkbJaxGbZiqUjjSZTs4PLk8BzbIY4G3mNmPPCrYuu9uWRgxQwHMDIlKF2FtMbp
         aPWAByZDe1aBTfGCcqaLxEcuuHNfKxhUO+MPx0SXtQtIFGglnABdvRno/63TYtRMKaS/
         sXUKRgWbQS1VMwXy4uEbG9Zdct/xXT7+YDlWcCLSrpkrrDtC9W5y1+EZQtgNXd2x7PCh
         Nmjw==
X-Gm-Message-State: AOAM530BEs5pqKDx86K+xJxjT4Nm9BMk2qgWvdTDe+89PwTYFI/vTkqD
        sL/sZUUghiCo3Uq+HJOQxlB6KEi6ZGu8rhyjh+wqrriaLS6ExkccOwmpZAnuLxBwkVvgyNA68c/
        /jluq2Jl4xh/GwL1rOLrZkNFw
X-Received: by 2002:adf:e710:: with SMTP id c16mr3007763wrm.295.1608279336680;
        Fri, 18 Dec 2020 00:15:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxUFVDuslSIR7sNU3rmxCt3qjTQFKF/gKj1mKj2MVbmEs9Iy1ApdCkivOAma0zVSTrHR8vMmw==
X-Received: by 2002:adf:e710:: with SMTP id c16mr3007739wrm.295.1608279336451;
        Fri, 18 Dec 2020 00:15:36 -0800 (PST)
Received: from steredhat (host-79-13-204-15.retail.telecomitalia.it. [79.13.204.15])
        by smtp.gmail.com with ESMTPSA id k6sm10866853wmf.25.2020.12.18.00.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 00:15:35 -0800 (PST)
Date:   Fri, 18 Dec 2020 09:15:33 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Zouwei (Samuel)" <zou_wei@huawei.com>
Cc:     "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "mgurtovoy@nvidia.com" <mgurtovoy@nvidia.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSN?= =?utf-8?Q?=3A?= [PATCH -next] vdpa: Mark
 macaddr_buf with static keyword
Message-ID: <20201218081533.r7lv3yx5xba46saa@steredhat>
References: <1608256295-69649-1-git-send-email-zou_wei@huawei.com>
 <20201218075659.zjts2fiwp2jkh2ei@steredhat>
 <14fa1fb211784992a0e64e9810bdedef@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14fa1fb211784992a0e64e9810bdedef@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 08:11:20AM +0000, Zouwei (Samuel) wrote:
>Hi,
>I run this command:
>make allmodconfig ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-
>make C=2 drivers/vdpa/vdpa_sim/vdpa_sim_net.o ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-

Yeah, I can see the warning using C=2.
I'll use it next times.

Thanks for sharing,
Stefano

>
>
>-----邮件原件-----
>发件人: Stefano Garzarella [mailto:sgarzare@redhat.com]
>发送时间: 2020年12月18日 15:57
>收件人: Zouwei (Samuel) <zou_wei@huawei.com>
>抄送: mst@redhat.com; jasowang@redhat.com; mgurtovoy@nvidia.com; virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org
>主题: Re: [PATCH -next] vdpa: Mark macaddr_buf with static keyword
>
>On Fri, Dec 18, 2020 at 09:51:35AM +0800, Zou Wei wrote:
>>Fix the following sparse warning:
>>
>>drivers/vdpa/vdpa_sim/vdpa_sim_net.c:36:4: warning: symbol 'macaddr_buf' was not declared. Should it be static?
>>
>>Reported-by: Hulk Robot <hulkci@huawei.com>
>>Signed-off-by: Zou Wei <zou_wei@huawei.com>
>>---
>> drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>
>I built with W=1 but I didn't have this warning.
>
>Thanks for fixing,
>Stefano
>
>>
>>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>>b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>>index c10b698..f048242 100644
>>--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>>@@ -33,7 +33,7 @@ static char *macaddr;  module_param(macaddr, charp,
>>0);  MODULE_PARM_DESC(macaddr, "Ethernet MAC address");
>>
>>-u8 macaddr_buf[ETH_ALEN];
>>+static u8 macaddr_buf[ETH_ALEN];
>>
>> static struct vdpasim *vdpasim_net_dev;
>>
>>--
>>2.6.2
>>
>

