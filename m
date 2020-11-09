Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2E52AB3A2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgKIJdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:33:13 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:10132 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726176AbgKIJdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:33:12 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A99Teq8028551;
        Mon, 9 Nov 2020 01:32:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=NiUNk1po3KZHcBO/48rnrWUo08nMn9X4hTtnsHlfju4=;
 b=Evsu3oaKhpMoVqeuvqDLpYEsuCXrvRGsxu9QJ6NOi/PV6EuHn8ttHIN3BtaXyTbD915V
 /Ke2JHyZHhNNOzhgp9HRrf/GdECf5sbZrhJcF8j/wZ2gRFbR9XB43Bfm3CvajNqAKqs/
 ffXcAIhZ0QjNGFpdvU9G2P3mWGh6gY+45eE92pnWsDw6NViS28+xIGGynsFSfJX6uhtV
 CFjBneW069XQEzViqaGKyVvr6M3dGsyLtMDodqBmk+ktFOjHOh0pU1rDnXcZgmKQtGrm
 o/NcVwvOhT+6IfPjV+HZLIsrXxWZNVoagkzFuntqtEDTTc13pDQWTiG4uBoegGsBhyFm WA== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2045.outbound.protection.outlook.com [104.47.74.45])
        by mx0b-0014ca01.pphosted.com with ESMTP id 34nr22nqc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Nov 2020 01:32:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXoPwJxZgWMQ5cSXuqQsoeJoJNZt9/MpOJ43qC4n+nRqPl0kLTNX5ui4qj5PRorsBqfyxcRmKMxPUE953wSESYMRoe/lMP0qe1WZSN3ZYt/rWnpwuxdsn9tjPVKhgm/dF2mY9GXE0Dj9hct//GCq5pVb72YzdJBwFVE9gXRfsEL0OOmiOPKMsNzWMw6/s0FED4a66E3ORXv9rMBSckjrwbeV8kFVUS+fdZjyLuxEes1KVrQqA4T124x69M0N6Mw26BZvcoHYTYr1t3Okc+6nQb31kGOrmBE2Ix6Jg3BfB5XjDZ8SKEMXL7nIVIqNf8W1OILCmH16xDooOp+omKHs8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiUNk1po3KZHcBO/48rnrWUo08nMn9X4hTtnsHlfju4=;
 b=BZjtL2fcJtHc5GlxHriVd5M/M/0++PNVpvKUMy5j4cPB4O19fdNAaML5n8FR75ZZ3+H3AyRIH/IoT5lFvXR+1XKjThL5YpzF2MKnXD8WFsruAQJ2QRYPzffEq/u6lrIW1WciI/3RqXxBeZysInZKfmLq03mZ0yOaL7lWS81qOPnMe1VamrYeQi3ApHj3TdAMUvGpy2plVa8ucKDDj0kH2uTflF4DRN3e87+daubdC94VkFLxN/0X6ZjlFiaIsr6YZSD8SdTo1dI1ReahIxVZj98d7wRQV9FE17sj34dkgJ7PkLs+m6XOxnGy3vZpBTNTHrly0Umypv8j1seIQVqjWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiUNk1po3KZHcBO/48rnrWUo08nMn9X4hTtnsHlfju4=;
 b=2AVSNpNQp30HL0N4IWHjFANPuoFXZfaWoBVDHZz8A5Rtpe6iZQRQRd68B2QV5StgTzUoiII2jxbtQcd4xQltpl2yjuHina8OeXOY0Z85a0zOKks7PSomyldN7KR3dSAIUAt3qJpH8IMVAjSnvzVJMFa0V+FU2/m9h5WrlgAbUdg=
Received: from DM6PR07MB5529.namprd07.prod.outlook.com (2603:10b6:5:7a::30) by
 DM6PR07MB7324.namprd07.prod.outlook.com (2603:10b6:5:215::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.19; Mon, 9 Nov 2020 09:32:37 +0000
Received: from DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::f977:ce71:755d:bed6]) by DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::f977:ce71:755d:bed6%6]) with mapi id 15.20.3541.025; Mon, 9 Nov 2020
 09:32:37 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "peter.chen@nxp.com" <peter.chen@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "rogerq@ti.com" <rogerq@ti.com>, Rahul Kumar <kurahul@cadence.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>
Subject: RE: [PATCH v2 00/10] Introduced new Cadence USBSSP DRD Driver.
Thread-Topic: [PATCH v2 00/10] Introduced new Cadence USBSSP DRD Driver.
Thread-Index: AQHWtDIuYt3vZP0btU2r17P5MYzim6m7HLMAgARwBtA=
Date:   Mon, 9 Nov 2020 09:32:37 +0000
Message-ID: <DM6PR07MB55296B4A894077E112EBBF4FDDEA0@DM6PR07MB5529.namprd07.prod.outlook.com>
References: <20201106114300.1245-1-pawell@cadence.com>
 <20201106134136.GA3316286@kroah.com>
