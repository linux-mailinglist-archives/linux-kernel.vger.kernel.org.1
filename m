Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6292D38E5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 03:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgLIClS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 21:41:18 -0500
Received: from mail-am6eur05on2084.outbound.protection.outlook.com ([40.107.22.84]:57189
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725283AbgLIClS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 21:41:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEDhdMKErHNRrWreT4RXjjgJVffpOyaaLLgRyMQT08WIQmvgtFeX8n7L9Cag+EzWMyOdrbGBK0ow76nZ9sp3kFTckz7OfPPGA3AFkXpDzL0WUw8ds0hTYVKqAhlbDZoN/s/4pq8Z8uxK8iKHIr8Er4RAnDdVk1LCrqG8TLsIGt4xS1zguF1m/vmu8IYzhGK7l12bX+h+/yU5f/t7zTs+NQ67pOHWNr875FOHOcLH1a9F4XMe55gOWUfCuwygE2b9/SOc+78SxzJwRnfgzutPPUXtmJEUrwoxeyMkXtMuvD8Yv8EpSBUGKXKqWQxKQA+l/8SQt7ORqtUO6iRBWdYbEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDEJM/T8ODn12NbYgr9fl8BAeXmGMe+ID5TR6cMNDUA=;
 b=cY/NpXy6trAYgYBmarHEL4U2XRoDFG85FNBOAbanCENV6Lsvpg8k2o6mJ8FqQwFG9MC+GeqTo5DDa1O3k1mhQ/QAxoIRxv6B31FPnyomO+jpiWOf4ctxzxG6XzIB3AK8dK84575PXzi1WTor34oJIu6s/x2/OGyK7l99zxdTVkZOTokY+Cpmqzzj9hqeUdIrwUtXfkLoXqPmyHsnykcGnVIuxqb3X6IS5LDhSzT9HnPlDz4vLY2Yv8uHHt2XbpMgTmOOU8zqRJHjU+O6HmEkCE4/2Xh/E4L+OJIfSjAtg7fpO5OwlGqwPqm6fzfHuxkRhPoJ/CcrrO0GIAMVcQRczA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDEJM/T8ODn12NbYgr9fl8BAeXmGMe+ID5TR6cMNDUA=;
 b=mJcTify98Cx+auC77py6AcEFfmxHWzkqcDrGagrkyLBhWSUly+z88udqASX/0bBxF3EtqHaDTPkB7xRtyy4XqDHANknjBhvmRYFe93/DW0xvOjLX/pbe9O9C2b/HyB+EE/77WSH6egu1aDdU6yvHPIUH2dxdesgufWeLsxaDyZs=
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9)
 by DB6PR0402MB2758.eurprd04.prod.outlook.com (2603:10a6:4:96::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Wed, 9 Dec
 2020 02:40:28 +0000
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c]) by DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c%5]) with mapi id 15.20.3632.023; Wed, 9 Dec 2020
 02:40:28 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Zou Wei <zou_wei@huawei.com>
CC:     "pawell@cadence.com" <pawell@cadence.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] usb: cdnsp: Mark cdnsp_gadget_ops with static
 keyword
Thread-Topic: [PATCH -next] usb: cdnsp: Mark cdnsp_gadget_ops with static
 keyword
