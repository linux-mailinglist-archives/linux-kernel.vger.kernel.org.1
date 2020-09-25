Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643D0278918
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 15:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgIYNMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 09:12:17 -0400
Received: from mga01.intel.com ([192.55.52.88]:26712 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727733AbgIYNMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 09:12:17 -0400
IronPort-SDR: 3LPFaPiWSxZqYFn5e11ZDgXQ46thrnltS/hmoUF3dmoLLTdzDP0nFUarcPeuvjnRzZhupmXLj/
 TXWuDvGDXTUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="179601717"
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; 
   d="scan'208";a="179601717"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 06:12:17 -0700
IronPort-SDR: dMMBxGcPo9STqViUY7Aq22CcrQ4X7+X+9yd9oxEb8XWtx2Gtfjv+XTz75iCMZ4j608TAnMmFy3
 mNj2AQwzk4BQ==
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; 
   d="scan'208";a="336655318"
Received: from sboyapat-mobl2.amr.corp.intel.com (HELO [10.209.154.99]) ([10.209.154.99])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 06:12:16 -0700
Subject: Re: [PATCH 1/2] regmap: add support to regmap_field_bulk_alloc/free
 apis
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, srivasam@codeaurora.org,
        lgirdwood@gmail.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        tiwai@suse.com, rohitkr@codeaurora.org,
        linux-kernel@vger.kernel.org
References: <20200925092804.23536-1-srinivas.kandagatla@linaro.org>
 <20200925092804.23536-2-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <eb7af426-ab00-b444-e578-cf3c4b329c95@linux.intel.com>
Date:   Fri, 25 Sep 2020 08:12:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200925092804.23536-2-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/25/20 4:28 AM, Srinivas Kandagatla wrote:
> Usage of regmap_field_alloc becomes much overhead when number of fields
> exceed more than 3.
> QCOM LPASS driver has extensively converted to use regmap_fileds.

Multiple typos scattered in this patch: fileds -> fields?

> 
> Using new bluk api to allocate fields makes it much more cleaner code to read!

bulk api?

> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Tested-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> ---
>   drivers/base/regmap/regmap.c | 100 +++++++++++++++++++++++++++++++++++
>   include/linux/regmap.h       |  11 ++++
>   2 files changed, 111 insertions(+)
> 
> diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
> index aec3f26bf711..271740a163ad 100644
> --- a/drivers/base/regmap/regmap.c
> +++ b/drivers/base/regmap/regmap.c
> @@ -1270,6 +1270,106 @@ struct regmap_field *devm_regmap_field_alloc(struct device *dev,
>   }
>   EXPORT_SYMBOL_GPL(devm_regmap_field_alloc);
>   
> +
> +/**
> + * regmap_field_bulk_alloc() - Allocate and initialise a bulk register field.
> + *
> + * @regmap: regmap bank in which this register field is located.
> + * @rm_field: regmap register fileds with in the bank.
> + * @reg_field: Register fields with in the bank.
> + * @num_fields: Number of register fileds.
> + *
> + * The return value will be an -ENOMEM on error or zero for success.
> + * Newly allocated regmap_fields should be freed by calling
> + * regmap_field_bulk_free()
> + */
> +int regmap_field_bulk_alloc(struct regmap *regmap,
> +			    struct regmap_field **rm_field,
> +			    struct reg_field *reg_field,
> +			    int num_fields)
> +{
> +	struct regmap_field *rf;
> +	int i;
> +
> +	rf = kcalloc(num_fields, sizeof(*rf), GFP_KERNEL);
> +	if (!rf)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < num_fields; i++) {
> +		regmap_field_init(&rf[i], regmap, reg_field[i]);
> +		rm_field[i] = &rf[i];
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(regmap_field_bulk_alloc);
> +
> +/**
> + * devm_regmap_field_bulk_alloc() - Allocate and initialise a bulk register
> + * fields.
> + *
> + * @dev: Device that will be interacted with
> + * @regmap: regmap bank in which this register field is located.
> + * @rm_field: regmap register fileds with in the bank.
> + * @reg_field: Register fields with in the bank.

within?

> + * @num_fields: Number of register fileds.
> + *
> + * The return value will be an -ENOMEM on error or zero for success.
> + * Newly allocated regmap_fields will be automatically freed by the
> + * device management code.
> + */
> +int devm_regmap_field_bulk_alloc(struct device *dev,
> +				 struct regmap *regmap,
> +				 struct regmap_field **rm_field,
> +				 struct reg_field *reg_field,
> +				 int num_fields)
> +{
> +	struct regmap_field *rf;
> +	int i;
> +
> +	rf = devm_kcalloc(dev, num_fields, sizeof(*rf), GFP_KERNEL);
> +	if (!rf)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < num_fields; i++) {
> +		regmap_field_init(&rf[i], regmap, reg_field[i]);
> +		rm_field[i] = &rf[i];
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(devm_regmap_field_bulk_alloc);
> +
> +/**
> + * regmap_field_bulk_free() - Free register field allocated using
> + *                       regmap_field_bulk_alloc.
> + *
> + * @field: regmap fields which should be freed.
> + */
> +void regmap_field_bulk_free(struct regmap_field *field)
> +{
> +	kfree(field);
> +}
> +EXPORT_SYMBOL_GPL(regmap_field_bulk_free);
> +
> +/**
> + * devm_regmap_field_bulk_free() - Free a bulk register field allocated using
> + *                            devm_regmap_field_bulk_alloc.
> + *
> + * @dev: Device that will be interacted with
> + * @field: regmap field which should be freed.
> + *
> + * Free register field allocated using devm_regmap_field_bulk_alloc(). Usually
> + * drivers need not call this function, as the memory allocated via devm
> + * will be freed as per device-driver life-cyle.
> + */
> +void devm_regmap_field_bulk_free(struct device *dev,
> +				 struct regmap_field *field)
> +{
> +	devm_kfree(dev, field);
> +}
> +EXPORT_SYMBOL_GPL(devm_regmap_field_bulk_free);
> +
>   /**
>    * devm_regmap_field_free() - Free a register field allocated using
>    *                            devm_regmap_field_alloc.
> diff --git a/include/linux/regmap.h b/include/linux/regmap.h
> index 0c49d59168b5..a35ec0a0d6e0 100644
> --- a/include/linux/regmap.h
> +++ b/include/linux/regmap.h
> @@ -1189,6 +1189,17 @@ struct regmap_field *devm_regmap_field_alloc(struct device *dev,
>   		struct regmap *regmap, struct reg_field reg_field);
>   void devm_regmap_field_free(struct device *dev,	struct regmap_field *field);
>   
> +int regmap_field_bulk_alloc(struct regmap *regmap,
> +			     struct regmap_field **rm_field,
> +			     struct reg_field *reg_field,
> +			     int num_fields);
> +void regmap_field_bulk_free(struct regmap_field *field);
> +int devm_regmap_field_bulk_alloc(struct device *dev, struct regmap *regmap,
> +				 struct regmap_field **field,
> +				 struct reg_field *reg_field, int num_fields);
> +void devm_regmap_field_bulk_free(struct device *dev,
> +				 struct regmap_field *field);
> +
>   int regmap_field_read(struct regmap_field *field, unsigned int *val);
>   int regmap_field_update_bits_base(struct regmap_field *field,
>   				  unsigned int mask, unsigned int val,
> 
