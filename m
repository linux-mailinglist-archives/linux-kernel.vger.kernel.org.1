Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97E92A2AB1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 13:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgKBM3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 07:29:39 -0500
Received: from mail-db8eur05on2134.outbound.protection.outlook.com ([40.107.20.134]:16864
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728359AbgKBM3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 07:29:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZAeMUMJELGVt/m0puaa0PwHN0w+eKg4lUqGnVAxB5Lax19POKXoiAUoUKFHxVtajqXtr1KXcPRnzgN0XFGJ/E0/t90KWLcYJlzGBvs1Wkt14COcETgZ5K6CRIUDbpztKqUKQSyTRQ43rrTyF4z7zxiUC91wZRxQma9Qk4IcMr06MAfaxelKTOoInSeaIyWzPJOz8Tj+sEGFg+4Vy26n9MPcmVT+WZ4gCFRjMFD7uAxpYKrrVFi4GJZphWmAtvEvOUwIkg1K+MIEJ45tv/y5HJsTgYDXtUwCwUnKNIjWOKDNOX5K/c+4Pex/IhAjsRurYZJmZkEeBGM4aK26hfNBuiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqPuy6Ubtif3GEpFO1TXkX2zETx0hXOSrwv0uiFg0Kw=;
 b=FcEzplw4FWLmO3EZ3lvjF0TPS3LZcOy715ZxNDNpDhDs9+Y1WWQh+ySHvNJNCGT8i6hs0MyL4wgrXcOERV1nOQ+nL/GRafBoyOktu+mHSRKa8Kd6Cve85zt/9Di0Hldw8rK9lvx97yO6RpTBgB4ULL5vuAB9t3J94uWCvbya1vlBLLKLlrwL7yTh+HVbliAxx+yX1ACnmIlwohEjg2zhXvrsT0G1L+hT55JwwH3vKgtSqQ0JLI10wOX0Ta/FKzd7j02sc+tFPs7GOse8XQXCxIYtaOw1TBDb3o+r8GS6zxngeny6psjlTubjiDg+Icjr0k6XH7qSNrqMkDsDjruXPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqPuy6Ubtif3GEpFO1TXkX2zETx0hXOSrwv0uiFg0Kw=;
 b=WDSbdGUHdEe38qUmysCPXuz2zRJ+B5UCXhidSFVWy0QkA6nqsOxouNGGZgFhj1awRXgkee3xnBYFy9E7Clqf67ecuskMNKiv1Hnf7ZshLfY+2IFK2pnVPp7tpXS7pUEAs9SuvH9PngXk8dqXTgspefMfIUeVCE7wZuNreOYqNm4=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM0PR10MB2115.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:4f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Mon, 2 Nov
 2020 12:29:35 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a0df:b996:7029:318a]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a0df:b996:7029:318a%7]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 12:29:35 +0000
Subject: Re: [PATCH 09/23] mtd: nand: spi: toshiba: Demote non-conformant
 kernel-doc header
To:     Lee Jones <lee.jones@linaro.org>, vigneshr@ti.com
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>,
        linux-mtd@lists.infradead.org
References: <20201102115406.1074327-1-lee.jones@linaro.org>
 <20201102115406.1074327-10-lee.jones@linaro.org>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <62865037-1f64-2515-2457-06767c232677@kontron.de>
