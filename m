Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D55B2BBDE9
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 08:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgKUH4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 02:56:50 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:39238 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726341AbgKUH4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 02:56:50 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AL7iv80005893;
        Sat, 21 Nov 2020 02:56:48 -0500
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2046.outbound.protection.outlook.com [104.47.73.46])
        by mx0b-00128a01.pphosted.com with ESMTP id 34xwheg3t3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 21 Nov 2020 02:56:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWtMrxCsdUBVEOj1pT1QNO23J3icRlnHvkxub6H4Vw3oakyrYTmbuGnQ+lvCkZK9J21TTfePfJj7AnWJ6v/KwKXLkSP4U3DRfP1b6xQRFOh+Ez6R55U+bDdGFWeV+05OpKq1lM6TVELpkDKe9sR7HB+OyKdYTDMIlyXdmpgcshZZc+xtdT62GUx9MvISLS86h2eswDbpuubX7qmgt/8JAzWiuvCw1K0PDpjfn/B3P5C1F9SmgkHqhhE0vTYThUPejwHEujpwubt4Fu4PSAdVhGVgsLgfwJwsTtquRrT48mLOqdIqfk1i+HT6GY27qnieE9QNlz/UKKhkwwIxd4hyRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuQNnyDeUeLkJAlblpYjvwsj6ay/9iG0CTLJHPt5r3A=;
 b=iYFHEI8W1k0vc5Wg9A0+MPnCdfS0s+wWhulZmYFbOpEo4gwykFMvzZL8Mulo5jI3NBn76aoz8ADQcUwz+QJ6t3COas9R2kU55uvZWJX22a+W3jC6kgHo3JvapU/DhkusLLQaV1CUwSAmGrscKeyMmgIrcu08J5cnX3wCLz4PJnA5H2qYYKRonu/VfeZmT241sH/XsY0npDpX3kSZ6z+zvzPaG8xuxegmO39b/jpFcCRRw5UHi0qbZFWGpDvxbrountmQk55Mo5Mmg+rU/A/Bi8nOKHAiue3o4TyARl6LovQt4bmxhIZxU7EQmJwwU2ANz3Up1WEkzkgnPeeFzbAYSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuQNnyDeUeLkJAlblpYjvwsj6ay/9iG0CTLJHPt5r3A=;
 b=uEh37CZ/y0WGYZFLTE/5ETJSpZuq/d6N3gSRoPkMMUV9BN2J/lXJioUrIftGmb04DGFtqeRo4XlslZsjQUJe6iiPytwEjLpXDd1HRQM5YWt2edaX1sk+upmhxiBSWIQTzLwVXnzoOOfCHbPh1SbG1CiUh2uF9IsbDHW6Rk/4BDs=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DS7PR03MB5511.namprd03.prod.outlook.com (2603:10b6:5:2c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Sat, 21 Nov
 2020 07:56:46 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::f99d:8928:7e14:1a62]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::f99d:8928:7e14:1a62%6]) with mapi id 15.20.3589.021; Sat, 21 Nov 2020
 07:56:46 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] uio/uio_pci_generic: remove unneeded pci_set_drvdata()
Thread-Topic: [PATCH] uio/uio_pci_generic: remove unneeded pci_set_drvdata()
Thread-Index: AQHWvoPLrKdhmexKlkeX/vresyKnUanRK32AgAEPE5A=
Date:   Sat, 21 Nov 2020 07:56:46 +0000
Message-ID: <DM6PR03MB44116A5DF5A5F4C6D8386132F9FE0@DM6PR03MB4411.namprd03.prod.outlook.com>
References: <20201119145906.73727-1-alexandru.ardelean@analog.com>
 <X7fkv1m4CvCcCbzF@kroah.com>
In-Reply-To: <X7fkv1m4CvCcCbzF@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYWFyZGVsZWFc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy0xOTkwZTRkMy0yYmNmLTExZWItYTVjOS00MTU2?=
 =?us-ascii?Q?NDUwMDAwMzBcYW1lLXRlc3RcMTk5MGU0ZDUtMmJjZi0xMWViLWE1YzktNDE1?=
 =?us-ascii?Q?NjQ1MDAwMDMwYm9keS50eHQiIHN6PSIxNjQxIiB0PSIxMzI1MDQxOTAwNjIz?=
 =?us-ascii?Q?OTU1NzkiIGg9IklrbEs5S0kyVUJZa2FYaGQ2b0JVQy9xMGgwTT0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?QzdnT3ZiMjcvV0FmdjFTR2tJUk5mZSsvVklhUWhFMTk0REFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBZ3NWMDRRQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
 =?us-ascii?Q?UUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFCekFG?=
 =?us-ascii?Q?OEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRR?=
 =?us-ascii?Q?QnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURF?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dC?=
 =?us-ascii?Q?dkFHb0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21l?=
 =?us-ascii?Q?dGE+?=
