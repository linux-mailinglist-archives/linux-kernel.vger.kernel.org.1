Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3511A27FFA8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 15:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732183AbgJANAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 09:00:10 -0400
Received: from mail-vi1eur05on2110.outbound.protection.outlook.com ([40.107.21.110]:62081
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731952AbgJANAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 09:00:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsTxhM4gnmXOoO9ko4lO9Xigbh1ETBrwK+qwASeL4E+KolpxqseYKxUxhh3rwfp9xYTMXP/BXfkaAxEbqxnzGFzwb/Tee67VnuE8NQ7Hx7R6Ddw6TphXSFlHDDN2v2rCsYW4V9fPSUK73RdgmJYlkso+WCuo4N4uOi/oqJTPSKzej+UXniSfUyx1L6cP5NF/rXa5+dzpXdtr/cy/pGNEAwNqWqEyWKAD0jRKlmCmpbmtddGTbq6vzrRBWDI8vHnFxTZyZA24Njoc4jrl/SG5ha0QE5Yn2XBoxTId2dF0JHAB9wEvnMNOdo74l8OY0PAzElsAF97Hfy94PP+sSpw1VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HQPF8dBouMAjyVlKyqTZDzGWikRdyJ5iYzbmVn2brI=;
 b=l+9pCZ1/BK5oOvdVOw6CTdptVeslDyIgL12gVmw5W4bKqPrYwFu/jeB1O0llC8QH9xZnv6DIIl9LGN+zsM/1TuZBwkMDBdcXBrNvcChwKHqP46Cww5CGUk4YhaUUZWDa+xiF98X2JkzocQZFR9YHUKyEBWhWqD3e+k299FGfsHERq9a7GJ3ybZcPdT1MSETaUrZOXTtfGYpi9r2juI072dXlDRMghryEfSPh1H8KThFiML7ocL11BLiu+hXSJ8fO2kAs+Ay5K4bJftqU/4na8nvoc8G65rvDZYvylndSnXZ4b3y6HWMJOHG9qsJ3V5RvK0EC+DaNMxjeWx2vBrrX1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HQPF8dBouMAjyVlKyqTZDzGWikRdyJ5iYzbmVn2brI=;
 b=RUlGoIJLL4p2cUP9rV3MZ8VMejdtPgO+WO3Wd8UCFYkV/++cbXWg3HJ2dwWxeGQ+LAbZ/lxCCOoGY4fKZ1LT5pGyP4R0lAHMwu4Ho9if7YAXN3pCLGAy1Ul+0U++DIUBuRezxUfXbeU1H7HeLDxaVF2UVQdCXHPWx1S3g2uoW5s=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM9PR10MB4199.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Thu, 1 Oct
 2020 13:00:07 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852:b8d:8b04:d2f5]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852:b8d:8b04:d2f5%6]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 13:00:07 +0000
Subject: Re: [PATCH 1/2] regulator: pca9450: Add SD_VSEL GPIO for LDO5
To:     Mark Brown <broonie@kernel.org>
Cc:     Robin Gong <yibin.gong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20201001123447.1610-1-frieder.schrempf@kontron.de>
 <20201001125339.GF6715@sirena.org.uk>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <f4f88a3f-dc6d-ff2e-0a1f-c8761e07891c@kontron.de>
