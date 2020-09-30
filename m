Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9713327E547
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 11:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbgI3Jh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 05:37:27 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:32312 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728399AbgI3Jh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 05:37:27 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08U9OX5N019416;
        Wed, 30 Sep 2020 02:36:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=2q/+Vtr2ZRFy3Jk7amu6VNsvCMmLM/IFyMpCA/yct2Y=;
 b=dYX95+oEBpELsg/7Fj+ijGpPE5jxr/bju9nH+a3L8vic2GeV3zJVTnOINc0QLhAN0J2j
 zdX7NSX0ZQQh3Qwy6w5cJgMydcGvFhxVjGv3n0VjCe6YzBo1h8QQr+xUdxEVnTj1Fw3r
 xveuU+TLp+CGT4Uj72+ioroEqMCMlw9uB6+mlk2LT7xVMD0V7N79tFppu3kKvj172LDx
 JE0QOeMj9DwsjkK0jeOXI2DDEhsoRJct2+PXiedjyuR/vq6CKbXA/O8ax+HBVg4R2Uo6
 Gr/wucdedBid54Fkz9o2+H1FHUJus9qnpvEjpu6TVLpcNUCEabFE5o2bDYX4nUwwlnUt YA== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2047.outbound.protection.outlook.com [104.47.74.47])
        by mx0b-0014ca01.pphosted.com with ESMTP id 33t17x68gc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 02:36:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCWR4UueuKyetdD7TlBEfO6spJDoQXkNeej3Hw9Na+pDHRUK3YKfJNYz93P4jrFHvEeOqijuK0vU+ze8ElRKm2d3Zjadjr3betDkXcU+HlDMmGW417cDxPsHd74shgnIriGhSi+SrUFI5vugnOZ4P4110khKdi/RMQXuTJ1IaH9G4sb9fR556F7xMHdFPTF3rVeQjY/kkGI2O5Z4L8zuF5iRQgLgPoyK2DOOvrLS74ipjRmHei5aolhLMAHH2Etd0zqxC5oFCH4wkSao0jUetUUvLqnIRkZy+05iagZCfKQIJt23xARHR7yDeF2rRfk6lVoBNiReek5DAYJvivBUiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2q/+Vtr2ZRFy3Jk7amu6VNsvCMmLM/IFyMpCA/yct2Y=;
 b=WnwJB7YQodX8D3JE8WL8iAHtsY/hf14O0SNPDDIHRzv8anIBH9s4y2dmAjeRtk+/PfYKYRvx66x5H6+wjbF08Dd6RDJjoZ2BuoVvUl7HzdhGMXejdxf8MQyC1LyTrQZAbWuFipa2pohALNODqBjlPGeMGaDgb84vVuazDR5zHB5DdM7dB8cnYTv28eSu1RA379Tsl5FZ93QZ6YgmxsFa0gC2Jy5hX7czl9NRmWyDlVPDJ1KnFu/PRrJB3CzhVwVApp0NVY8vurkU4cYsT8vNvjHjY1O7c8kv6Ayn57Xtf6Y9oMmAKNG6f/5QPIxzOUyn997FpeXeT0NzIvUuLFXNtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2q/+Vtr2ZRFy3Jk7amu6VNsvCMmLM/IFyMpCA/yct2Y=;
 b=YVyPxoFtkBnmdQmvovJkHZlB+CVqfyZqm6QbXAY4em4uZ9fHgSw6cBFNwnVbFjiFc3NhZ9/X904s4Pc+jN+2YIlngadpS23o/IkEhUOTzeKzLiDEs2t3z0X6v1boC8iSCPdVVQWzBHxl52LnmCOp++uFS0lOUSHVTTHhJKQWTMk=
