Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CF82F1871
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388198AbhAKOkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:40:12 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:22792 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729302AbhAKOkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:40:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1610375943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N32pC0acih86D/l0R5T8eoMjvYHiUsUu7K3o3XaEIjg=;
        b=FVMwMd5txcs7gIFqlP6K43Bctro4fzUGUufEHdusCCHHIc/R2kG8SRPwAPmCdNKzdgb9M8
        isQl6iG6kQf0CK3mTVRvX1mkyWVKRBpiq4jcIh0fBJAjr7Fjct6ETGW+YVSU+btqD1Ldq9
        RzONeOux/ecWZL8TDB6XUlXbHcBbUm8=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2059.outbound.protection.outlook.com [104.47.0.59]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-6-rdh8dxsQPr-PEWwbUOUCCw-1;
 Mon, 11 Jan 2021 15:39:02 +0100
X-MC-Unique: rdh8dxsQPr-PEWwbUOUCCw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcA9DO5dQuvt2f9mocFo9kKcMyawKvP1nPdbErKVADfjbyhnvtFDeqEnRmhhxm72ihRFtgn27IIPkwF3uCI6AFbgxVC+G8EOuEyzTmcaya6AvVOAT9nUt7wFuIa5H3UOm6H2hSftTGlGUyj/rJ+Xcnx5LtK81OThZVydJV54ZfoXfAZhNY5EN5uHZDxaR+2SRyLQUUkdFpFZ61Wae3X7xrSGtsfN1hJn1hJJH7GzfWDXD316bMn0sN6QrxdEQ+jeakDYaLSJxT4vOOcnr+hLANGEUNwNSrjchfnjOU/eUkNOMSxrRV67MupOeXZANomYtU1KJfoZLFiTqq7o5row1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O565qy6yCXpgQBU2Bb752y8920QwcorASaAS5NztnQ8=;
 b=RroFSlut+sw60JTxJ53EiCLaHC2T3d00q1wve4AC/SrIVZ8XKTDtHNLGa14nRFak0ZenuX2zVLKfvu2sloIVI/QeNZNLrBA7XRw/2h6BY5G9djvRi7GWVokNLKb1qgAps4Gyxv1SJ3ZGviXTMMH0wpmFXXGMpNYxceSPFx7sU5sTdv8QFkoCeFMFBNF3D25aKOVv8+vBHF8l/qYlWJgIvpNS1UcDx3BgMPsTP+M4iWrlmiOua+I8ivW2fSEWdXdV3gMP3KuEsjez3L+3g7WY7CaZBPZF/1fkFdZ6XcnDK8A75kyaJhjPde3agziJKJzTdd8ZucvPJNVa3pDL6gnqFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB5366.eurprd04.prod.outlook.com (2603:10a6:20b:9d::19)
 by AM5PR0401MB2595.eurprd04.prod.outlook.com (2603:10a6:203:2f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Mon, 11 Jan
 2021 14:39:00 +0000
Received: from AM6PR04MB5366.eurprd04.prod.outlook.com
 ([fe80::58d1:4050:d882:3ca0]) by AM6PR04MB5366.eurprd04.prod.outlook.com
 ([fe80::58d1:4050:d882:3ca0%7]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 14:39:00 +0000
Subject: Re: [PATCH] mfd: mt6360: Fix MFD cell names and compatibles
To:     Gene Chen <gene.chen.richtek@gmail.com>, matthias.bgg@kernel.org
CC:     Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Gene Chen <gene_chen@richtek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20210111123518.30438-1-matthias.bgg@kernel.org>
 <CAE+NS35Br8jgLfii=VPjFx+m+9=a=EQKYyoQMAyd7Zdo0K6n+A@mail.gmail.com>
From:   Matthias Brugger <mbrugger@suse.com>
Message-ID: <392f08b4-0e46-3ba3-2515-640a05accbcb@suse.com>
Date:   Mon, 11 Jan 2021 15:38:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <CAE+NS35Br8jgLfii=VPjFx+m+9=a=EQKYyoQMAyd7Zdo0K6n+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [213.195.126.134]
X-ClientProxiedBy: AM0PR07CA0021.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::34) To AM6PR04MB5366.eurprd04.prod.outlook.com
 (2603:10a6:20b:9d::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ziggy.stardust (213.195.126.134) by AM0PR07CA0021.eurprd07.prod.outlook.com (2603:10a6:208:ac::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.2 via Frontend Transport; Mon, 11 Jan 2021 14:38:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7717ed13-d17a-4145-75f2-08d8b63ea27e
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2595:
X-Microsoft-Antispam-PRVS: <AM5PR0401MB259507917FA245D9BFD54A6FBAAB0@AM5PR0401MB2595.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eXIAZFh5Qmv1YoEXNWkbw3tmY4dx6WfgswB7gDNF1IGsjJNsqX5k4PPCaQMhvjf5GM6E4HbDuuCxO2TsRnEiQnek2RNZagLpXMbSk/nPOME4W0E1SPDTgjQTYRkCyiVPwWeYon5nfJdkk/rTpb4hAY8mHrPg7TgRpetbtVo/IT4BLLozj+JgbQjSP/JWldL7Zo2vPreVNcvCydCZsPoCU4w5+fhbc1YwWIBviWV6ru/HfVpKsWHKBhY/9YP5rl5x0O5N7m2zxU75JUHjcSMqWwYxwNbLXLyAxwwEl61VFCgNyU+Bb2TtZxzoFlFSAzA+M0zU/ZV7mm99P8UKOO+r8c+AD6JCPTW5uMbFb/EHOg5y86qcK5+/DRV4YvXxY654HRuTeAcuPhZDTwH7fopb9oidIZDoD+6MP54EveftmvoHCk/o5aWK4CGrI3ORzIa/KFFU9pjBcdEF6KyLNipcz0giFJYyhAgKfJfZtG/8i6o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(396003)(136003)(39860400002)(54906003)(53546011)(6506007)(316002)(36756003)(956004)(2616005)(478600001)(66946007)(66556008)(8936002)(86362001)(7416002)(31686004)(66476007)(52116002)(5660300002)(6486002)(16526019)(6512007)(31696002)(83380400001)(8676002)(2906002)(4326008)(26005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?TcLiLjFGSAka+LH4QU5JXrQiT4xdyfEcxdUaU1PxrvdypuUcCJy2msEhPveI?=
 =?us-ascii?Q?gi04DNw3L/+bwGaXG2rkKg6eRZJDdEGdk9vp4sZQO0e9tQWm9JpBYrvtgOzg?=
 =?us-ascii?Q?zh1OAfNnDIWmZZf6UP2BePUaBKCkvmqdY3TaHCNQH3sTUq7yjDqR5nDYYhJ2?=
 =?us-ascii?Q?uY4LXvIc7rg2si2yealmnT1bfgcqcip7RXtw1Dqr4NP0l/QSh770kCRYbG5Z?=
 =?us-ascii?Q?E3nUGgrrMH9rf5eEmaN44YEPX7v6vnYM5sNCDxzOx3gaguht/1mXZOKAuN3E?=
 =?us-ascii?Q?GLKE8TmsXXUodE3Ccv6VDwJNVl5/W04TQbyfbOuyMnda6Wct+Zn37QBVTmyM?=
 =?us-ascii?Q?b2QjaU2gexfoBg2dXRdPfIQnno3osEwKtm0dWOupgBUQMyBJ+E79tN4DeKbt?=
 =?us-ascii?Q?L87dRwDdBdEAJJkb3jFvJxzxCPzD77SmmViGJ4VedxifkZNVWaBePlTHqVjR?=
 =?us-ascii?Q?LZRTdp/bhxoYWABYFP2ri24AspQlPeMf2QHV8pIoIol98Xn9eoaBMp4tBRUV?=
 =?us-ascii?Q?xUffFm0eGuOqoTUeCNNouIYSoPBJw5W1xh9rm6BI4jS7T9MEaYKqrdWHmMth?=
 =?us-ascii?Q?MNT3UgyJw5nX3mgcKTd8pkajRuWvY3cIpFwSai3NpE8gPfgM0x1gEQZCnaaP?=
 =?us-ascii?Q?mX5Cx1yLgRjU7V+LtUSQPn4nNcZf3MpmvSjc4a+jm4ngqY4qwXL0OdYxCgeA?=
 =?us-ascii?Q?/nbQ9zwmuCMorjnIlGUf8BowB1q96Rv4QVUAhhawleFKVd26kcRK01zPOby3?=
 =?us-ascii?Q?7NxEzFMMYAk4KdPRHNa6Jc5Lw+ds4SFoB2gusHr0scX0vEtZFI3A6CuoyvcY?=
 =?us-ascii?Q?qJnE+2MqMvCWN+9ChnIXQBZer98iPBLnd890Ru5n8KL9eSCb/oDLvnkX6xT2?=
 =?us-ascii?Q?qoxoSdT4VooOrFm2rym0CdpxazL2eX+COdVaBKchHxBgevaTSm5A4jIVz46y?=
 =?us-ascii?Q?rovwBcfXkKQVdw2VbhksIJWHoknaebC2wFusbY9HkPGusf8UznjUuPb2Fvcu?=
 =?us-ascii?Q?Is5X?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2021 14:39:00.2529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-Network-Message-Id: 7717ed13-d17a-4145-75f2-08d8b63ea27e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1c9bycABZ9zEQU2yTc1qNQ1XDh4yROsIog6wtEl2h4a7goZb8S08+8BGVT65T2Dhk3VB/zzeP2+Q5uOmAgcDYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2595
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/01/2021 14:05, Gene Chen wrote:
> Hi Lee,
>=20
> This change exists in [PATCH v7 03/11] mfd: mt6360: Indicate sub-dev
> compatible name by using "-".
> Does patch v7 also merge together to mfd-next?
>=20

once again, please don't top-post.

Sorry I didn't saw this patch. Looks good to me, so please ignore this patc=
h mine.

Regards,
Matthias

> <matthias.bgg@kernel.org> =E6=96=BC 2021=E5=B9=B41=E6=9C=8811=E6=97=A5 =
=E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=888:35=E5=AF=AB=E9=81=93=EF=BC=9A
>>
>> From: Matthias Brugger <mbrugger@suse.com>
>>
>> MFD cell names and compatibles use '_' instead of '-', which is common
>> practice for names and the standard for DT compatibles.
>> This will also fix the probing for the drivers already implemented
>> (mt6360-adc and mt6360-tcpc).
>>
>> Fixes: 7edd363421da ("mfd: Add support for PMIC MT6360")
>> Fixes: 1f4877218f7e ("iio: adc: mt6360: Add ADC driver for MT6360")
>> Fixes: e1aefcdd394f ("usb typec: mt6360: Add support for mt6360 Type-C d=
river")
>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>>
>> ---
>>
>>  drivers/mfd/mt6360-core.c | 24 ++++++++++++------------
>>  1 file changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
>> index 4661c1b29a72..14e649ffe50f 100644
>> --- a/drivers/mfd/mt6360-core.c
>> +++ b/drivers/mfd/mt6360-core.c
>> @@ -292,18 +292,18 @@ static const struct resource mt6360_ldo_resources[=
] =3D {
>>  };
>>
>>  static const struct mfd_cell mt6360_devs[] =3D {
>> -       OF_MFD_CELL("mt6360_adc", mt6360_adc_resources,
>> -                   NULL, 0, 0, "mediatek,mt6360_adc"),
>> -       OF_MFD_CELL("mt6360_chg", mt6360_chg_resources,
>> -                   NULL, 0, 0, "mediatek,mt6360_chg"),
>> -       OF_MFD_CELL("mt6360_led", mt6360_led_resources,
>> -                   NULL, 0, 0, "mediatek,mt6360_led"),
>> -       OF_MFD_CELL("mt6360_pmic", mt6360_pmic_resources,
>> -                   NULL, 0, 0, "mediatek,mt6360_pmic"),
>> -       OF_MFD_CELL("mt6360_ldo", mt6360_ldo_resources,
>> -                   NULL, 0, 0, "mediatek,mt6360_ldo"),
>> -       OF_MFD_CELL("mt6360_tcpc", NULL,
>> -                   NULL, 0, 0, "mediatek,mt6360_tcpc"),
>> +       OF_MFD_CELL("mt6360-adc", mt6360_adc_resources,
>> +                   NULL, 0, 0, "mediatek,mt6360-adc"),
>> +       OF_MFD_CELL("mt6360-chg", mt6360_chg_resources,
>> +                   NULL, 0, 0, "mediatek,mt6360-chg"),
>> +       OF_MFD_CELL("mt6360-led", mt6360_led_resources,
>> +                   NULL, 0, 0, "mediatek,mt6360-led"),
>> +       OF_MFD_CELL("mt6360-pmic", mt6360_pmic_resources,
>> +                   NULL, 0, 0, "mediatek,mt6360-pmic"),
>> +       OF_MFD_CELL("mt6360-ldo", mt6360_ldo_resources,
>> +                   NULL, 0, 0, "mediatek,mt6360-ldo"),
>> +       OF_MFD_CELL("mt6360-tcpc", NULL,
>> +                   NULL, 0, 0, "mediatek,mt6360-tcpc"),
>>  };
>>
>>  static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] =3D {
>> --
>> 2.29.2
>>
>=20

