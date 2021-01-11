Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDC02F1267
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 13:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbhAKMjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 07:39:35 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:31751 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725601AbhAKMje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 07:39:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1610368705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=is7cmiol6TRwAoeQk2PjItn3jwos5xZaWT61znh3Qa8=;
        b=nkSgngpo7HylMbAE8BiyYBpgW1j/51AqgEvBnJ6k7CMIM9mg8indiwj+/jvIW/TCu9LXmD
        RX6xPGr8jdiQxWWkSlQEIbsiuk4se8ceY9s1NX+lvV3Nz/bn0xdeMKTYMljBxR4gWpWtYX
        1/nMAVYL8vKy9SWGmyR7AATYAvN+07A=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2109.outbound.protection.outlook.com [104.47.17.109])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-24-4HYf5GLSNpmYNJ-jqIL89g-1; Mon, 11 Jan 2021 13:38:24 +0100
X-MC-Unique: 4HYf5GLSNpmYNJ-jqIL89g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwA0GcQDqO/Ks5g/g9O9UbTSlJCWmlOdEB6hzQwzccTOr89f679ZFzm+wUUI8DJkCZuiv4BfVUGA4ALkjpeQEGzFtDBhsEcSq5U6Q9LwPfTW9X4c3fiyV9WFGHf4y/FXfYsJs5kAph7T8EBPMzbO37Vd/UBv283fiKQ8NmlingVPq5nfIEgwruUuGeeMYe2GrcBghSWW0qEi57VHO5Hbiy+bakq5gmreSLROZxKkiZaSWQ8aAxFFzFr5bLCBh9WapDhZYL3wth4ZNGlv6m1Na1Cr+idVr4fzMiZOA48mKCkL+lRWZ1LeF9RbMERZcM7JbeAabhB2t+o8gbtMgRD4AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNkwbmmw+1Cc7j4G81PW8YvlvJvb5xuVzFnUXsPGPeI=;
 b=eOlSQRSbtZcvu8T3T5E/+eN2IU0PjFPa2gHd9Ot8jOI9ofonxAwQK/1AssoGAiUH2RwFZZrvTBY+/RhQoiuCqspbH3H0Fb2bo+sp0P7CB6E+Nzs+hAsgZHWjGsTfcYqgz+Hu6ZlP6igPH8s9hzWn6322JIG+za9uEpwBSncw/0h4k39SRev3m2R33eue1HLxzcmGiF+xxqyxYf1YOTfZ40HGjk8iYAi9SdepHW/iUV/TeWeqC0nktC34trJcuumRdKKaZaW0D/OdFsG6Ym3PWRd+5vqe1wTZ2sZuRk79VHBmYB3PSZX6yVeAuEP8AcOkz9BXwlAoUz47fCc+SmFsBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=suse.com;