Received: from DM6PR07MB5529.namprd07.prod.outlook.com (2603:10b6:5:7a::30) by
 DM6PR07MB7035.namprd07.prod.outlook.com (2603:10b6:5:1e9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.32; Wed, 30 Sep 2020 09:35:57 +0000
Received: from DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::2087:7f2b:5dc6:a960]) by DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::2087:7f2b:5dc6:a960%6]) with mapi id 15.20.3412.029; Wed, 30 Sep 2020
 09:35:57 +0000
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
Subject: RE: [PATCH 2/8] usb: cdns3: Split core.c into cdns3-plat and core.c
 file
Thread-Topic: [PATCH 2/8] usb: cdns3: Split core.c into cdns3-plat and core.c
 file
Thread-Index: AQHWlZOUYv8sXgkrDk6Uskl5ji524ql++LKAgAHzKcA=
Date:   Wed, 30 Sep 2020 09:35:57 +0000
Message-ID: <DM6PR07MB5529F3C0C769C09662232AC0DD330@DM6PR07MB5529.namprd07.prod.outlook.com>
References: <20200928122741.17884-1-pawell@cadence.com>
 <20200928122741.17884-3-pawell@cadence.com>
 <20200929033655.GB9076@b29397-desktop>
In-Reply-To: <20200929033655.GB9076@b29397-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNTU4ZDk0N2QtMDMwMC0xMWViLTg3NmItMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDU1OGQ5NDdlLTAzMDAtMTFlYi04NzZiLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTY2MzYiIHQ9IjEzMjQ1OTMyMTU0NTkxNTM5NCIgaD0iNnhYK1JtRXdBT2FTQ1lqcURqbnZ0eFNOSjVjPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fbfc17ad-7915-4ebd-3b8b-08d865243c41
x-ms-traffictypediagnostic: DM6PR07MB7035:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR07MB7035223F6AF6D9604DD0BB9CDD330@DM6PR07MB7035.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9uBFnOYSJdOf0ItJAJm6zPKCnhKuEpmE4CUOF0DRdrVonENd8J29sMyxky3sI8tdqSt00Hone+lvh0/9kme04KV8tphjBWfnkB4amvfQ6u9U0cjuRG02K+7ZybgarmzS8Utgx7SCVu2kEM31atmF+/SGDWyjJNuohS1UA/VhEzGRqDtfppRbyaAi2oPsnPStwFecqL/3q9bwugcxvGd/r740Pi6wHQLbKGij3I6HX0IPsyheG1NnwufJ3ZOpUjsDG2U/GlIZbZe5CoYCEajU2zAbbdTAT9uMhM+1L6iTsTowjhM3HsmapEYX//F/aHz79x4VsjlU+tYkYsYSSrEvkaj0eUlWwEq9Hrlj3EaOcBj2T2tUb57CwfzOiC6wSmQg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB5529.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(36092001)(6916009)(86362001)(6506007)(478600001)(83380400001)(7416002)(7696005)(186003)(26005)(30864003)(5660300002)(9686003)(55016002)(66476007)(2906002)(66946007)(66446008)(64756008)(66556008)(76116006)(52536014)(33656002)(54906003)(8936002)(8676002)(71200400001)(316002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: jHVUijgQ0eKR3kts5vuEzBZdMxJFeQB3SwEnX1F6W1MWvSjDyzomAIZs5Hnr4UTTnY7pSZq6fJQfD2YPLZrVgPMsunP6OUfz7ahd3/ElAmBa9L7Yt/JTM1+zc1H+qTwu5tTyuymSrgrn+OLDEzY7LU0tOzyfZsU13vMICVNOE/TDZmyeN0Av3scM0J1m7xnhKQy+ii3o4FylFc8K66pKmHwy72L5NEKzjIgZC6QQdm7DC4Y3jApxwA5pZUS7zqkKDRcnoYtSglU3/mi7J1u7TSohny6SfIgOnpSvNYo5bvZN29LL5RMAVKGcx+A9/KkyxnkqEM/96GJ7Wfa8+mn0Tj8MCZt/OTDu+to9nhlskCGPDGZsET9mJYjkY7w7hf3LGjeCDGMcrYgrkK0nEAMVAdb5VATPYoRizZiQzFT8BIccl5MT31UDHe1uWHgABeZ8VHuOvusF8erwJGhiFP9YH2z6kR6Zw6PxTd2DSIz+1L6og9YJyGXNyCnRICICSr2QLtoZU8joPutqiOxqVX5sVCCvi44ENw1sqY1JS8KsIIjf3iNS/Vlu+m6gW+5HV+btn4aqZlf//k0kKFRXm0cl0XauYPiJud8+Jaw68nL9HX1Kxr4nz73xOfK7Ih7dNwY9qBVTXwLOOiGf7UQGFLxIdQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB5529.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbfc17ad-7915-4ebd-3b8b-08d865243c41
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 09:35:57.5142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bwIiwbLoVq1Kt6ThkE9JkPxxuS9tBocUdV0+rwjaSaPm3VSU+qiMg2TGvefBphcsAcYzqFWqZdyeqXVyihgSU/2D/M2aHa0LFW2kvT+X4wA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB7035
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_05:2020-09-29,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 mlxlogscore=999 clxscore=1015
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009300075
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>On 20-09-28 14:27:35, Pawel Laszczak wrote:
>> Patch splits file core.c into core.c containing the common reusable code
>> and cnd3-plat.c containing device platform specific code. These changes
>
>cdns3-plat.c
>
>Pawel, at 5.10-rc1, there are some cdns3 driver updates at Felipe's
>next tree, you may create patches based on that to avoid rebase effects in
>future.
>

