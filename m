Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15DBF27407E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 13:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgIVLLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 07:11:08 -0400
Received: from mail-eopbgr70117.outbound.protection.outlook.com ([40.107.7.117]:27247
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726340AbgIVLLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 07:11:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALfyndWmHopd0CAf5wbnGmufiOoWrzjxcU/7kL2TT/Wt4nU7mP7+yL9BkH6NrFcT1HO/VCWAiVw2oLbxQvDnQKvK/bLLS51l+m5V8KC3v7cdsfiQVpDtI7buWvQPi7xO2mI3oQMIt8R1G+TYX0jQU5FtzXVcj6NTUqhCbsQgTHfnAUco320B2mVCBDNGJ97bEKauPLvx6Gy7KkwLZxEz3SF46OgQ00KpBdZhHHed7iNVGuNlIETVNwq3JtWG/BTwdxKJzd9NVK3hAhC3EzguIdW08BFV3+lPfEXJZlAKpwjhz+yTZFjx420waaNpqrq6sRykD4zEHBs46/WLfIxBVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynzBhX7Cr3cpGMc9ACF2DsTSFs6vMCd4PmvPPOuJ0H0=;
 b=NUvgdALxxbcnCGRru9dnJqNyZeaCU5zatdoLGLFKMnJ9cM9m9PcGAw52Upqf0HNjOLgi2uzYMYTvS2+Oha7U1JRulBechDWc9qifGfbTimLmu5s3GE+GZ8Tltk7Jsr3MJcZrDaZCrQS7AGn3YWLpDTzzAxXwsSFybMc1wIpclQknv6MKiB+VASK5VBTVOxwIHKqA3w4388EYT+na381MHnYQRdeHAM0z3midCf26dFMilIxv5sqigtQYOvYr2Sgqth5TCKk+vdzRkTZJN43OntjALdee0OwtT6Ba9onMehhEHkX3hOYx0nYEqMC/UKGM+MPR0rwG2WMZsaxAz8MuZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynzBhX7Cr3cpGMc9ACF2DsTSFs6vMCd4PmvPPOuJ0H0=;
 b=t8ygOZJyFNFIY8MJvsjx3y9KBnWFmGgV7vxHZSYoDwtzJd7DHb3I69UMCmW5L0w5TYzT/t7HAAFG/oOlDS5FnkrP2/ixel2W1hflsFmBVgnB0OV13yMG6cqzSWfgc87ayLFxl9rSTXZhzf/rmb9bCogLXc/wGq0OcVboOC7RqgA=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=plvision.eu;
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:56::28) by
 HE1P190MB0460.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:58::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.13; Tue, 22 Sep 2020 11:11:02 +0000
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::c1ab:71de:6bc2:89fe]) by HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::c1ab:71de:6bc2:89fe%6]) with mapi id 15.20.3391.019; Tue, 22 Sep 2020
 11:11:02 +0000