In-Reply-To: <20201106134136.GA3316286@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctN2VhYjBmMzgtMjI2ZS0xMWViLTg3NmItMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDdlYWIwZjNhLTIyNmUtMTFlYi04NzZiLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMzM4MCIgdD0iMTMyNDkzODc5NTQxOTk4MzM5IiBoPSI5L2JsWHFad2JXY3JyUDYvazJVcXVIb2NqSHc9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66e87fa2-53cd-4034-ba31-08d88492655d
x-ms-traffictypediagnostic: DM6PR07MB7324:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR07MB7324C0BBBA496435BFBA6487DDEA0@DM6PR07MB7324.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /gpADwXur5s5TgfNL2nRrObE1KYDsImn3f2WGHpGA6Bi7IFprQZ8SwOME1sjrbec+WlUgiKkwmKUSEPyNrp8MT+LC7ggXF2f1YabcjaPSh0zczVO9ecJCws3whWKqmjVKW1Y9vti9L68e7g3b8CshIED8aYELYBFLoqZMuSuFnirNI3uzSFqG51x1TE/PS85rl40RZaA4N/VNPmD+LGzmDBym6uVJAPCODWOmoP/3vmDQq8DVPdpnj0ELme4/ns1gLJ8DlhEMn06YFJ03mcggFvs0zyLaQFESkzSXR3k5xoDskDgQnvjyCNyI1Iq9tK/yoqIxxRxUWgpWS9UvTl7gP7Wuiue2EJW++osf6QrB4I9VtoqizsHqtRtxOFpg50P
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB5529.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(36092001)(7696005)(186003)(86362001)(8936002)(4326008)(71200400001)(66556008)(6916009)(9686003)(26005)(6506007)(54906003)(2906002)(55016002)(66446008)(52536014)(316002)(66476007)(64756008)(76116006)(5660300002)(478600001)(33656002)(8676002)(66946007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: g4VPWBsteKf04uoLuqdEODuQg2RDVzGRdPljAa5byRfKG81u8cLb1jYXOEsfwoY0c1Gp82EmUSeZufwqCfnKDCDaTpKhdff59L/ofouJdckgp9cfPUOGwmtKq0zB9FV2qBnwfBdKhq9NFUFCjK6CTpM8gdhTw3F+NNW4H5KCIUckkR8X10ybKWhmlJkdNf9KrYXedyFiIw6UkBHhGk2BHQ1HLg+91cZwjvxPrPo80ymhv0gOz9jz3LcyVqIZSEtDH10oqeQUG4Tsyw/fpnEHlLKjnyC2+bg4Ul/fdnH4AsujXBbWTA8epE2coycRYmwCadh57TYz9LGot6FLQnuYzTukiblriYhpQzoCG7CSYt2dk+O0gq5g2azYQf3wibBOZ5R3vKU3u8K4lmTLzyzJgXqXLZfIsWaATyR2Nkvj8AUP7n394cT6SxMp/OEq0X5i5e7DgZ3Nv7e1eeIzalN4YP2oDsBT2/hglaxwAeP7s7AufQdZ3bsqHHn7GHsSIqjLOvtI8bKcKlBwlsO9ET7GFo6+a3r4T/J+haxidhHCLBkXSYFGn34TXGnZtKBWJfVjmKRQL6ZhaUT7ARSXrQPho2a7+l1HltV7+xMFWY18oo6+gngRqyFBRPkDAzvTnQymYiLk+8WySuR4kO+wPzHgRg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB5529.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e87fa2-53cd-4034-ba31-08d88492655d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2020 09:32:37.2488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YW9ufI9ZtcDLw0WMFOZpQJqixHMpGr4PRVqq6dHIxglXK1HG6dU8i1CkGDr+QxQ6bqyCUJiH44CQ35s+OyhVm5burYOfFscv14wR1fuKZKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB7324
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-09_02:2020-11-05,2020-11-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 mlxlogscore=284 mlxscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011090061
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>
>On Fri, Nov 06, 2020 at 12:42:50PM +0100, Pawel Laszczak wrote:
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
>> Changlog from v1:
>> - updated common code to latest cdns3 driver
>> - moved cdnsp driver files to cdns3 as sugested by Peter Chan
>> - removed duplicate code from cdnsp_ep0_set_config function
>> - added cdns3 prefixes to file related with USBSS driver
>> - updated MAINTAINERS file
>> - fixed issue with U1
>> - fixed issue with L1
>> - some less improtant changes sugested by Chunfeng Yun
>
>After a quick review, I don't see anything wrong with this series, nice
>work.
>
>It does feel odd you need to split things into a "common" and then 2
>other modules, but I guess it makes sense.  Worst case, over time, you
>merge them back together after everyone just ends up enabling both of
>them :)
>
>Felipe, want me to take these directly, or should they go through your
>tree after you review them?  I never remember with this driver whose it
>goes through.
>

Thanks Greg for fast review.=20
It could be good to take these from Peter Chen branch.=20
Let's wait for Peter review and opinion. =20

There are some changes that can have impact on existing cdns3 driver.

Regards,
Pawel

