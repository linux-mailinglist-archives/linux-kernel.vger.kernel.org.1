Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3914528304F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 08:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbgJEGRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 02:17:08 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:23086 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725267AbgJEGRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 02:17:07 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0956D3dK008789;
        Sun, 4 Oct 2020 23:15:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=e/uOfn+j0zb0BlZnQntb06LJ2ArGRYhAmciRScfcSOM=;
 b=cACaaQLn0qBn9vaSMAvIxKqqr9jK7CUhDflM/6kTaYs2szba82WtRv81Jl8Cn+TcEmZe
 lP8uy8RJlh7I67XUd6YCSDKhpGgWpkzqjV1vvfva9eO+eBv3H4+egddkOuCeSmKBFoHx
 /4V/rJJn9zhrVZHCZA5hSp0TAp+RQgT3bFxCR+NDVdCyPqrGL3ihoWHLCiWBmLXv/bV+
 lQwQwsEjYjOrGvawBAJyW1txk9EvMrPJyG7gyr8KWXaaHyLtlKxxyT6lGQ5BiVHvUl4w
 ad7juHyRBRcTMlPgDox0ZAwefgez6CeuF7LmlXr7Slg5owX1jFNdkeFrXzxMxx1rGpyM 6Q== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0a-0014ca01.pphosted.com with ESMTP id 33xnuxc7ke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Oct 2020 23:15:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zd8RG0mqiC3v2ls82wK5L3G/WDcD/LQzVPXq/ppasSt9Zn0OZYDrw9IdFMMhHXpVk4AVmbWsxz5nZcMrdciLjvq2PnXqTXqmwjDfuYARG+fv4YpcApGPE/Y4Co+xNVAusPth5ybpSgVCukK6OrplmbYUmmuZTgXdG1Z//DBEecSEROAaXrq0iWS+mo5zvIEWIE8gYKiw34bjv1WcKquyZNOfUvcwg57cH613bRk/rKENv053h7mhMKxWd5/Pxl8pu0g4O9GODBVTh6rR8n7oSS2g9y+b0UJHSs//xoZKmGWObWpj4IRVcyAEucA+eV9EVtn6UAHGxFBEzHa8b5AAwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/uOfn+j0zb0BlZnQntb06LJ2ArGRYhAmciRScfcSOM=;
 b=HVFD5y9gqjhjJ8kY5X7Pv7wLtAh9WQ3u2NlxvBCYA8hjl1qOwcpAKObXB9aqsq3F5BIQGjARn2EYZ1K4G5ml9TNZPtWbWqZw6JopmJ7E8FIu3O+B0fwyGhYHuaEmP/648XLDaNPbslrCMnFmA7mknt2CuaahPgz9EHju//aceV2tHXrB2epd0nvqzyCIi7jRGSMBmyTJbuTYJmwy+dbWTLbJ2CN7MzDl78iJp5ACa04uQ6abh8nwFMB71X7yA7+fEc4gJV7ffELTiz046+FMkw3Q2eqBUdRqkdFb4U8Hi1Y2hGr7dn04GNj6XPv+0V8AMQ1QuzC3BFuXw2RavQTHAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/uOfn+j0zb0BlZnQntb06LJ2ArGRYhAmciRScfcSOM=;
 b=tBK0I36aOrKpz0ddsdIipTL5czS2guO8FWgV1FlhQz0JwJ66pm2Zxrjit+MpbWL1Jf8BRz3XnvlyIN6l0QDpeONKLqasR1T/+h5Rlqs2ToYr66g1jD8AohZ+KpUZgGFBBLdMPv6ufLMCun2wEN8Ti3NNQ+H1Etqh9dB08vPbjA0=
Received: from DM6PR07MB5529.namprd07.prod.outlook.com (2603:10b6:5:7a::30) by
 DM6PR07MB7243.namprd07.prod.outlook.com (2603:10b6:5:217::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.38; Mon, 5 Oct 2020 06:15:33 +0000
Received: from DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::2087:7f2b:5dc6:a960]) by DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::2087:7f2b:5dc6:a960%6]) with mapi id 15.20.3433.044; Mon, 5 Oct 2020
 06:15:33 +0000
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
Thread-Index: AQHWlZOWAZZyZIyAvEqOj9uQKqZ+Val/CPYAgAMhoZCABmbWgA==
Date:   Mon, 5 Oct 2020 06:15:33 +0000
Message-ID: <DM6PR07MB5529DD806756B5EB36A2B6B4DD0C0@DM6PR07MB5529.namprd07.prod.outlook.com>
References: <20200928122741.17884-1-pawell@cadence.com>
 <20200928122741.17884-6-pawell@cadence.com>
 <20200929043508.GC9076@b29397-desktop>
 <DM6PR07MB55293E7DAC48DBB3000AE6EEDD300@DM6PR07MB5529.namprd07.prod.outlook.com>
