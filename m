Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED2D27E80C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 13:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbgI3L7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 07:59:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727997AbgI3L7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 07:59:14 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3967A2075F;
        Wed, 30 Sep 2020 11:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601467152;
        bh=j7TyWiQ46A8cgocAOXeM5f1+0eI0qyuI4IcopJ3Xq28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i8situxT7lHaqrW5D0ijbVCB0KIfk7XFB0RvE6AjJrbs5RQx3g7M6s91yj5s8zvx2
         noAxcYVL7Uks2NrVIGmIHd18W2m90leiGA2lHQHXx2cR+U9MlQs7EYqahR89rQXa6j
         dluo5/yAcjNy0jJjOzht9zpX+qLp3jcb0L87T61E=
Date:   Wed, 30 Sep 2020 13:59:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, rafael@kernel.org, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, srivasam@codeaurora.org,
        rohitkr@codeaurora.org
Subject: Re: [PATCH v2 1/2] regmap: add support to
 regmap_field_bulk_alloc/free apis
Message-ID: <20200930115915.GB1611809@kroah.com>
References: <20200925164856.10315-1-srinivas.kandagatla@linaro.org>
 <20200925164856.10315-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925164856.10315-2-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 05:48:55PM +0100, Srinivas Kandagatla wrote:
> Usage of regmap_field_alloc becomes much overhead when number of fields
> exceed more than 3.
> QCOM LPASS driver has extensively converted to use regmap_fields.
> 
> Using new bulk api to allocate fields makes it much more cleaner code to read!
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Tested-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> ---
>  drivers/base/regmap/regmap.c | 100 +++++++++++++++++++++++++++++++++++
>  include/linux/regmap.h       |  11 ++++
>  2 files changed, 111 insertions(+)
> 
> diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
> index aec3f26bf711..8d6aedce666d 100644
> --- a/drivers/base/regmap/regmap.c
> +++ b/drivers/base/regmap/regmap.c
> @@ -1270,6 +1270,106 @@ struct regmap_field *devm_regmap_field_alloc(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(devm_regmap_field_alloc);
>  
> +
> +/**
> + * regmap_field_bulk_alloc() - Allocate and initialise a bulk register field.
> + *
> + * @regmap: regmap bank in which this register field is located.
> + * @rm_field: regmap register fields within the bank.
> + * @reg_field: Register fields within the bank.
> + * @num_fields: Number of register fields.
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
> + * @rm_field: regmap register fields within the bank.
> + * @reg_field: Register fields within the bank.
> + * @num_fields: Number of register fields.
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
> + * will be freed as per device-driver life-cycle.
> + */
> +void devm_regmap_field_bulk_free(struct device *dev,
> +				 struct regmap_field *field)
> +{
> +	devm_kfree(dev, field);
> +}
> +EXPORT_SYMBOL_GPL(devm_regmap_field_bulk_free);
> +
>  /**
>   * devm_regmap_field_free() - Free a register field allocated using
>   *                            devm_regmap_field_alloc.
> diff --git a/include/linux/regmap.h b/include/linux/regmap.h
> index 0c49d59168b5..a35ec0a0d6e0 100644
> --- a/include/linux/regmap.h
> +++ b/include/linux/regmap.h
> @@ -1189,6 +1189,17 @@ struct regmap_field *devm_regmap_field_alloc(struct device *dev,
>  		struct regmap *regmap, struct reg_field reg_field);
>  void devm_regmap_field_free(struct device *dev,	struct regmap_field *field);
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

You only have a patch that uses these last two functions, so why add all
4?  We don't add infrastructure to the kernel without users.

thanks,

greg k-h
