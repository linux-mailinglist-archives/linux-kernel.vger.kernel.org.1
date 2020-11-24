Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7BD12C210D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 10:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731133AbgKXJWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 04:22:19 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:12092 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730910AbgKXJWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:22:16 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AO9DOTh021300;
        Tue, 24 Nov 2020 01:21:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=vMNjoCWrs2NFrpOGlez2o1SvTX//c0V0WOccJMUoRYw=;
 b=jHCisUpeVv/+wji8bBOrOShQTIeOrJ+vkdYlygXEp4KYEu9J7sHtiMZfJgONTqrUitSS
 0mUJ8pgX6/gkRtUdxdgCGHJZcTjkZld+Ks6yEKnl3ZPy4Wd1tz/0fwJtpqV0ween53Uz
 CMRkRZrrzFfGMB/vs0Yti51A0CC1boIse3JP6g+Cde6p69J1r5uCye4jj3s1f8M7V+Qk
 KeSlFR1pRUN5QDHaSZkxPvUtaQko7PIE/H+htH88kliUTWL0ODpiCK2Q3khXMDZPDtAh
 6HcYXfw876YQmVrlw3PZdqUJ93863DXqTae7vaZ0MSW8v1DrgVJHY+Qd+lyVttnWYW3p nA== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by mx0a-0014ca01.pphosted.com with ESMTP id 34y0b01w65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Nov 2020 01:21:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bd8mLWGDRbAkIZLTwsWEKy3Cb7/8F4a4mAY2+/Q49Mhvpid77FQI0RWudkSgsVV9JVNynMluxvEm7/nrJFC9VWr3BJ6ocYvsfMTpRbKLl2LBRC6vOALcsamKod2zswm4f3wP/A3WpbhRYHWygdvhAsV8N7e3beO9tc2dr/nCvgS8qEhAknkFXc93xiw2uN91uefKY5yCexIE7oNc3/MgkzLxsKWZHFLsxFNEdFl2HY/gQVIB4S8na4CZQwxccHpJ2cHOjBF8LKgLeH2xoTrmorWWbe7mBIqQL3Lm93cWUMvBC57F2XNgN1RAvRd9pl0xG6Va8i3TOHeSaP6VzrGw5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMNjoCWrs2NFrpOGlez2o1SvTX//c0V0WOccJMUoRYw=;
 b=LmzK4lQxaSkG11V7qvQpi2JgqJd0VmhyNxg+tt7tZl2sT4f1Qjpj1pIDN0H6on34ptotgyhyhIWoBND9Dx2RJsQbFFOifrU+8CsMEljPljQXctc+o85/lilSr36FIqOZBM0rTlI+ZobG1paKk90XYLUdkV3H9IZfbt/oIoV98RqPvO+/NoMVIjwaJ5VXO12tb903rWrp4pyxG4B+Y+loKO9kRuG8yobNICz03KEtdfaC7qy25efNNdXBM3shcaLaxo3+FLA/V7ytQwwyMBjIiKlzO3i8Ffnt0z8YIdS+qhBOPZBmn2LMuLN1VB1j+4CYpGDvfBhyfiaOmUbFOS3NEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMNjoCWrs2NFrpOGlez2o1SvTX//c0V0WOccJMUoRYw=;
 b=hcHkNpa+jKyftTq5gzooWPaQU5EiZ9Ss9iOt2JVSHBgtYn7sABAX1c1wXIwORLY6Z7wfUY/WjFgJB+ZH0tsVrdWDXzjC1xGQWK2RYJjha+/Q8VPgCMVtvRBQvL5YKSxoJSdP4tCzj2ZS0tNN9DpR3QJ7p1Xb030w/Q5JAhP5e08=
Received: from DM6PR07MB5529.namprd07.prod.outlook.com (2603:10b6:5:7a::30) by
 DM6PR07MB5052.namprd07.prod.outlook.com (2603:10b6:5:1d::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.22; Tue, 24 Nov 2020 09:21:38 +0000
Received: from DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::5c52:d1b0:b595:cfc1]) by DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::5c52:d1b0:b595:cfc1%3]) with mapi id 15.20.3589.022; Tue, 24 Nov 2020
 09:21:38 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Peter Chen <peter.chen@nxp.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "rogerq@ti.com" <rogerq@ti.com>, Rahul Kumar <kurahul@cadence.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>
Subject: RE: [PATCH v3 00/10] Introduced new Cadence USBSSP DRD Driver.
Thread-Topic: [PATCH v3 00/10] Introduced new Cadence USBSSP DRD Driver.
Thread-Index: AQHWvn5OSwS8ExQKVEepEyu7IWVrI6nW8BSAgAAYUOA=
Date:   Tue, 24 Nov 2020 09:21:38 +0000
Message-ID: <DM6PR07MB55299F262CEA81216999CB05DDFB0@DM6PR07MB5529.namprd07.prod.outlook.com>
References: <20201119141307.8342-1-pawell@cadence.com>
 <20201124075023.GC32310@b29397-desktop>
