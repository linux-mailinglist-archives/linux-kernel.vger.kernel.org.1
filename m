Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5332F0FBD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 11:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbhAKKLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 05:11:32 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:31695 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728798AbhAKKLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 05:11:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1610359824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ARvhkssMQeJo/i/W/g/hz+RapebGQd94lMBJ67CplCE=;
        b=Wmrd4RmCGRUIRG7xcu4okCKQ8jxh9frjQTmKJUlVk0es/utDtXpcMneIuKJMRZ/4T0xheQ
        rRRxU+V6vQNC8fLBsoTGw57Y0H1YOTkJupyhxavhg2ePdRJVT8aq431HS+E6okIdN/8Z6q
        gkoXHRD+vXJ2RuhxEr731Q3zqC3Og5A=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2050.outbound.protection.outlook.com [104.47.4.50]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-19-dIjTj2uQPSCwi0HoqAf_wg-1; Mon, 11 Jan 2021 11:08:14 +0100
X-MC-Unique: dIjTj2uQPSCwi0HoqAf_wg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXOusoDc9aU342h4s7v2lAdh7AuoW0ZKfDgyxlcSAWia+LQ8jVEOI10PmS8Ssm6RRapuFSPQ5SY+xuXiFDPVd7ZD94tsVfdT73gttJdGinBiezdqOylARNZiNpLcDYdmPr4/W5B+d2VCk+kAYDJ/K8gt29De3F5kuLnPq0YQKoPC0jny3lf2BtNjAvyTNOAKco8IRFM4+EXsnYpWlcALaj2voqsNc2KrSn5Uwy7H2p+3rSmQWqXxALuzdkJnM4Py/Aqc1arSTmU9mIvPAoidCMJV5Gi3GpklUhclIrYuBT/LENk5Z/X6ptSzwragW4797NnVC+cfvszh5ol/Ky6fxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBSwokSyeUFuahmDnMu7fyA0nFKh4WTtAZgU17MnzCI=;
 b=UMD5d+X0XQAA9AxYCNqjx7miGUBIo8n8ayGRb7H4e29AW80YsT6KmTCr8Kb/KKBcTkIjT5P61JN9UQs1/GubDoOgWRnEJ+SVIRClhPGsU3NE2iOo7ZqL6GkonLKb/7Dsey6JrkD5BwxW5FjDuP9lZQYjoTv9BtTzGlLV+5oBM6jKraqsSPEmEMgaZjuiONIZwUsmZ4QqWy45enKF/CKhLp3S9DJ365JLTIOhO6gOTdNBebKZPLDP6GEeAonPlAjcp6xIKg5mKDwiQe1EUxSF6fR6iwWNWQBCqVnQcNT0UBoxc+3SpnftUMfXv+JoHVJp+Tm7UlRg/mIN+FvXYUi6lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: fi.rohmeurope.com; dkim=none (message not signed)
 header.d=none;fi.rohmeurope.com; dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB5366.eurprd04.prod.outlook.com (2603:10a6:20b:9d::19)
 by AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Mon, 11 Jan
 2021 10:08:13 +0000
