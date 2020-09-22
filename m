Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5EA273ED3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 11:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgIVJsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 05:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgIVJsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 05:48:31 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C71C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 02:48:30 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j2so16323714wrx.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 02:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=dLcWF3MC92ALsFyXJ8BrkEm/oY9EFkl4jFs830rj3Vc=;
        b=ReqFep1n48mg0WSF7s7k+SJOQC7/beAG3otbvkkpSuLyp/oslkIa+4ShCBXOCHSMga
         L7oXCU39o2UFqEGJpuyE83qAx6oC2hr4XkWe3/RAjc+mj9MvMIG9xaVkCuwAnDe6YjOg
         CLsFp+ZKgWseR1CRA2fR+ea8esUv62qxaRY0lcu5CR2zRn1AlZMTMYaTlzKYR0QF17kP
         JGbzBzb7EQ4bKLvAetzHiv7tDJ8UwoIDV70HcLGCEEu0XUYEeSSj8A0WrkpQjif4u87a
         OnAJouyUP9PLEcpTnbFOa/GOnpz3NoKkkBQxlcbhxIdLIomm2RsnhnBRMhq7NRxn5c/R
         g5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dLcWF3MC92ALsFyXJ8BrkEm/oY9EFkl4jFs830rj3Vc=;
        b=LuLKN2M3+T2O81YIYZNa6l0hFxnshEn9VMh9qSkIgQNT2Quh86ykhblYminFAfWo4J
         v/3qz5qwTSA7oprZtdynh37KdvPkpX/2WWvDLJjBeyZvgUu5bibW54CRF613o83n5ol+
         Z4q+hcfXAYZw9cGhhFDZMGXoIKSMKRchBiyyN5EKT1S6uStg401OL+Lm9BUjHl6iOFnT
         xac+SYKmorsFaAEKMzRLRr8QGXiwTf3XGsyxFDPVtXpZ6Aj7OBgm0uMVcLvBwDj83l2E
         62UKVTKBJclHeyZu0VaigqyvvaMRUbN0Zns0B9Uq2k13ymKAPG0FPQBbH5Uj0j4R5R5g
         fFwA==
X-Gm-Message-State: AOAM5326L/8FkfhaIbhr/82jB5JhbEzhfkwWBI+Pu4Z46/D547noZSFg
        Oq6xXg8yNSVBBlv5wE5ppkf6Ag==
X-Google-Smtp-Source: ABdhPJw2/Ckqf4Qs0ZE0jaMiT+y7/pzywDmc+9m3peSplde28EtexceC+QIPTdtG/8d56LULJV7wJw==
X-Received: by 2002:a5d:43cf:: with SMTP id v15mr4728848wrr.149.1600768109338;
        Tue, 22 Sep 2020 02:48:29 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id b18sm26795124wrn.21.2020.09.22.02.48.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Sep 2020 02:48:28 -0700 (PDT)
Subject: Re: [PATCH 1/3] nvmem: core: introduce cells parser
To:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20200915124116.7196-1-vadym.kochan@plvision.eu>
 <20200915124116.7196-2-vadym.kochan@plvision.eu>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <b2e63a28-7678-832e-f585-6d0f959d1b75@linaro.org>
Date:   Tue, 22 Sep 2020 10:48:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200915124116.7196-2-vadym.kochan@plvision.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/09/2020 13:41, Vadym Kochan wrote:
> Currently NVMEM core does not allow to register cells for an already
> registered nvmem device and requires that this should be done before.
> But there might a driver which needs to parse the nvmem device and then
> register a cells table.
> 
> Introduce nvmem_parser API which allows to register cells parser which
> is called during nvmem device registration. During this stage the parser
> can read the nvmem device and register the cells table.
> 

Overall this approach looks okay to me!

Rather than a binding for onie cell parser, I think we should add a 
generic bindings for parser something like:


nvmem-cell-parser = "onie-tlv-cells";


I also think the parser matching should be done based on this string 
which can remove
1. new DT node for onie parser.
2. works for both DT and non-DT setups.

nvmem provider register will automatically parse this once it finds a 
matching parser or it will EPROBE_DEFER!

Let me know if you think it works for you!


--srini

> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> ---
>   drivers/nvmem/core.c           | 89 ++++++++++++++++++++++++++++++++++
>   include/linux/nvmem-provider.h | 27 +++++++++++
>   2 files changed, 116 insertions(+)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 6cd3edb2eaf6..82a96032bc3f 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -55,6 +55,14 @@ struct nvmem_cell {
>   	struct list_head	node;
>   };
>   
> +struct nvmem_parser {
> +	struct device_node	*nvmem_of;
> +	struct kref		refcnt;
> +	struct list_head	head;
> +	nvmem_parse_t		cells_parse;
> +	void *priv;
> +};
> +
>   static DEFINE_MUTEX(nvmem_mutex);
>   static DEFINE_IDA(nvmem_ida);
>   
> @@ -64,6 +72,9 @@ static LIST_HEAD(nvmem_cell_tables);
>   static DEFINE_MUTEX(nvmem_lookup_mutex);
>   static LIST_HEAD(nvmem_lookup_list);
>   
> +static DEFINE_MUTEX(nvmem_parser_mutex);
> +static LIST_HEAD(nvmem_parser_list);
> +
>   static BLOCKING_NOTIFIER_HEAD(nvmem_notifier);
>   
>   static int nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,
> @@ -571,6 +582,30 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
>   	return 0;
>   }
>   
> +static struct nvmem_parser *
> +__nvmem_parser_find_of(const struct nvmem_device *nvmem)
> +{
> +	struct nvmem_parser *parser;
> +
> +	list_for_each_entry(parser, &nvmem_parser_list, head) {
> +		if (dev_of_node(nvmem->base_dev) == parser->nvmem_of)
> +			return parser;
> +	}
> +
> +	return NULL;
> +}
> +
> +static void nvmem_cells_parse(struct nvmem_device *nvmem)
> +{
> +	struct nvmem_parser *parser;
> +
> +	mutex_lock(&nvmem_parser_mutex);
> +	parser = __nvmem_parser_find_of(nvmem);
> +	if (parser && parser->cells_parse)
> +		parser->cells_parse(parser->priv, nvmem);
> +	mutex_unlock(&nvmem_parser_mutex);
> +}
> +
>   /**
>    * nvmem_register() - Register a nvmem device for given nvmem_config.
>    * Also creates a binary entry in /sys/bus/nvmem/devices/dev-name/nvmem
> @@ -674,6 +709,8 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   			goto err_teardown_compat;
>   	}
>   
> +	nvmem_cells_parse(nvmem);
> +
>   	rval = nvmem_add_cells_from_table(nvmem);
>   	if (rval)
>   		goto err_remove_cells;
> @@ -1630,6 +1667,58 @@ const char *nvmem_dev_name(struct nvmem_device *nvmem)
>   }
>   EXPORT_SYMBOL_GPL(nvmem_dev_name);
>   
> +struct nvmem_parser *
> +nvmem_parser_register(const struct nvmem_parser_config *config)
> +{
> +	struct device_node *nvmem_of;
> +	struct nvmem_parser *parser;
> +	int err;
> +
> +	if (!config->cells_parse)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (!config->dev)
> +		return ERR_PTR(-EINVAL);
> +
> +	nvmem_of = of_parse_phandle(dev_of_node(config->dev), "nvmem", 0);
> +	if (!nvmem_of)
> +		return ERR_PTR(-EINVAL);
> +
> +	parser = kzalloc(sizeof(*parser), GFP_KERNEL);
> +	if (!parser) {
> +		err = -ENOMEM;
> +		goto err_alloc;
> +	}
> +
> +	parser->cells_parse = config->cells_parse;
> +	/* parser->cells_remove = config->cells_remove; */
> +	parser->nvmem_of = nvmem_of;
> +	parser->priv = config->priv;
> +	kref_init(&parser->refcnt);
> +
> +	mutex_lock(&nvmem_parser_mutex);
> +	list_add(&parser->head, &nvmem_parser_list);
> +	mutex_unlock(&nvmem_parser_mutex);
> +
> +	return parser;
> +
> +err_alloc:
> +	of_node_put(nvmem_of);
> +
> +	return ERR_PTR(err);
> +}
> +EXPORT_SYMBOL(nvmem_parser_register);
> +
> +void nvmem_parser_unregister(struct nvmem_parser *parser)
> +{
> +	mutex_lock(&nvmem_parser_mutex);
> +	of_node_put(parser->nvmem_of);
> +	list_del(&parser->head);
> +	kfree(parser);
> +	mutex_unlock(&nvmem_parser_mutex);
> +}
> +EXPORT_SYMBOL(nvmem_parser_unregister);
> +
>   static int __init nvmem_init(void)
>   {
>   	return bus_register(&nvmem_bus_type);
> diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
> index 06409a6c40bc..854d0cf5234f 100644
> --- a/include/linux/nvmem-provider.h
> +++ b/include/linux/nvmem-provider.h
> @@ -15,10 +15,13 @@
>   
>   struct nvmem_device;
>   struct nvmem_cell_info;
> +struct nvmem_cell_table;
> +
>   typedef int (*nvmem_reg_read_t)(void *priv, unsigned int offset,
>   				void *val, size_t bytes);
>   typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
>   				 void *val, size_t bytes);
> +typedef void (*nvmem_parse_t)(void *priv, struct nvmem_device *nvmem);
>   
>   enum nvmem_type {
>   	NVMEM_TYPE_UNKNOWN = 0,
> @@ -100,6 +103,12 @@ struct nvmem_cell_table {
>   	struct list_head	node;
>   };
>   
> +struct nvmem_parser_config {
> +	nvmem_parse_t	cells_parse;
> +	void		*priv;
> +	struct device	*dev;
> +};
> +
>   #if IS_ENABLED(CONFIG_NVMEM)
>   
>   struct nvmem_device *nvmem_register(const struct nvmem_config *cfg);
> @@ -110,9 +119,19 @@ struct nvmem_device *devm_nvmem_register(struct device *dev,
>   
>   int devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem);
>   
> +int nvmem_cell_parser_register(const char *nvmem_name,
> +			       const struct nvmem_config *cfg);
> +void nvmem_cell_parser_unregister(const char *nvmem_name,
> +				  const struct nvmem_config *cfg);
> +
>   void nvmem_add_cell_table(struct nvmem_cell_table *table);
>   void nvmem_del_cell_table(struct nvmem_cell_table *table);
>   
> +struct nvmem_parser *
> +nvmem_parser_register(const struct nvmem_parser_config *config);
> +
> +void nvmem_parser_unregister(struct nvmem_parser *parser);
> +
>   #else
>   
>   static inline struct nvmem_device *nvmem_register(const struct nvmem_config *c)
> @@ -137,5 +156,13 @@ devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
>   static inline void nvmem_add_cell_table(struct nvmem_cell_table *table) {}
>   static inline void nvmem_del_cell_table(struct nvmem_cell_table *table) {}
>   
> +static inline struct nvmem_parser *
> +nvmem_parser_register(const struct nvmem_parser_config *config)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline void nvmem_parser_unregister(struct nvmem_parser *parser) {}
> +
>   #endif /* CONFIG_NVMEM */
>   #endif  /* ifndef _LINUX_NVMEM_PROVIDER_H */
> 
