Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6106527F8C2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 06:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgJAEle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 00:41:34 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:27524 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725823AbgJAEle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 00:41:34 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0914YUTf011662;
        Wed, 30 Sep 2020 21:40:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=UIDqe+ZAKVgCY1pUTmz0b3KOkLzBErBw4d67ou987cQ=;
 b=QSLRx224x0M73aqUdcYPyjT+KbmMfGPT/z4IHSJc2tNGLcYw58gcAxghmLedMcRROK3o
 QlJ29NsCUI300Fo/h5banjLdWCD3teBzkMuKikpAEexmtVMklA1fBVbmrMROK5+7dfuq
 d2F2BO87c1aESVeVn+yPbjsJGm5VJnlQJvME+vqSHoyxXtmt0dDMNfEpk0JG+I6sCVFu
 2WoOBBx1MxFVJX6LhDiTrok5iJHTqtryM8EpVhZJV8nIkUMc0Kk81Xrq/b7Du1Glrkpc
 U9UIpsvou9DNHpFLnwUxl8zGpZmtaUaTtXUXLPEuLrk1NTUErqNRh0HfK7ktH8X2s5Oo mA== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by mx0b-0014ca01.pphosted.com with ESMTP id 33t17xahk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 21:40:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ML265VKzCf4E6nyNAoXy6VvlQlQnsW+BhXkrDTmDTM+4tW/vBLQZ/OjmAy9RF1CgKGt4w2vCOgUOqqMR/+fVASFjNWz2VFx7ngsqH/kBv+s2uctJCjqpaixACG0VlR+eXssOLXG9Hmgja49u1oczyO0NC5XrnucJ58BNldha/qfJVQm/o5rCqk213kvCvTj/cC5cQ63bDUR9o9cA6Ov5/MKU6G8sv8Vn+D2O6bf5fA9XgvuERRquNFE8Db/s2geV3Hej9mBZf6F74E8wz36eSFJT68W9cS0MKfU5llN4k3tqQn3M2UCBY8BB0wIlgd36nLYB0X7UzQ6D5iz/9q8YfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIDqe+ZAKVgCY1pUTmz0b3KOkLzBErBw4d67ou987cQ=;
 b=V+tjT5pomZdBGh9iCpxZbaGvqNSAdOgOAaXjkVMqIQf/403bc3zbl0FqGQvSsxLokoXITtusXQttvBuvl9xXI76wQuKDnpL3VgNy6N7wj1qwLc44p8rRqtTQn/wy6BiqPgDCTBKxUEgPsyctOZe5eUIaLNBHho0dkfmtDc0Z7N6yq5lzcZOsvgPLBHurzWFJBLG6lbhwOs4PQJIv2ng4NekHDsQxEb2ApOMW72mse1DwEVOzHyIaNkAuBc28nF7xX+RtBkeTwJ95+cblBX0ANRa/pAVNcGlOJQxD3YuQq2DPbOh1UdnYiYLmipayztsQICHYFILsvjZ3/peQxfWycQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIDqe+ZAKVgCY1pUTmz0b3KOkLzBErBw4d67ou987cQ=;
 b=HU9GPSfNPOm6XqUUhgPvVR4kULs6kUbpnWonys85Kh0R1cNBlkcUJE6p1Ok4YTKpLSZZnaZJlYVpfzmhANpgL9QaCPI4k7m9BK5IjH0hudKSRTYkoPxsfTZuMuCUjO5di9MPKxpFwGV73k54llXit6guSlSqnWHRk8S9FBHf34A=
Received: from DM6PR07MB5529.namprd07.prod.outlook.com (2603:10b6:5:7a::30) by
 DM5PR07MB3498.namprd07.prod.outlook.com (2603:10b6:4:61::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.37; Thu, 1 Oct 2020 04:40:06 +0000
Received: from DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::2087:7f2b:5dc6:a960]) by DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::2087:7f2b:5dc6:a960%6]) with mapi id 15.20.3433.037; Thu, 1 Oct 2020
 04:40:06 +0000
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
Subject: RE: [PATCH 5/8] usb: cdns3: Changed type of gadget_dev in cdns
 structure
Thread-Topic: [PATCH 5/8] usb: cdns3: Changed type of gadget_dev in cdns
 structure