Received: from AM6PR04MB5366.eurprd04.prod.outlook.com
 ([fe80::58d1:4050:d882:3ca0]) by AM6PR04MB5366.eurprd04.prod.outlook.com
 ([fe80::58d1:4050:d882:3ca0%7]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 10:08:13 +0000
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
Subject: Re: [PATCH v2 1/3] regulator: mt6360: Add OF match table
Message-ID: <8a5b2d7a-cd31-ecbb-bdc2-35c881c9068d@suse.com>
Date:   Mon, 11 Jan 2021 11:08:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <b358179732f940f883c12dd1276f855a@richtek.com>
Content-Type: text/plain; charset=big5
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [213.195.126.134]
X-ClientProxiedBy: AM0PR01CA0164.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::33) To AM6PR04MB5366.eurprd04.prod.outlook.com
 (2603:10a6:20b:9d::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ziggy.stardust (213.195.126.134) by AM0PR01CA0164.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Mon, 11 Jan 2021 10:08:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 497418d0-5834-45ff-29c2-08d8b618ce70
X-MS-TrafficTypeDiagnostic: AM7PR04MB7157:
X-Microsoft-Antispam-PRVS: <AM7PR04MB715704111440A5B51E4884F3BAAB0@AM7PR04MB7157.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r+IfZ79WEJIxLu2b89HCU14Ju/Wk4iHV60NqHAUdpQPNK5sVxfMXdSVf3P9uVPAF6Ol1E0r6mw03ld3EjfaMP0rZEEhXrK4UazBsNIVmEbneNGotTfr1vWOsKxiVT9pPd0/6UNEreRVPov9lXyPHR9M8TOEWHN9wa2B/LWYzOliUK+ybBMFBKpUBGsC1KHa+VoOju/Anf/Gby8eloDAjGGxApM+l+CBQvjucPcshmEmE9aHF+77iyTX6TmzSQN3w4J1CMxlowFzp7QAGeTsReBzCQaFfpE2GwVM5RiL6fRAoV4quay5bTDRkUlgi74rMbFHBFH/PnQfzgeoPrI9asc6/iSnMQ0KgC1+5jbHtSZCv5+JjmjFtGBoAkFmvWlT2sHBg5YN+P0O0HDjI9RE77nuQv69HGkCe6kd83e1IbChKjljDhNEBNwBxJOl+acB6OLFjz9MiQdeHm07IP+5gq5V7aK+ilVBDkgjhLF2m8U/mgPnxfl36RmzP3PjH/bOtntyrboMkIISZRsYZu8nljQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(136003)(39860400002)(396003)(8936002)(110136005)(5009610100001)(8676002)(83380400001)(53546011)(54906003)(6512007)(316002)(7416002)(6486002)(2906002)(52116002)(36756003)(478600001)(956004)(2616005)(966005)(66946007)(5660300002)(66476007)(66556008)(31686004)(16526019)(26005)(186003)(6506007)(86362001)(31696002)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?pcszFiznf1jMMp9AipwS6SFvm2l+Tx8QoGzOcaqItV+oa1kwYec81Gxzjus9?=
 =?us-ascii?Q?TPF2NogBURPTzKk9tvZvxaeup5MpsyvF4D5MU+BfSHoiBMxS/HcuUW6urlDP?=
 =?us-ascii?Q?rNF0o/kaZZQ+bGLSIOvRjbxk77yWUwwV/wpDM97/nCvZzObnt2MRoJ/jFa9m?=
 =?us-ascii?Q?EmAYmmkRBQRdRiIdVGLqUiBHGhj9hLA7tKcOPGAh4LyeEv9Bu5R/4SUmwQmG?=
 =?us-ascii?Q?84zER8BGKBJIlnJ0k7jSF1RObhrGsMaXZLwm0JMAkYoXJpQf3lp4lW7iHrrJ?=
 =?us-ascii?Q?XFLHVSpdoAW4m868ICw4bnSGJlHYk4xMLW1Krve8EX/cEcCl17w+VvCCz6et?=
 =?us-ascii?Q?U3I0Kx41qyyfZIYzB/iZvIPXP1UUJK2sHVc2Vy19/RZs8vAohNAkIiv4+xpD?=
 =?us-ascii?Q?/MAKZEgBlDFvnR9kbJ6/MllAUXeLCG3FU+fL2wPDDap1mDp43zBhfkXJo0Kg?=
 =?us-ascii?Q?+iuNvuNs9oqLThur8wS8sDKLL17IJ0Z5yMcSxAHs1UZZflS6YhXfIa/r6Vg+?=
 =?us-ascii?Q?wwCSS1oV05TaPJh+6ZipkEze177cDCcLEvHJ0Lopw9BWRRominROxErkQ4p8?=
 =?us-ascii?Q?GYIS41kYzPSm7Mhc2P7a/YkSkiS6ZxUvZ3fgBzowtpu8f5pts+5Q9EELGqwQ?=
 =?us-ascii?Q?8fLSC2C/v8I659BTE2D+36NuLpGHyratCdShzUxk3aEx4Z+Z4H06Im30IT4c?=
 =?us-ascii?Q?0etX2WpLky8ynoD+/DNnG0bfpPMxkY+sjYKoBuvPNwcVpCSeIocbAQAssW7L?=
 =?us-ascii?Q?Yj8uMoz1v4EqvpSPstIh2ylKCQjs9HEJhqrsnPCreOyj4XOtrDQpflPKR9CP?=
 =?us-ascii?Q?PIwZ79Yvvcu1JNShGLwwUeSNjWHG/4wPxNikRflYJpAoOoSvbwNdZIPYJ+BL?=
 =?us-ascii?Q?iq23jiwxPuCdSqxc1XgfN7C/KJXj2X2aVtzetZTxxkRGVrIRCT9wTkwx5m/a?=
 =?us-ascii?Q?dHtY8oKaUwuj/7Y9bVWCLsGapSQBZAg2GE56a1NWRC1FW30TYgFQ8PpVjRx6?=
 =?us-ascii?Q?JIbR?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2021 10:08:12.9953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-Network-Message-Id: 497418d0-5834-45ff-29c2-08d8b618ce70
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ab23dZ+KnXlTkdrGdwwZfRvx3goVurE791H9e5/gMCSqNYZ0HJg8hYpWgCEG7EE2xe+4bxjct4r2ACCTsJWd2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7157
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/01/2021 03:18, gene_chen(=B3=AF=ABT=A6t) wrote:
> [ Internal Use - External ]
>=20

Please don't top-post in the future.

> Hi Matthias,
>=20
> I discussed OF match table with Mark in previous mail in our PATCH v3,
> MFD should just instantiate the platform device.

Did you ever test that? Which MFD driver should instantiate the device?
I had a look at mt6360-core.c (the obvious one) but I don't see any referen=
ce to
the regulator [1]. What am I missing?

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

Well from my understanding the regulator has a device-tree entry [2], so it
needs to match against a device-tree node. My understanding is, that you ne=
ed a
the devicetree node to describe the regulators provided by the device. TBH =
I'm a
bit puzzled about the comment from Mark here. How does another DT node be a=
ble
to reference a regulator if this is not described in DT? I think we need a =
DT
node here and the matching in the regulator and MFD driver to get the regul=
ator
loaded via udev.

Regards,
Matthias

[1] https://elixir.bootlin.com/linux/latest/source/drivers/mfd/mt6360-core.=
c#L294
[2]
https://elixir.bootlin.com/linux/v5.10.6/source/Documentation/devicetree/bi=
ndings/regulator/mt6360-regulator.yaml

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

