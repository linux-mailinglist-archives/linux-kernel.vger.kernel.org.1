Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24AE62958FA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 09:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508412AbgJVHVt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 22 Oct 2020 03:21:49 -0400
Received: from mail-eopbgr1300101.outbound.protection.outlook.com ([40.107.130.101]:6209
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2506098AbgJVHVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 03:21:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbFasQkg4Nu5TpnxGc77bfauN/lMjz6j+egi9imjvxzLaCMVV+kTyL+qA3vqzcJk2TEpuJo/MsQsPs7B1Ody7Edy2tUeg5jaw55nj+bUyq5llIaZBriwBGf4lT1ZTr0H3bzZWZrFmWNgCymP0FkEMRp5CejJSdoNdpBxLsf0ju9JeE0ExpyPrHsZAAR7fxkZ6A7G4V8Y/I+fMCXlWqml9xmasIRejKvKZLNIdB19WKAMCScBzy+qkiyu2UGATPvDH2I8DyMS7yRJ/NtGdtguTKIOb1u1xBTpPQPBgXKaFDO4L0rdGQ/U7emPBA+up5Cg7HTawkex/vjZ2hWu4q/2Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyEv5KUhxqUOTIsYKELkRxIP68R808/MVhY6z48D2aI=;
 b=M4LziQLV79Adh2fP0JA0YXZ37qw1Uc0BUE7wKQ/TGgvvb2Kr3wbEWmmNz7CzSiHzaubNOtfaX3n9HZwmoK7aipvOZwgXxNPkOsZ4QhrHjgv+oHKuZs13XzGbBTFNXHng5Orb9zzFdxGZ2GMN0LJ3qVv74sn/fq7otroTzHo03PVi/kadq8Tj+u5TvmV4KcfG5A7nap0n+5mMv7SkMlnhph4LuGt51m+FLsC8VMDXMkxPjE4wbfuP0RPBtwNZj/l8KjPZV163ShC+8gjBkCbTu95zlcnszApKQsasgtrHpjkaBLkMb6gMn7Z3iCimCwcttwtnClxEpuhTFvLsIqjPvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com (2603:1096:203:82::18)
 by HK0PR06MB3650.apcprd06.prod.outlook.com (2603:1096:203:ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Thu, 22 Oct
 2020 07:21:42 +0000
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::6def:b61:3beb:f3d5]) by HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::6def:b61:3beb:f3d5%6]) with mapi id 15.20.3477.028; Thu, 22 Oct 2020
 07:21:42 +0000
From:   Ryan Chen <ryan_chen@aspeedtech.com>
To:     Andrew Jeffery <andrew@aj.id.au>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: RE: [PATCH v2 3/3] ARM: dts: add ehci uhci enable in evb dts
Thread-Topic: [PATCH v2 3/3] ARM: dts: add ehci uhci enable in evb dts
Thread-Index: AQHWnebb86S5YSDou02D04yeRF7kFKmO7uQAgAQ2c5CAD6cpAIAAf4PQ
Date:   Thu, 22 Oct 2020 07:21:41 +0000
Message-ID: <HK0PR06MB338086FEB34FF63FE0950ECAF21D0@HK0PR06MB3380.apcprd06.prod.outlook.com>
References: <20200930040823.26065-4-ryan_chen@aspeedtech.com>
 <20201009024937.11246-1-ryan_chen@aspeedtech.com>
 <20201009024937.11246-4-ryan_chen@aspeedtech.com>
 <4efff4e7-27e0-35be-c112-5377f222a478@gmail.com>
 <HK0PR06MB3380D499BCF164951167FCE2F2070@HK0PR06MB3380.apcprd06.prod.outlook.com>
 <fb508440-62dc-49d2-b252-7c65dd6696fe@www.fastmail.com>
In-Reply-To: <fb508440-62dc-49d2-b252-7c65dd6696fe@www.fastmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: aj.id.au; dkim=none (message not signed)
 header.d=none;aj.id.au; dmarc=none action=none header.from=aspeedtech.com;