In-Reply-To: <DM6PR07MB55293E7DAC48DBB3000AE6EEDD300@DM6PR07MB5529.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMmI5NDMwYzYtMDZkMi0xMWViLTg3NmItMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDJiOTQzMGM3LTA2ZDItMTFlYi04NzZiLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMzU2OCIgdD0iMTMyNDYzNTIxMzE5NTUxNzk0IiBoPSJIZnZ6bEE3YWpWc1RadHVJUVlsL2NsaHM3MFU9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c61d9ee-2e94-4ef0-ff7c-08d868f6119b
x-ms-traffictypediagnostic: DM6PR07MB7243:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR07MB72435CE5D477A150D0972586DD0C0@DM6PR07MB7243.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RHUjG5NsaLAfmsuNiiuOKuSw10I+t5AC5ShhnmVciLc+S1gWUuZk3azSG+kDWRfVSbogRV5CNZ2HNDDF3+xuSw1ahz26gavUyQb+GKzIGUXCI5aV5nOhmLNAqygRhtBviLyeiLc3Zo9gJ9ooFX++1uaousKaxdGuVnUClPlrvoTiPlyFX7ZnvBYGg/LWC0aN+TnVvK5kFNITSBsUr94l3WxwwNvXGdnpRzaX5AJwdx7SON4OQRQXwcitY2TX+RLbiyCBZbUS9uqGIgjhWxfxYc7saoGbxbr6asTjRk8hpq1V1CM8G1Dkj3zAC/kpB9+AU9kdPoUaIWvauZa6GKrGXYpRE0RDLtcS12hXrexYbM4P/Y4ZNHDRl+yDBLPmkQvl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB5529.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(36092001)(33656002)(186003)(7696005)(478600001)(26005)(64756008)(8676002)(66446008)(7416002)(6916009)(6506007)(54906003)(316002)(2906002)(66476007)(4326008)(55016002)(8936002)(66556008)(76116006)(9686003)(66946007)(5660300002)(83380400001)(52536014)(71200400001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: jFRaJWxHqLlBFcDQVzPehNyeuIy9ZL3N4G1Jp/S3VJLnpvJ0kxPeNfKu21uGJ5ouxYOWHipZ8RzvfPn1WLUHdiBE0jWpFT2l31QoJym1shgO8bq7r8OEe24pWDqhB5whtjmBVp6M/wv8f2TI3ejU0o74AgV06AFryZOF8h5GUWDDDRUDBraahurHURZRP4DecnOykmIYsXOFXaKk6jDrCPixgCVUaI/A1RhbYBHkcwM4kMaruXjI1e/EXpN62jYWOkTi4IDqlG3LsCjQbrbqmXFSmN0FlR4mpiPQ2FQwMLFCm7pmPNIkyRS4E0HG6QKm4npmwJLHxLKa+EOYo0M9VN3qNX5tzOdo7j7ibrJEnynNaPNo1rSOJXLFHeUBLTvDZt3zjrM4SvPdeQkh/Y4T0AHcT0cWVoWXvjj4rsWU0IVba1FM/DqXfGMnUgX+M9VpePH6S3m2FRnOKuZ+Y2XSZ8DGX+WU0SQMaeaaHJrcIXUC+QDteN/cn9m5zMoEUXp25HkXdFHI66QsN+6GlPIYLKxEF06g+KfgmXIciySESVhcxDYNhA+TjtT55r0DxSvIPmi4azmQl43aLw0iEXG6lEO+lIcCnXVZ1Pi550gytaQUqQWf2Jhp0YMM9bgXyFvXLL+rpSFWGDPa7X1jaHQWuQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB5529.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c61d9ee-2e94-4ef0-ff7c-08d868f6119b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2020 06:15:33.8235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pEdbwlNgu2j+ATEckLxswTU/iiCiMXYyvN4eLFwtgz4Ud13KZ4Yt2DSg8hvRlZqUPzw1mPOoOo0q9gvT69gB/SqJkF0HxzGqDxZulJZJ30o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB7243
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-05_04:2020-10-02,2020-10-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 mlxscore=0 mlxlogscore=834 priorityscore=1501 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010050049
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>>On 20-09-28 14:27:38, Pawel Laszczak wrote:
>>> Patch changes the type for gadget_dev pointer in cdns structure from
>>> pointer to cdns3_device structure to void pointer.
>>> This filed is in reusable code and after this change it will be used to
>>> point to both cdns3_device or cdnsp_device objects.
>>>
>>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>>> ---
>>>  drivers/usb/cdns3/core.h   | 4 ++--
>>>  drivers/usb/cdns3/gadget.c | 6 ++++++
>>>  2 files changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
>>> index 0c6e14683b36..267923904a37 100644
>>> --- a/drivers/usb/cdns3/core.h
>>> +++ b/drivers/usb/cdns3/core.h
>>> @@ -55,7 +55,7 @@ struct cdns_role_driver {
>>>   * @roles: array of supported roles for this controller
>>>   * @role: current role
>>>   * @host_dev: the child host device pointer for cdns core
>>> - * @gadget_dev: the child gadget device pointer for cdns3 core
>>> + * @gadget_dev: the child gadget device pointer
>>>   * @usb2_phy: pointer to USB2 PHY
>>>   * @usb3_phy: pointer to USB3 PHY
>>>   * @mutex: the mutex for concurrent code at driver
>>> @@ -87,7 +87,7 @@ struct cdns {
>>>  	struct cdns_role_driver	*roles[USB_ROLE_DEVICE + 1];
>>>  	enum usb_role			role;
>>>  	struct platform_device		*host_dev;
>>> -	struct cdns3_device		*gadget_dev;
>>> +	void				*gadget_dev;
>>>  	struct phy			*usb2_phy;
>>>  	struct phy			*usb3_phy;
>>>  	/* mutext used in workqueue*/
>>> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
>>> index 26f68182e65e..f9cbc84bbfb8 100644
>>> --- a/drivers/usb/cdns3/gadget.c
>>> +++ b/drivers/usb/cdns3/gadget.c
>>> @@ -3177,7 +3177,9 @@ static int __cdns3_gadget_init(struct cdns *cdns)
>>>  static int cdns3_gadget_suspend(struct cdns *cdns, bool do_wakeup)
>>>  {
>>>  	struct cdns3_device *priv_dev =3D cdns->gadget_dev;
>>> +	unsigned long flags;
>>>
>>> +	spin_lock_irqsave(&priv_dev->lock, flags);
>>
>>unrelated changes?
>
>It's needed but this patch has missing removing this line from:
>cdns3_suspend/cdns3_resume from core.c file.
>It exists in patch 2 (usb: cdns3: Split core.c into cdns3-plat and core.c =
file).
>I will correct this patch.
>
>I had to move this spin_lock because in core.c we don't know the
>cdns->gadget_dev type (void * gadget_dev).
>

You have right, after merging  the latest patches from Felipe=20
repository this changes are not need.

Regards,
Pawel,

>
>>
>>>  	cdns3_disconnect_gadget(priv_dev);
>>>
>>>  	priv_dev->gadget.speed =3D USB_SPEED_UNKNOWN;
>>> @@ -3186,6 +3188,7 @@ static int cdns3_gadget_suspend(struct cdns *cdns=
, bool do_wakeup)
>>>
>>>  	/* disable interrupt for device */
>>>  	writel(0, &priv_dev->regs->usb_ien);
>>> +	spin_unlock_irqrestore(&priv_dev->lock, flags);
>>>
>>>  	return 0;
>>>  }
>>> @@ -3193,11 +3196,14 @@ static int cdns3_gadget_suspend(struct cdns *cd=
ns, bool do_wakeup)
>>>  static int cdns3_gadget_resume(struct cdns *cdns, bool hibernated)
>>>  {
>>>  	struct cdns3_device *priv_dev =3D cdns->gadget_dev;
>>> +	unsigned long flags;
>>>
>>>  	if (!priv_dev->gadget_driver)
>>>  		return 0;
>>>
>>> +	spin_lock_irqsave(&priv_dev->lock, flags);
>>
>>ditto
>>
>>>  	cdns3_gadget_config(priv_dev);
>>> +	spin_unlock_irqrestore(&priv_dev->lock, flags);
>>>
>>>  	return 0;
>>>  }
>>> --
>>> 2.17.1
>>>
>>
>>--
>>
>>Thanks,
>>Peter Chen
