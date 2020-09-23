Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2F1275244
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 09:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgIWHYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 03:24:55 -0400
Received: from mail-eopbgr1410052.outbound.protection.outlook.com ([40.107.141.52]:59296
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726557AbgIWHYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 03:24:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ToxS4aGTUh7T01o197mJxn7Y8XnnD1wj9TXDv5XD5aXd07yzwQ3/gklEO1sTzaEWpk2+uZ89oP378uC8BBzQggmGo5qaZLKGndyKh4SPlN4DFsbjmVZh9DXakl4QRzvqhBNfE+aUIn6yLzdRfYmKP+pEXkNwRW/E2mLTfMckJ5l92oVtGvl1TJCgvB+yC6l3QIvRsIa8M7homeI2Joatdl5MY2bFFXaJcyfvPoLPjsydrB4IFRrLSO78oFg4Bt14vgjZgz5XlzTqffrqsqihznoTAVDSSK2wUm16F3gflVT4mVbve9qS/GQT/VPeAzyqYxfuFNwai/31M+efpGfvvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DO2jKW+8ck5O2VRZao0xtYaUfn9+n8w4mp1Q5YDSL6s=;
 b=hTvitpIfjHV8L5RaG/ZeGy3VYbCdYCuaeOF8ZnzZ6Tkw2M5Jnbgv2C6590lBLRdWC/atztYnw9T5CSKVl9SDWuejxc4iAX1H4r8yRvXQiwqiz8axbFP8BjKyLF1JDlzo5pTOQ4VWfU7ufu0qGLwXkZtCcnuW1vQc1vjjj6LiO2Tx7QuqnkSFMjLo0Hii+YcaMy62PABAzzDu1izj9NAOc2w4NuoZCvCTqiBHmPlFIx2N1QR+ndjGa2l9h3L4wr6uNr2Wb/ehkYOICbrRkAEA/5uW3qZJe3hs195NU44uBNZ3UmN4xKU1LcUimPvRkFdHlRone9WDrAmg9g+k0Qfksw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DO2jKW+8ck5O2VRZao0xtYaUfn9+n8w4mp1Q5YDSL6s=;
 b=WEIxmOzVkUqoNrKY/3g+nR5RiVU82apBcyJYTH6TNELufVun+BRMfucwN3ImhxCpOpIL6Y/3uup4/4wJRuCTp9X0ob+nvJYdkJJU90EdlmwZAwYZjAcn8qXNcw/tShJcsNfVOFbCbENvKQXUXJDpvcgMYsOKGEIW61XiX+FiDXI=
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com (2603:1096:404:74::14)
 by TYBPR01MB5357.jpnprd01.prod.outlook.com (2603:1096:404:801f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Wed, 23 Sep
 2020 07:24:53 +0000
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::108f:629c:d934:9206]) by TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::108f:629c:d934:9206%7]) with mapi id 15.20.3412.020; Wed, 23 Sep 2020
 07:24:53 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Oscar Salvador <osalvador@suse.de>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "aris@ruivo.org" <aris@ruivo.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "cai@lca.pw" <cai@lca.pw>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v7 06/14] mm,hwpoison: kill put_hwpoison_page
Thread-Topic: [PATCH v7 06/14] mm,hwpoison: kill put_hwpoison_page
Thread-Index: AQHWkOhG0xc32acSLUmPhvjbQkVCZ6l103AA
Date:   Wed, 23 Sep 2020 07:24:52 +0000
Message-ID: <20200923072452.GC14664@hori.linux.bs1.fc.nec.co.jp>
References: <20200922135650.1634-1-osalvador@suse.de>
 <20200922135650.1634-7-osalvador@suse.de>
In-Reply-To: <20200922135650.1634-7-osalvador@suse.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fcb49556-d759-4d19-a5ab-08d85f91c3ad
x-ms-traffictypediagnostic: TYBPR01MB5357:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYBPR01MB535790416269AAEE498AEC0BE7380@TYBPR01MB5357.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:238;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MOIG0X1f4u4h264LdtHQiXir76/DjDCBy81k+XJzdYj2wKpzDSu+JXTq3sVrkJ5c5JtK19jrMR0uCiCYPLCTLupVJEffICkPxIDVycJaAxVLTujrYSH8fWAcRwl+Xq+AZB+thjup0ryAqknOdeahh8/t70X6Fw6/BEX6KWRmq8Z1+7LT/x1Kc6l9i9BkLpSOj1M/Dxfun7MsVHHpgE7TO++0NH1nNGY67C7RsT9MHS7epySB1Q/e7d5Ukno8f8Oxvv4/kVHiFuCbMcz+2q1o1dxi/FeZD39Ra/wHJttRrKWkk0yPnseb2RgmDfstMvMqm/nlg+Mgc8iNzTrswDVkK4WPDzs2JVHteX4ANOOJGou6xG9omBSvQyRL9UrgWvRdYa5BotCPVWaqcJD1ruI5CqR3aEPHyp4AZKo8Ay8yfcs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3210.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(66556008)(316002)(6486002)(1076003)(54906003)(55236004)(478600001)(26005)(33656002)(66446008)(6506007)(86362001)(2906002)(76116006)(4326008)(66946007)(64756008)(71200400001)(6916009)(8936002)(6512007)(85182001)(8676002)(5660300002)(558084003)(9686003)(66476007)(186003)(142933001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: qbAYit7N1X7QArY9fT+LJtFVA3Eig5iON63RKfr0f5EPfJ57N/4Evk3+l8Rmm3Woih7qAXyZkBT3gMe/PwfHExg8Eigz26wDKI/ZEEb+fLfKXS3WNWi8TFZRW8VMZvhuEJky8lf5P4FlIySKK51p/wUXToEwE421NRn5Inlua/APJVJpDXEH1hhSCtnp5iFpnCiU+GS+CAbO8Nf0A1GtQ3CLzTs1vMipxqrPia51Ygq/z+m5TuYD0xWp3EcxfYdX08LyJNwK7BjtH6sSc8MAAuolYjoQsVKZe5jW4g0wSiS7dVV3bdY8Y3xokrkguCQD5S3i4FTx+g21Fo7ZA9VTAdicaBbxk0tD5V9mpjXR0dUwjZre7QzWRimLBwDzKCZq/UCS69kTqXoaJ13QovFzcL8saSRf4WgzfaJlfcCrpw41+/8ErULQK8KcuyiMf34pUOZn7UDhvXMX/UWRCdcRDuz/NamnXEx0mQwFRUdynIz6+WlSA3V+wrsYoP1LqrKWFAFw5iPWmNDQRKAGOMqEFMPM8s1MK00YrRFf6SdLAlPyt619S1q6LNi4+NWQRyiuZrjhqfT4AyP9MwjOCEFc98utFrv0tCq+A60zTC3kMxbGk661Na09b73JNnZ2YVc7QQW4YupW0yMx7yMf2dZAsw==
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <548CE328CCE331418A0441E941C38B73@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3210.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb49556-d759-4d19-a5ab-08d85f91c3ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 07:24:52.9719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pAPU8z0StJtvuAh11AP3BsSLuRHBUw3l9ShvpotQWvWmqKRQ1+n3RI5kkEUbGNfkVQsejPTUNlRYr3sOSI6WYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5357
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 03:56:42PM +0200, Oscar Salvador wrote:
> After commit 4e41a30c6d50 ("mm: hwpoison: adjust for new thp
> refcounting"), put_hwpoison_page got reduced to a put_page.  Let us just
> use put_page instead.
>=20
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>=
