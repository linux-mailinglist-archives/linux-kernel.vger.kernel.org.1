Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978D22F2E2B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 12:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbhALLjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 06:39:53 -0500
Received: from mga01.intel.com ([192.55.52.88]:64052 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728082AbhALLjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 06:39:51 -0500
IronPort-SDR: Rco8oLum1Obv1EtsnXAovj/nDc7FwJ0/UuNiirPNkfybdSiGBNdUMRuIrnfZ0dIpxE3Hk4kuyn
 w5QZ5yA9RLZg==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="196645451"
X-IronPort-AV: E=Sophos;i="5.79,341,1602572400"; 
   d="scan'208";a="196645451"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 03:39:11 -0800
IronPort-SDR: lnR7dFyYpkhxnHjtv6spHfeZMqpyX6s1hJ8bn3sp53e/+TGB6SwVlPFcac2t8HeZ8qm5nanygO
 mFm56N7CQ7aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,341,1602572400"; 
   d="scan'208";a="569067170"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga006.fm.intel.com with ESMTP; 12 Jan 2021 03:39:11 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 12 Jan 2021 03:39:10 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 12 Jan 2021 03:39:10 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 12 Jan 2021 03:39:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=El5w7ebwwHt6MwwfY1IfvXEGd6741Pin3miWLMpmi4Fn5hg7ef3lrZ2pyvfK6FVLshJi6P8FAUAkuTl2KJ8b1wXNJBVDbHmlyZjjWThWI7g+7xeAcBqb8o/xR46ZdkUstV7bPS76RSRA+3k1nIfm0d5w9uzsLfrn1qgGSQcVluK2sWSN1m0wBB68L5nsbIJFJhBTVVQ/Xxfq/5Nru/w5ZqwA3+I2N9UA1hS8hxvSf7AyiJtElsGkDkr7dg5aGDQF+IQ2vt8NYv9U8M1so98fBAFQUrPUTskU7Nx/1DQ6b0C3ZK0avad+Asvezy4UEBs3lBlzrq+9CCKuOKOY7cczRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GOMavbqOiNsW+xqJkRMGQk2nKiMmfMgqAmuqueslWU=;
 b=RHLsefbjiLzwAThuccmKVgq8Iu9o8ACj8DnoG8rIdZ1yLBxlsC9D38E8bMvqrGVcP+QtF7cV5C796oITCnF/QuKQ/jf0So6RpzTcmk41ztB85y+qDlXq0bNjncKVdFVk9VrzJuq3302sF1PxEKu5VSvD32PBSUKssTLOzv+dE975HTINJb070lgDDPpyWwTSZ78ODhCflYkm5TkMD/o4j1nOC/S6MMNGKUUy1EPxgVnfUPvdNeGXSY8MHiN1HuZLsnNeO9ztIhRktxVKl262G0qSDryh4SRU5aZgUq9WHMSSVwSK3KVmarUIFOB8Md/koHlVOAr/slQrcifc7N0M4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GOMavbqOiNsW+xqJkRMGQk2nKiMmfMgqAmuqueslWU=;
 b=gejf4lRb4bE0mJdiH7+/uDC95w1f2IgwiNxb2/72ryq6dr327DWtcdlR/7DFStWxaQ1UDPJSLexD0fhFrscMeaKzR5x98cSfgMMndGySFXVj+HHCbZGBpmE5Xd4zt6ZPxJJ1bq4ThM1yGWxmv3oaRhJTYAe3oSVRjTzUiBiQk9Y=
Received: from DM5PR11MB1690.namprd11.prod.outlook.com (2603:10b6:3:15::11) by
 DM6PR11MB2571.namprd11.prod.outlook.com (2603:10b6:5:c7::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.9; Tue, 12 Jan 2021 11:39:07 +0000
Received: from DM5PR11MB1690.namprd11.prod.outlook.com
 ([fe80::8929:bef9:ffe:569e]) by DM5PR11MB1690.namprd11.prod.outlook.com
 ([fe80::8929:bef9:ffe:569e%6]) with mapi id 15.20.3763.009; Tue, 12 Jan 2021
 11:39:07 +0000
From:   "Metzger, Markus T" <markus.t.metzger@intel.com>
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "Lutomirski, Andy" <luto@amacapital.net>
CC:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        "tdevries@suse.com" <tdevries@suse.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: RE: gdbserver + fsgsbase kaputt
Thread-Topic: gdbserver + fsgsbase kaputt
Thread-Index: AQHW6EXGGSDS0D32IEu+vSvpt9UFe6oizxgAgAAJLICAABKQAIAAmVKAgABFJ3A=
Date:   Tue, 12 Jan 2021 11:39:07 +0000
Message-ID: <DM5PR11MB1690CB5004CADCE5E9D5A221DEAA0@DM5PR11MB1690.namprd11.prod.outlook.com>
References: <20210111200027.GH25645@zn.tnic>
 <E74AC970-CFCF-4CFD-A71F-F719F5BCE2DC@amacapital.net>
 <5B5C1F0A-9780-4E42-BC65-742BAEE920BF@intel.com>
In-Reply-To: <5B5C1F0A-9780-4E42-BC65-742BAEE920BF@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [91.89.55.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fdcfdd77-3469-408a-9a15-08d8b6eeac16
x-ms-traffictypediagnostic: DM6PR11MB2571:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB257158E6242FADE196A38C0BDEAA0@DM6PR11MB2571.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XV+8LaaBzfwpXVydiGfXrsHnTtHAtQTThDQktxjn0HEZIkRoyZgAGOYHuzeCvohFp3BylNVAf+a7Ta+l6EuW52DPxGnoeaXv4p4Z40EV6D1IikFZVDA9LcUxTRFyVUS6SuNgVouGmOp3+xg8pyMGlf4rXI2hl+rz3G7ZKSN03xjXd+76hqqWLjYCJAVNe7rfb/0D7oivM98yYBG2VQU7mZZWiPoOmtLkSapiwISmPZsFuGLLQfw1QuwsUCvTDXGkwc+mqxbq7HiokqlsqHTZn21QlHg+ty9VfYdpv5O13emXrqTytGEtpu7lNPwQwlELYjc5fVGOS9AbUIyjS2Kb2QufZ8RZYy0/LOkADqP1PK6C4lNLJ9mConTZ8qwZ7YJBOaesr2NVY2qAZoMIVbzUqd/EO0X/IxOf4cEOVD/idxw8C/suCzLgXT8UcM7RNEDgm0W8Vr0OdEsX43Ge7hbsaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1690.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(66446008)(66476007)(76116006)(66946007)(8676002)(66556008)(55016002)(52536014)(110136005)(2906002)(71200400001)(64756008)(6506007)(4744005)(966005)(7696005)(8936002)(5660300002)(54906003)(4326008)(33656002)(316002)(26005)(478600001)(86362001)(9686003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?imIDZ7nJzqzDJLtsDuLW2nfOzwQ1weJ3SE+kgROPf6ufUkqQmITXq/sjMJEF?=
 =?us-ascii?Q?bD+v8D03OwlCoTUDdq65xg+vJPo6RKtxwc+f/yULSYVeBRRQIeo1PjsDTyrA?=
 =?us-ascii?Q?zfIKGLdIDftOSem6TaYZBCAycDcBFoAEKHLKImPFPSl9kGqTOsNJq/NYEO7y?=
 =?us-ascii?Q?/WG5PoC/z8VSSVCTBE47BNU9LMPNtmq5w/8yQ9UgsmV3GNopWqrEj7kqlacm?=
 =?us-ascii?Q?6x6xTgIpbqCGctXlClE4Wl0+3R56IpR+peu/4d0WJMpci2p4qYB0LU8QBNOl?=
 =?us-ascii?Q?THE3r21+mAlvUsQ9MlRnZNJO7NOIYCvE8gxjfoR1TCR5U6QD6X0JkxTL0nY3?=
 =?us-ascii?Q?aTAwgH0ldtWyYW3+R3QK+m5sxxH8ZCOTOicNJDCS++arWGvQMZZN75s7ecEV?=
 =?us-ascii?Q?ZdW/OgnB7qEJeQk5pqwJliGZQ8q0UZM3thXkr9lUtpklrF7Twq6KlAdI+QLp?=
 =?us-ascii?Q?YoOFZwrNGTU/9djUBVbFwdc0TAAqlzlx9DgAbsF2r7FQY/Md45SJUkPXpIsX?=
 =?us-ascii?Q?CMUw9jDIvk87gVjYL5Bj9MUZFi6bt6kt8tPb4hw1e8U+Qm5U4Xp9P/KiqHeW?=
 =?us-ascii?Q?rXXGJZN8A8ETHJ6fLiREOON3CxOQGHpCvcwUZvMPmOORvpEd1WDHE4H3ezEu?=
 =?us-ascii?Q?ayyiO22xTh8k+LPijth0WgUCK/8XL/kqOoFhBYMnCVxB5ti9izTxIZMqya99?=
 =?us-ascii?Q?l/LiJtQx0k/eE8yejPEKJYEx3uvtZiB4l2j4IT4+f5/ESgBNEia3L7/AE9dx?=
 =?us-ascii?Q?Obwlbj7NiuvnB3FufjnhfWu+77r0i3xc+GqNJNQXie0Bj3hHZMKeUg9KHYD6?=
 =?us-ascii?Q?aHFqvR/0Q2dO68TZiECXXl1ZoEfF3CYRjM1jCnDzNhAIW7ruS4JsUC6P6GKQ?=
 =?us-ascii?Q?7qRsqjKvLgZfmYuQly0NUodc+4DLNnFKaxkBmVA0+g8BTDgqnwyAeUVMePF6?=
 =?us-ascii?Q?t0K4l2mXGjzP9H2q1S80cVHuO8Knb4Y13CyHVhSxg1w=3D?=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1690.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdcfdd77-3469-408a-9a15-08d8b6eeac16
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 11:39:07.7239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7FS2yq8BS8XqUZt3aMtKOKcXT1NJOSyXh54SXK9GtOkFxdBDOB2wX/BzkSVcW6UVBdiDnrqV442Zu2kM2dHv+VaFBDmCVfb4A9EHbKZTytI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2571
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The GDB behavior looks to be different between the two cases -- with vs
> without gdb server, when I checked the GS/GSBASE values on the ptrace fro=
nt.

64-bit GDB doesn't support FSGSBASE for 32-bit inferiors and it looks like =
gdbserver
might not support FSGSBASE, at all.

I had added support for the former as part of the tests I wrote about a yea=
r ago [1]
but never submitted the patch.  Was the discussion ever concluded?

The general behavior should be that GDB reads a regset, overwrites the regi=
sters it
knows about, and writes it back again to preserve the original values of re=
gisters it
doesn't know about.

When I log the values that are read and written for FSGSBASE, however, it l=
ooks like
ptrace is returning a non-zero GS_BASE on a read and gdbserver is writing z=
ero on
the next write.

Chang, is that also what you were seeing?

Regards,
Markus.

[1]
https://lkml.org/lkml/2019/11/29/306

Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Gary Kershaw
Chairperson of the Supervisory Board: Nicole Lau
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928

