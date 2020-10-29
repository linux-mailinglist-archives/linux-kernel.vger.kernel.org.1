Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5C229EB47
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 13:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgJ2MIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 08:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgJ2MIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 08:08:42 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D48C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 05:08:42 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t9so2452865wrq.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 05:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nUIB6xZbdC+X2BzItFkytedV7dKtPaiafogFyZyseZE=;
        b=PHuJ+bnVXtr8bCch947yAWTwMo9qMXm58rkBr82hg3AZZ8S7xMUrQHCZdeEUO1bekc
         EA7NgL/AwvVaKX+AxXIyDJPGoEmqn0199oWTb3/4tfqHolNBsPVNAEerd6xoch/qwKyy
         JImhzlrXjdg9WDXLXyfJoM1c3cUZWHoGUuLhAU/pqaA2x6KBEtZ46/aA/931NsqalJps
         C8FuDbByFHVjEawboOUXsfke+Ri1pd3gTKVniscBchF84lEMSWf0IPhuDLZSe68IZmNM
         rWhlfXaYha94dIYQQGOOxhJGDTiYqEn2rUxzg0zMZgc08BQ0Xe0B2JHCKVyFfV33KHYA
         c+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nUIB6xZbdC+X2BzItFkytedV7dKtPaiafogFyZyseZE=;
        b=TW6i7M12LAP3Nl8RI2rp/VGvCRht5psAsmqLdX4zI2cNvQT6wXHXFoq0tCdgu7Q/qO
         07+QsbunuChslwlHRHoMMBHDytPDGu8TO2ZdeRbEZbmrxVUuolEGkZQMh/oKaub5xGWc
         5kN0OOppda42aPc37rZr8FybDXMa3g1h9FUgn5tDyPq7u2r9yTn2aJC42DADQkl7k/Uj
         Ctk+0lpe/R8AttO4++dNH5s57tHetZYHeEcnuS4jLGphgC/4zGATNLseXrYgfy8qRtYV
         +CHWgAYf6aV1aEeXwwcLVMpMtsdpzvh5pHJ3X/CEDwV5c8qA1Lp+/4xkxABu7xGnQVs/
         yCiw==
X-Gm-Message-State: AOAM530GHzR0sSdtXD6+tO1bMFVTplr5n1shdcrmfpsbDfmTo+Q6B1xi
        BKRgTMrP/8LSIansdzOMbHhtWJutfRJ62g==
X-Google-Smtp-Source: ABdhPJyY3ZC5LP6m4CqlYSywFoLp6+tH70dEFSQSOe7l4cXpzKhBa7FXu4KGeIR3M6icu/3d7A0uhA==
X-Received: by 2002:a5d:694b:: with SMTP id r11mr5352158wrw.104.1603973320640;
        Thu, 29 Oct 2020 05:08:40 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id k16sm4182967wmi.5.2020.10.29.05.08.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2020 05:08:39 -0700 (PDT)
Subject: Re: [PATCH v3 3/4] nvmem: core: Add support for keepout regions
To:     Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org
References: <20201029002827.1729915-1-evgreen@chromium.org>
 <20201028172737.v3.3.Ibb3eedcd634298b039e3af2ec43c7860ae947916@changeid>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <c244ed8a-ccd4-6e7d-501c-e3d7f2da3916@linaro.org>
Date:   Thu, 29 Oct 2020 12:08:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20201028172737.v3.3.Ibb3eedcd634298b039e3af2ec43c7860ae947916@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Evan for doing this,

On 29/10/2020 00:28, Evan Green wrote:
> Introduce support into the nvmem core for arrays of register ranges
> that should not result in actual device access. For these regions a
> constant byte (repeated) is returned instead on read, and writes are
> quietly ignored and returned as successful.
> 
> This is useful for instance if certain efuse regions are protected
> from access by Linux because they contain secret info to another part
> of the system (like an integrated modem).
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>

Overall the patch looks good for me.
I have applied just this patch for more testing in next!

I can pick up 1/4 and 4/4 once Rob's Ack/Reviews the patch!