Date:   Mon, 2 Nov 2020 13:29:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201102115406.1074327-10-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [89.247.37.117]
X-ClientProxiedBy: AM6PR10CA0022.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:89::35) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.17] (89.247.37.117) by AM6PR10CA0022.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:89::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Mon, 2 Nov 2020 12:29:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aec41ebf-50d8-47ff-e7ec-08d87f2af524
X-MS-TrafficTypeDiagnostic: AM0PR10MB2115:
X-Microsoft-Antispam-PRVS: <AM0PR10MB2115FE1B2D7F25FEB418513DE9100@AM0PR10MB2115.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 93TPab/ksaotilPiseJ2OPw8ti7e67G2VdTyIa48QAZl1CZtm2M9T47anLkz7IAKRsMsJt6wpRPknEm9bGHVTvcyo7UzYhScWoapoftUsDEVXODQNDq+DJGYQvx4f2dVvEASVWhoO4FElptKPieqPpgzldxLgdIqiY6u5QwBuj6ANVMJDMKiPogpdXIDxhE7Kdzf0eUlGpRj3px2vwKWL7KXS5FcqI2wkefx8kr7CKRUGUs+1ymQv+7D9v5ioUMn26aEfSLapN9LzwMtpu1ntZeMqrl1syig3bnx9MbwFpq3nV2i4gAxJ4XesLyBI8ORFO6De+lnmASgT9yr4G/2qssQJL42dRocBjlKNu+hLz7tIuBOcTXw7N2dbgGy4o2c
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(4326008)(26005)(44832011)(66556008)(66476007)(66946007)(16576012)(86362001)(6486002)(31696002)(8936002)(83380400001)(36756003)(8676002)(54906003)(956004)(478600001)(186003)(31686004)(316002)(53546011)(2616005)(5660300002)(16526019)(2906002)(52116002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: W2VUd6NMYfPJfbHEwxMm7wEmnfRBY780mhsWWBVIeu31YpbcksKgym5q/PGrvlvPyfj9W+79Bkrj4Y1urdYp2DAUIp77SE32Gb4YABItX+v9O+WctA76Txn7UmtK7MxbcoKmKsJAWVJENz5Gvk8H51jWWq1Qd45s/nOOybRunwcUNnAC4sVzBVKvqgatI0geHQ4vKHYW7EsiHjQHfyyRVwi5SUZR2aAFs+1C3aUcXwCNYyCy5+VaEnApLbxuCGo4MmPGQuCJQcS7u4jixLP6YCAkJbS5Ld80DumXGZHFkZ64yzoFPNw8cUwy5ctG497Q8YUv/12m68qM1PIRUuFYYEPDVc6/RGRACWv3J7ghqvi+yfojbD9Agtew+Rmr4izRzxvgA0h/d0oE5YpnAflCQURxLB8BZRsr1DPjmWARx2fCpV76AeAJzf6/M2p2MfHPuDPPuMHJ28MXyIkYhDyliw64r7Z7VP3PHiCoZtsniNIGAUoq9rugmDxy/J3GmS1EP2f/c5qFqdbXBQfi3YAqtf9rUnQWNBIB1MBZ6xuPeNuvnpxAA07w3gfWNHP2QYEc/w8N6mIMqTTTNz8bYzGlOZHKHxyYa9fnMFumW8uLcK57bYpQQ1Inze9lkN3CUbmqfv5HlGrw1dQ86bcKgB68fg==
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: aec41ebf-50d8-47ff-e7ec-08d87f2af524
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2020 12:29:35.2494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iG1qALq8lcoh+VX4bvQHYwNN6/RLWFkTOv7y9FaJ+AdoI7C6R563voTFeQQBa2xn8UYQn0V/WsdM4mnRZK0vk50Xpj4Z59Gg7x5xPaVo//Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2115
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.11.20 12:53, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>   drivers/mtd/nand/spi/toshiba.c:36: warning: Function parameter or member 'write_cache_variants' not described in 'SPINAND_OP_VARIANTS'
>   drivers/mtd/nand/spi/toshiba.c:36: warning: Function parameter or member '0' not described in 'SPINAND_OP_VARIANTS'
> 
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
> Cc: Frieder Schrempf <frieder.schrempf@kontron.de>
> Cc: linux-mtd@lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> ---
>   drivers/mtd/nand/spi/toshiba.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c
> index 21fde28756742..7380b1ebaccd5 100644
> --- a/drivers/mtd/nand/spi/toshiba.c
> +++ b/drivers/mtd/nand/spi/toshiba.c
> @@ -28,7 +28,7 @@ static SPINAND_OP_VARIANTS(update_cache_x4_variants,
>   		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
>   		SPINAND_PROG_LOAD(false, 0, NULL, 0));
>   
> -/**
> +/*
>    * Backward compatibility for 1st generation Serial NAND devices
>    * which don't support Quad Program Load operation.
>    */
> 
