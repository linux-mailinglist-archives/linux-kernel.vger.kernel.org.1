Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B602A6D4D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 19:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbgKDS6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 13:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729679AbgKDS6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 13:58:46 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC93C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 10:58:45 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id h12so12941887qtc.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 10:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hfB0DSWTLiTu8ZzC419NNWd9j2K1BmkAw+YsWu6FT5A=;
        b=RNbUm2hENFioEkGFyvhGl4z7H4Vbv6KrXU6WwkrMbBOu1gGR1SwFiubCu9ZB0YbxS1
         gmpqjTll241CLMxfv/pLmDwOmxTsvvyENXz7I/JltjEIlXCEjt3BeZk7rjzH33Y/nIDh
         5ysoN1BDI1mQ49jqGKuZ/k4Pv9/XbMa/1rFZuEl4vIbkI1N7OVPZHLrtaO0AH7VMXygG
         Wt0W7EheNsOl2Ow/G5Kb4fww/7Tt/OYCOXodQt9tg1Gq8EefG0W3yXMFrHhIillsliIz
         0OHLCvlWOoiufhGxpxfHOBEHd2O7Pl8APUr1S0djaRQC18NCYyXb+mdYSeCKDdYrDDR6
         plDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hfB0DSWTLiTu8ZzC419NNWd9j2K1BmkAw+YsWu6FT5A=;
        b=HuFm/CrCyYn3XkgD1zMkx2+OLi4N8+JTcfQVcPqZmhk1P9Z80P5Jd4roB1lnilo6pt
         3sy5t7n6r0RaZbE7zhsZZpBIcnwq6c9NBZaPRCgLZNWUNd966jyS1Y8knBvdrkzaAmZp
         0Xh5RzXU3p1U1DlI0aX9N1LN1eSLR0Is8ToFhG4uDNFJRX4OucXgklSIlIgfUtOt0xIA
         Ufg+SGsTpJafUG0/kzBUc2XKHF3mFBvoAoNwnr4wpvhEJ5lCZK77clQ/4fKD+CpuuNUi
         nl34o3cNYwtDiFEr2zWEmUUWGB06Br6u7IFUDic2DkWrtvRSGJ2T+eNdXvmWThJbrbUk
         ofgQ==
X-Gm-Message-State: AOAM532/KDNLkfU8ySe2XehBqqykBLtas7921TWjKV2e9RBI9WbuaUVk
        waIZ9gwZW/deLrfVhlDRL3bevg==
X-Google-Smtp-Source: ABdhPJxsj/V64EaBSstAvLnvJThz7y9TKfysQWt5ygzqa77aglKGjn2z+mKuwKrbY6r7b5RQX+ZpSg==
X-Received: by 2002:ac8:588d:: with SMTP id t13mr21443413qta.380.1604516325038;
        Wed, 04 Nov 2020 10:58:45 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id b14sm3000314qkn.123.2020.11.04.10.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 10:58:44 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kaNzX-00GbZ5-Mo; Wed, 04 Nov 2020 14:58:43 -0400
Date:   Wed, 4 Nov 2020 14:58:43 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "xiaofeng.yan" <xiaofeng.yan2012@gmail.com>
Cc:     willy@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dledford@redhat.com,
        oulijun@huawei.com, yanxiaofeng7@jd.com
Subject: Re: [PATCH 2/2] infiniband: Modify the reference to xa_store_irq()
 because the parameter of this function  has changed
Message-ID: <20201104185843.GV36674@ziepe.ca>
References: <20201104023213.760-1-xiaofeng.yan2012@gmail.com>
 <20201104023213.760-2-xiaofeng.yan2012@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104023213.760-2-xiaofeng.yan2012@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 10:32:13AM +0800, xiaofeng.yan wrote:
> From: "xiaofeng.yan" <yanxiaofeng7@jd.com>
> 
> function xa_store_irq() has three parameters because of removing
> patameter "gfp_t gfp"
> 
> Signed-off-by: xiaofeng.yan <yanxiaofeng7@jd.com>
>  drivers/infiniband/core/cm.c            | 2 +-
>  drivers/infiniband/hw/hns/hns_roce_qp.c | 2 +-
>  drivers/infiniband/hw/mlx5/srq_cmd.c    | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
> index 5740d1ba3568..afcb5711270b 100644
> +++ b/drivers/infiniband/core/cm.c
> @@ -879,7 +879,7 @@ static struct cm_id_private *cm_alloc_id_priv(struct ib_device *device,
>  static void cm_finalize_id(struct cm_id_private *cm_id_priv)
>  {
>  	xa_store_irq(&cm.local_id_table, cm_local_id(cm_id_priv->id.local_id),
> -		     cm_id_priv, GFP_KERNEL);
> +		     cm_id_priv);
>  }

This one is almost a bug, the entry is preallocated with NULL though:

	ret = xa_alloc_cyclic_irq(&cm.local_id_table, &id, NULL, xa_limit_32b,
				  &cm.local_id_next, GFP_KERNEL);

so it should never allocate here:

static int cm_req_handler(struct cm_work *work)
{
	spin_lock_irq(&cm_id_priv->lock);
	cm_finalize_id(cm_id_priv);

Still, woops.

Matt, maybe a might_sleep is deserved in here someplace?

@@ -1534,6 +1534,8 @@ void *__xa_store(struct xarray *xa, unsigned long index, void *entry, gfp_t gfp)
        XA_STATE(xas, xa, index);
        void *curr;
 
+       might_sleep_if(gfpflags_allow_blocking(gfp));
+
        if (WARN_ON_ONCE(xa_is_advanced(entry)))
                return XA_ERROR(-EINVAL);
        if (xa_track_free(xa) && !entry)

And similar in the other places that conditionally call __xas_nomem()
?

I also still wish there was a proper 'xa store in already allocated
but null' idiom - I remember you thought about using gfp flags == 0 at
one point.

Jason
