Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697412CE741
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 06:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgLDFGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 00:06:46 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:51632 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725300AbgLDFGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 00:06:45 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B44wi1q007940;
        Thu, 3 Dec 2020 21:05:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=NO1fehWihMXASY6pbPkHrXtaHR/I3k3CZYHciE0Bh2Y=;
 b=qB0n8WpR/NU0d6vv+rfuyjbVQ2YY4PecTmsnlz2CKVyb6Sg9b5ZBo58GHfHJDFm4byAN
 QP7hAhZxa325J8zK2CTdQDN7bB+har00wUD6WgUMCV/eRtpGBJYT2Z+c/NDy5kROoPXY
 Thm7/XAb0xJ7+moeVv81Ei0QFvot3cymaC593X9t45o55+z022cnGl9/z1W8vXJ+4imQ
 vMATgZc/MGMnYJochiUlAiOYR0K6dH8k7lXfhu2VsVH7IWJbNphb8UGvwiRMiaxJ7Tmt
 FgwUTwpwe9JoRqVBhx428FI05aG3bQlQwFSU7iFc8mVGE1RXUwkiI9ZvnKTEyI/TJE5y 2Q== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0b-0014ca01.pphosted.com with ESMTP id 355vn6j0s6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Dec 2020 21:05:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lg68TBewPKVsRjAB3sVaXP4bQpWxYixe1ICuO4g5vkU22PlNvi4w7O6t8Rjx+tFA1jQYRfVReKVOYqO9+03NM/z3SQHJqTPvhgoXs8HCZYSvzbJtbugr9kOj64UGrljpVoCTgC5LHb7SRtLs8NdI3pbZUyzhO2+80BSgux2em41X8xwXj6m4NwA4Z6RDihF+nbShO++ewTHXElpcfe32+t6MzP+uffAAjW+H1YZIjOWCZQ9kTbLxyvyK3dnyTwn+KXGFakZRneiEP7enXHaP0fxe0LQokRsPabu5EEUgwOilovcr0yvtiCIvquUAEyT3JIaFZndTGPdMiEm4Y/zQcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NO1fehWihMXASY6pbPkHrXtaHR/I3k3CZYHciE0Bh2Y=;
 b=OkOsXSCjhyL3oHt5RiIVtavbntK4pl5GDrrTdb5m4KuJOasBWTe3a9rYzNuT2vm5eu1fim7L28+gJ3asOzobnNjN+HuLFH9rA6VhioHc/5xjMARjftGDcQOlu7T3Jroujg4raUyRXGzF/V7kFnyvM1BtLmmZuKJKQkT7jVLkq7p12tSi8x+NC8odCureh/H2kiRHWyQMYRgXPEz91+ZJna47EzdJ4sEfDtzy6qGX4bPqW3cG8mKuXRIq+BsAPN3+nDSQCgn8izChbLY5D4LwgZPdIXvYJuKAVPhkiyKAPTe/Slb8W3EthNxDWe+Xdfqow8usW5LcQBE7f4BQr+4kfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NO1fehWihMXASY6pbPkHrXtaHR/I3k3CZYHciE0Bh2Y=;
 b=ZGSXVRUYwYodct2mS60399a1V/zyYifwzCs7f2qs53yqisuCF/qAqTL6apYbuYtXo5024bZBAYiu8T82tQvLeG2RUWgTJn0ZnH9JU79d4nbsDzLweiK3MAkUeJLk5pWdKg/c3+fgmmLvF4g8bVE5bg0bhb9gBrCPZBUuesQCSmc=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by BYAPR07MB4887.namprd07.prod.outlook.com (2603:10b6:a02:f5::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Fri, 4 Dec
 2020 05:05:29 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::b09c:4a2d:608f:a0ab]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::b09c:4a2d:608f:a0ab%3]) with mapi id 15.20.3632.017; Fri, 4 Dec 2020
 05:05:29 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Peter Chen <peter.chen@nxp.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "rogerq@ti.com" <rogerq@ti.com>, Rahul Kumar <kurahul@cadence.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>
