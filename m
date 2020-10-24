Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4BD297CB0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 15:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761825AbgJXN7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 09:59:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43756 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1761814AbgJXN7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 09:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603547959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8KmBaS2YJr8kWdyqWOIZ92IbUvQAUIDpQIFRCq90/EQ=;
        b=cptcjbWdAm8NuEMBFUb7G4NJ5xtAfbn4966lQAUKvsjPYwwkST6VbEGArMy7hwBDfpM/Ct
        J6CXNZe0aMglbgHTwC+qxh7OqRmpR2PC3Wb6xFPRJAKDD1BKMz9LweaajK3Aust0S9S724
        EEFnDZ/0a6aKKXhWIDApMy4HNU/Yyvk=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-JuZtLnPKMFiFHbzJbwaggQ-1; Sat, 24 Oct 2020 09:59:17 -0400
X-MC-Unique: JuZtLnPKMFiFHbzJbwaggQ-1
Received: by mail-oo1-f71.google.com with SMTP id f12so312983oos.23
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 06:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8KmBaS2YJr8kWdyqWOIZ92IbUvQAUIDpQIFRCq90/EQ=;
        b=jDwRBu+OsYVpRzTxILG9GOZv/q4pBozs6fgstt1ZVSmmqmtBSGJAqW8628/FYY0ZFy
         lWXQurMSgI2UQNhSo/H62UmVm0HJ/k4J8sWzbhBKYY90YFwDI6FXXXcB9ZUmqOR1+toj
         nY8gu1UrbyDm1ugkXKDAKExWOhgvxff9zTuNqOmETsC8EKc3ga7Np0Ka4y9q6xEKv5zE
         q6IQ4D8FJ8OcclW4PRHzqfEfEyqk3VkBD32WJIiZ8kKqLfeHz6G8KwfCsD78WNk4hxse
         S2gPJgm+NfiWkume1IMyz0uGDtq/cmLoLgVmjg3KNIaANQuhwuBwwh0Ido90ogGhK94E
         y2/A==
X-Gm-Message-State: AOAM5325/++q/fcgch6jkyrwUucXBLTWev8HHLr7dXptO7kO5criKECW
        i5yBcpZZ64OAqPXBdE5b+zeBRZUnGKjRqKo++rW8vYwfBDYxASHpdxe+nnaLAQ1K1Hf+2CPzc5q
        YFt81SIyBmeVDuIx8M2mj/paH
X-Received: by 2002:aca:c64e:: with SMTP id w75mr5758440oif.134.1603547956985;
        Sat, 24 Oct 2020 06:59:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwVMVRpyHW964SEFmnh2ALQAff7JNNO5mS4ANH9Zf1jv0VgDT8+gvJOe2QUE14WeZWABsnsQ==
X-Received: by 2002:aca:c64e:: with SMTP id w75mr5758417oif.134.1603547956725;
        Sat, 24 Oct 2020 06:59:16 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id d11sm1262078oti.69.2020.10.24.06.59.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Oct 2020 06:59:16 -0700 (PDT)
Subject: Re: [RFC PATCH 2/6] fpga: dfl: export network configuration info for
 DFL based FPGA
To:     Xu Yilun <yilun.xu@intel.com>, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, davem@davemloft.net, kuba@kernel.org,
        mdf@kernel.org, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        netdev@vger.kernel.org, lgoncalv@redhat.com, hao.wu@intel.com
References: <1603442745-13085-1-git-send-email-yilun.xu@intel.com>
 <1603442745-13085-3-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <23767a73-dbd7-949a-1f58-176cf3d2d380@redhat.com>
