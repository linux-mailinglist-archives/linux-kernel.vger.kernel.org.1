Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409FA2F4D4C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbhAMOic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:38:32 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:35300 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726565AbhAMOic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:38:32 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10DETxth014611;
        Wed, 13 Jan 2021 06:37:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=Y9xK8QC2W463YKiwSsurUlCaFs1Gcg4Dy7/jzD09jcU=;
 b=iSMT9eY1c5EQtbYM9Ic2YWItsUlOrUAeORsJej8+nRY8YVGUDsfoKJZKi7BNgmXcmvEZ
 L5z3+VRoAWy/DjEK14pGUjQc5wYuwbg27PO8L31R8ovfnSw+0udHML41gbF4JpEIo7u3
 f6WH7Fibiqh1Av3Eq6FMp2L5gxo0pludNqexRPpFLuu+N7pQLhR13AK5fZF/e9hB12B/
 Sm3chCTjzKHUQ4LgXeWNDAroPic94bqkA7vMazP8vgKPES7Hj39IQyU56PvhmxWlOsw7
 ZoOBZ0SaSbaSkD+s8nd9SRW+RODMtwPwUzVuYDjpNWw5oq5OHp/k/bZ/Vzxsa+W5m1Xy Fw== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3618temuje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jan 2021 06:37:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iy8q/w594EY3urjdvPj1CBOpw3tDHiX2DF7rvlrOVej0T44zcythC4SlNpT+0uLmcqh95C7S8UJy4Wyu8Xup3Z5onDj+9laCq4agjcK+wXdITxQJHDrlIacCGgEKGrcCTv/BFrG//3IGNG93NjvlZLHAiJiHZnE2IGulehhOiM9EoozGVCw70zo2ZRrsEMHBCKP7O5hf3kNQeNqEGO4aCltDn6OZ2SRQ2eVPNdHzLS2dOJuO7b3teH5aU9YMFnoy6/E4TnpGeU5eGw1cu7kAPrOYemZQRYxjcINjwVR5UDvhF/HdBYuhTAMsQz/YWKN5ztjJ24PEIHg9JO7otxMgEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9xK8QC2W463YKiwSsurUlCaFs1Gcg4Dy7/jzD09jcU=;
 b=XbAQ1DyELOFXaH7pliDc9pbXAVpiF3fabdDFaxQ4xdSUj+9mMYfd3NYXTvSELm4Xo14MJXAAUhdpjp3d/kgk3ASxokzDYlsuL5y2uL1aw3AW47S4r7wdn8Lh7BOupmCmEqiHFqcLGpIv6L3YRyF1FmmvR542XtouIozfRDECuBUlT2IOdQfjkF+xyrSGy3PJFehFE5lgbKmvyL3vXW+pokFOd031J3y7DpDe469V6eDS1nCBUK1Cqg/Xnb9QtpiuZCwBkXIiTd1xYNJ7jpVIhz1b5nL5jF7oI8cO/ebhEJEONMjFgid4ieds1YpA0NYC/M7H6jPf+EjwSpZ/6zEQgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9xK8QC2W463YKiwSsurUlCaFs1Gcg4Dy7/jzD09jcU=;
 b=Q+/5hrkhq6EpbD/Gyr8PiP/99H09DJu0IkjtHBy5tb6ulWRirb0F3RCLc0Plf3jaOrH4ig0W4JpjlVi75TnXPZu4CicD6iC5SYqjYAS35hpzKtIA9V5m6/suC+J2o/cX9yB/OFBkyHy51dp5mUeG1QqbpHJBBFHuQOHepeaaMUE=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by BYAPR07MB5384.namprd07.prod.outlook.com (2603:10b6:a03:6f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Wed, 13 Jan
 2021 14:37:15 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::34a2:314c:e80b:3be3]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::34a2:314c:e80b:3be3%7]) with mapi id 15.20.3763.010; Wed, 13 Jan 2021
 14:37:15 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Pawel Laszczak <pawell@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>