thanks,
srini
> ---
> 
> Changes in v3:
>   - Use min()/max() macros instead of defining my own (Doug)
>   - Comment changes to indicate sorting (Doug)
>   - Add function to validate keepouts are proper (Doug)
> 
> Changes in v2:
>   - Introduced keepout regions into the core (Srini)
> 
>   drivers/nvmem/core.c           | 153 ++++++++++++++++++++++++++++++++-
>   include/linux/nvmem-provider.h |  17 ++++
>   2 files changed, 166 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index a09ff8409f600..177f5bf27c6d5 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -34,6 +34,8 @@ struct nvmem_device {
>   	struct bin_attribute	eeprom;
>   	struct device		*base_dev;
>   	struct list_head	cells;
> +	const struct nvmem_keepout *keepout;
> +	unsigned int		nkeepout;
>   	nvmem_reg_read_t	reg_read;
>   	nvmem_reg_write_t	reg_write;
>   	struct gpio_desc	*wp_gpio;
> @@ -66,8 +68,8 @@ static LIST_HEAD(nvmem_lookup_list);
>   
>   static BLOCKING_NOTIFIER_HEAD(nvmem_notifier);
>   
> -static int nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,
> -			  void *val, size_t bytes)
> +static int __nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,
> +			    void *val, size_t bytes)
>   {
>   	if (nvmem->reg_read)
>   		return nvmem->reg_read(nvmem->priv, offset, val, bytes);
> @@ -75,8 +77,8 @@ static int nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,
>   	return -EINVAL;
>   }
>   
> -static int nvmem_reg_write(struct nvmem_device *nvmem, unsigned int offset,
> -			   void *val, size_t bytes)
> +static int __nvmem_reg_write(struct nvmem_device *nvmem, unsigned int offset,
> +			     void *val, size_t bytes)
>   {
>   	int ret;
>   
> @@ -90,6 +92,88 @@ static int nvmem_reg_write(struct nvmem_device *nvmem, unsigned int offset,
>   	return -EINVAL;
>   }
>   
> +static int nvmem_access_with_keepouts(struct nvmem_device *nvmem,
> +				      unsigned int offset, void *val,
> +				      size_t bytes, int write)
> +{
> +
> +	unsigned int end = offset + bytes;
> +	unsigned int kend, ksize;
> +	const struct nvmem_keepout *keepout = nvmem->keepout;
> +	const struct nvmem_keepout *keepoutend = keepout + nvmem->nkeepout;
> +	int rc;
> +
> +	/*
> +	 * Skip all keepouts before the range being accessed.
> +	 * Keepouts are sorted.
> +	 */
> +	while ((keepout < keepoutend) && (keepout->end <= offset))
> +		keepout++;
> +
> +	while ((offset < end) && (keepout < keepoutend)) {
> +		/* Access the valid portion before the keepout. */
> +		if (offset < keepout->start) {
> +			kend = min(end, keepout->start);
> +			ksize = kend - offset;
> +			if (write)
> +				rc = __nvmem_reg_write(nvmem, offset, val, ksize);
> +			else
> +				rc = __nvmem_reg_read(nvmem, offset, val, ksize);
> +
> +			if (rc)
> +				return rc;
> +
> +			offset += ksize;
> +			val += ksize;
> +		}
> +
> +		/*
> +		 * Now we're aligned to the start of this keepout zone. Go
> +		 * through it.
> +		 */
> +		kend = min(end, keepout->end);
> +		ksize = kend - offset;
> +		if (!write)
> +			memset(val, keepout->value, ksize);
> +
> +		val += ksize;
> +		offset += ksize;
> +		keepout++;
> +	}
> +
> +	/*
> +	 * If we ran out of keepouts but there's still stuff to do, send it
> +	 * down directly
> +	 */
> +	if (offset < end) {
> +		ksize = end - offset;
> +		if (write)
> +			return __nvmem_reg_write(nvmem, offset, val, ksize);
> +		else
> +			return __nvmem_reg_read(nvmem, offset, val, ksize);
> +	}
> +
> +	return 0;
> +}
> +
> +static int nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,
> +			  void *val, size_t bytes)
> +{
> +	if (!nvmem->nkeepout)
> +		return __nvmem_reg_read(nvmem, offset, val, bytes);
> +
> +	return nvmem_access_with_keepouts(nvmem, offset, val, bytes, false);
> +}
> +
> +static int nvmem_reg_write(struct nvmem_device *nvmem, unsigned int offset,
> +			   void *val, size_t bytes)
> +{
> +	if (!nvmem->nkeepout)
> +		return __nvmem_reg_write(nvmem, offset, val, bytes);
> +
> +	return nvmem_access_with_keepouts(nvmem, offset, val, bytes, true);
> +}
> +
>   #ifdef CONFIG_NVMEM_SYSFS
>   static const char * const nvmem_type_str[] = {
>   	[NVMEM_TYPE_UNKNOWN] = "Unknown",
> @@ -533,6 +617,59 @@ nvmem_find_cell_by_name(struct nvmem_device *nvmem, const char *cell_id)
>   	return cell;
>   }
>   
> +static int nvmem_validate_keepouts(struct nvmem_device *nvmem)
> +{
> +	unsigned int cur = 0;
> +	const struct nvmem_keepout *keepout = nvmem->keepout;
> +	const struct nvmem_keepout *keepoutend = keepout + nvmem->nkeepout;
> +
> +	while (keepout < keepoutend) {
> +		/* Ensure keepouts are sorted and don't overlap. */
> +		if (keepout->start < cur) {
> +			dev_err(&nvmem->dev,
> +				"Keepout regions aren't sorted or overlap.\n");
> +
> +			return -ERANGE;
> +		}
> +
> +		if (keepout->end < keepout->start) {
> +			dev_err(&nvmem->dev,
> +				"Invalid keepout region.\n");
> +
> +			return -EINVAL;
> +		}
> +
> +		/*
> +		 * Validate keepouts (and holes between) don't violate
> +		 * word_size constraints.
> +		 */
> +		if ((keepout->end - keepout->start < nvmem->word_size) ||
> +		    ((keepout->start != cur) &&
> +		     (keepout->start - cur < nvmem->word_size))) {
> +
> +			dev_err(&nvmem->dev,
> +				"Keepout regions violate word_size constraints.\n");
> +
> +			return -ERANGE;
> +		}
> +
> +		/* Validate keepouts don't violate stride (alignment). */
> +		if (!IS_ALIGNED(keepout->start, nvmem->stride) ||
> +		    !IS_ALIGNED(keepout->end, nvmem->stride)) {
> +
> +			dev_err(&nvmem->dev,
> +				"Keepout regions violate stride.\n");
> +
> +			return -EINVAL;
> +		}
> +
> +		cur = keepout->end;
> +		keepout++;
> +	}
> +
> +	return 0;
> +}
> +
>   static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
>   {
>   	struct device_node *parent, *child;
> @@ -647,6 +784,8 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   	nvmem->type = config->type;
>   	nvmem->reg_read = config->reg_read;
>   	nvmem->reg_write = config->reg_write;
> +	nvmem->keepout = config->keepout;
> +	nvmem->nkeepout = config->nkeepout;
>   	if (!config->no_of_node)
>   		nvmem->dev.of_node = config->dev->of_node;
>   
> @@ -671,6 +810,12 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   	nvmem->dev.groups = nvmem_dev_groups;
>   #endif
>   
> +	if (nvmem->nkeepout) {
> +		rval = nvmem_validate_keepouts(nvmem);
> +		if (rval)
> +			goto err_put_device;
> +	}
> +
>   	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
>   
>   	rval = device_register(&nvmem->dev);
> diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
> index 06409a6c40bcb..e162b757b6d54 100644
> --- a/include/linux/nvmem-provider.h
> +++ b/include/linux/nvmem-provider.h
> @@ -30,6 +30,19 @@ enum nvmem_type {
>   #define NVMEM_DEVID_NONE	(-1)
>   #define NVMEM_DEVID_AUTO	(-2)
>   
> +/**
> + * struct nvmem_keepout - NVMEM register keepout range.
> + *
> + * @start:	The first byte offset to avoid.
> + * @end:	One beyond the last byte offset to avoid.
> + * @value:	The byte to fill reads with for this region.
> + */
> +struct nvmem_keepout {
> +	unsigned int start;
> +	unsigned int end;
> +	unsigned char value;
> +};
> +
>   /**
>    * struct nvmem_config - NVMEM device configuration
>    *
> @@ -39,6 +52,8 @@ enum nvmem_type {
>    * @owner:	Pointer to exporter module. Used for refcounting.
>    * @cells:	Optional array of pre-defined NVMEM cells.
>    * @ncells:	Number of elements in cells.
> + * @keepout:	Optional array of keepout ranges (sorted ascending by start).
> + * @nkeepout:	Number of elements in the keepout array.
>    * @type:	Type of the nvmem storage
>    * @read_only:	Device is read-only.
>    * @root_only:	Device is accessibly to root only.
> @@ -66,6 +81,8 @@ struct nvmem_config {
>   	struct gpio_desc	*wp_gpio;
>   	const struct nvmem_cell_info	*cells;
>   	int			ncells;
> +	const struct nvmem_keepout *keepout;
> +	unsigned int		nkeepout;
>   	enum nvmem_type		type;
>   	bool			read_only;
>   	bool			root_only;
> 