x-dg-rorf: true
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=analog.com;
x-originating-ip: [188.27.128.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0a75ec9a-fdc6-44b8-e57c-08d88df2fe6f
x-ms-traffictypediagnostic: DS7PR03MB5511:
x-microsoft-antispam-prvs: <DS7PR03MB55113C2DEFA923858ED70586F9FE0@DS7PR03MB5511.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v5/Ey8psnB/08lZSE4mTqNbBivzMwVl9ffmnFHNSMTDA0TMVhfDFq+vlyiGwe0rut0eA/40Fx2UaYGv2bDpJXo2Z7WvUZ710eYFhyxTVCkTVsh8+hpBMl4kWhmehOlqFXBRbuK/6pClHTUBlITe08An0oj6zt3761vefoLiAAOPYTwBlih7mRmEvDNONNJDy5y4hhTi/M6OwtO1/qjgiCLeO2g467/u4pqZ+qlwMl/pK31ff5Vb1zr16C2PrEVntYqKdZmNBhFHEMQ96RYku+nvW4XqIN+YnykPCzs6u/dOwf9n3tl/yL2wFSEBU76bS4hkkfw6cY+0iGRGFzSYb5yJS3O2WWeeNU8I+JJlhampj5r4exBC+YefeI38JSd4EcsDQobOpqrOjcww3htzHyTUeU2U/KqmnmdHhL9/MSePAh/4N7LJ03RXvNB1TpHtWiRpRfCOLdlD2MLRfr3YZnWUvMosq8PpBKBAGISA6B9A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(66476007)(316002)(64756008)(86362001)(2906002)(8936002)(66946007)(66446008)(76116006)(66556008)(71200400001)(6506007)(186003)(83380400001)(55016002)(52536014)(478600001)(53546011)(7696005)(966005)(8676002)(4326008)(26005)(6916009)(9686003)(33656002)(5660300002)(41533002)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: g+M6n7AuuFZL8exnsc0a3iJYx10FMnr1zOZcwmN3Xy2JiLeOetTUVE7NG3ENeTyfvxitlMXDTNYWPdzbg73T6OGu6aJElRqRr8mn0OFMfSBR0XK8NpN+6fvTTVfsxCwI5YbkOV7K9QB8/BH60toPgsTMgHEh1nUvdEBnoV1qB4atG7DBxGHXgqdIco2Q5nrufRT92n6b+ncD8ZlqSJI8msBgKXG7Nv9eBOpUS5FCecbw9SYw+m5KsP+YGU5N/AksdUOWRsIQnRyDMP+nvk9e9wk8UPTeSzRWuy5V7L+MU+q8up2YrsGgUQrbOM7dF/qcMWJAZgNtjTNekgBtSanl0a9dLpIlM1hdGTxP8iOTHqatoPE5pkRAQSc/6Z7IGOBj4uSNt2lpIj7pRkKUk9j/9vndE+YRuG3HEwic01Jj3M9AqWOoM4+13P2qAg++GXCYeXgiDFsZz0GPy9DBtlq49MeRjKY0r8ZRgNJ9+J8VAVXdEc6c3YSOkWYjHUU83YGlOfV0uD15BUW7NV63Zi55xaNfKzgjWjaljSUdswbaJzBHYeEJ/2UkHvTCVQz368BwSm02aPL6mBmr8HBFk82yiPP+PmL5XBWRkogQ3HINDKY0Xyq/vG2FwmjuwEn4hD93mM3qKl3slbGMAyFUHkum9Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4411.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a75ec9a-fdc6-44b8-e57c-08d88df2fe6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2020 07:56:46.1594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ySFOA3NQ4NfchvBH5gfdl08F7SGKVOskELFd4aHx+/tj8OqX84JKCX4smdnJhMA7tnRT2M3cqecLLQ35rmRgweerjCY5c5K1SZb9mrsObAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5511
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-21_03:2020-11-20,2020-11-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=944 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011210052
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Friday, November 20, 2020 5:46 PM
> To: Ardelean, Alexandru <alexandru.Ardelean@analog.com>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] uio/uio_pci_generic: remove unneeded pci_set_drvdata=
()
>=20
> [External]
>=20
> On Thu, Nov 19, 2020 at 04:59:06PM +0200, Alexandru Ardelean wrote:
> > The pci_get_drvdata() was moved during commit ef84928cff58
> > ("uio/uio_pci_generic: use device-managed function equivalents").
> >
> > I should have notice that the pci_set_drvdata() requires a
> > pci_get_drvdata() for it to make sense.
> >
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >
> > Apologies for not noticing this sooner.
> > If this can be squashed into commit ef84928cff58 , then it's also fine.
> > I've started seeing that there actually more xxx_set_drvdata()
> > leftovers in the entire kernel, and I pinged the checkpatch crew to
> > add a check for this.
> >
> > https://urldefense.com/v3/__https://lore.kernel.org/lkml/CA*U=3DDspy5*R=
E
> >
> 9agcLr6eY9DCMa1c5**B0JLeugMMBRXz4YLj1w@mail.gmail.com/T/*u__;KysrK
> ysj!
> >
> !A3Ni8CS0y2Y!q3fJW4rKvEHQ7BDt1PaK4Cbexv4wbivUKBeDjo7ZwNXYwOLBawA
> Eq1Jaj
> > mhYxftX6DAJpg$
>=20
> I can't squash existing public commits.  Can you resend this and add a "F=
ixes:"
> tag to it to show what commit it fixes so we can track this properly?
>=20

Sure, will re-send in the next couple of days.

Thanks
Alex

> thanks,
>=20
> greg k-h