Received: from AM6PR04MB5366.eurprd04.prod.outlook.com (2603:10a6:20b:9d::19)
 by AM6PR04MB4536.eurprd04.prod.outlook.com (2603:10a6:20b:16::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.12; Mon, 11 Jan
 2021 12:38:22 +0000
Received: from AM6PR04MB5366.eurprd04.prod.outlook.com
 ([fe80::58d1:4050:d882:3ca0]) by AM6PR04MB5366.eurprd04.prod.outlook.com
 ([fe80::58d1:4050:d882:3ca0%7]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 12:38:22 +0000
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        "matthias.bgg@kernel.org" <matthias.bgg@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "gene_chen@richtek.com" <gene_chen@richtek.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "chen.zhong@mediatek.com" <chen.zhong@mediatek.com>,
        "axel.lin@ingics.com" <axel.lin@ingics.com>,
        "hsin-hsiung.wang@mediatek.com" <hsin-hsiung.wang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
References: <20210109112612.1221-1-matthias.bgg@kernel.org>
 <b358179732f940f883c12dd1276f855a@richtek.com>
 <8a5b2d7a-cd31-ecbb-bdc2-35c881c9068d@suse.com>
 <ef659bcf62c9bfcf68359f21a9c9cd0093b9b969.camel@fi.rohmeurope.com>
From:   Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH v2 1/3] regulator: mt6360: Add OF match table
Message-ID: <b1bfe40a-8d70-4177-8afc-e2c0dfe442a3@suse.com>
Date:   Mon, 11 Jan 2021 13:38:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <ef659bcf62c9bfcf68359f21a9c9cd0093b9b969.camel@fi.rohmeurope.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [213.195.126.134]
X-ClientProxiedBy: AM0PR03CA0029.eurprd03.prod.outlook.com
 (2603:10a6:208:14::42) To AM6PR04MB5366.eurprd04.prod.outlook.com
 (2603:10a6:20b:9d::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ziggy.stardust (213.195.126.134) by AM0PR03CA0029.eurprd03.prod.outlook.com (2603:10a6:208:14::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Mon, 11 Jan 2021 12:38:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ad4c6e7-b9f0-4d7f-0d2b-08d8b62dc89b
X-MS-TrafficTypeDiagnostic: AM6PR04MB4536:
X-Microsoft-Antispam-PRVS: <AM6PR04MB453634B1DB5CDF04C19D9029BAAB0@AM6PR04MB4536.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DAhO91dNMfbflffD+QD21+9CURdy8nc+4HG6hCRs75l2Emn2c5ll2anu3eaCQPP0w70CxTi399ydYnt7YaZUp+7XUpDLODqZLUd17wRidJvP88sBb7fFAR4gnXz9bi127U9AtMq/GTsnJ3slvUIs9Ybuz/RMe9gm9kuGFXaIY45vGLiAm7T9HuO3X7Yx+nTxSynv9k7dHqi3pZeP348yqlL9BgGXMbtC2EKIl6joa5VG/Tn6xn4MSvjr/us5tDbia5sH+7xDrCoXr71+lbYd9QTIDNiQhS4RQkhcpCmS79pEHV8mtvv9/4N1ZTQ6TZxniUGzOae7RaNFxf+qOmwCgjXa0yC9W0AvmArzTjVh2R+cfxYKqczn7Bs744dNtspZDVyL5uHD+5DTPp9DZnRr0YiB3pPLvldE3VUZgRS/qeo+Ou5EQ3mwt6CNJnIsx5ormf5MsHv9jO2fv6F/s0zgt2JsB7d94h0cSZzP0b+08iJZt++zatjd1OnrJKdAzQoR/hscKOgkJ9QDBP6h/XlB1w4mUUDUC0FInox7D+FNOAmaKVE/6zOK9bvgFAMaFOoP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(136003)(376002)(366004)(396003)(5660300002)(966005)(53546011)(83380400001)(36756003)(52116002)(6512007)(86362001)(66556008)(478600001)(31686004)(110136005)(54906003)(316002)(66476007)(31696002)(66946007)(8676002)(4326008)(2906002)(26005)(186003)(7416002)(2616005)(956004)(6506007)(8936002)(16526019)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hwP1Yr5rnCL+ROJ1WjXoYqutnvOPlUJTGnEH8y/Nhu3i6bJTTmojx1BlSxLc?=
 =?us-ascii?Q?dKQ3GIE/3mTnXzxB05BvzCgkwlhVRh1U4eZMgxO390B0OUAm1EI6yylUPtOs?=
 =?us-ascii?Q?tA2xpFyYQ8xvq0hN75eYP21ZKrMgSkcyMmX63Ng45CHQZ00osRsS4Rz+SCoC?=
 =?us-ascii?Q?RNETIwGiUJ5uJP+9QlieXkqEbYrXBUvmOlcsvjS0b9KxhAuo6r83es5PBisY?=
 =?us-ascii?Q?v0dC+aqPSbwjpeOpFgXDsTdrskzPKCrwrCMQ18gusEmOeEnmBaqzr0errydU?=
 =?us-ascii?Q?7is+K+vmNlKeqXdflTkR1+RjniJUrES+MJDBjq+2Ecj+tWFQbUsa5BJva/3R?=
 =?us-ascii?Q?fo53KbR1bx0wmFW52Nb9qGw0CMKaqMuFxBA5o3cimLKHf23D4khAaldnK8Dl?=
 =?us-ascii?Q?ZJICBNnJ/yjVrGRFrmKps9EH8vtrBSF2tbyvPp/VEywElUblpyz6bCOWb0Wp?=
 =?us-ascii?Q?lghGjgI9/gUGeSfDWVijNm0wHhNHqu8uMc3Zh8zywQnaX0q3qMKWmC89JS+O?=
 =?us-ascii?Q?vfC7L8DYY9JfEFLzAZY2EGiDV8E+8WCW4QUazCup41cGG0FeO0mBiXxesxHV?=
 =?us-ascii?Q?O8PnECsZk2A2IWl/9ncGB/oJ42SEk5/GWRldqSNQAl3x3h0m/eflHroz7TX8?=
 =?us-ascii?Q?/d9aXbG+ZzW/WoWR4eQFOM74PobKKgFxEWbd1Nmuy1BlVXMWYt+pLmA6jAsv?=
 =?us-ascii?Q?45wipB3EbiCT+Jst0NLi6CF1ieZzL8kDoiWOP2MO0SyePSA4ize7xP2ULIqQ?=
 =?us-ascii?Q?55QSgcwyuUWRupF40gXezbylKcGABn0uIa8jn4Bdx3AwkcaazlmwY2aeXF71?=
 =?us-ascii?Q?h23bpmukqI5QVOeGo5Z9RZGzB5T9nyDPybsU6ghEBI9XInNt9Kr7YzOo6KAo?=
 =?us-ascii?Q?zhwhKugm04caZmkBFFZ7kruB+3oH6AEsrCYFq9HDD+LFWn/7IDJUqgo3mLiM?=
 =?us-ascii?Q?yXUA0XDiXLSuoS5HJ9kFB/HPmmnsmV7N5XJNS77WOcRSk9qr7F6EjU/u1YEx?=
 =?us-ascii?Q?3uvf?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2021 12:38:22.7703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad4c6e7-b9f0-4d7f-0d2b-08d8b62dc89b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8MCy/bZ2IPC2LeFJND0rMIjDEzRkFUht4KyZi6pE80V7iGx0TP4qpd45nKC3cRhgQafNb9rIsjnHCarLP5e+Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4536
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti,

On 11/01/2021 11:32, Vaittinen, Matti wrote:
>=20
> Hello Matthias & All,
>=20
> On Mon, 2021-01-11 at 11:08 +0100, Matthias Brugger wrote:
>>
>> On 11/01/2021 03:18, gene_chen(=E9=99=B3=E4=BF=8A=E5=AE=87) wrote:
>>> [ Internal Use - External ]
>>>
>>
>> Please don't top-post in the future.
>>
>>> Hi Matthias,
>>>
>>> I discussed OF match table with Mark in previous mail in our PATCH
>>> v3,
>>> MFD should just instantiate the platform device.
>>
>> Did you ever test that? Which MFD driver should instantiate the
>> device?
>> I had a look at mt6360-core.c (the obvious one) but I don't see any
>> reference to
>> the regulator [1]. What am I missing?
>>
>>>> Mark Brown <broonie@kernel.org> =E6=96=BC 2020=E5=B9=B48=E6=9C=8820=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=887:45=E5=AF=AB=E9=81=93=EF=BC=9A
>>>>> This device only exists in the context of a single parent
>>>>> device, there
>>>>> should be no need for a compatible string here - this is just a
>>>>> detail
>>>>> of how Linux does things.  The MFD should just instntiate the
>>>>> platform
>>>>> device.
>>>> Trying to autoload module without of_id_table will cause run-time=20
>>>> error:
>>>> ueventd: LoadWithAliases was unable to load
>>>> of:NregulatorT(null)Cmediatek,mt6360-regulator
>>>
>>> You shouldn't have this described in the device tree at all, like I
>>> say
>>> the MFD should just instantiate the platform device.
>>>
>>
>> Well from my understanding the regulator has a device-tree entry [2],
>> so it
>> needs to match against a device-tree node. My understanding is, that
>> you need a
>> the devicetree node to describe the regulators provided by the
>> device. TBH I'm a
>> bit puzzled about the comment from Mark here. How does another DT
>> node be able
>> to reference a regulator if this is not described in DT? I think we
>> need a DT
>> node here and the matching in the regulator and MFD driver to get the
>> regulator
>> loaded via udev.
>=20
> Others are better to answer - but as I spotted this from my inbox I'll
> give my 2 cents :)=20
>=20
> This can be done W/O regulators having own compatible. Please see
> following:
>=20
> drivers/mfd/rohm-bd718x7.c
> drivers/regulator/bd718x7-regulator.c
> Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
> Documentation/devicetree/bindings/regulator/rohm,bd71847-regulator.yaml
>=20
> as example.

Thanks for the links. Yes that's' a way to go, but...

>=20
> The device matching can be done via platform_device_id table.
> I think the MODULE_ALIAS() is needed for module matching - but I don't
> remember without further code browsing.
>=20
> Anyways, the BD71837/47/50 DT entry without compatible for
> clk/regulators do probe and load the sub-devices.
>=20
> As a "tradeoff" subdevices must retrieve the DT node from the parent
> device.
>=20
> For my uneducated eyes the DT binding for regulators should be changed.
> Compatible should not be required and the example node should be moved
> to MFD binding document in the MFD node. But that's just my view on
> this - not willing to push this to any direction!
>=20

Generally speaking, DT bindings are stable and can't be changed in a
none-compatible way. We could argue if there is any user of the compatible =
out
there (probably there isn't any, as the code seems to not even be working).
Apart from that all other cells in the MFD driver are defined as OF_MFD_CEL=
L
[1]. Actually I suspect that mt6360_ldo should represent mt6360-regulator.

Regards,
Matthias

[1] https://elixir.bootlin.com/linux/latest/source/drivers/mfd/mt6360-core.=
c#L294

> Best Regards
> 	Matti Vaittinen
>=20
> --
> Matti Vaittinen, Linux device drivers
> ROHM Semiconductors, Finland
> SWDC
> Kiviharjunlenkki 1E
> 90220 OULU
> FINLAND
>=20
> ~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
>=20
> Simon says - in Latin please.
> "non cogito me" dixit Rene Descarte, deinde evanescavit
>=20
> (Thanks for the translation Simon)
>=20

