Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C85B27E2D0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 09:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgI3HoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 03:44:13 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:23444 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725440AbgI3HoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 03:44:12 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08U7eUgo011283;
        Wed, 30 Sep 2020 00:43:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=Un1zwEJtCK8XKW996gpJSqTPNTfT84o5GirTa6/lw7g=;
 b=MNV8yWA1jiGWZq2jhfHpvvlnCIb+LtBRH6nguCqfhRAcETJbXIB1HEIP9btSATRPeLx9
 an+GTqgLfF3B14QGMy1uwGkkfofA0hU34PZu1UgeeiOWUtdiXWPPQ6Oci1+YLo370/TK
 HzIx+yGlWDUCAzOnReQ9XZe1qCVUBuYZRlvEekDvY5sMSZRqH6QGb5quGNRutIE6zbTb
 0ArxEY0L+gV7SoLSKgAEDeWuaD0pjDebX+jiLMBp21WuIlp0hxHDdNRa5ZakW/YTTNPW
 sRD9BrYDxAx9pNoWrWyjLD1QeXnuxkkJy1CIT45u+uZFHXYHDn3KkNzbXaObBrigc/cM SA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by mx0b-0014ca01.pphosted.com with ESMTP id 33t17x5xpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 00:43:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFccJx2tTgYMfEgn0sTyAfRbgLBl4f1JZfO/R6jdIhErtPdvmbmkwgpjhWT6rlJvud27ZHof0pGdcU7Zr4+DBR7aaLHbkDj3omDCrjOtWZjT/g7/8FNzF041efkmY7uOFG1N9HjxvA7cuuabaojAodeT92VszzjjOnG3e5Rj/Q5XifJxPrQ8dbXputGdunEZYTPNz/eNsw7e/NoP/G8txHwGZBLu+kDLdKHIOKPvNj6YmEBNdZavX6lTmjxGnJEztk4PPoRlkutj0pGN3p/K17Xr/ihSQ7OQIWssQpARBGiyQMbQEV2w+iZJVS1qD0MFW34c9U7tLdf5k2yBSmIkVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Un1zwEJtCK8XKW996gpJSqTPNTfT84o5GirTa6/lw7g=;
 b=GhL/awv+7XlXN5VWHD4NvGEaKX1d9fcj7te6UR8bVnPQAWY3RjsgDPLgVOgneeLVF2Rdrng1BRcccvKHvMhBouIwoM7TymzOGuQtDnajqAPldtsiesCnFxNSEUuf5JLylkgnzK6O3yAstYgCOIXaIHMDNoC/nuQd44kFmYZ6egzvtSy8VF59sj5KKeFyKtJe8EDwuVJSeC4o8kGOE4tNAv41WhGkjOjwqvgxJ6TeBgiHgUzWokrJoHrI/U1XIkmWf4Erfua93d1F6wB+bETFnA+fFL4yKJdvGKYtG3GvgXsSLCYUTndj35Tso9dJ/pWGynGq0hKmHjmua4BCBAbRIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Un1zwEJtCK8XKW996gpJSqTPNTfT84o5GirTa6/lw7g=;
 b=kdu/CEbDx9wmUOH3oVqO4XfqMnsH/zljgjX59aIxn+n4nAQ69r7/b8z4W2FZ+opW8ur5142ZWydraaHBRXc5s5MVi/tIJnCYFzPp8yJHgPprcC4T4K0l4EDC3whb67g+Vr29Aub2BnnRwTiFf8XSzkEMjEVI2DMiX6a+lEPJ+s8=
Received: from DM6PR07MB5529.namprd07.prod.outlook.com (2603:10b6:5:7a::30) by
 DM6PR07MB6667.namprd07.prod.outlook.com (2603:10b6:5:1c1::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.32; Wed, 30 Sep 2020 07:43:45 +0000
Received: from DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::2087:7f2b:5dc6:a960]) by DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::2087:7f2b:5dc6:a960%6]) with mapi id 15.20.3412.029; Wed, 30 Sep 2020
 07:43:45 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Peter Chen <peter.chen@nxp.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Sanket Parmar <sparmar@cadence.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "chunfeng.yun@mediatek.com" <chunfeng.yun@mediatek.com>,
        "yanaijie@huawei.com" <yanaijie@huawei.com>
