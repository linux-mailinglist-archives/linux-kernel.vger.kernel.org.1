Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276CB275253
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 09:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgIWHfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 03:35:54 -0400
Received: from mail-eopbgr1310077.outbound.protection.outlook.com ([40.107.131.77]:3344
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726550AbgIWHfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 03:35:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gX0ZJvDP+iLxFqi3bLwuVYUloomrcJufVbj1Z/oSt7RylzQXQMnQmQ7hkZIHyKo6Uik0icBb4hv9B5ihkNb3AtvaOJyrq+kFwP6GuIHxC4qQdrg1WNfdIkjvuVw1dZbZnB046Fm5GZ2xaF8Zx3S8quUwqAtrJzq33SfCN4ukh55Ys/F25Kanvvo1pZVPZMHvqmbQjBC4sYfpfZ7XMx2SfHDlFn9bPR/dRTg8ycC/Q9mlRL9Z3bJ6WhanfsgQaFqVEPoXdtCYTCGLOpummKcTQGNxk+M2jsoiceuLMnNq7c00I3S8i8RP4OFLwYvUyEs0Sop56Qys17f0Ctstpmmuvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QH74C4yH2b6Zz+mssjgwpbL8S0xLLntrCIfmLO2ArMY=;
 b=Ql32BiQkmaUbUmqgwcJ2Bfn31lZ1aihG82pbQJjrpWcqeTDPrUxqqAe2rLJIZl0CN2JLBM6kNOMDVd0bYbfNPropV9FuiRNg6VJ+2UX/k+8FV+8e/FV5QQIAfp+x8dqMIDbWK8nRAknyYyC9z2q72MZgA5VpIjstdFwJcPMm1buPFTbkXH7aFwYcmXaJEgQyB3ROwQ7wLSfb2+gcx5ChNRsxqzThM6+JWSGqq6pZ2Z9BFUpwqq5NgADt5C4xYe3KOewt/zYSuJt3Q9W4B1o++Et75OzaEVUx8wxbcvEvEE04djPMqotgqL531OwrW+CD35tu8zwauVuYd6LRsOLtdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QH74C4yH2b6Zz+mssjgwpbL8S0xLLntrCIfmLO2ArMY=;
 b=d9dBCm5D/E2jnlqYyAOqe38AxhR7weNOQYOP2APPxrn3LQcogqOG5J+bwq0dfO/Bdb0dPdRSlTW6/9jUvaI8iMdWEz+q2Ejt+yrJvpxSCcKjcy1SOZz1Tc/WBlxEFoC/zF4kBoWB3o2rByczjc1aXNjJPoj7ahB9x/5NmWEEiLQ=
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com (2603:1096:404:74::14)
 by TY2PR01MB4698.jpnprd01.prod.outlook.com (2603:1096:404:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Wed, 23 Sep
 2020 07:35:48 +0000
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::108f:629c:d934:9206]) by TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::108f:629c:d934:9206%7]) with mapi id 15.20.3412.020; Wed, 23 Sep 2020
 07:35:48 +0000
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
Subject: Re: [PATCH v7 10/14] mm,hwpoison: refactor soft_offline_huge_page and
 __soft_offline_page
Thread-Topic: [PATCH v7 10/14] mm,hwpoison: refactor soft_offline_huge_page
 and __soft_offline_page
Thread-Index: AQHWkOhHgnsXx2Ejak+slvNuayRdCql11n4A
Date:   Wed, 23 Sep 2020 07:35:48 +0000
Message-ID: <20200923073548.GC15221@hori.linux.bs1.fc.nec.co.jp>
References: <20200922135650.1634-1-osalvador@suse.de>
 <20200922135650.1634-11-osalvador@suse.de>
In-Reply-To: <20200922135650.1634-11-osalvador@suse.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ab47291-d585-40b8-e2e3-08d85f934a7d
x-ms-traffictypediagnostic: TY2PR01MB4698:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB46981B1D3C1B3E5CCA62A57FE7380@TY2PR01MB4698.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9dnSorTZtPsL9LOiNPQp9PcP7WCAJWz5ernob0DyxUatORG6j4qGl2eHvnNqd/tk0JqtwfpBRF3zoNidVgFUrbJiWoUUreaDQPUPblF4ruMElsfnQhxOBGLH6lHZGpgSn/k6ICakug1zsrYMsg24b7736/+3Aa3OMSMe7sHFwLKTSbNVJ62GCrAWShwDpTGdHlIAFi6i5GBT0zubQ4Re00uYnCc7lSzKWbCrtvbaT6ZNHehWQcnsjuFd/rdIgRBJxV5n377+7JCccsbipGEilwrCpQ8pdxEEusnV3N+KOBFLStUFG2d5fSp0pMYoMxvaIbgdoAcW/OAr4JZQqCSIIrz18uVqFmuNUGZMCfFefg+WXabkNscQvI/cY7JUeYGNPmsNm4C2aXD8/VVqbQqMQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3210.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(478600001)(6486002)(4744005)(1076003)(33656002)(66946007)(76116006)(186003)(9686003)(6512007)(8676002)(8936002)(66446008)(64756008)(66476007)(2906002)(54906003)(6916009)(66556008)(316002)(6506007)(55236004)(26005)(85182001)(71200400001)(86362001)(4326008)(5660300002)(14583001)(142933001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ht7DrqCxaNlGjjP4OJqu2AcEzD426h5/mPEduA92lajBpTWL/syWB0U6DdHlrl5cl5oqySeKR5llsez87b9Pi/30SwLvjR/Gdzv2/ncyDIlyAT4iUCXCx36C55tAAFAe510WNEJajvEVcCQAv6N1WJWNZVDMaJ3VOI7kVZkoDGPvYXspeJHzlTkiHiFHNyBANwHk3r57O0eNEHmtEnkPbYZAX84ZHEA7CTTKyE1TS54Gt4/CVnXyAh95H/jntMuwf1raBIvil3PlczyPYLmBFvbaNEJ7J9O1bT/8Xx+2F/hoPNG6Pmg053vmL52/UGIQ/MHHeaqtCR3vsUCm9uT9ilFTuSFTCViREB9R9Yace2cTEXdBmWiD1vXKK/A7pMQKYM1zLAdlbDe/OTeNB+uwyJ/e5hgcSAZj6Wptrl7c86+jwxBA2jOhHlm2RgGF/AmeZZ2Fl7DAX37QoCAGE5bCRo1HOJd0bMOUIb2gJR4JKRwKWK4ZAq1kXZAdxLBbM5ibJNrmSmy7UxvIoIeTvvGyq4enxbhjY++B9xXkZzayavba3zyDlhld7WzVevls0FfIR4NTYjZOqqSHSUXtjhY/PAmDmbJ/uPGGEA5nta+HHJ6tNwG70fv6n0U6rIbZhIhx1P2JrfZ2RVwofwNWHfNidQ==
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <8E7BAB07E24C924EA60946156E4F3586@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3210.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab47291-d585-40b8-e2e3-08d85f934a7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 07:35:48.6571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kVDYIennImsP7FhSAr3zBxwFzNroQ88qof/oaHhgDumVBi/e7Ps9HcBHKZZO3buKXn5tZBMh3Zxnwv4qkJ6eNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4698
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 03:56:46PM +0200, Oscar Salvador wrote:
> Merging soft_offline_huge_page and __soft_offline_page let us get rid of
> quite some duplicated code, and makes the code much easier to follow.
>=20
> Now, __soft_offline_page will handle both normal and hugetlb pages.
>=20
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>=
