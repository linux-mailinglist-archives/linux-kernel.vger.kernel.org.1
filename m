Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4110F29E537
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731649AbgJ2HzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:55:19 -0400
Received: from mail-eopbgr1300055.outbound.protection.outlook.com ([40.107.130.55]:1760
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729655AbgJ2Hww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:52:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPsvWxaCMpNbDwufzOeSsaeOHjj9vDP/eH7QK8RwXc9bfTbQfnGW3ywYqAo/pj2Qd9B3SPze0thMoTuM0rreHFQBjM9xtLae/i0jmxHk9ds1srUh5w+GlnU1mK/uSfyWjyKcrLwwl8LGEhUpC+0Ph54PJKMYDM39Xw8+MUDU50EQTAaT5gXlD1IwqRCJgjmj5/qSZQWDwXHkR/6tBUf7BAA1qr4PHuLtrvNabMY+hRNiRtM2lh2C2gcp8Wztcx3lBwcGztQyn8rutUC+aFXOuWbxaQxD0g3Qg1Vc8/7z+rnpH5WC++ffjMRC+WuaXPy0mpjXcBdj10odaM3AG79IuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpeWBo5NgAxfOmlH8/BKOazO7ebAkeaVStbH+PQ2SZY=;
 b=gNyeWcd8cabUMS7F7M4lIbwNcfZx6UQ5++6KzUY4RTprtjwA0kd6YW1QnD8LQy8YjU3GIO8Av1R7QNld9bCPtcsI3Zca6R3PpnIeKRBgU/+d4PXkmPO30tLn0J8U0lkXmurMBk2u/ROCYT5g94cp+Ihv/qtGwECJc5MTOkGEf7ZkLJu3rWylTCn0SXFQrASkPONzNvHfmzborOkNnxWeGrzdTkGR/qXOWAjOb+EMq1tvhphCgZnK3w7hoHEUU/1Tz7TKE8/pKq+QOu711o5lsD7AWwClepGM0H3G/k44J3qF+V+JU0tWttQAhIgrSjkgu0/YOE12nU1Ozuh5al0c6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ssstc.com; dmarc=pass action=none header.from=ssstc.com;
 dkim=pass header.d=ssstc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ssstc.onmicrosoft.com;
 s=selector1-ssstc-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpeWBo5NgAxfOmlH8/BKOazO7ebAkeaVStbH+PQ2SZY=;
 b=JqBMP35qiLdpBdSGI7fUKqdLeKAcCQ/VkGXxxZJ3iJJWx9L0Y8Z+Hz0EiCjyW870ZdoZ9+MJ1G+369w/AUkiZdmKgqlIgWg1OR7m/dCIprHvPCVpIPOhdQUA4f/2Gqdscu4tZOB0I7bHvd6uQ/XDMn52FbdwSGLUH9bypvX4bjM=
Received: from HK2PR02MB4004.apcprd02.prod.outlook.com (2603:1096:202:22::15)
 by HK0PR02MB2659.apcprd02.prod.outlook.com (2603:1096:203:37::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Thu, 29 Oct
 2020 03:21:27 +0000
Received: from HK2PR02MB4004.apcprd02.prod.outlook.com
 ([fe80::e10b:73fd:962e:1968]) by HK2PR02MB4004.apcprd02.prod.outlook.com
 ([fe80::e10b:73fd:962e:1968%7]) with mapi id 15.20.3477.034; Thu, 29 Oct 2020
 03:21:27 +0000
From:   Gloria Tsai <Gloria.Tsai@ssstc.com>
To:     Keith Busch <kbusch@kernel.org>
CC:     Jongpil Jung <jongpuls@gmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Jens Axboe <axboe@fb.com>,
        "dj54.sohn@samsung.com" <dj54.sohn@samsung.com>,
        "jongpil19.jung@samsung.com" <jongpil19.jung@samsung.com>,
        "jongheony.kim@samsung.com" <jongheony.kim@samsung.com>,
        Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH V3 1/1] nvme: Add quirk for LiteON CL1 devices running FW
 220TQ,22001
Thread-Topic: [PATCH V3 1/1] nvme: Add quirk for LiteON CL1 devices running FW
 220TQ,22001
Thread-Index: AQHWrQrF3kKZ6Iwnv0+X+dwLEwfIxqmtQlQAgACXJlCAAAQaAIAAC86AgAABWuA=
Date:   Thu, 29 Oct 2020 03:21:27 +0000
Message-ID: <HK2PR02MB4004E96D4FEF0589232CF694EE140@HK2PR02MB4004.apcprd02.prod.outlook.com>
References: <20201028091421.GA667673@image-900X5T-900X5U>
 <20201028171726.GA9897@lst.de>
 <HK2PR02MB4004EC30D14A16B59FD22A44EE140@HK2PR02MB4004.apcprd02.prod.outlook.com>
 <20201029023306.GB20928@redsun51.ssa.fujisawa.hgst.com>
 <20201029031521.GC20928@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20201029031521.GC20928@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_70000674-648a-490a-aff3-4c9f8463df7a_Enabled=True;
 MSIP_Label_70000674-648a-490a-aff3-4c9f8463df7a_SiteId=5715baf5-0afd-4dc3-a35d-166593a054fb;
 MSIP_Label_70000674-648a-490a-aff3-4c9f8463df7a_Owner=Gloria.Tsai@ssstc.com;
 MSIP_Label_70000674-648a-490a-aff3-4c9f8463df7a_SetDate=2020-10-29T03:20:58.2594447Z;
 MSIP_Label_70000674-648a-490a-aff3-4c9f8463df7a_Name=Public;
 MSIP_Label_70000674-648a-490a-aff3-4c9f8463df7a_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_70000674-648a-490a-aff3-4c9f8463df7a_ActionId=057d77f0-f413-41a2-b7fe-bbe9eabb9a5d;
 MSIP_Label_70000674-648a-490a-aff3-4c9f8463df7a_Extended_MSFT_Method=Manual
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=ssstc.com;
x-originating-ip: [124.219.110.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: caa724b1-7d70-49cd-8094-08d87bb9b906
x-ms-traffictypediagnostic: HK0PR02MB2659:
x-microsoft-antispam-prvs: <HK0PR02MB2659AF6B16267CF81D1FC258EE140@HK0PR02MB2659.apcprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZDH8fuqtby8V4brzlwtAjvvB/1L5Hs1/eFr4tkL8KDnsB9Ilc9vdULY/YtPP7S+gC1k3IYH0qLg0RptL5NItWvs8Zc+4oXOmLhHf5aY/JROo8wqsx3G+H6KPFalcUBC8nNC9NQwwqPYhh3Y625m97soh94AHO31580T/PCjUkmVB9UhOqGMk+VAIw8A0oIsccYNM9K2BO1hrxml2WpgHBW/iDQH6qanPToPuL73BxiSOFis1tIjeB7iGZjLMpYroH1sUlD2ZWKrRU8ClSZufnu/oKNmcg53qaXLsB6tntUJL90NgJc5CPDH0zB2mw1IhB0jU7zX8XyFdfEyp/KfVmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR02MB4004.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(366004)(39840400004)(396003)(86362001)(8676002)(83380400001)(478600001)(71200400001)(7416002)(55016002)(7696005)(6916009)(66476007)(33656002)(66946007)(64756008)(66556008)(186003)(316002)(2906002)(6506007)(54906003)(9686003)(4326008)(76116006)(26005)(8936002)(5660300002)(55236004)(66446008)(53546011)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: hddDyKMi4mT9NvcjSlFinQfu9vjpAVgjSlFCy6kqXkeBNmGZN93gO4mqvLqvwJsqeZimIsGCvMkHoxHmHW4IHpTsjMZMzUZOkf/RMMLJBVDfHOPDIz4dtjOAXRJFfwo0BEbb+bTsaGmWZE74dg9VdnwqqRVAA9o/n6eEAFDjsOTUCL5PWVykBXFe88ubBGo4E/TcSACj5ERYybKHWJLBDlUz9dR26I/XeWHpk3QDA2lRx/9D0SzWRoKsJK0I8trgSmKjiFZ3J5YQTZ7RmzrdTj4n5GvyYh8ad63lkfKdlCdzuC5ttueotIkVxv2khzCQ4//9B8vecUNXlmgfuRanrRbNoHt4GmoCoTCc5yX3lRqpOBAx/EITuHBWXAA4LrUFrs8T0i4J1gQXu6gnUkbj37NMBweT5cYmnU5h3TmsorM/cZrxEYuJUUKraqcVRk3oCgmC3JSJUvh93EgBTArKr3HRsk1EEyx4PrNoFVKkA3Ckp1Pz6mcC6o5QQTlqCrr+IyFltFg3jH93OxDw+3croVFAl+jK187LtEmKxJrMwY+zyCoOq/3F5k5hi0HCFYmDjlzrfBo7ImTqGHjWuN2n7MBAlmHJ8GPlpmva+FW/AEVZWtDM54M/RP9xxlVPeuYM1zX+e/0pmVKemloKxiCnjw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ssstc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR02MB4004.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caa724b1-7d70-49cd-8094-08d87bb9b906
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2020 03:21:27.5802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5715baf5-0afd-4dc3-a35d-166593a054fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: muElmKMhNWQF1JpS4obxoI8bpxIxkRMb7gRP7P8LTGe2O1HXToTFZ+g6psnzaM3PMeVSjO9zyqK8NGM6wht5Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR02MB2659
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct, it's device SRAM.


Regards,
Gloria Tsai
_____________________________________

Sales PM Division
Solid State Storage Technology Corporation
TEL: +886-3-612-3888 ext. 2201
E-Mail: gloria.tsai@ssstc.com
_____________________________________

-----Original Message-----
From: Keith Busch <kbusch@kernel.org>=20
Sent: Thursday, October 29, 2020 11:15 AM
To: Gloria Tsai <Gloria.Tsai@ssstc.com>
Cc: Jongpil Jung <jongpuls@gmail.com>; Sagi Grimberg <sagi@grimberg.me>; li=
nux-kernel@vger.kernel.org; linux-nvme@lists.infradead.org; Jens Axboe <axb=
oe@fb.com>; dj54.sohn@samsung.com; jongpil19.jung@samsung.com; jongheony.ki=
m@samsung.com; Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 1/1] nvme: Add quirk for LiteON CL1 devices running =
FW 220TQ,22001



This message was sent from outside of the company. Please do not click link=
s or open attachments unless you recognize the source of this email and kno=
w the content is safe.


On Thu, Oct 29, 2020 at 11:33:06AM +0900, Keith Busch wrote:
> On Thu, Oct 29, 2020 at 02:20:27AM +0000, Gloria Tsai wrote:
> > Corrected the description of this bug that SSD will not do GC after rec=
eiving shutdown cmd.
> > Do GC before shutdown -> delete IO Q -> shutdown from host ->=20
> > breakup GC -> D3hot -> enter PS4 -> have a chance swap block -> use=20
> > wrong pointer on device SRAM -> over program
>
> What do you mean by "wrong pointer"? At the place in the sequence=20
> you're referring to, the PCI BME is disabled: you can't access *any*=20
> host RAM, so there's no "correct" pointer either.

Re-reading your message, I do see you said "device" rather than "host", so =
my response may not be relevant.