Thread-Index: AQHWlZOWAZZyZIyAvEqOj9uQKqZ+Val/CPYAgAMhoZA=
Date:   Thu, 1 Oct 2020 04:40:06 +0000
Message-ID: <DM6PR07MB55293E7DAC48DBB3000AE6EEDD300@DM6PR07MB5529.namprd07.prod.outlook.com>
References: <20200928122741.17884-1-pawell@cadence.com>
 <20200928122741.17884-6-pawell@cadence.com>
 <20200929043508.GC9076@b29397-desktop>
In-Reply-To: <20200929043508.GC9076@b29397-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMmJiNzc0NzEtMDNhMC0xMWViLTg3NmItMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDJiYjc3NDcyLTAzYTAtMTFlYi04NzZiLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMzM3MyIgdD0iMTMyNDYwMDA4MDM4NjI0MTU2IiBoPSJNY3pWSy9lUkF5TFV3dlpuZHY3VTJ0WUZsaDQ9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 421dba61-c649-48f0-5cf5-08d865c41229
x-ms-traffictypediagnostic: DM5PR07MB3498:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR07MB34988B0E0E58FEAECC01FFDBDD300@DM5PR07MB3498.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yx5mwlTcgeap/P9eZbSJ/cuKEaDPjCPzVae2RhQAWqioas647K5D5mMAHkN2Zs+rqSmxQQNntr9xvqT6/QOL93touRnGaw4gY/9N3zhsR+S4e9gH8LdfpdVT9cgvjfQwTDeZIVrXtBk1VvBNmRN9YD9p5YhoZx1rl2qqjQUiyG5YvNOuBiRQnEeObKU+kEdKWpVA4EyNO/WvdGRfVddMww78oR70YUuSjUWuAP7ZWOTN+NcvqJBSLuQ5gCkDFtwRx9JQvRh8MFYvXk28F5Hae4NuTjOYkEeONMCq5rCvJWdyqxHIpPPI4m/ohNml5SUuoGXei23/l7eMSHK7BeMppII571qPmYILwEcLj7qTBZTjiV7uflqCsK7Kzm2ZiSyd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB5529.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(36092001)(66446008)(64756008)(66476007)(76116006)(66556008)(66946007)(33656002)(6506007)(478600001)(86362001)(83380400001)(7416002)(8936002)(2906002)(186003)(8676002)(6916009)(4326008)(9686003)(55016002)(7696005)(54906003)(26005)(5660300002)(52536014)(316002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: fJnzx+Wvy0BmbBojt70slwF3LaBjTTIN6ZbJurpSSVRYH33wWMCHekuqit71LRyvN4c43UMao3EM5M+6CoZgl9yUhH/T4BnbC1Achn5zQ5f0bRUfwevcPFuR8WEbFvZ2yI8KZrlxtGI9jWNT8stgEgZ8R6yHMiAICH5WIf4jZS5o111R832qixmu4RWuWk0iguEQu8kXYRQ+VFtpJOBwZtUM6ilFigFrZ9Fdd9ZadX2sq3rYEy94NLvpgayPGpupox9mV074WOfZPjTYVPUnqC3r5+CRhn+IluyDlH8+9QI1Z1HeIdqinFg3kb5jxVyZOG9aSInoVSpB/5KDRCGNtPVSbaMpYxGJc8Y9L6Mh5Rg6ZB/OHmSQmmCDJMdRxiTiDSbPjEjCLx8YUU6ZygxoC10tRIWicWS2eOsZGjEUh22ugQU0oX6vuMlHxaBmEspoSzmUX5RT2Nq/48kXK13/Rd66dV/gCknV6Qmo6zm5x0dMcEwEELB69GXcbxnQQr5aBtHX/K1gCrqmCoZEfE/ZLDDswRDarjtLwap+1wDFcthgDHStE1Si0d4iJSzneNaXb1rK/tfr6iJAdisFvMNzE+8xzAcmbK+ylI7qLcbZnlmEz3IoDd0vYammPYdJlwshVfg+tbx1GFk4J5kLrHU+hQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB5529.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 421dba61-c649-48f0-5cf5-08d865c41229
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 04:40:06.3642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KY3qiFwEpRap50ZBJnEiK429zTDsJm8yhvZFLbmrwU3Kk4btZisvGZSdU8BtuNG+jvmagjvbWj35KNWbSUx9wgFbdy8HMobGfKdTyG56Oww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3498
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-01_02:2020-10-01,2020-10-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 mlxlogscore=683 clxscore=1015
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2010010042
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>On 20-09-28 14:27:38, Pawel Laszczak wrote:
>> Patch changes the type for gadget_dev pointer in cdns structure from
>> pointer to cdns3_device structure to void pointer.
>> This filed is in reusable code and after this change it will be used to
>> point to both cdns3_device or cdnsp_device objects.
>>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  drivers/usb/cdns3/core.h   | 4 ++--
>>  drivers/usb/cdns3/gadget.c | 6 ++++++
>>  2 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
>> index 0c6e14683b36..267923904a37 100644
>> --- a/drivers/usb/cdns3/core.h
>> +++ b/drivers/usb/cdns3/core.h
>> @@ -55,7 +55,7 @@ struct cdns_role_driver {
>>   * @roles: array of supported roles for this controller
>>   * @role: current role
>>   * @host_dev: the child host device pointer for cdns core
>> - * @gadget_dev: the child gadget device pointer for cdns3 core
>> + * @gadget_dev: the child gadget device pointer
>>   * @usb2_phy: pointer to USB2 PHY
>>   * @usb3_phy: pointer to USB3 PHY
>>   * @mutex: the mutex for concurrent code at driver
>> @@ -87,7 +87,7 @@ struct cdns {
>>  	struct cdns_role_driver	*roles[USB_ROLE_DEVICE + 1];
>>  	enum usb_role			role;
>>  	struct platform_device		*host_dev;
>> -	struct cdns3_device		*gadget_dev;
>> +	void				*gadget_dev;
>>  	struct phy			*usb2_phy;
>>  	struct phy			*usb3_phy;
>>  	/* mutext used in workqueue*/
>> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
>> index 26f68182e65e..f9cbc84bbfb8 100644
>> --- a/drivers/usb/cdns3/gadget.c
>> +++ b/drivers/usb/cdns3/gadget.c
>> @@ -3177,7 +3177,9 @@ static int __cdns3_gadget_init(struct cdns *cdns)
>>  static int cdns3_gadget_suspend(struct cdns *cdns, bool do_wakeup)
>>  {
>>  	struct cdns3_device *priv_dev =3D cdns->gadget_dev;
>> +	unsigned long flags;
>>
>> +	spin_lock_irqsave(&priv_dev->lock, flags);
>
>unrelated changes?

It's needed but this patch has missing removing this line from:
cdns3_suspend/cdns3_resume from core.c file.=20
It exists in patch 2 (usb: cdns3: Split core.c into cdns3-plat and core.c f=
ile).
I will correct this patch.=20

I had to move this spin_lock because in core.c we don't know the=20
cdns->gadget_dev type (void * gadget_dev).

Thanks,
Pawel Laszczak

>
>>  	cdns3_disconnect_gadget(priv_dev);
>>
>>  	priv_dev->gadget.speed =3D USB_SPEED_UNKNOWN;
>> @@ -3186,6 +3188,7 @@ static int cdns3_gadget_suspend(struct cdns *cdns,=
 bool do_wakeup)
>>
>>  	/* disable interrupt for device */
>>  	writel(0, &priv_dev->regs->usb_ien);
>> +	spin_unlock_irqrestore(&priv_dev->lock, flags);
>>
>>  	return 0;
>>  }
>> @@ -3193,11 +3196,14 @@ static int cdns3_gadget_suspend(struct cdns *cdn=
s, bool do_wakeup)
>>  static int cdns3_gadget_resume(struct cdns *cdns, bool hibernated)
>>  {
>>  	struct cdns3_device *priv_dev =3D cdns->gadget_dev;
>> +	unsigned long flags;
>>
>>  	if (!priv_dev->gadget_driver)
>>  		return 0;
>>
>> +	spin_lock_irqsave(&priv_dev->lock, flags);
>
>ditto
>
>>  	cdns3_gadget_config(priv_dev);
>> +	spin_unlock_irqrestore(&priv_dev->lock, flags);
>>
>>  	return 0;
>>  }
>> --
>> 2.17.1
>>
>
>--
>
>Thanks,
>Peter Chen
