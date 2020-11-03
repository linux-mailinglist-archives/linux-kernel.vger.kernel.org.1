Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25372A41A4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 11:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgKCKXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 05:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgKCKXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 05:23:39 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA253C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 02:23:38 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id w1so17933499wrm.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 02:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=X3yKDwPPNTrytpbBfgv7cCHjHcmjRfwqt9p/XDeYkyo=;
        b=QRhxYm+YceTsQC+h72Ex2xvsSiHV6Zcg8bngRxEDEX+YshcYjYMlKTtM1jsKqc2CqG
         Fi7hsXT0eYnb4vuhiEVTLbK2rD27QVzC+RSUkHmTyy/dWJoMZ14gnDJ+GGWyTOsftlkw
         hUdPkXtNR59R+A3KSa13fN0kg08pHN0XTiZsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=X3yKDwPPNTrytpbBfgv7cCHjHcmjRfwqt9p/XDeYkyo=;
        b=af/1v9a1ryxkKg/WaXeHExt6WSuiU0/TLTvY/8WR35G6yBUz9/EhyII5hByMIpB6kM
         N60vvshTkhmOtX9B7Q7ecj2iz1OWebRMGqno6W6t+dZSuKjQCd2O+EzhNQXCcq5o6XRg
         bFiMY8lrAqUsrKZlmHtcXLwJTkS9ra7OF7/rJj9XFXYZsgNstqk7EcSytLSr26M0+Rch
         amwKGTLgwlIGdyFsKCovBQ7xfsGY0X0aBsiaI1hu264ss4LvZzkoE+RekxAeTYGNkbVy
         GLfKRoapj0h6Mdmj0q6q6GbOkjWxLuZA1AOeN4jv60uWUkXeZK1y3+q8EW4FFpDHPFOJ
         G3FA==
X-Gm-Message-State: AOAM531rUDMaoAogLTvp+D9NLToD8d+fx4xGdNgHAv0X3FsKPPyhhf3I
        /wT7A7B3+4o3wMxeqChbVrk2dw==
X-Google-Smtp-Source: ABdhPJy8mdOpufzGnndck6O/psSpr1rfJsmzfCAICDlLUNVHP24rvX9xmKGZSifSRoVv/X13c7Kz7w==
X-Received: by 2002:adf:e807:: with SMTP id o7mr13825087wrm.303.1604399017611;
        Tue, 03 Nov 2020 02:23:37 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t4sm2413753wmb.20.2020.11.03.02.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 02:23:36 -0800 (PST)
Date:   Tue, 3 Nov 2020 11:23:34 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm: Add the new api to install irq
Message-ID: <20201103102334.GA401619@phenom.ffwll.local>
Mail-Followup-To: Tian Tao <tiantao6@hisilicon.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <1604369441-65254-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604369441-65254-1-git-send-email-tiantao6@hisilicon.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 10:10:41AM +0800, Tian Tao wrote:
> Add new api devm_drm_irq_install() to register interrupts,
> no need to call drm_irq_uninstall() when the drm module is removed.
> 
> v2:
> fixed the wrong parameter.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  drivers/gpu/drm/drm_drv.c | 23 +++++++++++++++++++++++
>  include/drm/drm_drv.h     |  3 ++-
>  2 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index cd162d4..0fe5243 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -39,6 +39,7 @@
>  #include <drm/drm_color_mgmt.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_file.h>
> +#include <drm/drm_irq.h>
>  #include <drm/drm_managed.h>
>  #include <drm/drm_mode_object.h>
>  #include <drm/drm_print.h>
> @@ -678,6 +679,28 @@ static int devm_drm_dev_init(struct device *parent,
>  	return ret;
>  }
>  
> +static void devm_drm_dev_irq_uninstall(void *data)
> +{
> +	drm_irq_uninstall(data);
> +}
> +
> +int devm_drm_irq_install(struct device *parent,

parent argument should not be needed, we have drm_device->dev. If that
doesn't work, then don't use the drm irq helpers, they're optional (and
there's already devm versions of the core irq functions).

Just a detail aside from all the other things alreay mentioned.
-Daniel

> +			 struct drm_device *dev, int irq)
> +{
> +	int ret;
> +
> +	ret = drm_irq_install(dev, irq);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action(parent, devm_drm_dev_irq_uninstall, dev);
> +	if (ret)
> +		devm_drm_dev_irq_uninstall(dev);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(devm_drm_irq_install);
> +
>  void *__devm_drm_dev_alloc(struct device *parent, struct drm_driver *driver,
>  			   size_t size, size_t offset)
>  {
> diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> index 0230762..fec1776 100644
> --- a/include/drm/drm_drv.h
> +++ b/include/drm/drm_drv.h
> @@ -513,7 +513,8 @@ struct drm_driver {
>  
>  void *__devm_drm_dev_alloc(struct device *parent, struct drm_driver *driver,
>  			   size_t size, size_t offset);
> -
> +int devm_drm_irq_install(struct device *parent, struct drm_device *dev,
> +			 int irq);
>  /**
>   * devm_drm_dev_alloc - Resource managed allocation of a &drm_device instance
>   * @parent: Parent device object
> -- 
> 2.7.4
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
