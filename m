Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D782AD259
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 10:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731404AbgKJJVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 04:21:38 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:58070 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726462AbgKJJVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 04:21:35 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AA99krL024861;
        Tue, 10 Nov 2020 01:20:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=95mdUeDOPEfYohbsnqMM0AOoMLADz6COzAQoNNEoE/A=;
 b=R+EtMWNNTnxKj3wzn1BxU57hohoItF0Q4M8F0w/ief48Wek6qRXaPKeIQfQax+Z8IQni
 Aj8os9HxoM6e5+nZSXgIrQdT5bOrgb9eWklEdrlEvdv31QdlNOfMEMP9sla8PXgJPF6X
 8C2Gi1OiB9qaNARPEHNiyZ+4i4ZeJ3YEQc0FjMeLz1Bu5/9G/ui907w1WqE8eotT3XgJ
 8QQCgV8yB6jpCAhHbHcqN/FRvykoZnnyBZSbB+CihvaclqI7jlIjHT6D+rsrf4ZTA0b0
 gXhH72OJaenukEz8Tw9RWJbWU44NL1q6psTX8f9MYABZsW9GrOeNAufDkq+TqHJKcYNW GA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0b-0014ca01.pphosted.com with ESMTP id 34nr22tf32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Nov 2020 01:20:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUaxRwwazehRCU0kKWqk2XnAJvodV+kkLZAn6u5lS+ja2mjuFcnqlSPZlaWbgYobiGfHwDCGtnGq29qYPovc6JmVaLMHSiNBylA82ga9c6IDBFQS9BToJLjc7in932dDliAbfIxds4UqMtyj0i2/akAX8TOvUilvRLiNK6Qn2hX5GiIhsAgpoJDTZStqivOCNTIh/GIFYYZK7WvUCVXCwA3b8ToOpmgXFbZFC2c3QZ8a6r6RWjyJkNJSQnJAug1MEJdbe5ne1C0yOkSGjknAa8IUSVnCx7xUFSQro6QDec3+IVwUblz1omu16mj7bOH5WLASdxoEY5r3RAkY3iV4YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95mdUeDOPEfYohbsnqMM0AOoMLADz6COzAQoNNEoE/A=;
 b=RiQlWcDlFrxB4GgeTZ/d9wrMM/gv9elkYZ7zo1aC3qJ4PxpHTd8u+78mr6juaW8zhtREaO1ov6IxRHKLYQypNniut77M+pUUYB0oxXDbDbNd67zyDaTZYrgIkXoiPJfeoKK2ze5BV8tkxwTkaxmFH6xqEReb7XjOjDPAmK22a2cpqI0pkpquMiAZrPuXoaiv31G9eIGIl0d1yXT5A9gg/vMo5kOt6Q+5wSAksRpaaIoShZD+86ffn1kxjiO4bs0d6/gmW5TOG01cBgg3t/9HPA0GS0Zz0Sa/4GPHAG4UhXcmfm6sWtvr6izNTfriXQPt2gf8svmo5ykszLDM5WDmcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95mdUeDOPEfYohbsnqMM0AOoMLADz6COzAQoNNEoE/A=;
 b=kC/Oot0K5XZ8+W/eiX7T4ukxrhmbn1GhJCPf+OF3ddedfuLuUTPmxjMg9i5s51gq98q7YID9UNGxMqoByxljcP+vZ3hsNmW7ZvBgR6W0XfTtn6e2rjl4iaCrOjxvwSWOSR4rfiSy9mxObmq1O1V001/702qbNwvpS42fZqiGFmU=
Received: from DM6PR07MB5529.namprd07.prod.outlook.com (2603:10b6:5:7a::30) by
 DM6PR07MB5674.namprd07.prod.outlook.com (2603:10b6:5:36::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18; Tue, 10 Nov 2020 09:20:54 +0000
Received: from DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::f977:ce71:755d:bed6]) by DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::f977:ce71:755d:bed6%6]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 09:20:54 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Peter Chen <peter.chen@nxp.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "rogerq@ti.com" <rogerq@ti.com>, Rahul Kumar <kurahul@cadence.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>
Subject: RE: [PATCH v2 03/10] usb: cdns3: Moves reusable code to separate
 module
Thread-Topic: [PATCH v2 03/10] usb: cdns3: Moves reusable code to separate
 module
