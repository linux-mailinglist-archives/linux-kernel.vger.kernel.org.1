Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A072C84FC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgK3NVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:21:07 -0500
Received: from mail-eopbgr1390077.outbound.protection.outlook.com ([40.107.139.77]:19184
        "EHLO IND01-BO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726162AbgK3NVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:21:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fxp2UkhFL8p+8XWfc7pcL0i09p3+Lf69/YkkG0Qi05c4eQcI5W1xDXJwoqy8FDztjibanmU9UkgmDfI9JJnBVE1EYzfFaUNq6ZCWFcUHW4w7rzSjtr3MhnDMCerg7CY1trWZaLbMZuP8TcT1I6fBVRvr5WFLjko1xwG4ue4XLBf8FWUW/Lcek5ejbIw/CvFbkdQqvd9yzpbvW8nMZq9fHdAZnmL5tKaaTB+0Z4v0gTKqRgAXcUm+hnTAvyOaukU4eOFTNySB0HKg/9o9lbJcwntSj+dVOzym0FrXBn7BrnMJu7o+9QnDhF9fC1rHo6x4bRu55kuLKxNE1Lqd1aJfMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPRwZt6GqYm2jyGU2M5K4xYjiWNUjYFUMf+WjtuM35k=;
 b=baLmuMDievLGPvvxYE6+ERMp+T0lqSpgVfusy6wPNMaZNkmwM5128C5qa1Dmm0fBSB1gQvyXuBtg82w7zhhtHpWnwDkVFf4BqAgxeMwHmCooEHpXxUDNTSQmyleUeZITueOaddE2XfqKBn3cUygyXZ3Zhqc9yFNvSLbQRslA6nD5GtpxyOPcCfY1Vm9Hby31xelmBG5aINH8AXpzCzzga/3qOtcV0HTlE8Wqr2lrzIzZIMFqrNye2D8aglWDVTXzyPkw9gT1oJay4D8xqQmcTLs2wM/w+jSdZ/2dkX4zoNJdEbqxDL+8HoQL/tFMXkJIue9icupL836Xrz66Bl98Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolrdvisiondata.com; dmarc=pass action=none
 header.from=wolrdvisiondata.com; dkim=pass header.d=wolrdvisiondata.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORGFT6437635.onmicrosoft.com;
 s=selector1-NETORGFT6437635-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPRwZt6GqYm2jyGU2M5K4xYjiWNUjYFUMf+WjtuM35k=;
 b=n5UeBdPwz3rhwtDrwrHk59RRKKbkYS8wGO84MP+P2arxeJR2oP80R8QipWFJ0zaKKQZTpsFoDeRDTVBMJ+B+TY/qRsPAN7DejlSjOVVGv82+2EfilEvRqVlX/QxM7v8f3UUaXlAXNWx0nP659LOaJuAhuZ+L65k9dYQhI+hLXfgWnNw6rdkBSLgqHAhEP1ZxBzWWL+fra0aV6/I7WqJOwZYnZZ6NLIIZO7xDhnc88pyp1PWK4tRhPQJSoWtnu65pDnMu9y8sOMzaWA/5vSqPFo3MLyWWp1oGttcj6rQHZQjL/AjeHUkeCEuO762TmgwkS0OqjMj67ZMdzouuyhzu6Q==
Received: from MAXPR01MB3471.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:6f::22)
 by MA1PR0101MB1207.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:2d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.23; Mon, 30 Nov
 2020 13:20:16 +0000
Received: from MAXPR01MB3471.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::2898:2472:50ad:c3c0]) by MAXPR01MB3471.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::2898:2472:50ad:c3c0%6]) with mapi id 15.20.3611.025; Mon, 30 Nov 2020
 13:20:16 +0000