Date:   Thu, 1 Oct 2020 15:00:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201001125339.GF6715@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [89.247.42.197]
X-ClientProxiedBy: AM5P194CA0014.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:203:8f::24) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.17] (89.247.42.197) by AM5P194CA0014.EURP194.PROD.OUTLOOK.COM (2603:10a6:203:8f::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.36 via Frontend Transport; Thu, 1 Oct 2020 13:00:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d7c88bf-b04e-486e-885c-08d86609ebd1
X-MS-TrafficTypeDiagnostic: AM9PR10MB4199:
X-Microsoft-Antispam-PRVS: <AM9PR10MB4199991F2AA5CB507421B4CAE9300@AM9PR10MB4199.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V2pywYpfLEPd7vn3SawcF5Ur7mVPIU6l6PIuOPfWmVw5zCU6eahcYy2/ymN+O1WRZ8ZmAuw1HGcEge2bF+X8uGRvmnTGSlBN4SFshg5Xt6EVAv/h4wEa48leqAZyG45taEJ7gybY6/8hQ6SVs9j1hSmxWWzhYPkvpHFS8wp5P5JnhaNFd0GGNaeoRONJzoVBi0LNpj9vpYXWVLGTBKxA2U+equ0EU/ajf9Y24MsRrFBcxBOUNUG3P+k9FmedBILRzxqp2MTOfwEEDz+Mui9muJt3GWnpyC0br2I0DxrofuQF+kbmBQYaS5kxjMqPiiJIkkIoZvDC2e5XLH/t5OwHEGgdvh8HJvunDzmAGAmidAR4oHtFuVrLIAWq+6ZcT3BNgbcvrPU5YbNyKwgTISz37NMYSBPHn5Lg2QlJHjhT7TE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(52116002)(16526019)(26005)(44832011)(2616005)(36756003)(6486002)(54906003)(186003)(16576012)(53546011)(316002)(31686004)(86362001)(4326008)(2906002)(8936002)(478600001)(8676002)(6916009)(956004)(4744005)(31696002)(66476007)(7416002)(5660300002)(83380400001)(66556008)(66946007)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: dDnlRtll8J2S981mpsBQTbeRcdsomvAR5hEFGUSG52OMjA6/MwLkOPFTdpkt7mRm9NJx+vp2hrXgZra5nwhySyqgkNxsCrwIodZNo4lXyK5uGciYN3e6zcJXKvgaoa9Y8H0tvdewp8rTrMonQHL+59yKbVm/NfW0X5I8cNmQ/0QE19H6irSgGlMr+BVLg6UTlhIA75/1ZtmVoTAaT8QwYnpTAQYUSSlHSh9VL3jzWkocQemmaRylZPwdnLni73621nCjD+tDfNTNVf6RgV5+HYE0+sg3TSGkMlyIjMWoyQBD+D+qfNSbq0eIOx5x4CWDExok6End9XxK6G/JQY9e/g2gXKUZbRwKRQHwzBPKTVKNwdbbeBRQ/hgzLIlsTvCt9gKmX6B3hBqnkxx3EKrhi3tQYsNTA+VuF1z7i9Smfe22KfV05yxarK7GALI15b6fC281m84T65MMH2TudLsb+lxyNvbnxUDuVY6CKmFh8QXVu5jMvcgbJjjPTROemRW3qkGijtAmVc4Fpc6UqeAHMmaO+LSCJcZ1y61V9YD9imwCUOAbRrFW2jbYjPWRBZ0c+0vlvm6VIACMDId0HTQJUw1pkGqjO73RLYTSdAlnWiRY6vD02V2qg2x1pFAXEQ/VffcHdm8GlD/7lRUXSLIemg==
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d7c88bf-b04e-486e-885c-08d86609ebd1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2020 13:00:07.1031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9fiik8yfA2Y2eBXERktO2NxWaB4P8yg06aH6iiVLu9E9EPkJPSQOyHN091WdXeEbvsClVH09HyiFHSrQqtSokmQcMwa+JEwN9AYxpzdyDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4199
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01.10.20 14:53, Mark Brown wrote:
> On Thu, Oct 01, 2020 at 02:34:31PM +0200, Schrempf Frieder wrote:
> 
>> +	pca9450->sd_vsel_gpio = gpiod_get_optional(pca9450->dev, "sd-vsel", GPIOD_OUT_HIGH);
> 
> We need a patch adding this to the binding document too.

Right, totally forgot about that. Thanks for the reminder.