CC:     "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "a-govindraju@ti.com" <a-govindraju@ti.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>
Subject: RE: [PATCH v2] usb: cdnsp: fixes undefined reference to cdns_remove
Thread-Topic: [PATCH v2] usb: cdnsp: fixes undefined reference to cdns_remove
Thread-Index: AQHW6bZnkOBmLPUj90+oH08d89YqSaolngpw
Date:   Wed, 13 Jan 2021 14:37:15 +0000
Message-ID: <BYAPR07MB5381F03FB95880ABBAE10F96DDA90@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20210113141407.25473-1-pawell@cadence.com>
In-Reply-To: <20210113141407.25473-1-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZDFlNDIxNjktNTVhYy0xMWViLTg3NzYtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGQxZTQyMTZiLTU1YWMtMTFlYi04Nzc2LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMjExNyIgdD0iMTMyNTUwMjIyMzE5MjI0NTMzIiBoPSJTOEZGVU5RRHdSbkRKUU5BV3dNdFhCUnQwT3c9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 408056bd-2d19-46e6-24f8-08d8b7d0b8f7
x-ms-traffictypediagnostic: BYAPR07MB5384:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR07MB53841408F3579058B52A3737DDA90@BYAPR07MB5384.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /fAaaLXV0hUSFVA79OGsGg98uVgYMoiMwaOZ9NJTCyjX3IvjBKWMVu3LU/n+DT9BbZZfarMmURIQ0Fcg9dtuOdJf85pzcE0+ccV73ZA10KS5Y3auHax8xJ/g1jWzbQDdcAwaE/UgP2QpkUXrVeTz3sePNFHw2FE2EDBJMIwK1GnsVq5OUgacdR5+GB91QYlg1MfYdciJ1hpQqJFoUFBHxMjC4eaDT0L5rPGuknwl+/ahwPbTHg9X+G29gQ/LLspiycf/TxOsaZOaUem1dnftUjmXJvAUDpIe7J0xg2WC8RZbjtT1sxG4yVLe6J9iuNT5sVn/bnknNMdvWlQLSh3wvyaEKFbUOswLY3bGwgjaVsWBcWlwJxbppyJg4KpCIhf3s76RpfyXoCEPcT2aJdoDxePI8T7GlIXOR228w8M4h8p+t+5HxjmrCSA1o6FM0uja
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(36092001)(52536014)(26005)(55016002)(8936002)(110136005)(66556008)(66476007)(9686003)(64756008)(66446008)(66946007)(186003)(33656002)(2906002)(76116006)(54906003)(316002)(478600001)(83380400001)(86362001)(7696005)(5660300002)(71200400001)(8676002)(4326008)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?pYcKd4aWGnf87cWS5HE3FF4nGIA8lHUn5R2n3nDSdsw7zUDyyVl8jjOGaZcW?=
 =?us-ascii?Q?olQP0w4/O35suTri3YTfrTYCqAkjYj4Q+mWyH2yEIgpiW2RDTPS6EBfMA4rV?=
 =?us-ascii?Q?KgF87VrLubZra1rlhleFCHMSSZjboz/XkpIPjkJ4D4/OwOCCYxy93YYl9ssw?=
 =?us-ascii?Q?6KtJuuOaawbw53Y7XCkLQDSYZdalLS/x6qDV1IeTtWun9oofJI8qbLKg5Dpn?=
 =?us-ascii?Q?ajJPSuBVCcPmGO60cHZfktwxWUZ6v/Pq9T+vlO/aANmprhjAH+TTyeGbRNdo?=
 =?us-ascii?Q?1jQXiGuLRKhYX7/kd0zdvyeFUT3zSoBzFfCwzVOohVFn6d+DC3gvgxjUwUDJ?=
 =?us-ascii?Q?KOEV6lW+FBwjTnxwa1R8KhT6Q3FXo7VlgQzMsQsEE+q66g+ed3j6+n6LbQaR?=
 =?us-ascii?Q?IyErpIJrj3UtfNZEYTE2xvfB0piXDe1kxmyqclam6SDT0F5nGlPqo6s0JwJq?=
 =?us-ascii?Q?m+hSajOWLwPBqy7mPnYa6a9YpfkvH+LmYv++BttZ6Ah7TiwvnMY+MitmuvlB?=
 =?us-ascii?Q?ysp9d83m1JGdPFQdoDQlxCmst1sDmtoHgPmGIzhWqNgp+KAGFlYdYplM+62L?=
 =?us-ascii?Q?6gHIjsgTSKMztHGWZCtPVXfiBzY3Tzu07ezJ+IihIBMpLWIITeR4R7Gc2IyT?=
 =?us-ascii?Q?lRDhCXzjBjTiI+3u2DKyYh41H1UBnyEBFGOnYN5+0jYsB/ePe4iTfc8RD1Fq?=
 =?us-ascii?Q?adrLM/Zx6JpNKPqbzkCtCsWNFc6rsaTu3c/ceFIPQfzXWMedzGlpCbaV4iZx?=
 =?us-ascii?Q?0SEdAcso8xuL2so6jAKiNWSPlhGOW1B1vZtVeZHqSpkwNyYvFeU+DNKa9iUP?=
 =?us-ascii?Q?NR1NIAPMQW13cW0O0STHLJnbYSyGeIOOyssrAblqq3IH1wPzfhbpNkRAc5kf?=
 =?us-ascii?Q?rteEW14NFmGtXOlmNoHLqunByoUwnD6tF3zRh8XbltSawlveYtIuR42mBh+t?=
 =?us-ascii?Q?HLznajpRrr2UM/mm80lLo8YhzDFi1j8Cm0rwDvjsQCE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 408056bd-2d19-46e6-24f8-08d8b7d0b8f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 14:37:15.6081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7mPydoQ8QIWTUKF20Jp0r5iwwgNufrv1JKju1IePWR68qI6szAX7FdsqHBPpAq274xmomZPBFFrdd3oNlioXdctZBLiVS0ArhlagmYfOxLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5384
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-13_07:2021-01-13,2021-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1011
 mlxlogscore=999 adultscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2101130090
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Can you replace the previous version with this one.=20
The v1 still has problem with undefined reference when CONFIG_PCI or CONFIG=
_ACPI are disabled.