x-originating-ip: [211.20.114.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: adda7722-99ba-49eb-96ab-08d8765b2005
x-ms-traffictypediagnostic: HK0PR06MB3650:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB36508E1C78CE9DB83FED98B3F21D0@HK0PR06MB3650.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:397;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZtkCe+klgx67hSOErq/VprTDimkuOQyl612LbK1nY3la4NVtnX5NCD5m/DbbuL9/+8F6K86YGYtAZNRoFOcMcfD2X5yiZ2smcbMnKlLbrDJhrffVfOGZZLYVyG1aD+uf4OzuCORx0i8yqXL6ycd6Og/UEHYCmJ47II7a/ot4e+0dypI+E2S0i5Vwi21Z7284OpZDdTz324RVA1VPlKklxrPpWPS3CIitF5xMaVbp8cpsSDw72mXCEJ8pzmstUUdpbg6ibj/RzJhH4ijqKmINC5K7drzjBZaCupPZsVIgA4H/kwn2wKyVszjTMrFqoEi6KcoDuh+/rx7BkgwxM/6S6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3380.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39840400004)(396003)(366004)(136003)(346002)(86362001)(6506007)(8936002)(76116006)(2906002)(66946007)(7696005)(53546011)(66476007)(55016002)(478600001)(5660300002)(83380400001)(9686003)(66446008)(66556008)(64756008)(33656002)(55236004)(8676002)(71200400001)(186003)(52536014)(316002)(110136005)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Zrx78UEfmKw7UtHvr1xAeKvXu1zxGebmgSp4WaPY2bKJ60Lvaw+lczNUZr4nmC5CcGMbdvYKxJAt7+BROUPolrIiETDd9LDVI0BRKLoIpguVcFhyAFSUBlXo7XAwkhXyPsf+Sqm9CdSh/Ph5p75ysXtwKfUrIFFZgkVgVPLAB7yIE9mpIbpJX0F/dNt8kGFuNGfqevWJFVeBKsvbr05y5pd4WxLkIHwt6z3xPdsp6ZpJ60yv1+OdpoiMFgg9yUJQ6KxqM98Txx5ZFrnu/Ivtg3jiYOHLDhqT/Jm+FwtkrwzcMGAvUrdz4JbKfSsIHzx0KfzYUyoSIw4oQg5aDuVx3ty/abG8MtR3a7bwBVE63bAmLUwG5DDgkK3iZeG0NaC9I1Utri5PnxJRE26K8CXuHblclAmTkZl++H30Lz2jQfDDuIZ8ASbc5RrlZzvcdMVt+SWr/3eTmIoc0xMh7j+wLxMd/icPefyQg++xsZsK/h0uvYp7PfIUMXKClYOc77uUJACaLbZPWc84MgUfQBiE6CueuGQbgMMKLp2iM1XZdUuDBuJfCPLwtcGrf6Q4Q52gna1Du/tdwmuxLiPR3jnjJxOo0maDCveDSLJQKuvIrBwms1jPeKn60wtaO2bG6yF2XMEPcjMnRMQiCq2MGr+NDg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3380.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adda7722-99ba-49eb-96ab-08d8765b2005
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2020 07:21:42.3004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xVpd7pEcQoOSXSpAnDod3TJwbN55FrOB/fJoL3qOhEzQaE1wZqBi7UfB9DSMGmCX6fNRRqvdbp/C3NDuxiE+dSfrd4SaFMDQyqF+17nyBGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3650
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Andrew Jeffery <andrew@aj.id.au>
> Sent: Thursday, October 22, 2020 7:45 AM
> To: Ryan Chen <ryan_chen@aspeedtech.com>; Sergei Shtylyov
> <sergei.shtylyov@gmail.com>; Joel Stanley <joel@jms.id.au>;
> linux-arm-kernel@lists.infradead.org; linux-aspeed@lists.ozlabs.org;
> linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org; BMC-SW
> <BMC-SW@aspeedtech.com>; Alan Stern <stern@rowland.harvard.edu>
> Subject: Re: [PATCH v2 3/3] ARM: dts: add ehci uhci enable in evb dts
> 
> Hi Ryan,
> 
> On Mon, 12 Oct 2020, at 11:13, Ryan Chen wrote:
> > Hello Segei,
> >
> > > -----Original Message-----
> > > From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
> > > Sent: Friday, October 9, 2020 4:23 PM
> > > To: Ryan Chen <ryan_chen@aspeedtech.com>; Joel Stanley
> > > <joel@jms.id.au>; Andrew Jeffery <andrew@aj.id.au>;
> > > linux-arm-kernel@lists.infradead.org;
> > > linux-aspeed@lists.ozlabs.org; linux-kernel@vger.kernel.org;
> > > linux-usb@vger.kernel.org; BMC-SW <BMC-SW@aspeedtech.com>; Alan
> > > Stern <stern@rowland.harvard.edu>
> > > Subject: Re: [PATCH v2 3/3] ARM: dts: add ehci uhci enable in evb
> > > dts
> > >
> > > HEllo!
> > >
> > > On 09.10.2020 5:49, Ryan Chen wrote:
> > >
> > > > Add EHCI UHCI enable build in aspeed-ast2600-evb.dts
> > >
> > >     Enable ECHI/UHCI for the  Aspeed AST2600 EVB, perhaps?
> > >
> >
> > Yes, it is enable for AST2600 EVB.
> 
> I think Sergei was suggesting you change the wording of the commit message.
> 
Thanks, will resend the patch with modification. 

