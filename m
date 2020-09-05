Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFBC325EA6F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Sep 2020 22:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbgIEUkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Sep 2020 16:40:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54265 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728400AbgIEUj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 16:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599338395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kx8HzmaZpeYZYpWwlpa7IbVO/+/3Ogwe4v1RfYOzGi8=;
        b=INjEBySK9TSpKil5sFytoBsY2jYb3sweOs8lkR3tmb8whmw4rhCUCe7I1qaNDFy/o/GAR/
        mc/6hQypLj8lX8+wbWfBtq3W3HJRDDBrXPIK46hqTQvrl51+hkhEj7GN1yGBMWpBWiKZ7s
        Wid45J4Vg5lgqO73hPkm2VdGCp+u6zk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-_MKVJSABOVKnKbywJJQ0gg-1; Sat, 05 Sep 2020 16:39:54 -0400
X-MC-Unique: _MKVJSABOVKnKbywJJQ0gg-1
Received: by mail-qv1-f72.google.com with SMTP id p20so5686777qvl.4
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 13:39:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Kx8HzmaZpeYZYpWwlpa7IbVO/+/3Ogwe4v1RfYOzGi8=;
        b=CwKbF3rREHWJN/3ovJTFlE6fY256JfLSZTYqAslNS4kPYzXq2K5UJ6SibYwn/7xmQ/
         Mvs+hmwDmDdcabC1yvqN0Wq55n6Xr//m3AmhzqASlmoAGFkQnRnSiGZkGf1qj21d5doT
         bOF/cKeskAJ8Y5zNJFGd13GdGbx8k5dhtfDvXVRCvtbNL4K3eBDdECg3dpmvQwOfd8rm
         nDOBhirnP7JOlW8Rvs3wq/s/kSU6FMa/hUmVhtcuHPCZ8oxExxYAQb8CMvpCAc7JX990
         uUA8PHnGsKAv79GfbbSy4RwwJkpLM7BvPzLi+WQK4A/32YSYsUdfD2MEYnGt+mzQ/xNw
         d58w==
X-Gm-Message-State: AOAM531f+MMLnvePjidzM66iwa7MEGgyCkNy6ezvQD8DTQKEbZAgsym7
        6IQLkTX7xTK2TWqVKQlJFezxiwI61LxwCyjz4h7ZZLId8rBq2TKWNFdAzJNfiIafwAV1usXqZu+
        TQ9J+UNyk1VPtPbSwUYHvrVPE
X-Received: by 2002:ac8:411b:: with SMTP id q27mr14554196qtl.255.1599338393664;
        Sat, 05 Sep 2020 13:39:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEEppV8KOTKDOVXJjHNDLaJizH+e1HUtcIP/UpF9boOGOaBHyt97v0JQjlD2oPNxl6jMi+TQ==
X-Received: by 2002:ac8:411b:: with SMTP id q27mr14554188qtl.255.1599338393436;
        Sat, 05 Sep 2020 13:39:53 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l13sm6440861qtv.82.2020.09.05.13.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2020 13:39:52 -0700 (PDT)
Subject: Re: [PATCH v1 03/12] fpga: expose max10 flash update counts in sysfs
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20200904235305.6254-1-russell.h.weight@intel.com>
 <20200904235305.6254-4-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <a4ee319d-9f6f-5a27-415e-b1fabd1d5465@redhat.com>
Date:   Sat, 5 Sep 2020 13:39:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200904235305.6254-4-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/4/20 4:52 PM, Russ Weight wrote:
> Extend the MAX10 BMC Security Engine driver to provide a
> handler to expose the flash update count for the FPGA user
> image.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Wu Hao <hao.wu@intel.com>
> ---
>  drivers/fpga/intel-m10-bmc-secure.c | 32 +++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
> index 1f86bfb694b4..b824790e43aa 100644
> --- a/drivers/fpga/intel-m10-bmc-secure.c
> +++ b/drivers/fpga/intel-m10-bmc-secure.c
> @@ -10,6 +10,7 @@
>  #include <linux/mfd/intel-m10-bmc.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/slab.h>
>  #include <linux/vmalloc.h>
>  
>  struct m10bmc_sec {
> @@ -99,7 +100,38 @@ SYSFS_GET_REH(bmc, BMC_REH_ADDR)
>  SYSFS_GET_REH(sr, SR_REH_ADDR)
>  SYSFS_GET_REH(pr, PR_REH_ADDR)
>  
> +#define FLASH_COUNT_SIZE 4096
This seems too high at most it should be 64.
> +#define USER_FLASH_COUNT 0x17ffb000
Why shouldn't this be in intel-m10-bmc.h ?
> +
> +static int get_qspi_flash_count(struct ifpga_sec_mgr *imgr)

what does 'qspi' mean ?

unless there are going to be several *flash_count's consider

removing this substring.

> +{
> +	struct m10bmc_sec *sec = imgr->priv;
> +	unsigned int stride = regmap_get_reg_stride(sec->m10bmc->regmap);
> +	unsigned int cnt, num_bits = FLASH_COUNT_SIZE * 8;
> +	u8 *flash_buf;
> +	int ret;
> +
> +	flash_buf = kmalloc(FLASH_COUNT_SIZE, GFP_KERNEL);
> +	if (!flash_buf)
> +		return -ENOMEM;
> +
> +	ret = m10bmc_raw_bulk_read(sec->m10bmc, USER_FLASH_COUNT, flash_buf,
> +				   FLASH_COUNT_SIZE / stride);
> +	if (ret) {
> +		dev_err(sec->dev, "%s failed to read %d\n", __func__, ret);
> +		goto exit_free;
> +	}
> +
> +	cnt = num_bits - bitmap_weight((unsigned long *)flash_buf, num_bits);
Simplify ret = num_bits...
> +
> +exit_free:
> +	kfree(flash_buf);
> +
> +	return ret ? : cnt;

Then simplify

return ret;

Tom

> +}
> +
>  static const struct ifpga_sec_mgr_ops m10bmc_iops = {
> +	.user_flash_count = get_qspi_flash_count,
>  	.bmc_root_entry_hash = get_bmc_root_entry_hash,
>  	.sr_root_entry_hash = get_sr_root_entry_hash,
>  	.pr_root_entry_hash = get_pr_root_entry_hash,