Subject: RE: [PATCH 0/8] Introduced new Cadence USBSSP DRD Driver.
Thread-Topic: [PATCH 0/8] Introduced new Cadence USBSSP DRD Driver.
Thread-Index: AQHWlZOUsTetct7Lb0qpa/pmqGWlval+9M6AgAHahpA=
Date:   Wed, 30 Sep 2020 07:43:45 +0000
Message-ID: <DM6PR07MB55297822FC01723AC9E34BF1DD330@DM6PR07MB5529.namprd07.prod.outlook.com>
References: <20200928122741.17884-1-pawell@cadence.com>
 <20200929032258.GA9076@b29397-desktop>
In-Reply-To: <20200929032258.GA9076@b29397-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYThkY2YxZmEtMDJmMC0xMWViLTg3NmItMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGE4ZGNmMWZjLTAyZjAtMTFlYi04NzZiLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iNDY0NCIgdD0iMTMyNDU5MjU0MjIzNjAwNjE3IiBoPSJkVVRkbmJxbmNBWW9kQkpZOE1UaC9DSzJFUjQ9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25a7c64f-318c-42e8-98ab-08d865148f85
x-ms-traffictypediagnostic: DM6PR07MB6667:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR07MB66675999ACC249F11C8B5809DD330@DM6PR07MB6667.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p75+TO1hTeJ4pahD8YtQUiverL6wuVr74Mbu6GVWkYPi11xABsljQuue9wVGSH5tyN72ayUM9zxhBChB3/7qbtlQNUmF8eWE5Bi1Jg5kWaf6JRZ9cwjqjDhFE0LR4S/Jh+vNA8SgbTtZcTjcjyQw8HNg2WHWsA0vnHkXSVDYKZkNJrQHbzVIKrfexb73XCIQlEV4F+ZNVcFGLJ/wWNT0jaLf69xOnoeS78/gjPPLJBWUCBjnnmq0ShlogCbd3VaXnZ5s6NMHL2pVyDkbgL5SCWOsOzc1toEG8uD7xYS5/H69InpCKW/2rV6ayMNLavf/JUqUb8plnrgimfYFUGbktgXUIxwT8lECdNSCUXLAZonkS9334cbsBInCITP7DBnH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB5529.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(136003)(376002)(366004)(346002)(36092001)(33656002)(76116006)(8936002)(55016002)(71200400001)(6506007)(9686003)(2906002)(52536014)(7696005)(7416002)(186003)(86362001)(5660300002)(26005)(478600001)(6916009)(66476007)(66556008)(64756008)(8676002)(83380400001)(66446008)(4326008)(66946007)(316002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: HtpZMIWU0MMjzxu+NQ8mBMc0T3T2PQVo+1EXyUTGYiIpyZJaKzgbuDGagDPQenh+w0j+mRyVA34XJ58oX20gsCy2PrbE8p/PF9jByVrrRn5ZypXUHcweNvEmEp57sD2+sXDnGT4lsP9GveTc9E8PdZxl/fHc2zJkooC0mXODIY9rWBEY3CpR7cCKJKayyU8f0KHm2D+iQYGQ+i/ZfG35/C6gIMHvBE0rWOMnbUoIz6Z+YA+nHUNYjOhaJ8rwASYlaoFDPC6jSjCM90Gf5/uq9a4Jc5NZH4MtoWktSCuk8ti/smYuf1591+apZbztHH2wqKtUxFOwHdvdHdFZqqeDWgbqiirX7S+oORQjLKDekzgdLqQ581WdMjiz5872XAJM7qVBGeDbv8mh86Fakyd4sp10D/0LIdOD4UFzb2hvS/pJEbLamFZTA26yIwGN+evp6XqThG6dWUWVUeQA5p+VRRU/jbSPNanQjP/qICuayTnH98FsEpRilPGZ8D8DzPpW5iB1GhXgbfWvkgxe12VMRrPPaBZMJz7a3R427zaYQ+Lg/n96CBnGVe67HdI8Do1F7+d9/OpkJeCMQJIBCjgoXB5xMub/nT/+VaC13d/NjbG+E9MqlF4JfwnQmdRx1zXVOk8kBFdG1jqryayv0AoWaw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB5529.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a7c64f-318c-42e8-98ab-08d865148f85
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 07:43:45.3844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NT8RJtQFjQcaKO4m0sxSn4TK2i5byHXwvA7rQypz61K5oX1suU9qeA7rYUb52aUiPHFXa8fYUKIfsFz1Yrbjh6a4TBUUWrhEy6xR2c6ZFtY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB6667
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_05:2020-09-29,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 mlxlogscore=523 clxscore=1015
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009300060
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On 20-09-28 14:27:33, Pawel Laszczak wrote:
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
>> The host side of USBSS DRD controller is compliant with XHCI.
>
>The device side?

Yes, it should be device side.
Thanks

>
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
>> The patch 4: changes prefixes in reusable code frome cdns3 to common cdn=
s.
>> The patch 5: adopts gadget_dev pointer in cdns structure to make possibl=
e
>> 	     use it in both drivers.
>> The patches 6-8: add the main part of driver and has been intentionally
>>              split into 3 part. In my opinion such division should not
>>              affect understanding and reviewing the driver, and cause th=
at
>>              main patch (7/8) is little smaller. Patch 6 introduces main
>>              header file for driver, 7 is the main part that implements =
all
>>              functionality of driver and 8 introduces tracepoints.
>>
>> ---
>>
>> Pawel Laszczak (7):
>>   usb: cdns3: Add support for DRD CDNSP
>>   usb: cdns3: Split core.c into cdns3-plat and core.c file
>>   usb: cdns3: Moves reusable code to separate module
>>   usb: cdns3: Refactoring names in reusable code
>>   usb: cdns3: Changed type of gadget_dev in cdns structure
>>   usb: cdnsp: Device side header file for CDNSP driver
>>   usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver
>>   usb: cdnsp: Add tracepoints for CDNSP driver
>>
>>  drivers/usb/Kconfig               |    1 +
>>  drivers/usb/Makefile              |    1 +
>>  drivers/usb/cdns3/Kconfig         |    8 +
>>  drivers/usb/cdns3/Makefile        |    8 +-
>>  drivers/usb/cdns3/cdns3-plat.c    |  209 +++
>>  drivers/usb/cdns3/core.c          |  336 ++--
>>  drivers/usb/cdns3/core.h          |   51 +-
>>  drivers/usb/cdns3/drd.c           |  219 ++-
>>  drivers/usb/cdns3/drd.h           |   93 +-
>>  drivers/usb/cdns3/gadget-export.h |   26 +-
>>  drivers/usb/cdns3/gadget.c        |   29 +-
>>  drivers/usb/cdns3/host-export.h   |   10 +-
>>  drivers/usb/cdns3/host.c          |   23 +-
>>  drivers/usb/cdnsp/Kconfig         |   40 +
>>  drivers/usb/cdnsp/Makefile        |   12 +
>>  drivers/usb/cdnsp/cdnsp-pci.c     |  247 +++
>>  drivers/usb/cdnsp/debug.h         |  583 +++++++
>>  drivers/usb/cdnsp/ep0.c           |  500 ++++++
>>  drivers/usb/cdnsp/gadget.c        | 2009 ++++++++++++++++++++++++
>>  drivers/usb/cdnsp/gadget.h        | 1598 +++++++++++++++++++
>>  drivers/usb/cdnsp/mem.c           | 1326 ++++++++++++++++
>>  drivers/usb/cdnsp/ring.c          | 2426 +++++++++++++++++++++++++++++
>>  drivers/usb/cdnsp/trace.c         |   12 +
>>  drivers/usb/cdnsp/trace.h         |  840 ++++++++++
>>  24 files changed, 10228 insertions(+), 379 deletions(-)
>>  create mode 100644 drivers/usb/cdns3/cdns3-plat.c
>>  create mode 100644 drivers/usb/cdnsp/Kconfig
>>  create mode 100644 drivers/usb/cdnsp/Makefile
>>  create mode 100644 drivers/usb/cdnsp/cdnsp-pci.c
>>  create mode 100644 drivers/usb/cdnsp/debug.h
>>  create mode 100644 drivers/usb/cdnsp/ep0.c
>>  create mode 100644 drivers/usb/cdnsp/gadget.c
>>  create mode 100644 drivers/usb/cdnsp/gadget.h
>>  create mode 100644 drivers/usb/cdnsp/mem.c
>>  create mode 100644 drivers/usb/cdnsp/ring.c
>>  create mode 100644 drivers/usb/cdnsp/trace.c
>>  create mode 100644 drivers/usb/cdnsp/trace.h
>>
>> --
>> 2.17.1
>>
>
>--
>
>Thanks,
>Peter Chen