Subject: RE: [PATCH v4 00/10] Introduced new Cadence USBSSP DRD Driver.
Thread-Topic: [PATCH v4 00/10] Introduced new Cadence USBSSP DRD Driver.
Thread-Index: AQHWyK60yAoVqs+xVU2ITP+8YsRIU6nmRMoAgAAcHvA=
Date:   Fri, 4 Dec 2020 05:05:29 +0000
Message-ID: <BYAPR07MB5381CD5A119FFE77CC875C6FDDF10@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20201202132548.10736-1-pawell@cadence.com>
 <20201204031022.GA13031@b29397-desktop>
In-Reply-To: <20201204031022.GA13031@b29397-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNTE2MTIwM2ItMzVlZS0xMWViLTg3NzUtYTQ0Y2M4MWIwYzU1XGFtZS10ZXN0XDUxNjEyMDNjLTM1ZWUtMTFlYi04Nzc1LWE0NGNjODFiMGM1NWJvZHkudHh0IiBzej0iNzc3NCIgdD0iMTMyNTE1MzE5MjU5MjY4NzAzIiBoPSJ4WXB3SVQ2b2x5cDZCMmtVajJWVEZsS2g1ZnM9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35a3fac4-57d0-4023-b4dd-08d89812382a
x-ms-traffictypediagnostic: BYAPR07MB4887:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR07MB4887BEC3B456B916DD028448DDF10@BYAPR07MB4887.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TqOD1cETc4FkzlQAUuPJ7bFeLE6JKc/n7x9pC4neC3y+Hdn5Pf/qP84kKJ6YGYb8RveIImOUWdmHxynfJ1YaKx5LzHOs2WbjumJ3g2hKeoCIC9MCQy4d53/cvaCd2R9KgBB0Ulr+lPThOqCkYx65Ku2HqlTtMtDoB3mgBTmcdzbn1eUI2Vb4M6gm9t3II2NjwXb8RDtFL7oyXbePZMUcvrw/jt7XjiROVwrzzY9gQRv1WNigGg8QNfB6g5kPq/0/3jps4zuL+q19Wk73iN0eD6Rexp5MNkkwHfDRLJKpUfqhx8/D9smDx2wKtL8YYLcYSwkp1o+a8Xw3y0ofy8/m8ONJiQiXbnf3vf0zzIAG2H0VTA0IiUqF4WDwTodlmPz8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(36092001)(76116006)(55016002)(83380400001)(26005)(316002)(186003)(4326008)(66446008)(52536014)(7696005)(71200400001)(86362001)(5660300002)(33656002)(478600001)(54906003)(8676002)(66556008)(2906002)(6506007)(64756008)(66946007)(8936002)(66476007)(6916009)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?FC07laVhibnivG9SQ1TIzrms4ff79PUlxwieTaduSqBuisXnpe8SHCeuY1C7?=
 =?us-ascii?Q?Dd04fnvSVchJIBwrqsLyIK+c03A1WGxhMF1tg8YeGLDv+HlAiC/rPuHYiRGu?=
 =?us-ascii?Q?DLTxK/cAyrh3vlTbcGhPdLvJfDlokE/rttKyK0NSxymFEBEqWQL0Ztv6XqDN?=
 =?us-ascii?Q?zEKl00nBtQl0+AbRQVRILcLC4Nfy+twFQ7TuecUwNKZf4QvXVaEIOgpI+f/L?=
 =?us-ascii?Q?09gaBUYRdJ/I+bMoih0fZ2rbMJpVaFPSd5nPXATJzaI62vrm29NdzUEGFsFD?=
 =?us-ascii?Q?NcGgW4J1Rmzj5IwMipi5rkBYkwChQHaWgeC1TXh/htGf3e6Fith/qXRVtQxR?=
 =?us-ascii?Q?Ie+4T+yto0zVsqxFBJKYZuXRK02EG1+DJ9fLCH2D4x64gbWEp+/bOmU8gKDc?=
 =?us-ascii?Q?up3NraU7Oe3WJe5zAYJY2yrxER6QxBlZe0rQs5Q4MBn4pGRA8ZQXrCLqaoRq?=
 =?us-ascii?Q?0HB6/Q/Hhhf0tVmQLXrvZSf2AuWtnd78oIqesRVCd4oh1T89AGJTm7xdfgha?=
 =?us-ascii?Q?U8sJ/xw8sK2lxEuIiXJFk+atmxGQ+N6G0Y0RHBCNjeD5vcxgtcWhDBIS/xv4?=
 =?us-ascii?Q?osyCkEleFZjuUosXvCh42GJZLBq3tWKZBsN2om5I9QUpYuyqmc3oWRJE4UIP?=
 =?us-ascii?Q?UHXdu1LrkB02l42Px3bkPYbirlSs+xWQr7yyUhHNWpY6dumBRiWkTendQ4+E?=
 =?us-ascii?Q?y4ZhgsO2zZq2G9pDjoz06p1AbJYQyjG/DLhgB+WEo2TKUEhgkQS3ICW7SuUq?=
 =?us-ascii?Q?3unfhHut9+Xg1PhRPBF/dNCLQXAwvTN2CVQfTgFR/KHagttgRfJM2uxZadH3?=
 =?us-ascii?Q?nEwTuR1IiRtf9X7deq/ixocwqJs+ogW3teuP5JdgcQ9NAjlbtuCUOi+Dd2kk?=
 =?us-ascii?Q?NZe8UKGiAQ7wQGfQXWHCoG5ESZ/r0GCZeIW0bMqdGp1zSlE6eVRaLwSaXfeH?=
 =?us-ascii?Q?ZIUFk/zEels73Co1SvSkuWonreZp4NKWdpLrNpentH0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a3fac4-57d0-4023-b4dd-08d89812382a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2020 05:05:29.0712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x9TN+d7+ko4fh/JQ/WiExMw2BIq0Jg3mg56x3PYvA6FqpYznjQ5/issggoFt/qO1ckR1SvdyRAoc3rbr61yz81zXYY8BfLtpZEYWgc4BVXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4887
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-04_01:2020-12-04,2020-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=999
 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012040028
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>On 20-12-02 14:25:38, Pawel Laszczak wrote:
>> This patch introduce new Cadence USBSS DRD driver to linux kernel.
>>
>> The Cadence USBSS DRD Controller is a highly configurable IP Core which
>> can be instantiated as Dual-Role Device (DRD), Peripheral Only and
>> Host Only (XHCI)configurations.
>>
>> The current driver has been validated with FPGA burned. We have support
>> for PCIe bus, which is used on FPGA prototyping.
>>
>> The host side of USBSS-DRD controller is compliance with XHCI
>> specification, so it works with standard XHCI Linux driver.
>>
>> The device side of USBSS DRD controller is compliant with XHCI.
>> The architecture for device side is almost the same as for host side,
>> and most of the XHCI specification can be used to understand how
>> this controller operates.
>>
>> This controller and driver support Full Speed, Hight Speed, Supper Speed
>> and Supper Speed Plus USB protocol.
>>
>> The prefix cdnsp used in driver has chosen by analogy to cdn3 driver.
>> The last letter of this acronym means PLUS. The formal name of controlle=
r
>> is USBSSP but it's to generic so I've decided to use CDNSP.
>>
>> The patch 1: adds support for DRD CDNSP.
>> The patch 2: separates common code that can be reusable by cdnsp driver.
>> The patch 3: moves reusable code to separate module.
>> The patch 4: changes prefixes in reusable code from cdns3 to common cdns=
.
>> The patch 5: adopts gadget_dev pointer in cdns structure to make possibl=
e
>>              use it in both drivers.
>> The patches 6-8: add the main part of driver and has been intentionally
>>              split into 3 part. In my opinion such division should not
>>              affect understanding and reviewing the driver, and cause th=
at
>>              main patch (7/8) is little smaller. Patch 6 introduces main
>>              header file for driver, 7 is the main part that implements =
all
>>              functionality of driver and 8 introduces tracepoints.
>> The patch 9: Adds cdns3 prefixes to files related with USBSS driver.
>> the patch 10: Adds USBSSP DRD IP driver entry to MAINTAINERS file.
>
>Hi Pawel,
>
>You may need to fix below:
>
>
>diff --git a/drivers/usb/cdns3/cdns3-plat.c b/drivers/usb/cdns3/cdns3-plat=
.c
>index 04bccf6daaba..30d69b639492 100644
>--- a/drivers/usb/cdns3/cdns3-plat.c
>+++ b/drivers/usb/cdns3/cdns3-plat.c
>@@ -4,7 +4,7 @@
>  *
>  * Copyright (C) 2018-2020 Cadence.
>  * Copyright (C) 2017-2018 NXP
>- * Copyright (C) 2019 Texas Instrumentsq
>+ * Copyright (C) 2019 Texas Instruments
>  *
>  *
>  * Author: Peter Chen <peter.chen@nxp.com>
>
> static int cdns3_plat_runtime_resume(struct device *dev)
> {
>-	return cdns3_controller_resume(dev, PMSG_SUSPEND);
>+	return cdns3_controller_resume(dev, PMSG_AUTO_RESUME);
> }
>@@ -273,7 +273,14 @@ static int cdns3_plat_suspend(struct device *dev)
>
> 	cdns_suspend(cdns);
>
>-	return cdns3_controller_suspend(dev, PMSG_AUTO_SUSPEND);
>+	return cdns3_controller_suspend(dev, PMSG_SUSPEND);
>
>I am porting and testing your patches at NXP platforms.
>