From:   brenda taylor <brenda.taylor@wolrdvisiondata.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Visitors List - Gulfood 2021
Thread-Topic: Visitors List - Gulfood 2021
Thread-Index: AdbHG4m9HVd6cWwsQUiQ1+KLxV66Xg==
Importance: high
X-Priority: 1
Sensitivity: private
Date:   Mon, 30 Nov 2020 13:20:16 +0000
Message-ID: <MAXPR01MB347153AD9D5508688505BA39EEF50@MAXPR01MB3471.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=wolrdvisiondata.com;
x-originating-ip: [103.91.180.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 318329cd-5e0e-42f1-ce01-08d89532ad6b
x-ms-traffictypediagnostic: MA1PR0101MB1207:
x-microsoft-antispam-prvs: <MA1PR0101MB12077517A12F254232A0A93DEEF50@MA1PR0101MB1207.INDPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fojn8ZCrg/iypLdC62AwC4m68olYHn4QcK2jnn6Nk2uoC7s7pHOFkehDmTjjC7XWViwPQjVpzHokPEOrmzTxV5hc/1apIysIwbcxCqeOg1lhL3PNNJD0FsOD/9bsT5B0/YCDrVRM69gAW1cNmhgblKLe9mUbfSxF24PWBMEAGLecyPeBBCSL3HDcSddvBatyJHn641ELjIjxkbcu9KSpWRSgKB1hVZ21Go76LHBN9EoBaGhW13QoYF3+pg0bPJrploT0vHIEmb68dfeSDNDqyArY2QbKqkeIHC5eZ7Hf/WM/vCcadsZ8CLAA/ljQw+xi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MAXPR01MB3471.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(39850400004)(136003)(376002)(478600001)(186003)(5660300002)(83380400001)(7696005)(2906002)(26005)(6506007)(71200400001)(8936002)(6916009)(86362001)(55016002)(76116006)(66476007)(52536014)(64756008)(316002)(8676002)(9686003)(33656002)(66556008)(66946007)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: UhW22fwlvepNOb1LTpkIHjO+JmURoSe+iZHptHbObE6uTFaMMp1wIuFfpUbNidkwxUybFBHAJup8s1/57teSkFxMbVSh0d0oKovmweXSj9hP+1fBsOkdODNPOSaqfYlc1oAjYbiPMSA4a+roUODyRmbY1ZaMlKxqMfKnlrTDOP5FX4aI1k3LeBCpCwfsuHG8orlUWW6g/2gDK/io4iAwCr0fZovphbE7eWWd+W5eXUQDGE+zqYEHyJ0/EgFfuSIf4fxYvGEKR4e0W4HFxpf/5Jw9CYCzqaahq/0f8AvaLnUUz2cA3rVD9SrVCUweA6P3a0aRzea7KasdsnPTqc/rqOoK+rXRSczb7DMtUROTFgcVybEMUSIoUR5h3c2cVc1dZX4KJziIl+yvUahCLSvy7kCUN1JWkWDLcuZRtAnfkcA8AwYcUUM42KcXu0Vo3grftNPKC+clHTplzZT/2AX3WxvrSWeRj22YeV3g7VoWzhT9AMql5RqypmIZdiXMG8qy5rTBz5DjxpKZCAeRk4vH3W8HyvBkp//tU+QmQWm57yuzon8Kl1+K5+QzgIlvyxLseXxj91mIEmW0yQFmxZnzXAPOMyMr5z2Ic9qNPUIM4h6RhZt70/+1hDbcqzu4K5EduR3gsUbfeeqTC5gEW2WKcmK74Mrk5dlmD2e+pZxS0IzLDC/hPA7DZqVM4DazmC9mTA42su+axmmpI5f86g+8Gnrxc9z7kpKCp/MSAp6uSlU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wolrdvisiondata.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MAXPR01MB3471.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 318329cd-5e0e-42f1-ce01-08d89532ad6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 13:20:16.2302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 446afebd-6727-459a-9f99-49f9f43d6b11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gGLgNj69pbTl4xLCScifyj1/qwWXGXoVq168rq4/cVdvgLlHNcOHb8xWcs6OW3Ef0o81pIJ6oxVlxTWJCp1AneswLTl0Hmhe3WiPBj7hzx+9w+/992SXmJjX2vX/eZJF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA1PR0101MB1207
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings,

Hope this email finds you well.

I do see you were exhibiting at Gulfood 2021 (International Trade Show For =
Food And Beverage, Grocery, Bakery, Cafe, Supermarket and Restaurant) and w=
as wondering if you would be Interested in acquire Attendee Companies List =
for your business needs.
We have the most updated records of past/current Attendee Companies who are=
 participating in these events.

Information Provided: Company name, URL, Contact name, Job title, number, f=
ax number, physical address, Company size, Email address etc.

Date    :  21 - 25 Feb 2021
Venue :  Dubai, UAE

Our list is the best source for awareness and can be used for Booth Invites=
 -Industry initiatives - Product launch - Brand awareness - increase in rev=
enue etc.

We also provide customized lists as per your target audience.=20

Kindly confirm and let me know if I can share Proposal for your approval.

Many thanks,
Brenda Taylor
B2B investigation & Tradeshow Specialist
=20
If you're not interested kindly reply with the subject line "Opt-Out.