Thread-Index: AQHWzVyuwhB38e6st02GMKSdkSAp5anuDnKA
Date:   Wed, 9 Dec 2020 02:40:28 +0000
Message-ID: <20201209023958.GB995@b29397-desktop>
References: <1607430649-116383-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1607430649-116383-1-git-send-email-zou_wei@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b07f78f2-f8ff-4176-c2d3-08d89bebca4a
x-ms-traffictypediagnostic: DB6PR0402MB2758:
x-microsoft-antispam-prvs: <DB6PR0402MB27588ABA67EBBFB2D17D6A748BCC0@DB6PR0402MB2758.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wcevAvUDR8OJjiIEJEWzg2Sk0J7O4bp3CfP3KWgpyFtUt7sypel9sBiGJBzO811GrafeQCvwQQHx5jFxSu+aE6Fsu1hyH3KTPyGSI8n3Iz/nl16Uei/MLf3npitZxxIMWV5GK58EnWlPWl0RjNGH0rcNeyTfYXGliBcypF5SbyDa+BfHvQbxbjQN9sv6sObMCEuMGckGWPRpLps7jVH3TxS7SdjzDDSkeu+5bd/Y0Jy/5wsjOR3La7/vLqQo1dfC/Y1sTnXL+a85pojF50SqFWZi+DoO7T+kq4lqvHZWFUCLMbYv+llxtbzSs/gYyZ0iRzMeLY2VsSZ73rN5aWWGWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7979.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(346002)(136003)(376002)(2906002)(4326008)(8676002)(33716001)(26005)(83380400001)(6916009)(1076003)(33656002)(508600001)(71200400001)(44832011)(9686003)(53546011)(6506007)(86362001)(6512007)(6486002)(54906003)(186003)(4744005)(8936002)(91956017)(66446008)(64756008)(76116006)(66946007)(66476007)(66556008)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?lWrGzY2jF8jwdQ8s9/bL4qpVp9bFc7UJ+5cpBh9Fgkm+SHcdRMmi5VWqail2?=
 =?us-ascii?Q?2gV+K0fEoMHLKaJetRdI1KR1Be1mTZTf6Mat7hq1cQntcibGCDf/X8qXngMk?=
 =?us-ascii?Q?E5LaQH9QpIKs22CBqxTNDwQHygg+/incXO3o034wzYSpAAs+EnKYMzWjRJeq?=
 =?us-ascii?Q?m7LxO9nLtQUl1HOIX2dTKufFBU6BwLFREKrqtX6p+z6p217fidOrUm1eJ6Ty?=
 =?us-ascii?Q?UIdrrIvp/QC1k3dVjK+IiqeD5QEs6FlQxNtSbC0oGTdwsYk7PGOOivUvomTt?=
 =?us-ascii?Q?IbI8i1f1GpAaW8COV14VRGsg5vEGiU4uFiDY+xAZbBXhdPWtbU9puu7cVgWp?=
 =?us-ascii?Q?gLa0DF2lPkcfPeXqR8CgYabBiwpX1yxOXjMc/GkoXs+6ngJARFb/vymWVB9h?=
 =?us-ascii?Q?QmL3tFCrbV3IlNzqJEtto7EbLFFK32vjUrG6kBaVbiOBxPkxEMWvoWM6RrKZ?=
 =?us-ascii?Q?8GvnvaAxO6ECSJhIWnjDQj2CwAT3OpOdbbpCLfiroNyX3qB2rGKUXy0VtYm3?=
 =?us-ascii?Q?TNb0R+baxibjsNssz8Oo3qYSaPChiis6eAq757x0yrXjxdna+AqvROYZ0KV0?=
 =?us-ascii?Q?akXeMHDIB9DV1NJ4mEEkGdvbmWYGYCXAG5HkoMcTnDeG8DCba0k1c8mfIxDX?=
 =?us-ascii?Q?xhwnaHNLrLJcZboSDu9LIsjKMq0feMcBkLokcak4nmowosTHgDLO90Xn4sox?=
 =?us-ascii?Q?SauZ5CEdxrkTNosVioHdIWPQtyHa5HDz/Q52stChJrNjke7y/ZDTHeKZhtwk?=
 =?us-ascii?Q?151I8D3qQptLvEe7s8yFCB+I6FZCXc6Hk1Uke+05NXx0BWen9/HUh4A+1n6j?=
 =?us-ascii?Q?Cu8rFseIUi0vLwbDMCc83yeX/NDc1m2VBnFWh/gLNq3MnwSgzrMsTSvMXoSX?=
 =?us-ascii?Q?eJDmxzZ/O3FNcZ1sPskmTcqVhOqDV1z8f3l8p9PASwnRQQLrOQVPONbrLSkY?=
 =?us-ascii?Q?AzhdLi/jrTgxrH0XzyaOfASnZLuZhm6KrPotiw4OH2WzX9ilm6w+XY2RmwmH?=
 =?us-ascii?Q?2xU/?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B8344A71C7110447AC89B34304F6E489@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7979.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b07f78f2-f8ff-4176-c2d3-08d89bebca4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 02:40:28.5078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q9EAPnaZg+QGrg4lmRUXt26Z98QZwsOVztBP2RYmstesBwm577bUb1vU7mCH3b+y0NI495wrsdQ3V3TmjnLFHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2758
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-12-08 20:30:49, Zou Wei wrote:
> Fix the following sparse warning:
>=20
> drivers/usb/cdns3/cdnsp-gadget.c:1546:29: warning: symbol 'cdnsp_gadget_o=
ps' was not declared. Should it be static?
>=20
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/usb/cdns3/cdnsp-gadget.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-g=
adget.c
> index 9716273..c7c5d0a 100644
> --- a/drivers/usb/cdns3/cdnsp-gadget.c
> +++ b/drivers/usb/cdns3/cdnsp-gadget.c
> @@ -1543,7 +1543,7 @@ static int cdnsp_gadget_pullup(struct usb_gadget *g=
adget, int is_on)
>  	return 0;
>  }
> =20
> -const struct usb_gadget_ops cdnsp_gadget_ops =3D {
> +static const struct usb_gadget_ops cdnsp_gadget_ops =3D {
>  	.get_frame		=3D cdnsp_gadget_get_frame,
>  	.wakeup			=3D cdnsp_gadget_wakeup,
>  	.set_selfpowered	=3D cdnsp_gadget_set_selfpowered,
> --=20

Applied, thanks.

--=20

Thanks,
Peter Chen=