Date:   Sat, 24 Oct 2020 06:59:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1603442745-13085-3-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/23/20 1:45 AM, Xu Yilun wrote:
> This patch makes preparation for supporting DFL Ether Group private
> feature driver, which reads bitstream_id.vendor_net_cfg field to
> determin the interconnection of network components on FPGA device.
>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ---
>  drivers/fpga/dfl-fme-main.c | 10 ++--------
>  drivers/fpga/dfl.c          | 21 +++++++++++++++++++++
>  drivers/fpga/dfl.h          | 12 ++++++++++++
>  include/linux/dfl.h         |  2 ++
>  4 files changed, 37 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> index 77ea04d..a2b8ba0 100644
> --- a/drivers/fpga/dfl-fme-main.c
> +++ b/drivers/fpga/dfl-fme-main.c
> @@ -46,14 +46,8 @@ static DEVICE_ATTR_RO(ports_num);
>  static ssize_t bitstream_id_show(struct device *dev,
>  				 struct device_attribute *attr, char *buf)
>  {
> -	void __iomem *base;
> -	u64 v;
> -
> -	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_HEADER);
> -
> -	v = readq(base + FME_HDR_BITSTREAM_ID);
> -
> -	return scnprintf(buf, PAGE_SIZE, "0x%llx\n", (unsigned long long)v);
> +	return scnprintf(buf, PAGE_SIZE, "0x%llx\n",
> +			 (unsigned long long)dfl_get_bitstream_id(dev));
should use sysfs_emit()
>  }
>  static DEVICE_ATTR_RO(bitstream_id);
>  
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index bc35750..ca3c678 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -537,6 +537,27 @@ void dfl_driver_unregister(struct dfl_driver *dfl_drv)
>  }
>  EXPORT_SYMBOL(dfl_driver_unregister);
>  
> +int dfl_dev_get_vendor_net_cfg(struct dfl_device *dfl_dev)
> +{
> +	struct device *fme_dev;
> +	u64 v;
> +
> +	if (!dfl_dev)
> +		return -EINVAL;
> +
> +	if (dfl_dev->type == FME_ID)
> +		fme_dev = dfl_dev->dev.parent;
> +	else
> +		fme_dev = dfl_dev->cdev->fme_dev;
> +
> +	if (!fme_dev)
> +		return -EINVAL;
> +
> +	v = dfl_get_bitstream_id(fme_dev);
> +	return (int)FIELD_GET(FME_BID_VENDOR_NET_CFG, v);
> +}
> +EXPORT_SYMBOL_GPL(dfl_dev_get_vendor_net_cfg);
> +
>  #define is_header_feature(feature) ((feature)->id == FEATURE_ID_FIU_HEADER)
>  
>  /**
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 2b82c96..6c7a6961 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -104,6 +104,9 @@
>  #define FME_CAP_CACHE_SIZE	GENMASK_ULL(43, 32)	/* cache size in KB */
>  #define FME_CAP_CACHE_ASSOC	GENMASK_ULL(47, 44)	/* Associativity */
>  
> +/* FME BITSTREAM_ID Register Bitfield */
> +#define FME_BID_VENDOR_NET_CFG	GENMASK_ULL(35, 32)     /* vendor net cfg */

Are there any other similar #defines that could be added here for completeness?

> +
>  /* FME Port Offset Register Bitfield */
>  /* Offset to port device feature header */
>  #define FME_PORT_OFST_DFH_OFST	GENMASK_ULL(23, 0)
> @@ -397,6 +400,15 @@ static inline bool is_dfl_feature_present(struct device *dev, u16 id)
>  	return !!dfl_get_feature_ioaddr_by_id(dev, id);
>  }
>  
> +static inline u64 dfl_get_bitstream_id(struct device *dev)
> +{
> +	void __iomem *base;
> +
> +	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_HEADER);
> +
> +	return readq(base + FME_HDR_BITSTREAM_ID);
> +}

This is is a generic change and should be split out.

Tom

> +
>  static inline
>  struct device *dfl_fpga_pdata_to_parent(struct dfl_feature_platform_data *pdata)
>  {
> diff --git a/include/linux/dfl.h b/include/linux/dfl.h
> index e1b2471..5ee2b1e 100644
> --- a/include/linux/dfl.h
> +++ b/include/linux/dfl.h
> @@ -67,6 +67,8 @@ struct dfl_driver {
>  #define to_dfl_dev(d) container_of(d, struct dfl_device, dev)
>  #define to_dfl_drv(d) container_of(d, struct dfl_driver, drv)
>  
> +int dfl_dev_get_vendor_net_cfg(struct dfl_device *dfl_dev);
> +
>  /*
>   * use a macro to avoid include chaining to get THIS_MODULE.
>   */

