Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF7F2F188A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388395AbhAKOoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:44:00 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:21783 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728923AbhAKOn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:43:59 -0500
X-Greylist: delayed 16475 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Jan 2021 09:43:57 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1610376171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1G8cuiVUFhWPKP83ojLy/0EVJtSx/vMz7FSWedeR9zU=;
        b=RvcfNTyGhK12bvs0j+fdLULOQOSf3pP4gpHjDlXRZS+kr7n+wo8rXV+hXOtzt9PxKW405P
        qWF9kKPlNjDzVZoqyN7dOvyRDbSIuwp/IMj/MGtsiQIthzSWxB4d9ZHyPpuaZ4wznpoghk
        eAv/fcqwP4sSambtNtwEDLlJfs+rpWI=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2059.outbound.protection.outlook.com [104.47.0.59]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-25-y_1jlEjVOTOH-jQBDdsILA-1; Mon, 11 Jan 2021 15:42:49 +0100
X-MC-Unique: y_1jlEjVOTOH-jQBDdsILA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7GBa9HtPEkp3ECDsG2cYFOc7Tc0DtyDYCg9YPFGg5+L2dzwilwRXFGLModiNDyTbO1dNn9k3hEIuRdH070p/M8O4XFCB1OV2ci+EyUo/gYjn8bVSwVByXpZpE5rHN0Ce1KpBUCi3mduTi7AKn7TdWSk/lG1wAI3j11khwGjYs7pOVAuGzEWuwh/ZOPLhOzJ2mCZZP5opBT1+0lkqXe9gmlpxDZ5ky4+Tqvb3f9KXbfhOhr+gu0uwQtqNlrjJd+GSLQgWbS17cFU21K2fQDFcaY7y4RXYOk10RwpDtMUV1hTzOor1f8Zc7zI1pVG/vnylvkEFv9wP3j4mv6fzBpVuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6DpbqNjiPazuPaQF+Q7z0ZdhMo+VrAm/58NplvKVAw=;
 b=E9AKNs3nNV29RNMxsDJqy17A19eh2hEhAxX2CzixA5UbR3NW+SndLhu2Wduu2U7xbBM1RmuAvCWupgv8KVtcTT0WD/EhvnQecu2WhlOo5MACA97EBRURzhgrfGpI77FxE76bfS6s6kzQ2tYTTTFzWYA56fSOhVuI5gWswJZWNgFS3mcEI7FHQvgA2m6L9K0NDveWrG5yEMbxYALcMV8m/ropOQFSHCzHTFT0dbxUpIHNwv6TJFV+FD5Ds2waSV4t1qdS4mbkBs6wHKhbwmteErfV4koELSFqNBbfIXoE8DnSnEZ11/of2gASv2bZrpQOawW6Cmm7VnqNojAXdGDfpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: fi.rohmeurope.com; dkim=none (message not signed)
 header.d=none;fi.rohmeurope.com; dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB5366.eurprd04.prod.outlook.com (2603:10a6:20b:9d::19)
 by AM5PR0401MB2595.eurprd04.prod.outlook.com (2603:10a6:203:2f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Mon, 11 Jan
 2021 14:42:48 +0000
Received: from AM6PR04MB5366.eurprd04.prod.outlook.com
 ([fe80::58d1:4050:d882:3ca0]) by AM6PR04MB5366.eurprd04.prod.outlook.com
 ([fe80::58d1:4050:d882:3ca0%7]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 14:42:48 +0000
Subject: Re: [PATCH v2 1/3] regulator: mt6360: Add OF match table
To:     =?UTF-8?B?Z2VuZV9jaGVuKOmZs+S/iuWuhyk=?= <gene_chen@richtek.com>,
        "matthias.bgg@kernel.org" <matthias.bgg@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Axel Lin <axel.lin@ingics.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
References: <20210109112612.1221-1-matthias.bgg@kernel.org>
 <b358179732f940f883c12dd1276f855a@richtek.com>
From:   Matthias Brugger <mbrugger@suse.com>
Message-ID: <a82ba3bd-2ca0-f0cd-b715-a59b57284c1b@suse.com>
Date:   Mon, 11 Jan 2021 15:42:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <b358179732f940f883c12dd1276f855a@richtek.com>
Content-Type: text/plain; charset=big5
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [213.195.126.134]
X-ClientProxiedBy: AM0PR02CA0027.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::40) To AM6PR04MB5366.eurprd04.prod.outlook.com
 (2603:10a6:20b:9d::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ziggy.stardust (213.195.126.134) by AM0PR02CA0027.eurprd02.prod.outlook.com (2603:10a6:208:3e::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Mon, 11 Jan 2021 14:42:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2312cd48-4086-4b82-6112-08d8b63f2a6a
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2595:
X-Microsoft-Antispam-PRVS: <AM5PR0401MB2595AB726D1743D6F6843BB2BAAB0@AM5PR0401MB2595.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DEGO411Oo6/A7eDW5Gd9Vv4BfelDbRrqgRlMhiRfUisIvkKdeS5UbyLNupFFGDMQOWOQoJkFh7senZJycEsTBZahLuPlX8vgva0Cp4vRsh3OYMsxT866Y7rX7Y5Y/qzpN9N295SpnDScSTZuErmRHo2I8e2qFogs1QfOgcd56VMsmPfOlddQ89HqH/R7iYax6VeoQMEs1FUupR9eHPGH3FArOgzwwN76mwCn8CUsdedJOdysXymtxsyqR9hoJZbkjvFC1P96b6I+n6C9L/ZsWP6iWHarOyNCd5IhxeyYYoVVKaMvqAsnISapvNPtoN6TEuU6Z5fZBNLFoZbzSBWJ6gACrW2r3q57lkABiK8Y12AsaWzeFpMkLyh0JefqM6getTbUJ/CXZicD0tbZBzH06KUr+S/QTH/1D00yIQ7Di57wSlZJepXV5SkD+H62iGZpEnVNnMJDHKI3Czqmb4SL1ucJso0uNoBtMRTL15BAiYdN5J59v1PZt/Wo/E6l1b60MM7SP4HN/13DYvycuuv+eSPxbEXs3dlSkDZCqCnE5dkgqLqG+95vhzCrpYBEvSP6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(396003)(136003)(39860400002)(54906003)(53546011)(6506007)(316002)(36756003)(956004)(2616005)(110136005)(478600001)(66946007)(66556008)(8936002)(86362001)(7416002)(31686004)(66476007)(52116002)(5660300002)(6486002)(16526019)(6512007)(5009610100001)(31696002)(83380400001)(8676002)(966005)(2906002)(4326008)(26005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1pqLeX/XUMex/34lQFyt+8LV7SowvCMVbwOoLYqPu6FyG7GdX5uXeeCw1EF2?=
 =?us-ascii?Q?nvo9FfHWIjZHFZ2ykhY5RszxxHmSdGm4YxFjAshs7ZQkg6/9E94Xt/Ocje4V?=
 =?us-ascii?Q?Vr2HGJ3yeqHt6a64Y7Tv4R+D89yLuEQc8o9Agl6o5LC4eGLAvRU5ioVaaTfO?=
 =?us-ascii?Q?/7g0+XGH7fhakMc0CjV41wH+sCIR2o3yzi017Psz/fasOCGxIQ4FFIUMgvhy?=
 =?us-ascii?Q?X6ziv0wT+LlvHPSK6c1SuJcdA/3GL3exbdjw/d0zIhUVIc3E0N6Z8PuUiMWt?=
 =?us-ascii?Q?GYNup9Q4p9g5255dy4XxJ2ArIZADO0FMwlTUu/3Te13y21B8vXl8nh1FoNzc?=
 =?us-ascii?Q?DjEcshPNZ/IPH+69qAHZuvOVaSetQB1PsqWuEWWWlnGvbaeGU8sSmSmokdRp?=
 =?us-ascii?Q?g7nqjh+9FCfMKzW5WnupXUY6xEHKBYURKrC6ema0vSdI8F47XhxFk/UzDtGx?=
 =?us-ascii?Q?kRKzz8d6quy/JMtGmp0g4MW95CjHaF1IEXyLy24PUx1jrfIkzXT4LIzHavHk?=
 =?us-ascii?Q?D3NR9e3xdM5UGHB0gcWcNZclxnuhs3ZPr8gS9rMdG8cWGskwSZ6T9Fm5x6Is?=
 =?us-ascii?Q?DNmdHx1lsHi3BrGoPYTyXUH4Jk3inGEesTCjKJLDukoJHqJmgf8DPQi2/ibc?=
 =?us-ascii?Q?EnlWNyR+SUfI7wzmaKPrKdiRwYqEo0xGh2XCAFp+6cuOA/xvOycd7bJtYw5o?=
 =?us-ascii?Q?e1Fyp3qrH426hhiWbl2kX53sV5xIy+3jxYvSWHTfCA8H2NuuRWU6D2VUuXUG?=
 =?us-ascii?Q?BKCBwPahEncn295TuvMI4R+/7gRV0bHt1/Q8WKPYBvrgtRT1d6U6RH4WgghB?=
 =?us-ascii?Q?a+fkvc1gbapwEsPmjG02JAriubp2hBWgsGizGRrNJJnmqd8bXrnApt1S7ymI?=
 =?us-ascii?Q?I9IBmb7Q67RmFQ+m8O9rmOY27ktabmDbR4QoFxan2CVlVQH2hsdExuVIvR4y?=
 =?us-ascii?Q?+Lc6LRtEqfHSoSyXqc5p3ZSK1AvKTN36FiI2bqcHT7CN9y1WYtqICn3lFd0+?=
 =?us-ascii?Q?NgYa?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2021 14:42:48.3005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-Network-Message-Id: 2312cd48-4086-4b82-6112-08d8b63f2a6a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ToMsxEzix74wSBhcUER8xkfWMKdCSpvVcb6g8RwRjGD4SKPmj2umCLRzEuqhQCh4fN8PFJkPnJExGBTgmnJdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2595
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/01/2021 03:18, gene_chen(=B3=AF=ABT=A6t) wrote:
> [ Internal Use - External ]
>=20
> Hi Matthias,
>=20
> I discussed OF match table with Mark in previous mail in our PATCH v3,
> MFD should just instantiate the platform device.
>=20
>> Mark Brown <broonie@kernel.org> =A9=F3 2020=A6~8=A4=EB20=A4=E9 =B6g=A5| =
=A4U=A4=C87:45=BCg=B9D=A1G
>=20
>>> This device only exists in the context of a single parent device, there
>>> should be no need for a compatible string here - this is just a detail
>>> of how Linux does things.  The MFD should just instntiate the platform
>>> device.
>=20
>> Trying to autoload module without of_id_table will cause run-time error:
>> ueventd: LoadWithAliases was unable to load
>> of:NregulatorT(null)Cmediatek,mt6360-regulator
>=20
> You shouldn't have this described in the device tree at all, like I say
> the MFD should just instantiate the platform device.
>=20

Well with the patch you send to enable regulators [1]  you use OF_MFD_CELL.=
 So
my understanding is, if you don't provide an of_match_table in the regulato=
r
driver, the loading via udev is broken (like you mentioned in the cite from=
 an
older email).

Regards,
Matthias

[1]
https://lore.kernel.org/linux-mediatek/1605177598-23501-5-git-send-email-ge=
ne.chen.richtek@gmail.com/

>> -----Original Message-----
>> From: matthias.bgg@kernel.org <matthias.bgg@kernel.org>
>> Sent: Saturday, January 9, 2021 7:26 PM
>> To: Liam Girdwood <lgirdwood@gmail.com>; Mark Brown
>> <broonie@kernel.org>
>> Cc: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>; Axel Lin
>> <axel.lin@ingics.com>; Chen Zhong <chen.zhong@mediatek.com>;
>> gene_chen(=B3=AF=ABT=A6t) <gene_chen@richtek.com>; linux-kernel@vger.ker=
nel.org;
>> linux-mediatek@lists.infradead.org; linux-arm-kernel@lists.infradead.org=
;
>> Matthias Brugger <matthias.bgg@gmail.com>; Matti Vaittinen
>> <matti.vaittinen@fi.rohmeurope.com>; Matthias Brugger
>> <mbrugger@suse.com>
>> Subject: [PATCH v2 1/3] regulator: mt6360: Add OF match table
>>
>> From: Matthias Brugger <mbrugger@suse.com>
>>
>> Binding documentation mentions that a compatible is required for the
>> MT6360 device node, but the driver doesn't provide a OF match table.
>>
>> Fixes: d321571d5e4c ("regulator: mt6360: Add support for MT6360 regulato=
r")
>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>>
>> ---
>>
>> Changes in v2:
>> - check for CONFIG_OF
>> - add Fixes tag
>>
>>  drivers/regulator/mt6360-regulator.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/regulator/mt6360-regulator.c
>> b/drivers/regulator/mt6360-regulator.c
>> index 15308ee29c13..f7b2514feabf 100644
>> --- a/drivers/regulator/mt6360-regulator.c
>> +++ b/drivers/regulator/mt6360-regulator.c
>> @@ -445,9 +445,18 @@ static const struct platform_device_id
>> mt6360_regulator_id_table[] =3D {  };  MODULE_DEVICE_TABLE(platform,
>> mt6360_regulator_id_table);
>>
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id mt6360_of_match[] =3D {
>> +{ .compatible =3D "mediatek,mt6360-regulator", },
>> +{ /* sentinel */ },
>> +};
>> +MODULE_DEVICE_TABLE(of, mt6360_of_match); #endif
>> +
>>  static struct platform_driver mt6360_regulator_driver =3D {
>>  .driver =3D {
>>  .name =3D "mt6360-regulator",
>> +.of_match_table =3D of_match_ptr(mt6360_of_match),
>>  },
>>  .probe =3D mt6360_regulator_probe,
>>  .id_table =3D mt6360_regulator_id_table,
>> --
>> 2.29.2
> ************* Email Confidentiality Notice ********************
>=20
> The information contained in this e-mail message (including any attachmen=
ts) may be confidential, proprietary, privileged, or otherwise exempt from =
disclosure under applicable laws. It is intended to be conveyed only to the=
 designated recipient(s). Any use, dissemination, distribution, printing, r=
etaining or copying of this e-mail (including its attachments) by unintende=
d recipient(s) is strictly prohibited and may be unlawful. If you are not a=
n intended recipient of this e-mail, or believe that you have received this=
 e-mail in error, please notify the sender immediately (by replying to this=
 e-mail), delete any and all copies of this e-mail (including any attachmen=
ts) from your system, and do not disclose the content of this e-mail to any=
 other person. Thank you!
>=20