V2 fixes this issue.=20

Thanks,
Regards,
Pawel Laszczak


>From: Pawel Laszczak <pawell@cadence.com>
>Sent: Wednesday, January 13, 2021 3:14 PM
>To: peter.chen@nxp.com
>Cc: rdunlap@infradead.org; a-govindraju@ti.com; gregkh@linuxfoundation.org=
; linux-usb@vger.kernel.org; linux-
>kernel@vger.kernel.org; Rahul Kumar <kurahul@cadence.com>; geert@linux-m68=
k.org; Pawel Laszczak <pawell@cadence.com>
>Subject: [PATCH v2] usb: cdnsp: fixes undefined reference to cdns_remove
>
>Patch fixes the following errors:
>ld: drivers/usb/cdns3/cdnsp-pci.o: in function `cdnsp_pci_remove':
>cdnsp-pci.c:(.text+0x80): undefined reference to `cdns_remove'
>ld: drivers/usb/cdns3/cdnsp-pci.o: in function `cdnsp_pci_probe':
>cdnsp-pci.c:(.text+0x34c): undefined reference to `cdns_init'
>
>Issue occurs for USB/CDNS3/CDNSP kernel configuration:
>CONFIG_USB=3Dm
>CONFIG_USB_CDNS_SUPPORT=3Dy
>CONFIG_USB_CDNS3=3Dm
>CONFIG_USB_CDNS3_PCI_WRAP=3Dm
>CONFIG_USB_CDNSP_PCI=3Dy
>
>Reported-by: Randy Dunlap <rdunlap@infradead.org>
>Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>---
>changelog:
>v2
>- added missing condition
>
> drivers/usb/cdns3/Makefile | 8 ++++++++
> 1 file changed, 8 insertions(+)
>
>diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
>index 3f9b7fa8a594..61edb2f89276 100644
>--- a/drivers/usb/cdns3/Makefile
>+++ b/drivers/usb/cdns3/Makefile
>@@ -26,7 +26,15 @@ obj-$(CONFIG_USB_CDNS3_TI)			+=3D cdns3-ti.o
> obj-$(CONFIG_USB_CDNS3_IMX)			+=3D cdns3-imx.o
>
> cdnsp-udc-pci-y					:=3D cdnsp-pci.o
>+
>+ifdef CONFIG_USB_CDNSP_PCI
>+ifeq ($(CONFIG_USB),m)
>+obj-m						+=3D cdnsp-udc-pci.o
>+else
> obj-$(CONFIG_USB_CDNSP_PCI) 			+=3D cdnsp-udc-pci.o
>+endif
>+endif
>+
> cdnsp-udc-pci-$(CONFIG_USB_CDNSP_GADGET)	+=3D cdnsp-ring.o cdnsp-gadget.o=
 \
> 						   cdnsp-mem.o cdnsp-ep0.o
>
>--
>2.17.1

