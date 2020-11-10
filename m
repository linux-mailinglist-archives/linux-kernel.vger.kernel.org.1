Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7405E2AD4BD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 12:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732148AbgKJLVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 06:21:35 -0500
Received: from mail-eopbgr130085.outbound.protection.outlook.com ([40.107.13.85]:55363
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732072AbgKJLVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:21:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPaGwkXfA16xsd33JSLZZGDXjbEB8slkaxWrxS/dI7Yz0873C7cgxd2oxJYBKMip2+khV9Hjz8rStLtDPmAPKJLy23FSOupmiQGgB2K99wxBHsQ7LziqaS7K/d0LvE1fyzF6HqLiLcV0mufR3YgSuHfskBJwHwHf0ijuplZcd2MsL1qCrvs0T0UejPC7Ic1tFSh3+ygbBLjpV9WwnnvG8Wbld/Agn2+GtOtdcwQqj5KcuO3pmOuplyJgyeyPjEVbRLy7wE2oFV6+wehUJAYVbdKbKcyUDSGUKf8KuBeTjIHZ8Reag3W8leZZWEiPrMqdu8/5y8ydLDQL2WsMlLq0hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5/EOe+Ul1BKMchC1G9um8OBUYqh+f93SOW7m0zLCQ4=;
 b=N88kHcObqbRqtDqZddR4JDdY7HQ0MN+ceYGcsjOjx7qYh4HP6cWmwMr8H2RFG70M4WnlI3L5FIDX1HBur9kcHACFIPQKMxGthEOVnEzOXmUuGristmfFv7loV7xouApXNFQgaIWxE4QiqJ+nPivv6aMQhBiT5AaZ6IfC+ZGjIqpqhUi4uRvXYQGtzvag7k3V7PGsDshNW+tukNQ+VlHHL6SChgPUL2/lmxhcLZ2LT+1kXKrE8Ik7Fkap75jDGA3doVwj79uZ0LpZUaeQhIh+Q2+ailUnRzFUXu5AfLHCMb5F8BlPRbgbM/h2/OLlww1Uqnu9zJXB8GqYtUGEt7CcNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5/EOe+Ul1BKMchC1G9um8OBUYqh+f93SOW7m0zLCQ4=;
 b=bUX5APYNaK+hc9qsHcQ+8472QAkrvQvigT33IaC+maCbUVhK/8x6rM6+nja9EPj34Ihk6p+iaAxnsDbSLDeU6XhZklG/yKGDbqMt59fRYXPsDsXzN/0uR4EEUAc6YgharpNR/WfDXDdlUYDwatNqAH/RGrVP9YTqFnJCnTFD93I=
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9)
 by DB7PR04MB4092.eurprd04.prod.outlook.com (2603:10a6:5:27::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Tue, 10 Nov
 2020 11:21:22 +0000
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c]) by DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c%5]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 11:21:22 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Pawel Laszczak <pawell@cadence.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "rogerq@ti.com" <rogerq@ti.com>, Rahul Kumar <kurahul@cadence.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>
Subject: Re: [PATCH v2 03/10] usb: cdns3: Moves reusable code to separate
 module
Thread-Topic: [PATCH v2 03/10] usb: cdns3: Moves reusable code to separate
 module
Thread-Index: AQHWtDIyz+T8rxkKp0C+ynxTcVw25qnBGdUAgAADWgCAACGHAA==
Date:   Tue, 10 Nov 2020 11:21:22 +0000
Message-ID: <20201110112054.GC22481@b29397-desktop>
References: <20201106114300.1245-1-pawell@cadence.com>
 <20201106114300.1245-4-pawell@cadence.com>
 <20201110090854.GB22481@b29397-desktop>
 <DM6PR07MB55294E87F6D76BA3C04E510ADDE90@DM6PR07MB5529.namprd07.prod.outlook.com>
