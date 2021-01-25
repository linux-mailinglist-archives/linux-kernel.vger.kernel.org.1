Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2262303505
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 06:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbhAZFdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 00:33:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35658 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727317AbhAYKXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 05:23:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611570102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=neC9gRrB4GfD4ikmR6bOJWjEMRDiBCVqaviG/V2Kj6M=;
        b=bzyyobXeLlbDDcoXFCfNB/hDbPLn8MYVluNY7gmmbzyU6XSmiBM7eXb0DendK0BxXJ6lSm
        rnPwinzwdSLCXr4sPU5ltXvbhz0Aunzvy3UfB1oL760/hQsv6ZXSq7u0A4Z0+0OwjLEXgl
        H0JdYmNFgvSHukLI3zeo92D55P9ZF9A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-gJRtUu58MamTWfFDYece6Q-1; Mon, 25 Jan 2021 05:21:40 -0500
X-MC-Unique: gJRtUu58MamTWfFDYece6Q-1
Received: by mail-wr1-f71.google.com with SMTP id c1so7191004wrx.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 02:21:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=neC9gRrB4GfD4ikmR6bOJWjEMRDiBCVqaviG/V2Kj6M=;
        b=XszfCtbKlbdlWLjHOKD5aooq9+AMdcpm7D5OyKVEHrPHnjoLst52sZYO/lxjLxy37X
         01V2verzcRqLDps+YX/QFFiPNqzTkB4Piw9et0dhidTdTbiiF1hNddRdxMwQtqyxGrBc
         qIm8SqC3rSldgVWmFOZVyfVTDV0fPYBWjfP9Pm4wvP7C3O11q6rEXddWqKpfpngl6OC0
         4kNv84QpMO+/EtVk5o+KkR2gucsNUQVsWBUO1UcHJYaHFuVr4bQcBVYgar095GqTVCXi
         +eZmJLu0I2wUmy9Iaay6gSOP0GXhF8R+cpPdJ6PXouqeaJq+wQbcErb2RRUICbAaW5ne
         3Czw==
X-Gm-Message-State: AOAM533iDyRILj4LShVupNKckdbqf0CcTEPp1cq24I1zFKkaJOecGDr+
        q7U/ulGKTpL0zYsnrk8LGA7YaZrRfzMEEvgXHFQOJpqYCIvPapjjpDtsZF2AqfZRSQRChNIpRdW
        hVpiaBwTkImCJE7q++dQeG+z8
X-Received: by 2002:a05:6000:108b:: with SMTP id y11mr47283wrw.379.1611570099625;
        Mon, 25 Jan 2021 02:21:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzo8xB0nNvfVQNlZFuiUUrKX4YBDOVPnzKGovmFB65m63nYV0NQGp/FRjcrGa9UOHgLHWoAig==
X-Received: by 2002:a05:6000:108b:: with SMTP id y11mr47272wrw.379.1611570099455;
        Mon, 25 Jan 2021 02:21:39 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id z130sm20270523wmb.33.2021.01.25.02.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 02:21:38 -0800 (PST)
Date:   Mon, 25 Jan 2021 11:21:36 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Colin King <colin.king@canonical.com>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Parav Pandit <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] vpda: Fix memory leaks of msg on error return paths
Message-ID: <20210125102136.6e7dye5ucoe5qiw2@steredhat>
References: <20210122145235.209121-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210122145235.209121-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 02:52:35PM +0000, Colin King wrote:
>From: Colin Ian King <colin.king@canonical.com>
>
>There are two error return paths that neglect to free the allocated
>object msg that lead to memory leaks. Fix this by adding an error
>exit path that frees msg.
>
>Addresses-Coverity: ("Resource leak")
>Fixes: 39502d042a70 ("vdpa: Enable user to query vdpa device info")
>Signed-off-by: Colin Ian King <colin.king@canonical.com>
>---
> drivers/vdpa/vdpa.c | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>index 9700a0adcca0..eb1f5a514103 100644
>--- a/drivers/vdpa/vdpa.c
>+++ b/drivers/vdpa/vdpa.c
>@@ -540,13 +540,15 @@ static int vdpa_nl_cmd_dev_get_doit(struct sk_buff *skb, struct genl_info *info)
> 	if (!dev) {
> 		mutex_unlock(&vdpa_dev_mutex);
> 		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
>-		return -ENODEV;
>+		err = -ENODEV;
>+		goto err;
> 	}
> 	vdev = container_of(dev, struct vdpa_device, dev);
> 	if (!vdev->mdev) {
> 		mutex_unlock(&vdpa_dev_mutex);
> 		put_device(dev);
>-		return -EINVAL;
>+		err = -EINVAL;
>+		goto err;
> 	}
> 	err = vdpa_dev_fill(vdev, msg, info->snd_portid, info->snd_seq, 0, info->extack);
> 	if (!err)
>@@ -554,6 +556,7 @@ static int vdpa_nl_cmd_dev_get_doit(struct sk_buff *skb, struct genl_info *info)
> 	put_device(dev);
> 	mutex_unlock(&vdpa_dev_mutex);
>
>+err:
> 	if (err)
> 		nlmsg_free(msg);
> 	return err;

The patch looks okay, but reviewing it I figure out that if 
genlmsg_reply() returns an error, it also frees the sk_buff passed, so 
IIUC calling nlmsg_free() when genlmsg_reply() fails should cause a 
double free.

Maybe we should do something like this (not tested):

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 9700a0adcca0..920afcb4aa75 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -538,24 +538,29 @@ static int vdpa_nl_cmd_dev_get_doit(struct sk_buff *skb, struct genl_info *info)
         mutex_lock(&vdpa_dev_mutex);
         dev = bus_find_device(&vdpa_bus, NULL, devname, vdpa_name_match);
         if (!dev) {
-               mutex_unlock(&vdpa_dev_mutex);
                 NL_SET_ERR_MSG_MOD(info->extack, "device not found");
-               return -ENODEV;
+               err= -ENODEV;
+               goto err_msg;
         }
         vdev = container_of(dev, struct vdpa_device, dev);
         if (!vdev->mdev) {
-               mutex_unlock(&vdpa_dev_mutex);
-               put_device(dev);
-               return -EINVAL;
+               err = -EINVAL;
+               goto err_dev;
         }
         err = vdpa_dev_fill(vdev, msg, info->snd_portid, info->snd_seq, 0, info->extack);
-       if (!err)
-               err = genlmsg_reply(msg, info);
+       if (err)
+               goto err_dev;
+
         put_device(dev);
         mutex_unlock(&vdpa_dev_mutex);
  
-       if (err)
-               nlmsg_free(msg);
+       return genlmsg_reply(msg, info);
+
+err_dev:
+       put_device(dev);
+err_msg:
+       mutex_unlock(&vdpa_dev_mutex);
+       nlmsg_free(msg);
         return err;
  }
  

Thanks,
Stefano