Yes, I know. The cdnsp is put in drivers/usb directory and I was not sure
on which repository I should based on.=20

This series can be successfully applied on Linux-Next and Greg  (usb) repos=
itory.=20

As I remember we also have some patch not added to Felipe repository.=20
I hope that next version will contain all latest changes in drd.c and core.=
c.=20

Thanks
Pawel=20
 =20

>
>> are required to make possible reuse DRD part of CDNS3 driver in CDNSP
>> driver.
>>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  drivers/usb/cdns3/Makefile     |   2 +-
>>  drivers/usb/cdns3/cdns3-plat.c | 209 +++++++++++++++++++++++++++++++++
>>  drivers/usb/cdns3/core.c       | 181 +++-------------------------
>>  drivers/usb/cdns3/core.h       |   8 +-
>>  4 files changed, 234 insertions(+), 166 deletions(-)
>>  create mode 100644 drivers/usb/cdns3/cdns3-plat.c
>>
>> diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
>> index d47e341a6f39..a1fe9612053a 100644
>> --- a/drivers/usb/cdns3/Makefile
>> +++ b/drivers/usb/cdns3/Makefile
>> @@ -2,7 +2,7 @@
>>  # define_trace.h needs to know how to find our header
>>  CFLAGS_trace.o				:=3D -I$(src)
>>
>> -cdns3-y					:=3D core.o drd.o
>> +cdns3-y					:=3D cdns3-plat.o core.o drd.o
>>
>>  obj-$(CONFIG_USB_CDNS3)			+=3D cdns3.o
>>  cdns3-$(CONFIG_USB_CDNS3_GADGET)	+=3D gadget.o ep0.o
>> diff --git a/drivers/usb/cdns3/cdns3-plat.c b/drivers/usb/cdns3/cdns3-pl=
at.c
>> new file mode 100644
>> index 000000000000..f35e9dca30fe
>> --- /dev/null
>> +++ b/drivers/usb/cdns3/cdns3-plat.c
>> @@ -0,0 +1,209 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Cadence USBSS DRD Driver.
>> + *
>> + * Copyright (C) 2018-2020 Cadence.
>> + * Copyright (C) 2017-2018 NXP
>> + * Copyright (C) 2019 Texas Instrumentsq
>> + *
>> + *
>> + * Author: Peter Chen <peter.chen@nxp.com>
>> + *         Pawel Laszczak <pawell@cadence.com>
>> + *         Roger Quadros <rogerq@ti.com>
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>> +
>> +#include "core.h"
>> +
>> +/**
>> + * cdns3_plat_probe - probe for cdns3 core device
>> + * @pdev: Pointer to cdns3 core platform device
>> + *
>> + * Returns 0 on success otherwise negative errno
>> + */
>> +static int cdns3_plat_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev =3D &pdev->dev;
>> +	struct resource	*res;
>> +	struct cdns3 *cdns;
>> +	void __iomem *regs;
>> +	int ret;
>> +
>> +	cdns =3D devm_kzalloc(dev, sizeof(*cdns), GFP_KERNEL);
>> +	if (!cdns)
>> +		return -ENOMEM;
>> +
>> +	cdns->dev =3D dev;
>> +
>> +	platform_set_drvdata(pdev, cdns);
>> +
>> +	res =3D platform_get_resource_byname(pdev, IORESOURCE_IRQ, "host");
>> +	if (!res) {
>> +		dev_err(dev, "missing host IRQ\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	cdns->xhci_res[0] =3D *res;
>> +
>> +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "xhci");
>> +	if (!res) {
>> +		dev_err(dev, "couldn't get xhci resource\n");
>> +		return -ENXIO;
>> +	}
>> +
>> +	cdns->xhci_res[1] =3D *res;
>> +
>> +	cdns->dev_irq =3D platform_get_irq_byname(pdev, "peripheral");
>> +	if (cdns->dev_irq =3D=3D -EPROBE_DEFER)
>> +		return cdns->dev_irq;
>> +
>> +	if (cdns->dev_irq < 0)
>> +		dev_err(dev, "couldn't get peripheral irq\n");
>> +
>> +	regs =3D devm_platform_ioremap_resource_byname(pdev, "dev");
>> +	if (IS_ERR(regs))
>> +		return PTR_ERR(regs);
>> +	cdns->dev_regs	=3D regs;
>> +
>> +	cdns->otg_irq =3D platform_get_irq_byname(pdev, "otg");
>> +	if (cdns->otg_irq =3D=3D -EPROBE_DEFER)
>> +		return cdns->otg_irq;
>> +
>> +	if (cdns->otg_irq < 0) {
>> +		dev_err(dev, "couldn't get otg irq\n");
>> +		return cdns->otg_irq;
>> +	}
>> +
>> +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "otg");
>> +	if (!res) {
>> +		dev_err(dev, "couldn't get otg resource\n");
>> +		return -ENXIO;
>> +	}
>> +
>> +	cdns->otg_res =3D *res;
>> +
>> +	cdns->usb2_phy =3D devm_phy_optional_get(dev, "cdns3,usb2-phy");
>> +	if (IS_ERR(cdns->usb2_phy))
>> +		return PTR_ERR(cdns->usb2_phy);
>> +
>> +	ret =3D phy_init(cdns->usb2_phy);
>> +	if (ret)
>> +		return ret;
>> +
>> +	cdns->usb3_phy =3D devm_phy_optional_get(dev, "cdns3,usb3-phy");
>> +	if (IS_ERR(cdns->usb3_phy))
>> +		return PTR_ERR(cdns->usb3_phy);
>> +
>> +	ret =3D phy_init(cdns->usb3_phy);
>> +	if (ret)
>> +		goto err_phy3_init;
>> +
>> +	ret =3D phy_power_on(cdns->usb2_phy);
>> +	if (ret)
>> +		goto err_phy2_power_on;
>> +
>> +	ret =3D phy_power_on(cdns->usb3_phy);
>> +	if (ret)
>> +		goto err_phy3_power_on;
>> +
>> +	ret =3D cdns3_init(cdns);
>> +	if (ret)
>> +		goto err_cdns_init;
>> +
>> +	device_set_wakeup_capable(dev, true);
>> +	pm_runtime_set_active(dev);
>> +	pm_runtime_enable(dev);
>> +
>> +	/*
>> +	 * The controller needs less time between bus and controller suspend,
>> +	 * and we also needs a small delay to avoid frequently entering low
>> +	 * power mode.
>> +	 */
>> +	pm_runtime_set_autosuspend_delay(dev, 20);
>> +	pm_runtime_mark_last_busy(dev);
>> +
>> +	return 0;
>> +
>> +err_cdns_init:
>> +	phy_power_off(cdns->usb3_phy);
>> +err_phy3_power_on:
>> +	phy_power_off(cdns->usb2_phy);
>> +err_phy2_power_on:
>> +	phy_exit(cdns->usb3_phy);
>> +err_phy3_init:
>> +	phy_exit(cdns->usb2_phy);
>> +
>> +	return ret;
>> +}
>> +
>> +/**
>> + * cdns3_remove - unbind drd driver and clean up
>> + * @pdev: Pointer to Linux platform device
>> + *
>> + * Returns 0 on success otherwise negative errno
>> + */
>> +static int cdns3_plat_remove(struct platform_device *pdev)
>> +{
>> +	struct cdns3 *cdns =3D platform_get_drvdata(pdev);
>> +	struct device *dev =3D cdns->dev;
>> +
>> +	pm_runtime_get_sync(dev);
>> +	pm_runtime_disable(dev);
>> +	pm_runtime_put_noidle(dev);
>> +	cdns3_remove(cdns);
>> +	phy_power_off(cdns->usb2_phy);
>> +	phy_power_off(cdns->usb3_phy);
>> +	phy_exit(cdns->usb2_phy);
>> +	phy_exit(cdns->usb3_phy);
>> +	return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> +
>> +static int cdns3_plat_suspend(struct device *dev)
>> +{
>> +	struct cdns3 *cdns =3D dev_get_drvdata(dev);
>> +
>> +	return cdns3_suspend(cdns);
>> +}
>> +
>> +static int cdns3_plat_resume(struct device *dev)
>> +{
>> +	struct cdns3 *cdns =3D dev_get_drvdata(dev);
>> +
>> +	return cdns3_resume(cdns);
>> +}
>> +#endif
>> +
>> +static const struct dev_pm_ops cdns3_pm_ops =3D {
>> +	SET_SYSTEM_SLEEP_PM_OPS(cdns3_plat_suspend, cdns3_plat_resume)
>> +};
>> +
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id of_cdns3_match[] =3D {
>> +	{ .compatible =3D "cdns,usb3" },
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(of, of_cdns3_match);
>> +#endif
>> +
>> +static struct platform_driver cdns3_driver =3D {
>> +	.probe		=3D cdns3_plat_probe,
>> +	.remove		=3D cdns3_plat_remove,
>> +	.driver		=3D {
>> +		.name	=3D "cdns-usb3",
>> +		.of_match_table	=3D of_match_ptr(of_cdns3_match),
>> +		.pm	=3D &cdns3_pm_ops,
>> +	},
>> +};
>> +
>> +module_platform_driver(cdns3_driver);
>> +
>> +MODULE_ALIAS("platform:cdns3");
>> +MODULE_AUTHOR("Pawel Laszczak <pawell@cadence.com>");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_DESCRIPTION("Cadence USB3 DRD Controller Driver");
>> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
>> index 371128e9a4ae..079bd2abf65d 100644
>> --- a/drivers/usb/cdns3/core.c
>> +++ b/drivers/usb/cdns3/core.c
>> @@ -2,7 +2,7 @@
>>  /*
>>   * Cadence USBSS DRD Driver.
>>   *
>> - * Copyright (C) 2018-2019 Cadence.
>> + * Copyright (C) 2018-2020 Cadence.
>>   * Copyright (C) 2017-2018 NXP
>>   * Copyright (C) 2019 Texas Instruments
>>   *
>> @@ -383,17 +383,14 @@ static int cdns3_role_set(struct usb_role_switch *=
sw, enum usb_role role)
>>
>>  /**
>>   * cdns3_probe - probe for cdns3 core device
>> - * @pdev: Pointer to cdns3 core platform device
>> + * @cdns: Pointer to cdnsp structure.
>>   *
>>   * Returns 0 on success otherwise negative errno
>>   */
>> -static int cdns3_probe(struct platform_device *pdev)
>> +int cdns3_init(struct cdns3 *cdns)
>>  {
>>  	struct usb_role_switch_desc sw_desc =3D { };
>> -	struct device *dev =3D &pdev->dev;
>> -	struct resource	*res;
>> -	struct cdns3 *cdns;
>> -	void __iomem *regs;
>> +	struct device *dev =3D cdns->dev;
>>  	int ret;
>>
>>  	ret =3D dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
>> @@ -402,85 +399,8 @@ static int cdns3_probe(struct platform_device *pdev=
)
>>  		return ret;
>>  	}
>>
>> -	cdns =3D devm_kzalloc(dev, sizeof(*cdns), GFP_KERNEL);
>> -	if (!cdns)
>> -		return -ENOMEM;
>> -
>> -	cdns->dev =3D dev;
>> -
>> -	platform_set_drvdata(pdev, cdns);
>> -
>> -	res =3D platform_get_resource_byname(pdev, IORESOURCE_IRQ, "host");
>> -	if (!res) {
>> -		dev_err(dev, "missing host IRQ\n");
>> -		return -ENODEV;
>> -	}
>> -
>> -	cdns->xhci_res[0] =3D *res;
>> -
>> -	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "xhci");
>> -	if (!res) {
>> -		dev_err(dev, "couldn't get xhci resource\n");
>> -		return -ENXIO;
>> -	}
>> -
>> -	cdns->xhci_res[1] =3D *res;
>> -
>> -	cdns->dev_irq =3D platform_get_irq_byname(pdev, "peripheral");
>> -	if (cdns->dev_irq =3D=3D -EPROBE_DEFER)
>> -		return cdns->dev_irq;
>> -
>> -	if (cdns->dev_irq < 0)
>> -		dev_err(dev, "couldn't get peripheral irq\n");
>> -
>> -	regs =3D devm_platform_ioremap_resource_byname(pdev, "dev");
>> -	if (IS_ERR(regs))
>> -		return PTR_ERR(regs);
>> -	cdns->dev_regs	=3D regs;
>> -
>> -	cdns->otg_irq =3D platform_get_irq_byname(pdev, "otg");
>> -	if (cdns->otg_irq =3D=3D -EPROBE_DEFER)
>> -		return cdns->otg_irq;
>> -
>> -	if (cdns->otg_irq < 0) {
>> -		dev_err(dev, "couldn't get otg irq\n");
>> -		return cdns->otg_irq;
>> -	}
>> -
>> -	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "otg");
>> -	if (!res) {
>> -		dev_err(dev, "couldn't get otg resource\n");
>> -		return -ENXIO;
>> -	}
>> -
>> -	cdns->otg_res =3D *res;
>> -
>>  	mutex_init(&cdns->mutex);
>>
>> -	cdns->usb2_phy =3D devm_phy_optional_get(dev, "cdns3,usb2-phy");
>> -	if (IS_ERR(cdns->usb2_phy))
>> -		return PTR_ERR(cdns->usb2_phy);
>> -
>> -	ret =3D phy_init(cdns->usb2_phy);
>> -	if (ret)
>> -		return ret;
>> -
>> -	cdns->usb3_phy =3D devm_phy_optional_get(dev, "cdns3,usb3-phy");
>> -	if (IS_ERR(cdns->usb3_phy))
>> -		return PTR_ERR(cdns->usb3_phy);
>> -
>> -	ret =3D phy_init(cdns->usb3_phy);
>> -	if (ret)
>> -		goto err1;
>> -
>> -	ret =3D phy_power_on(cdns->usb2_phy);
>> -	if (ret)
>> -		goto err2;
>> -
>> -	ret =3D phy_power_on(cdns->usb3_phy);
>> -	if (ret)
>> -		goto err3;
>> -
>>  	sw_desc.set =3D cdns3_role_set;
>>  	sw_desc.get =3D cdns3_role_get;
>>  	sw_desc.allow_userspace_control =3D true;
>> @@ -490,78 +410,47 @@ static int cdns3_probe(struct platform_device *pde=
v)
>>
>>  	cdns->role_sw =3D usb_role_switch_register(dev, &sw_desc);
>>  	if (IS_ERR(cdns->role_sw)) {
>> -		ret =3D PTR_ERR(cdns->role_sw);
>>  		dev_warn(dev, "Unable to register Role Switch\n");
>> -		goto err4;
>> +		return PTR_ERR(cdns->role_sw);
>>  	}
>>
>>  	ret =3D cdns3_drd_init(cdns);
>>  	if (ret)
>> -		goto err5;
>> +		goto init_failed;
>>
>>  	ret =3D cdns3_core_init_role(cdns);
>>  	if (ret)
>> -		goto err5;
>> -
>> -	device_set_wakeup_capable(dev, true);
>> -	pm_runtime_set_active(dev);
>> -	pm_runtime_enable(dev);
>> +		goto init_failed;
>>
>> -	/*
>> -	 * The controller needs less time between bus and controller suspend,
>> -	 * and we also needs a small delay to avoid frequently entering low
>> -	 * power mode.
>> -	 */
>> -	pm_runtime_set_autosuspend_delay(dev, 20);
>> -	pm_runtime_mark_last_busy(dev);
>> -	pm_runtime_use_autosuspend(dev);
>>  	dev_dbg(dev, "Cadence USB3 core: probe succeed\n");
>>
>>  	return 0;
>> -err5:
>> +init_failed:
>>  	cdns3_drd_exit(cdns);
>>  	usb_role_switch_unregister(cdns->role_sw);
>> -err4:
>> -	phy_power_off(cdns->usb3_phy);
>> -
>> -err3:
>> -	phy_power_off(cdns->usb2_phy);
>> -err2:
>> -	phy_exit(cdns->usb3_phy);
>> -err1:
>> -	phy_exit(cdns->usb2_phy);
>>
>>  	return ret;
>>  }
>>
>>  /**
>>   * cdns3_remove - unbind drd driver and clean up
>> - * @pdev: Pointer to Linux platform device
>> + * @cdns: Pointer to cdnsp structure.
>>   *
>>   * Returns 0 on success otherwise negative errno
>>   */
>> -static int cdns3_remove(struct platform_device *pdev)
>> +int cdns3_remove(struct cdns3 *cdns)
>>  {
>> -	struct cdns3 *cdns =3D platform_get_drvdata(pdev);
>> -
>> -	pm_runtime_get_sync(&pdev->dev);
>> -	pm_runtime_disable(&pdev->dev);
>> -	pm_runtime_put_noidle(&pdev->dev);
>>  	cdns3_exit_roles(cdns);
>>  	usb_role_switch_unregister(cdns->role_sw);
>> -	phy_power_off(cdns->usb2_phy);
>> -	phy_power_off(cdns->usb3_phy);
>> -	phy_exit(cdns->usb2_phy);
>> -	phy_exit(cdns->usb3_phy);
>> +
>>  	return 0;
>>  }
>>
>>  #ifdef CONFIG_PM_SLEEP
>>
>> -static int cdns3_suspend(struct device *dev)
>> +int cdns3_suspend(struct cdns3 *cdns)
>>  {
>> -	struct cdns3 *cdns =3D dev_get_drvdata(dev);
>> -	unsigned long flags;
>> +	struct device *dev =3D cdns->dev;
>>
>>  	if (cdns->role =3D=3D USB_ROLE_HOST)
>>  		return 0;
>> @@ -569,28 +458,21 @@ static int cdns3_suspend(struct device *dev)
>>  	if (pm_runtime_status_suspended(dev))
>>  		pm_runtime_resume(dev);
>>
>> -	if (cdns->roles[cdns->role]->suspend) {
>> -		spin_lock_irqsave(&cdns->gadget_dev->lock, flags);
>> +	if (cdns->roles[cdns->role]->suspend)
>>  		cdns->roles[cdns->role]->suspend(cdns, false);
>> -		spin_unlock_irqrestore(&cdns->gadget_dev->lock, flags);
>> -	}
>>
>>  	return 0;
>>  }
>>
>> -static int cdns3_resume(struct device *dev)
>> +int cdns3_resume(struct cdns3 *cdns)
>>  {
>> -	struct cdns3 *cdns =3D dev_get_drvdata(dev);
>> -	unsigned long flags;
>> +	struct device *dev =3D cdns->dev;
>>
>>  	if (cdns->role =3D=3D USB_ROLE_HOST)
>>  		return 0;
>>
>> -	if (cdns->roles[cdns->role]->resume) {
>> -		spin_lock_irqsave(&cdns->gadget_dev->lock, flags);
>> +	if (cdns->roles[cdns->role]->resume)
>>  		cdns->roles[cdns->role]->resume(cdns, false);
>> -		spin_unlock_irqrestore(&cdns->gadget_dev->lock, flags);
>> -	}
>>
>>  	pm_runtime_disable(dev);
>>  	pm_runtime_set_active(dev);
>> @@ -599,32 +481,3 @@ static int cdns3_resume(struct device *dev)
>>  	return 0;
>>  }
>>  #endif
>> -
>> -static const struct dev_pm_ops cdns3_pm_ops =3D {
>> -	SET_SYSTEM_SLEEP_PM_OPS(cdns3_suspend, cdns3_resume)
>> -};
>> -
>> -#ifdef CONFIG_OF
>> -static const struct of_device_id of_cdns3_match[] =3D {
>> -	{ .compatible =3D "cdns,usb3" },
>> -	{ },
>> -};
>> -MODULE_DEVICE_TABLE(of, of_cdns3_match);
>> -#endif
>> -
>> -static struct platform_driver cdns3_driver =3D {
>> -	.probe		=3D cdns3_probe,
>> -	.remove		=3D cdns3_remove,
>> -	.driver		=3D {
>> -		.name	=3D "cdns-usb3",
>> -		.of_match_table	=3D of_match_ptr(of_cdns3_match),
>> -		.pm	=3D &cdns3_pm_ops,
>> -	},
>> -};
>> -
>> -module_platform_driver(cdns3_driver);
>> -
>> -MODULE_ALIAS("platform:cdns3");
>> -MODULE_AUTHOR("Pawel Laszczak <pawell@cadence.com>");
>> -MODULE_LICENSE("GPL v2");
>> -MODULE_DESCRIPTION("Cadence USB3 DRD Controller Driver");
>> diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
>> index c09fdde3ae8f..284707c19620 100644
>> --- a/drivers/usb/cdns3/core.h
>> +++ b/drivers/usb/cdns3/core.h
>> @@ -3,7 +3,7 @@
>>   * Cadence USBSS DRD Header File.
>>   *
>>   * Copyright (C) 2017-2018 NXP
>> - * Copyright (C) 2018-2019 Cadence.
>> + * Copyright (C) 2018-2020 Cadence.
>>   *
>>   * Authors: Peter Chen <peter.chen@nxp.com>
>>   *          Pawel Laszczak <pawell@cadence.com>
>> @@ -97,5 +97,11 @@ struct cdns3 {
>>  };
>>
>>  int cdns3_hw_role_switch(struct cdns3 *cdns);
>> +int cdns3_init(struct cdns3 *cdns);
>> +int cdns3_remove(struct cdns3 *cdns);
>>
>> +#ifdef CONFIG_PM_SLEEP
>> +int cdns3_resume(struct cdns3 *cdns);
>> +int cdns3_suspend(struct cdns3 *cdns);
>> +#endif /* CONFIG_PM_SLEEP */
>>  #endif /* __LINUX_CDNS3_CORE_H */
>> --
>> 2.17.1
>>
>
>--
>
>Thanks,
>Peter Chen