Thanks for that,
I tried to compare the original code with this one very carefully but
I omit this. Also during testing no problem arose.

I will wait some day and on Tuesday or on Wednesday I will post
v5 with your fix.=20

>
>>
>> Changlog from v3:
>> - added 'T' to MAINTAINERS file for CDNSP entry
>> - updated common code with latest cdns3 fixes
>>
>> Changlog from v2:
>> - removed not used pdev parameter from cdnsp_read/wite_64 functions
>> - fixed incorrect value assigned to CDNSP_ENDPOINTS_NUM (32 -> 31)
>> - replaced some constant value with CDNSP_ENDPOINTS_NUM macro
>> - replaced 'true' with '1' in bits description in cdnsp-gadget.h file
>> - fixed some typos
>> - some other less important changes suggested by Peter Chen
>>
>> Changlog from v1:
>> - updated common code to latest cdns3 driver
>> - moved cdnsp driver files to cdns3 as sugested by Peter Chan
>> - removed duplicate code from cdnsp_ep0_set_config function
>> - added cdns3 prefixes to file related with USBSS driver
>> - updated MAINTAINERS file
>> - fixed issue with U1
>> - fixed issue with L1
>> - some less improtant changes sugested by Chunfeng Yun
>> ---
>>
>> Pawel Laszczak (10):
>>   usb: cdns3: Add support for DRD CDNSP
>>   usb: cdns3: Split core.c into cdns3-plat and core.c file
>>   usb: cdns3: Moves reusable code to separate module
>>   usb: cdns3: Refactoring names in reusable code
>>   usb: cdns3: Changed type of gadget_dev in cdns structure
>>   usb: cdnsp: Device side header file for CDNSP driver
>>   usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver
>>   usb: cdnsp: Add tracepoints for CDNSP driver
>>   usb: cdns3: Change file names for cdns3 driver.
>>   MAINTAINERS: add Cadence USBSSP DRD IP driver entry
>>
>>  MAINTAINERS                                   |    9 +
>>  drivers/usb/Makefile                          |    2 +
>>  drivers/usb/cdns3/Kconfig                     |   61 +-
>>  drivers/usb/cdns3/Makefile                    |   30 +-
>>  drivers/usb/cdns3/{debug.h =3D> cdns3-debug.h}  |    0
>>  drivers/usb/cdns3/{ep0.c =3D> cdns3-ep0.c}      |    4 +-
>>  .../usb/cdns3/{gadget.c =3D> cdns3-gadget.c}    |   28 +-
>>  .../usb/cdns3/{gadget.h =3D> cdns3-gadget.h}    |    0
>>  drivers/usb/cdns3/cdns3-imx.c                 |    2 +-
>>  drivers/usb/cdns3/cdns3-plat.c                |  315 +++
>>  drivers/usb/cdns3/{trace.c =3D> cdns3-trace.c}  |    2 +-
>>  drivers/usb/cdns3/{trace.h =3D> cdns3-trace.h}  |    6 +-
>>  drivers/usb/cdns3/cdnsp-debug.h               |  583 ++++
>>  drivers/usb/cdns3/cdnsp-ep0.c                 |  495 ++++
>>  drivers/usb/cdns3/cdnsp-gadget.c              | 2017 ++++++++++++++
>>  drivers/usb/cdns3/cdnsp-gadget.h              | 1600 +++++++++++
>>  drivers/usb/cdns3/cdnsp-mem.c                 | 1325 +++++++++
>>  drivers/usb/cdns3/cdnsp-pci.c                 |  255 ++
>>  drivers/usb/cdns3/cdnsp-ring.c                | 2439 +++++++++++++++++
>>  drivers/usb/cdns3/cdnsp-trace.c               |   12 +
>>  drivers/usb/cdns3/cdnsp-trace.h               |  840 ++++++
>>  drivers/usb/cdns3/core.c                      |  455 +--
>>  drivers/usb/cdns3/core.h                      |   54 +-
>>  drivers/usb/cdns3/drd.c                       |  222 +-
>>  drivers/usb/cdns3/drd.h                       |   94 +-
>>  drivers/usb/cdns3/gadget-export.h             |   22 +-
>>  drivers/usb/cdns3/host-export.h               |   13 +-
>>  drivers/usb/cdns3/host.c                      |   22 +-
>>  28 files changed, 10400 insertions(+), 507 deletions(-)
>>  rename drivers/usb/cdns3/{debug.h =3D> cdns3-debug.h} (100%)
>>  rename drivers/usb/cdns3/{ep0.c =3D> cdns3-ep0.c} (99%)
>>  rename drivers/usb/cdns3/{gadget.c =3D> cdns3-gadget.c} (99%)
>>  rename drivers/usb/cdns3/{gadget.h =3D> cdns3-gadget.h} (100%)
>>  create mode 100644 drivers/usb/cdns3/cdns3-plat.c
>>  rename drivers/usb/cdns3/{trace.c =3D> cdns3-trace.c} (89%)
>>  rename drivers/usb/cdns3/{trace.h =3D> cdns3-trace.h} (99%)
>>  create mode 100644 drivers/usb/cdns3/cdnsp-debug.h
>>  create mode 100644 drivers/usb/cdns3/cdnsp-ep0.c
>>  create mode 100644 drivers/usb/cdns3/cdnsp-gadget.c
>>  create mode 100644 drivers/usb/cdns3/cdnsp-gadget.h
>>  create mode 100644 drivers/usb/cdns3/cdnsp-mem.c
>>  create mode 100644 drivers/usb/cdns3/cdnsp-pci.c
>>  create mode 100644 drivers/usb/cdns3/cdnsp-ring.c
>>  create mode 100644 drivers/usb/cdns3/cdnsp-trace.c
>>  create mode 100644 drivers/usb/cdns3/cdnsp-trace.h
>>
>> --
>> 2.17.1
>>
>
--

Thanks,
Pawel