In-Reply-To: <DM6PR07MB55294E87F6D76BA3C04E510ADDE90@DM6PR07MB5529.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aeb49ae6-7700-49cb-5978-08d8856ac134
x-ms-traffictypediagnostic: DB7PR04MB4092:
x-microsoft-antispam-prvs: <DB7PR04MB409214D9F207882375B46CBD8BE90@DB7PR04MB4092.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MhKjxA7eDodsGApSHWvrT5+zgbZyJnKEMH/dwHMJRexyNBepxGuN6AbFeFfcXHVstg47gBlUQRnFdW9LkOwNQyRkeV5dJZ+D/qN73hiuuG+pPd5PAc1LUKcACJzG1UoiDgzv0lUaLTBwJ6MpFUtkNLtJqL921s8va3eJhCN0HiKd1y0rtXWZVn95Ch+IxIGN58oiF6JCoqdEepuS6+XrGMHWp8KoVtNdXZzu4VwJV+i2DMjE8mTG58Pr3lXdiy5Zqp+6ZpA6X6xA9b1OF+8znBJjM5ndZaBN9YK31h7tWpgNCShRMjZhL3YKkuu5hdvAg/pulOOh7eLWGS1Xp8wVLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7979.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(5660300002)(8936002)(2906002)(26005)(1076003)(186003)(83380400001)(6506007)(6512007)(9686003)(53546011)(8676002)(4326008)(478600001)(76116006)(6916009)(54906003)(316002)(86362001)(66946007)(66446008)(66476007)(66556008)(64756008)(91956017)(71200400001)(6486002)(33716001)(44832011)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: yshX40TI0jrJI14YaepF4b08jRW82OzI+dBrNm94QnfijN5EpwQh1AyeGCc93xCX0BpeQlpKg/EPnsiV7qoeVXscdDN1SHvkO+jfLlq6G0egAXj2JIDRt8wz2py/JadTmDYK4R69CveMROvJBSXzlnXX80j1Sg56UMwOJWJyFxZ7aKoSmG/Cf7jsLaNubZpo9eqPO9Iaw0z+zAd/ldCd6swUIqL3lZij3i8myKNaKGTnvzHbTkXUzR/GuchYo6oJn39wV/lSoCbfa6VUKugcqq4r0E2xC4fCqnmmbEhpiTr/O8LRn8RGpfHomlAoAbHQBGEKrgqCKbVqOxAX4NXw1wGjRneeqNMVqy/hwUoQOQR+tvuektpL9kswJTv7RJVrXl4vmVXA7mxiArOUje11DTjiMvQnOh5c2zcW+5aBF+H9IrXz2pOG6Y4wiOLMXx10x+yK0tA2+rLW5QHpykrLkryg4eBH64sLlPrRyjJjXovycD19+go+pv+uLMraQuIy5PBpNCZ4dWkj95ReHsqNju0kK68G8vLkpvl5r5nK0ve2TlTZaPmggpNmvWByBugsbkarPZNkTRJ7oaWpaNj7E62tekdo8QrbB4lOxF3jbAhx6x/61Te5UNSRs7yRV5bZSOXo5vy2ygwmrYOnCoOqbQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5F45511D655EA349A1A58ED43CC947D6@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7979.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb49ae6-7700-49cb-5978-08d8856ac134
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 11:21:22.6878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bIGgh/bndsszA12MLnRfZ+YLrPvyx4Cz5Hu5GwEHY472pSyYyI2CJbKObf57qd+f3ogYQ7PtSJ6LJ2QYj2Z/AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-11-10 09:20:54, Pawel Laszczak wrote:
> Hi,
>=20
> >>
> >>  int cdns3_hw_role_switch(struct cdns3 *cdns);
> >> -int cdns3_init(struct cdns3 *cdns);
> >> -int cdns3_remove(struct cdns3 *cdns);
> >> +extern int cdns3_init(struct cdns3 *cdns);
> >> +extern int cdns3_remove(struct cdns3 *cdns);
> >
> >Why add "extern" here and below?
> >
>=20
> These functions are the API between cdnsp and cdns3 modules.
> It's looks like a common approach in kernel.
> Many or even most of API function in kernel has "extern".=20
>=20

Even you have not written "extern" keyword, the "extern" is
added implicitly by compiler. Usually, we use "extern" for variable
or the function is defined at assembly. You could see some
"extern" keyword use cases at include/linux/device.h.

Never mind, it is not a issue.

Peter
> Of course, here we have little different situation because these API func=
tions
> are limited only to cdns3 directory.=20
>=20
>  was not sure about that, but I think that this extern is the
> information that these functions are used, or can be used
>  by other modules.
>=20
> Am I right ?
>=20
> >>
> >>  #ifdef CONFIG_PM_SLEEP
> >> -int cdns3_resume(struct cdns3 *cdns, u8 set_active);
> >> -int cdns3_suspend(struct cdns3 *cdns);
> >> +extern int cdns3_resume(struct cdns3 *cdns, u8 set_active);
> >> +extern int cdns3_suspend(struct cdns3 *cdns);
> >>  #endif /* CONFIG_PM_SLEEP */
> >>  #endif /* __LINUX_CDNS3_CORE_H */
> >> diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
> >> index ed8cde91a02c..1874dc6018f0 100644
> >> --- a/drivers/usb/cdns3/drd.c
> >> +++ b/drivers/usb/cdns3/drd.c
> >> @@ -15,7 +15,6 @@
> >>  #include <linux/iopoll.h>
> >>  #include <linux/usb/otg.h>
> >>
> >> -#include "gadget.h"
> >>  #include "drd.h"
> >>  #include "core.h"
> >>
> >> @@ -226,6 +225,7 @@ int cdns3_drd_gadget_on(struct cdns3 *cdns)
> >>  	phy_set_mode(cdns->usb3_phy, PHY_MODE_USB_DEVICE);
> >>  	return 0;
> >>  }
> >> +EXPORT_SYMBOL_GPL(cdns3_drd_gadget_on);
> >>
> >>  /**
> >>   * cdns3_drd_gadget_off - stop gadget.
> >> @@ -249,6 +249,7 @@ void cdns3_drd_gadget_off(struct cdns3 *cdns)
> >>  				  1, 2000000);
> >>  	phy_set_mode(cdns->usb3_phy, PHY_MODE_INVALID);
> >>  }
> >> +EXPORT_SYMBOL_GPL(cdns3_drd_gadget_off);
> >>
> >>  /**
> >>   * cdns3_init_otg_mode - initialize drd controller
> >> diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
> >> index d752d8806a38..972aba8a40b6 100644
> >> --- a/drivers/usb/cdns3/drd.h
> >> +++ b/drivers/usb/cdns3/drd.h
> >> @@ -209,8 +209,8 @@ int cdns3_get_vbus(struct cdns3 *cdns);
> >>  int cdns3_drd_init(struct cdns3 *cdns);
> >>  int cdns3_drd_exit(struct cdns3 *cdns);
> >>  int cdns3_drd_update_mode(struct cdns3 *cdns);
> >> -int cdns3_drd_gadget_on(struct cdns3 *cdns);
> >> -void cdns3_drd_gadget_off(struct cdns3 *cdns);
> >> +extern int cdns3_drd_gadget_on(struct cdns3 *cdns);
> >> +extern void cdns3_drd_gadget_off(struct cdns3 *cdns);
> >>  int cdns3_drd_host_on(struct cdns3 *cdns);
> >>  void cdns3_drd_host_off(struct cdns3 *cdns);
> >>
> >> --
> >> 2.17.1
> >>
>=20
> --
> Thanks
> Pawel Laszczak

--=20

Thanks,
Peter Chen=