In-Reply-To: <20201124075023.GC32310@b29397-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNzFjYjljZWUtMmUzNi0xMWViLTg3NzUtYTQ0Y2M4MWIwYzU1XGFtZS10ZXN0XDcxY2I5Y2YwLTJlMzYtMTFlYi04Nzc1LWE0NGNjODFiMGM1NWJvZHkudHh0IiBzej0iNjgzOCIgdD0iMTMyNTA2ODMyOTQ3Mzk5NTA5IiBoPSI3WnVqd1llQUVXOXFxUWtpdnF5OW5rRW1vVE09IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ccb4464-c238-4469-5a26-08d8905a58b4
x-ms-traffictypediagnostic: DM6PR07MB5052:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR07MB505238F121A064455FC54437DDFB0@DM6PR07MB5052.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E5yOYuvXUSvGqeWDjjFyRbVzgkSDDCrrLIvXi7GrLSRig7I5f7GnzTZCd0lITjlz7gkFBqD31iUZ/xA/XAsknbmDuhA/dJg8PvjNb2FaqtX0cuwZ4yWJXIG1rQRaDoYYzGK0fzAP6bVXNKtA2mjUmlgAt+V/dFGtBbjIzC3k+2zTHmpo1xmDGNZbcObnGgATMAX3A5YwkMd+/HAnMSLgXs6WTMYTXDGr249M4UEuXj9yQ0EojC4zenN+1rAY8a2L4n0ghgHs+ELMqV/EmEFcn92z/k8N1nn/tLILHIS7s3snIXLAB8oKYr4SRCH7S/uFx7SeBUND3HrABzIYUgue+DMMmwbxdrC9RtbEvgZxNCfQzVVfw9zmkxlLrjV4SHh/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB5529.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(36092001)(6916009)(33656002)(8676002)(478600001)(8936002)(55016002)(5660300002)(52536014)(9686003)(66446008)(64756008)(66946007)(66556008)(66476007)(86362001)(6506007)(83380400001)(76116006)(4326008)(186003)(71200400001)(2906002)(7696005)(316002)(54906003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: HIjgY7ppB777izLzpLkvcoN4EDJzVP2mtZvcze4IJTsQJaVYnqDzezaDQ3YEgcLLT1G1aPusnnnC2u66MKIpDhVda/PJzR8pbItrCoNSHWxm/zN1MeFQK4VDpYpi5pfulxqmoJ0cbTEBpT368+tPWS94i6xPpljumwOkM0xghqluUHmO1KrVaHu4t6wnRBip6U17W5dalbD0qwMSMSMKooZQAAnIcYm1/MAVLcJSCWDbeEzPCnbRSxmnrR4T1CNtZqeNaH6tXM4/fnABgowPunNqL0TjXj72LHz5gNgymW3aeE3cX6A23vwb6JgZ+ii3+MTctrXBqpH/f6nY5G08M6F13lF3q+DzG7PnxcHwq9/FUOwdxPQEjg/b5IGAH7yb1eoKjn7V7H4nshJf5IU7GthRqGEP/cFiwOXXkCZZWS6BjbYoUDIiwUMMk25oeS83VC+f/D9k1tNYPH9e+kRON1h6t5Veg8EHHtI00ht5HO4R+dc2KyKe+W9FWW6qCg9/bITRM2VOUUFn/4Kc0gFn+ByIJNWG4BnEl1/ciJ6zDZpgCUEumctBW1AbdvfjKbC9k3xwTQDKkGWQ+Z53uzSogDrlROWwFaiBNaIn4u568nCltfen0/jvh8sQ1BvAahRWKGkREeYaOkIP922BeI4xnJ+JimcMBGto4aKQYMqdJptq1zRS8UocLSSsPu2OwkDSR9YyFeoxzCTp/5jKxEYYRTov5SGW4p+0RmTMV5OSy2s4u68WHB6IzXUP69fsMpke5QWfdwSxPqXULZwFxFxZqP8zNVOgIBosPlEdBxNDOl6K1ossIfukV97b0l5mLZRcLMsC9wXAJpIRBpursbQsbR1KEe9Lo14osDWe4uQFF54FPRtTAscnOiX6U4trj/W1J4bl1DVWNbFx3EBxo6VA/g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB5529.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ccb4464-c238-4469-5a26-08d8905a58b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 09:21:38.0917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 18SwDiLmGJyFumnmFSCcwD3CBJszKkb6pdAPA97PlqZakAL/Cgmm6tL5FDWvQ2ctVs3VBxmjhXwR9rpaTRrOnZ+iYnrYjf4HWYTaVf3UIFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5052
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-24_04:2020-11-24,2020-11-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=948 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011240057
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

>On 20-11-19 15:12:57, Pawel Laszczak wrote:
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
>>
>> Changlog from v2:
>> - removed not used pdev parameter from cdnsp_read/wite_64 functions
>> - fixed incorrect value assigned to CDNSP_ENDPOINTS_NUM (32 -> 31)
>> - replaced some constant value with CDNSP_ENDPOINTS_NUM macro
>> - replaced 'true' with '1' in bits description in cdnsp-gadget.h file
>> - fixed some typos
>> - some other less important changes suggested by Peter Chen
>
>Hi Pawel,
>
>I have updated my -next tree as the latest usb-next tree which v5.10-rc4
>is included, would you please rebase my tree and send again, I could apply=
 your
>patches and test, if test could pass, I will apply it to my -next tree.
>You don't need to rebase again since it is a huge patch set, will take som=
e
>efforts for rebase.
>

I'll try to post it tomorrow.

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
>>  MAINTAINERS                                   |    8 +
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
>>  drivers/usb/cdns3/core.c                      |  454 +--
>>  drivers/usb/cdns3/core.h                      |   54 +-
>>  drivers/usb/cdns3/drd.c                       |  222 +-
>>  drivers/usb/cdns3/drd.h                       |   94 +-
>>  drivers/usb/cdns3/gadget-export.h             |   22 +-
>>  drivers/usb/cdns3/host-export.h               |   13 +-
>>  drivers/usb/cdns3/host.c                      |   22 +-
>>  28 files changed, 10398 insertions(+), 507 deletions(-)
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

--

Thanks
Pawel