Thread-Index: AQHWtDIwjXrTHzGzLka9II0WlmWMgKnBGfiAgAAAUrA=
Date:   Tue, 10 Nov 2020 09:20:54 +0000
Message-ID: <DM6PR07MB55294E87F6D76BA3C04E510ADDE90@DM6PR07MB5529.namprd07.prod.outlook.com>
References: <20201106114300.1245-1-pawell@cadence.com>
 <20201106114300.1245-4-pawell@cadence.com>
 <20201110090854.GB22481@b29397-desktop>
In-Reply-To: <20201110090854.GB22481@b29397-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMDYxNDkxYzgtMjMzNi0xMWViLTg3NmItMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDA2MTQ5MWM5LTIzMzYtMTFlYi04NzZiLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iODYxOSIgdD0iMTMyNDk0NzM2NTEyODA4NzcyIiBoPSJ6cFFJNXVqL2RHK2ozOXNOSkhZdUVVT24rNmc9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8dba1b45-7ac5-4586-d14c-08d88559ece1
x-ms-traffictypediagnostic: DM6PR07MB5674:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR07MB56749A3FF1C9635486C23B7EDDE90@DM6PR07MB5674.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NGHCCWzYDf5equmzWLuJnk+RGnqoOK/HCsbyBxcm/MAAAYf7XeoC3zOvhO4uTjAxQWRAl8Ty5SR3OMCegok3E4j52tEiAQOzPS4UGTOupRworh9816AzW+BPYF1LqJkrmYqX7E7L+X0BGwp+I+31OSTW3rf/vl4I8tlQjt9f/AGIyH+CBRQmSkqDJzeEEhn+pmOTieCzSBFkIYx8z5CLG+mkCkJExi5Imts5uzW5+ZXrtTh4fLbJGRZtXq/fMM463lUSr36aHyzUDYsWd2SY+v01w9NhINHbxHzCIkFhQN8GeGgjAgdtEnD10bmYTfyxhmMZY4Ms5hnxQYqs9n23tuzj7OdUY7L+oaJMfc50q4/BvfbLU0u5Hd9jEghDi8IU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB5529.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(36092001)(55016002)(8936002)(2906002)(66476007)(52536014)(83380400001)(4326008)(33656002)(5660300002)(6506007)(478600001)(76116006)(66556008)(7696005)(9686003)(6916009)(66446008)(86362001)(26005)(66946007)(186003)(54906003)(64756008)(8676002)(71200400001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: SiQMP5al0uc1e4wCrKkVAelxkBXCqk72ez3bzb7CtVgHim30MmQiJlJz0Bko6QRp/4uUoiW+tIL8oZB7+Z9vgjjZatJMTkEqFVKig2kgPgcE5aVE0sCOphFjcoq7DNZsFUA554YH23kQBqZ5AW9HU78HehLt9xsS9SOZo5jaUk5iOCgrrBMMm59mIN/pcdzCuwG4fhrqZhPPNJAGMJ3MsZ6GvwP9sIeKVPVy99yxchSCja18Wqog2t+NJtyU8t+vPBZie1VX+XnxRL999MqWFqlCtfqfpQXjZkL0DSYWlV36ZFQOYbI5AexRHNDVrkPxoWPeC9eanCiMcp8i4gkXFicaTKcVqhqxaWGPghECYk1UMDXaFUO/vX6FJNm4Nxj2yyIX/3k+8oy2YFz0XwAr9B5whjGWdVz4TlVwMx+TClI1iC8Yd0U+bgu7Hbfy00SW5emiguQsEE1zEmqdKYWjUQOynubTJecYQNnliDNdncx9zurw3+/vTNla4N1z5n6LMYYK1duTq0+G98oFK0pJlG5Xf1l8FKicrcNyx0iNs3V0qFKK5MkFZ6ldw/xOpX3K9qO0cdT9XyB4QE1OjWeoBNkq6vp+H+shHGAOEH7w6R4tErXIsiHKMbpVBrCa2+u6UNQpACyS3A1y5C7916qmuBOPinuz0yLdmfWCcrEg3K8MQT0jf1P5HGVCgNvYj2jKkvFL2s6Y5tJhI7e72yiCWid4nk0jll+iah75GewHsPEU0A1Yi21WupQWskq4GzZifBcLKDBrRZtxDVsTQAYyEufH6s/otXUYCpzOtua8d4/nVH4Jyt4E9yPszBwiVXVTpw4JxeK6rCPmQmW7Zd5/uabDekL5IivTA8iuHu06tBtT+26jPl2k+x+e+KSucViQZj4aGbdpIrbDJisZTMUZCA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB5529.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dba1b45-7ac5-4586-d14c-08d88559ece1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 09:20:54.3542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lgRPLZR/ax+ljd9rMIuTzCfpi6HpKNNolwQ2+eiowJgtp3HMQQqHgmYTskYAuKoD6W6UGS7B9OvRD10Gl+E4q6Cegh+ey33NSe40RfD8BKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5674
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-10_04:2020-11-05,2020-11-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 mlxlogscore=829 mlxscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011100067
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>
>On 20-11-06 12:42:53, Pawel Laszczak wrote:
>> Patch moves common reusable code used by cdns3 and cdnsp driver
>> to cdns-usb-common library. This library include core.c, drd.c
>> and host.c files.
>>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  drivers/usb/cdns3/Kconfig      |  8 ++++++++
>>  drivers/usb/cdns3/Makefile     |  8 +++++---
>>  drivers/usb/cdns3/cdns3-plat.c |  2 ++
>>  drivers/usb/cdns3/core.c       | 18 +++++++++++++++---
>>  drivers/usb/cdns3/core.h       | 11 +++++++----
>>  drivers/usb/cdns3/drd.c        |  3 ++-
>>  drivers/usb/cdns3/drd.h        |  4 ++--
>>  7 files changed, 41 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/usb/cdns3/Kconfig b/drivers/usb/cdns3/Kconfig
>> index 84716d216ae5..58154c0a73ac 100644
>> --- a/drivers/usb/cdns3/Kconfig
>> +++ b/drivers/usb/cdns3/Kconfig
>> @@ -1,8 +1,15 @@
>> +config CDNS_USB_COMMON
>> +	tristate
>> +
>> +config CDNS_USB_HOST
>> +	bool
>> +
>>  config USB_CDNS3
>>  	tristate "Cadence USB3 Dual-Role Controller"
>>  	depends on USB_SUPPORT && (USB || USB_GADGET) && HAS_DMA
>>  	select USB_XHCI_PLATFORM if USB_XHCI_HCD
>>  	select USB_ROLE_SWITCH
>> +	select CDNS_USB_COMMON
>>  	help
>>  	  Say Y here if your system has a Cadence USB3 dual-role controller.
>>  	  It supports: dual-role switch, Host-only, and Peripheral-only.
>> @@ -25,6 +32,7 @@ config USB_CDNS3_GADGET
>>  config USB_CDNS3_HOST
>>  	bool "Cadence USB3 host controller"
>>  	depends on USB=3Dy || USB=3DUSB_CDNS3
>> +	select CDNS_USB_HOST
>>  	help
>>  	  Say Y here to enable host controller functionality of the
>>  	  Cadence driver.
>> diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
>> index a1fe9612053a..16df87abf3cf 100644
>> --- a/drivers/usb/cdns3/Makefile
>> +++ b/drivers/usb/cdns3/Makefile
>> @@ -2,17 +2,19 @@
>>  # define_trace.h needs to know how to find our header
>>  CFLAGS_trace.o				:=3D -I$(src)
>>
>> -cdns3-y					:=3D cdns3-plat.o core.o drd.o
>> +cdns-usb-common-y			:=3D core.o drd.o
>> +cdns3-y					:=3D cdns3-plat.o
>>
>>  obj-$(CONFIG_USB_CDNS3)			+=3D cdns3.o
>> +obj-$(CONFIG_CDNS_USB_COMMON)		+=3D cdns-usb-common.o
>> +
>> +cdns-usb-common-$(CONFIG_CDNS_USB_HOST) +=3D host.o
>>  cdns3-$(CONFIG_USB_CDNS3_GADGET)	+=3D gadget.o ep0.o
>>
>>  ifneq ($(CONFIG_USB_CDNS3_GADGET),)
>>  cdns3-$(CONFIG_TRACING)			+=3D trace.o
>>  endif
>>
>> -cdns3-$(CONFIG_USB_CDNS3_HOST)		+=3D host.o
>> -
>>  obj-$(CONFIG_USB_CDNS3_PCI_WRAP)	+=3D cdns3-pci-wrap.o
>>  obj-$(CONFIG_USB_CDNS3_TI)		+=3D cdns3-ti.o
>>  obj-$(CONFIG_USB_CDNS3_IMX)		+=3D cdns3-imx.o
>> diff --git a/drivers/usb/cdns3/cdns3-plat.c b/drivers/usb/cdns3/cdns3-pl=
at.c
>> index b74882af3a9f..562163c81911 100644
>> --- a/drivers/usb/cdns3/cdns3-plat.c
>> +++ b/drivers/usb/cdns3/cdns3-plat.c
>> @@ -18,6 +18,7 @@
>>  #include <linux/pm_runtime.h>
>>
>>  #include "core.h"
>> +#include "gadget-export.h"
>>
>>  static int set_phy_power_on(struct cdns3 *cdns)
>>  {
>> @@ -134,6 +135,7 @@ static int cdns3_plat_probe(struct platform_device *=
pdev)
>>  	if (ret)
>>  		goto err_phy_power_on;
>>
>> +	cdns->gadget_init =3D cdns3_gadget_init;
>>  	ret =3D cdns3_init(cdns);
>>  	if (ret)
>>  		goto err_cdns_init;
>> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
>> index 758fd5d67196..4fedf32855af 100644
>> --- a/drivers/usb/cdns3/core.c
>> +++ b/drivers/usb/cdns3/core.c
>> @@ -19,10 +19,8 @@
>>  #include <linux/io.h>
>>  #include <linux/pm_runtime.h>
>>
>> -#include "gadget.h"
>>  #include "core.h"
>>  #include "host-export.h"
>> -#include "gadget-export.h"
>>  #include "drd.h"
>>
>>  static int cdns3_idle_init(struct cdns3 *cdns);
>> @@ -147,7 +145,11 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
>>  	}
>>
>>  	if (dr_mode =3D=3D USB_DR_MODE_OTG || dr_mode =3D=3D USB_DR_MODE_PERIP=
HERAL) {
>> -		ret =3D cdns3_gadget_init(cdns);
>> +		if (cdns->gadget_init)
>> +			ret =3D cdns->gadget_init(cdns);
>> +		else
>> +			ret =3D -ENXIO;
>> +
>>  		if (ret) {
>>  			dev_err(dev, "Device initialization failed with %d\n",
>>  				ret);
>> @@ -473,6 +475,7 @@ int cdns3_init(struct cdns3 *cdns)
>>
>>  	return ret;
>>  }
>> +EXPORT_SYMBOL_GPL(cdns3_init);
>>
>>  /**
>>   * cdns3_remove - unbind drd driver and clean up
>> @@ -487,6 +490,7 @@ int cdns3_remove(struct cdns3 *cdns)
>>
>>  	return 0;
>>  }
>> +EXPORT_SYMBOL_GPL(cdns3_remove);
>>
>>  #ifdef CONFIG_PM_SLEEP
>>  int cdns3_suspend(struct cdns3 *cdns)
>> @@ -505,6 +509,7 @@ int cdns3_suspend(struct cdns3 *cdns)
>>
>>  	return 0;
>>  }
>> +EXPORT_SYMBOL_GPL(cdns3_suspend);
>>
>>  int cdns3_resume(struct cdns3 *cdns, u8 set_active)
>>  {
>> @@ -521,4 +526,11 @@ int cdns3_resume(struct cdns3 *cdns, u8 set_active)
>>
>>  	return 0;
>>  }
>> +EXPORT_SYMBOL_GPL(cdns3_resume);
>>  #endif /* CONFIG_PM_SLEEP */
>> +
>> +MODULE_AUTHOR("Peter Chen <peter.chen@nxp.com>");
>> +MODULE_AUTHOR("Pawel Laszczak <pawell@cadence.com>");
>> +MODULE_AUTHOR("Roger Quadros <rogerq@ti.com>");
>> +MODULE_DESCRIPTION("Cadence USBSS and USBSSP DRD Driver");
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
>> index 7e5d9a344a53..96bdab7e8357 100644
>> --- a/drivers/usb/cdns3/core.h
>> +++ b/drivers/usb/cdns3/core.h
>> @@ -75,6 +75,7 @@ struct cdns3_platform_data {
>>   * @wakeup_pending: wakeup interrupt pending
>>   * @pdata: platform data from glue layer
>>   * @lock: spinlock structure
>> + * @gadget_init: pointer to gadget initialization function
>>   */
>>  struct cdns3 {
>>  	struct device			*dev;
>> @@ -111,14 +112,16 @@ struct cdns3 {
>>  	bool				wakeup_pending;
>>  	struct cdns3_platform_data	*pdata;
>>  	spinlock_t			lock;
>> +
>> +	int (*gadget_init)(struct cdns3 *cdns);
>>  };
>>
>>  int cdns3_hw_role_switch(struct cdns3 *cdns);
>> -int cdns3_init(struct cdns3 *cdns);
>> -int cdns3_remove(struct cdns3 *cdns);
>> +extern int cdns3_init(struct cdns3 *cdns);
>> +extern int cdns3_remove(struct cdns3 *cdns);
>
>Why add "extern" here and below?
>

These functions are the API between cdnsp and cdns3 modules.
It's looks like a common approach in kernel.
Many or even most of API function in kernel has "extern".=20

Of course, here we have little different situation because these API functi=
ons
are limited only to cdns3 directory.=20

 was not sure about that, but I think that this extern is the
information that these functions are used, or can be used
 by other modules.

Am I right ?

>>
>>  #ifdef CONFIG_PM_SLEEP
>> -int cdns3_resume(struct cdns3 *cdns, u8 set_active);
>> -int cdns3_suspend(struct cdns3 *cdns);
>> +extern int cdns3_resume(struct cdns3 *cdns, u8 set_active);
>> +extern int cdns3_suspend(struct cdns3 *cdns);
>>  #endif /* CONFIG_PM_SLEEP */
>>  #endif /* __LINUX_CDNS3_CORE_H */
>> diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
>> index ed8cde91a02c..1874dc6018f0 100644
>> --- a/drivers/usb/cdns3/drd.c
>> +++ b/drivers/usb/cdns3/drd.c
>> @@ -15,7 +15,6 @@
>>  #include <linux/iopoll.h>
>>  #include <linux/usb/otg.h>
>>
>> -#include "gadget.h"
>>  #include "drd.h"
>>  #include "core.h"
>>
>> @@ -226,6 +225,7 @@ int cdns3_drd_gadget_on(struct cdns3 *cdns)
>>  	phy_set_mode(cdns->usb3_phy, PHY_MODE_USB_DEVICE);
>>  	return 0;
>>  }
>> +EXPORT_SYMBOL_GPL(cdns3_drd_gadget_on);
>>
>>  /**
>>   * cdns3_drd_gadget_off - stop gadget.
>> @@ -249,6 +249,7 @@ void cdns3_drd_gadget_off(struct cdns3 *cdns)
>>  				  1, 2000000);
>>  	phy_set_mode(cdns->usb3_phy, PHY_MODE_INVALID);
>>  }
>> +EXPORT_SYMBOL_GPL(cdns3_drd_gadget_off);
>>
>>  /**
>>   * cdns3_init_otg_mode - initialize drd controller
>> diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
>> index d752d8806a38..972aba8a40b6 100644
>> --- a/drivers/usb/cdns3/drd.h
>> +++ b/drivers/usb/cdns3/drd.h
>> @@ -209,8 +209,8 @@ int cdns3_get_vbus(struct cdns3 *cdns);
>>  int cdns3_drd_init(struct cdns3 *cdns);
>>  int cdns3_drd_exit(struct cdns3 *cdns);
>>  int cdns3_drd_update_mode(struct cdns3 *cdns);
>> -int cdns3_drd_gadget_on(struct cdns3 *cdns);
>> -void cdns3_drd_gadget_off(struct cdns3 *cdns);
>> +extern int cdns3_drd_gadget_on(struct cdns3 *cdns);
>> +extern void cdns3_drd_gadget_off(struct cdns3 *cdns);
>>  int cdns3_drd_host_on(struct cdns3 *cdns);
>>  void cdns3_drd_host_off(struct cdns3 *cdns);
>>
>> --
>> 2.17.1
>>

--
Thanks
Pawel Laszczak