Date:   Tue, 22 Sep 2020 14:10:59 +0300
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] nvmem: core: introduce cells parser
Message-ID: <20200922111059.GC22590@plvision.eu>
References: <20200915124116.7196-1-vadym.kochan@plvision.eu>
 <20200915124116.7196-2-vadym.kochan@plvision.eu>
 <b2e63a28-7678-832e-f585-6d0f959d1b75@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2e63a28-7678-832e-f585-6d0f959d1b75@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: AM6PR02CA0035.eurprd02.prod.outlook.com
 (2603:10a6:20b:6e::48) To HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:7:56::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plvision.eu (217.20.186.93) by AM6PR02CA0035.eurprd02.prod.outlook.com (2603:10a6:20b:6e::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend Transport; Tue, 22 Sep 2020 11:11:02 +0000
X-Originating-IP: [217.20.186.93]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3592c27-9199-43b3-e656-08d85ee83162
X-MS-TrafficTypeDiagnostic: HE1P190MB0460:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1P190MB0460D0C0EB9E031F4CB04427953B0@HE1P190MB0460.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mS+LXwfcG0uXD5g2MCkDWYtGny5CAWZLR53+jVSDYGM77aWSc6WWlAL1vKeZqUBMqXiauGHtC3w1dQ1apeHWEo9p4paW7YZW5P8AbWYNMwQ6zmYAzxGyxZmZVgeevg+ff3YcaoufLL17yCJA+01cP9bOTG0Q4Gsq1wyw+K7zPx/VzdTq+LWO56QyRTIxGcbCqx8cd/0F2KJPgZA3P/xh0+67XqZUuEIwK0OSSo2geL8XOxrJ1xX7XWqj4CaSYfoU/UIKIDH+CWA2EvKFGKrUY8frJ0mSo/LdutciJ7wdPbmg/r6Q2H8MD6ftH6qRKjTEZXGG6LfXktriGFbE0/VmCjbGPwCtVJWNZ70X57kMNaf+dNPK+559w+pVXY50C3wX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1P190MB0539.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(346002)(39830400003)(366004)(53546011)(36756003)(186003)(6666004)(2906002)(26005)(5660300002)(6916009)(66556008)(8676002)(1076003)(66476007)(83380400001)(55016002)(478600001)(8886007)(66946007)(86362001)(956004)(8936002)(52116002)(7696005)(44832011)(33656002)(4326008)(2616005)(16526019)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: VhVpn3VhPidx97uw1R/YoTj6ZpfSweLLYB4zyz4ot6/S7vO99PUcjH0N0L3R07O1kYMQhGou+X2aZ9Qf+sToIPJA5vOQj+rmtLiV4U/+VFpjpjsQXJiOnIB0dV5ZHnEC4Yf2ynrnmfsRB7ZC6w6ek+AU1+0TB8mFEDLrQNbI283Zs1szW/1kHDkgWZ0KL/zt9R9VG4jB6IfRxfLkbUQTOmAuaqequulOUqGVe4JzhTtJlDmUkN6rBObE9TmEx1RvzRDRnnWFQ1o3Eq+bpimxRHOJrGqIIX+Ra+OJcAuqLaJQMbj+JBGBKIERuLriZlBuOHRhq0mvDFMY7iITwRHDD9Nnx9aEktT6cunedKnrkp/tqO2+p9OfQ0lXw4NFkhWok12tcnK/3w1WwVYnM4Q56p4aQzgmTenm8JZFoCaw405ACmQLa7E73iTEKvUBoLop7pAIFXwbfEwF6diLZIUs6OUhtKupw3k7hMQaX4Z+eV2QQ8SSw2/EE+cHinkb4jrWUPEM5SnJ7tjw+RUZUSW/IY2+3MunUFFsmhTClVgV3Gm6LWL8wOUaSFFw/1OV9zlDScLlXylI1wGX2UuUvdWpef3nzc4Ot7adgmBqdqfXXQB9sOdwfSYpMQ8LGrpYlP4Y4B3sJv5IAWJqrPlYdEKvdw==
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d3592c27-9199-43b3-e656-08d85ee83162
X-MS-Exchange-CrossTenant-AuthSource: HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 11:11:02.8113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yAX8I+EAURZOtLV5aXaFIn7g7y9xwyDgZvrzhBsK13XtpiSp0MBrgPvvn9Ct8NGwNsSu2m5CBGBPCM6PpQ3fro4zHO6KnXch2FM7tEobnuM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1P190MB0460
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 10:48:27AM +0100, Srinivas Kandagatla wrote:
> 
> 
> On 15/09/2020 13:41, Vadym Kochan wrote:
> > Currently NVMEM core does not allow to register cells for an already
> > registered nvmem device and requires that this should be done before.
> > But there might a driver which needs to parse the nvmem device and then
> > register a cells table.
> > 
> > Introduce nvmem_parser API which allows to register cells parser which
> > is called during nvmem device registration. During this stage the parser
> > can read the nvmem device and register the cells table.
> > 
> 
> Overall this approach looks okay to me!
> 
> Rather than a binding for onie cell parser, I think we should add a generic
> bindings for parser something like:
> 
> 
> nvmem-cell-parser = "onie-tlv-cells";
> 
> 
> I also think the parser matching should be done based on this string which
> can remove
> 1. new DT node for onie parser.
> 2. works for both DT and non-DT setups.
> 
> nvmem provider register will automatically parse this once it finds a
> matching parser or it will EPROBE_DEFER!
> 
> Let me know if you think it works for you!
> 
> 
> --srini

Indeed, it sounds very good and fixes the early dependency that
parser should be registered first before nvmem provider.

I will try!

> 
> > Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> > ---
> >   drivers/nvmem/core.c           | 89 ++++++++++++++++++++++++++++++++++
> >   include/linux/nvmem-provider.h | 27 +++++++++++
> >   2 files changed, 116 insertions(+)
> > 
> > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > index 6cd3edb2eaf6..82a96032bc3f 100644
> > --- a/drivers/nvmem/core.c
> > +++ b/drivers/nvmem/core.c
> > @@ -55,6 +55,14 @@ struct nvmem_cell {
> >   	struct list_head	node;
> >   };
> > +struct nvmem_parser {
> > +	struct device_node	*nvmem_of;
> > +	struct kref		refcnt;
> > +	struct list_head	head;
> > +	nvmem_parse_t		cells_parse;
> > +	void *priv;
> > +};
> > +
> >   static DEFINE_MUTEX(nvmem_mutex);
> >   static DEFINE_IDA(nvmem_ida);
> > @@ -64,6 +72,9 @@ static LIST_HEAD(nvmem_cell_tables);
> >   static DEFINE_MUTEX(nvmem_lookup_mutex);
> >   static LIST_HEAD(nvmem_lookup_list);
> > +static DEFINE_MUTEX(nvmem_parser_mutex);
> > +static LIST_HEAD(nvmem_parser_list);
> > +
> >   static BLOCKING_NOTIFIER_HEAD(nvmem_notifier);
> >   static int nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,
> > @@ -571,6 +582,30 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
> >   	return 0;
> >   }
> > +static struct nvmem_parser *
> > +__nvmem_parser_find_of(const struct nvmem_device *nvmem)
> > +{
> > +	struct nvmem_parser *parser;
> > +
> > +	list_for_each_entry(parser, &nvmem_parser_list, head) {
> > +		if (dev_of_node(nvmem->base_dev) == parser->nvmem_of)
> > +			return parser;
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> > +static void nvmem_cells_parse(struct nvmem_device *nvmem)
> > +{
> > +	struct nvmem_parser *parser;
> > +
> > +	mutex_lock(&nvmem_parser_mutex);
> > +	parser = __nvmem_parser_find_of(nvmem);
> > +	if (parser && parser->cells_parse)
> > +		parser->cells_parse(parser->priv, nvmem);
> > +	mutex_unlock(&nvmem_parser_mutex);
> > +}
> > +
> >   /**
> >    * nvmem_register() - Register a nvmem device for given nvmem_config.
> >    * Also creates a binary entry in /sys/bus/nvmem/devices/dev-name/nvmem
> > @@ -674,6 +709,8 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
> >   			goto err_teardown_compat;
> >   	}
> > +	nvmem_cells_parse(nvmem);
> > +
> >   	rval = nvmem_add_cells_from_table(nvmem);
> >   	if (rval)
> >   		goto err_remove_cells;
> > @@ -1630,6 +1667,58 @@ const char *nvmem_dev_name(struct nvmem_device *nvmem)
> >   }
> >   EXPORT_SYMBOL_GPL(nvmem_dev_name);
> > +struct nvmem_parser *
> > +nvmem_parser_register(const struct nvmem_parser_config *config)
> > +{
> > +	struct device_node *nvmem_of;
> > +	struct nvmem_parser *parser;
> > +	int err;
> > +
> > +	if (!config->cells_parse)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	if (!config->dev)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	nvmem_of = of_parse_phandle(dev_of_node(config->dev), "nvmem", 0);
> > +	if (!nvmem_of)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	parser = kzalloc(sizeof(*parser), GFP_KERNEL);
> > +	if (!parser) {
> > +		err = -ENOMEM;
> > +		goto err_alloc;
> > +	}
> > +
> > +	parser->cells_parse = config->cells_parse;
> > +	/* parser->cells_remove = config->cells_remove; */
> > +	parser->nvmem_of = nvmem_of;
> > +	parser->priv = config->priv;
> > +	kref_init(&parser->refcnt);
> > +
> > +	mutex_lock(&nvmem_parser_mutex);
> > +	list_add(&parser->head, &nvmem_parser_list);
> > +	mutex_unlock(&nvmem_parser_mutex);
> > +
> > +	return parser;
> > +
> > +err_alloc:
> > +	of_node_put(nvmem_of);
> > +
> > +	return ERR_PTR(err);
> > +}
> > +EXPORT_SYMBOL(nvmem_parser_register);
> > +
> > +void nvmem_parser_unregister(struct nvmem_parser *parser)
> > +{
> > +	mutex_lock(&nvmem_parser_mutex);
> > +	of_node_put(parser->nvmem_of);
> > +	list_del(&parser->head);
> > +	kfree(parser);
> > +	mutex_unlock(&nvmem_parser_mutex);
> > +}
> > +EXPORT_SYMBOL(nvmem_parser_unregister);
> > +
> >   static int __init nvmem_init(void)
> >   {
> >   	return bus_register(&nvmem_bus_type);
> > diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
> > index 06409a6c40bc..854d0cf5234f 100644
> > --- a/include/linux/nvmem-provider.h
> > +++ b/include/linux/nvmem-provider.h
> > @@ -15,10 +15,13 @@
> >   struct nvmem_device;
> >   struct nvmem_cell_info;
> > +struct nvmem_cell_table;
> > +
> >   typedef int (*nvmem_reg_read_t)(void *priv, unsigned int offset,
> >   				void *val, size_t bytes);
> >   typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
> >   				 void *val, size_t bytes);
> > +typedef void (*nvmem_parse_t)(void *priv, struct nvmem_device *nvmem);
> >   enum nvmem_type {
> >   	NVMEM_TYPE_UNKNOWN = 0,
> > @@ -100,6 +103,12 @@ struct nvmem_cell_table {
> >   	struct list_head	node;
> >   };
> > +struct nvmem_parser_config {
> > +	nvmem_parse_t	cells_parse;
> > +	void		*priv;
> > +	struct device	*dev;
> > +};
> > +
> >   #if IS_ENABLED(CONFIG_NVMEM)
> >   struct nvmem_device *nvmem_register(const struct nvmem_config *cfg);
> > @@ -110,9 +119,19 @@ struct nvmem_device *devm_nvmem_register(struct device *dev,
> >   int devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem);
> > +int nvmem_cell_parser_register(const char *nvmem_name,
> > +			       const struct nvmem_config *cfg);
> > +void nvmem_cell_parser_unregister(const char *nvmem_name,
> > +				  const struct nvmem_config *cfg);
> > +
> >   void nvmem_add_cell_table(struct nvmem_cell_table *table);
> >   void nvmem_del_cell_table(struct nvmem_cell_table *table);
> > +struct nvmem_parser *
> > +nvmem_parser_register(const struct nvmem_parser_config *config);
> > +
> > +void nvmem_parser_unregister(struct nvmem_parser *parser);
> > +
> >   #else
> >   static inline struct nvmem_device *nvmem_register(const struct nvmem_config *c)
> > @@ -137,5 +156,13 @@ devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
> >   static inline void nvmem_add_cell_table(struct nvmem_cell_table *table) {}
> >   static inline void nvmem_del_cell_table(struct nvmem_cell_table *table) {}
> > +static inline struct nvmem_parser *
> > +nvmem_parser_register(const struct nvmem_parser_config *config)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> > +
> > +static inline void nvmem_parser_unregister(struct nvmem_parser *parser) {}
> > +
> >   #endif /* CONFIG_NVMEM */
> >   #endif  /* ifndef _LINUX_NVMEM_PROVIDER_H */
> > 
