Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4ED52881E1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 07:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731700AbgJIF7Z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 9 Oct 2020 01:59:25 -0400
Received: from mail-eopbgr1320128.outbound.protection.outlook.com ([40.107.132.128]:22944
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725917AbgJIF7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 01:59:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqpKTFt78wZkCS/c2X0LFmdSWudvU7x/WjSX6oREqVFR/c7J4y8kdPtPT5mpCfiFS8nSZPgPTiTCDSVj1aTy8iVX3S+kq+FXBzUdKlTpGMLCiM3/KthN/XsjFhhkRT9VnkA+bXgpTanixZXzN2wtCTG+2EtH3aklTPPC7LT3hEkWo8GpgVHc2wBvHktIfgoZcnLJkLAAn1tNT3tbMZztj9VLfj7XPiktCmi2xN3SBVmDgEVYSWp82qDEZ/Mlc4Yj8ZH3Vd4usyI+ZYPzVSootqLZ0tyuv99Wr5+vg34cg5x1iWpEQ9/Qpg8EExaFFO0JB0FTD/6Qyd0S4QKarNBL/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oJ8n/BQvWH6n3YpKt4gx06kGBdiaNBJ2GKb4S8s88Y=;
 b=K7GupiN74ML6HIWtp8e5ev1YDz8p6ccPLhyxFPLCxM1qib8FVTnFk1NSLW0aZLXzzn6qF+qGZfcazH96/G6FlpKruguAy5qvDllnAIQ4PBBZkIWO+BCnBPCqp/SIUK5O2fkE9Dt0a7eyBwocUpMxy+rNjngQFiCR9lFPsurDjLdr4qOmZj/+KMlSEy509+MJpT/io8o0KhbOu5ccG4OHuKKS3eKnFYx0qNYsymvJ0NzwrcC5KFslZ1ffWXptHtcVOyzm90oQopvG/xEkdOnPSAoUDjGmdOM7+q4k48UMaxjgXJGvOa4GFnwY7d4JdWNE1uCFmPSt/1XZBIXvuW9M9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com (2603:1096:203:82::18)
 by HK0PR06MB2705.apcprd06.prod.outlook.com (2603:1096:203:56::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Fri, 9 Oct
 2020 05:59:19 +0000
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::6def:b61:3beb:f3d5]) by HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::6def:b61:3beb:f3d5%6]) with mapi id 15.20.3455.023; Fri, 9 Oct 2020
 05:59:19 +0000
From:   Ryan Chen <ryan_chen@aspeedtech.com>
To:     Greg KH <greg@kroah.com>, Joel Stanley <joel@jms.id.au>
CC:     Andrew Jeffery <andrew@aj.id.au>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: RE: [PATCH v2 1/3] configs: aspeed: enable UHCI driver in defconfig
Thread-Topic: [PATCH v2 1/3] configs: aspeed: enable UHCI driver in defconfig
Thread-Index: AQHWnebaNuR8bEyOukOrd+cpU/jDTamOsjUAgAACw4CAAA5kAIAAAzZQ
Date:   Fri, 9 Oct 2020 05:59:19 +0000
Message-ID: <HK0PR06MB3380804F3330D4D34E01CC0DF2080@HK0PR06MB3380.apcprd06.prod.outlook.com>
References: <20200930040823.26065-4-ryan_chen@aspeedtech.com>
 <20201009024937.11246-1-ryan_chen@aspeedtech.com>
 <20201009024937.11246-2-ryan_chen@aspeedtech.com>
 <20201009044526.GB111063@kroah.com>
 <CACPK8Xd0h_2yGeyOjrpqV2_X8f4stZA_ur72b4Y4Nx91GrbXag@mail.gmail.com>
 <20201009054650.GA117723@kroah.com>
In-Reply-To: <20201009054650.GA117723@kroah.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kroah.com; dkim=none (message not signed)
 header.d=none;kroah.com; dmarc=none action=none header.from=aspeedtech.com;
x-originating-ip: [1.171.23.85]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e97c9863-ffa1-441e-92b4-08d86c18766e
x-ms-traffictypediagnostic: HK0PR06MB2705:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB270548BBB625F5144BBDAAC0F2080@HK0PR06MB2705.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WiPdSiRXYeGj1t9V0jhEdH+ajvp7ffo96J3aXiFwfa7npOXMNJzi9Sg6V9f+alKgMlsDzdXYeTSyjYiU2+WSDJjN9qoWuP0vbUiTn+929mRQ73X/0NXUDZVUSYAYVzpWzhlUWTA1Ow7kAJd+1Bln1tBkiTr6bavQMlSsgTv+hk3wROnr2WMMuQ5a61BkmVwllip3uWs3lNbD6jfoT2zu2J+WhCxmfDLH+ApOXSyLao+1XGGDQjK90rEUOCO1RMjHhtSp4N070HXQ8X7p+eVNW8vds1TCBo15a4CBoQw0dOv2LbKNfRZaduXJASyAWg6VDchmS5P1+Hyi45DJAPoGCw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3380.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(366004)(39830400003)(396003)(66556008)(76116006)(52536014)(83380400001)(33656002)(66476007)(66946007)(66446008)(64756008)(8676002)(86362001)(9686003)(4326008)(186003)(8936002)(71200400001)(5660300002)(55016002)(478600001)(110136005)(2906002)(7696005)(26005)(6506007)(53546011)(316002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: dXd3B5O3iHlbI3Yg5y8ttu//bMerv63SpSCuBD68//RvoKCdlUxWPtSp1rEK6gJG/p17J27h6/omkVNqarUPYHsWY3g9WZlTsqshdOLso8c5aixzxnBoH+RoARMAArLzVF525KAcCDETXygKsIsW4NyV6WwHdV5qT+oA/+zig/PCrDvFigywVdBQssYIEIO7TSir8UH3rQL+x/U5JReOhAfJ0ZpNvIncP1BlfW1uwQMvF326Un+wQ58vZDne38/oEKS7CvoiTFgiFMrn4kHq42xskTvydxmTQpNzAp1JEYltxwNODrcDoCHUF7QOj39+mNZrO9xsmw/5UXBqdv22epnJXRGzFE5c55Xta5tVZ57ivedzM4+bSWgIiNQafYKJD038WHhRCXEwQHgWR6hUR+Kp7rxehO7UhJ5O9GokF1wFWPFHVA5gchUiuNvYn2YkfEp8nPzwTmuj89s2Vbo+n88hvn5lM/AZeXNeAtqbpc/Gp6Tv5KrsYOX6ZI7Y4klbEq70XomPnTiExMzeRPYN/0bneBNUMfnemNxzj7UjgeMLMnwokPaTYc3QY6PIrjT5rjX9Bg7vUSSR8rODs43p3WKvVA4GttfbafhWWUnURV85NXUmUIuarI9zXtkz/LBLg4Zt3FqbZsbxnrt/3gUj5Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3380.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e97c9863-ffa1-441e-92b4-08d86c18766e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2020 05:59:19.2789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GOgcDIFjxuWTS+3358wbfC+kRz+W3eemLB4aScdGKT0A4DY1ygLiZYfGDTLy+aevgIYgjo47v8T6J6H/Zm5pXQAtxcrVb9V4a80d98ZsBiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2705
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Greg KH <greg@kroah.com>
> Sent: Friday, October 9, 2020 1:47 PM
> To: Joel Stanley <joel@jms.id.au>
> Cc: Ryan Chen <ryan_chen@aspeedtech.com>; Andrew Jeffery
> <andrew@aj.id.au>; Linux ARM <linux-arm-kernel@lists.infradead.org>;
> linux-aspeed <linux-aspeed@lists.ozlabs.org>; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>; linux-usb@vger.kernel.org; BMC-SW
> <BMC-SW@aspeedtech.com>; Alan Stern <stern@rowland.harvard.edu>
> Subject: Re: [PATCH v2 1/3] configs: aspeed: enable UHCI driver in defconfig
> 
> On Fri, Oct 09, 2020 at 04:55:19AM +0000, Joel Stanley wrote:
> > On Fri, 9 Oct 2020 at 04:45, Greg KH <greg@kroah.com> wrote:
> > >
> > > On Fri, Oct 09, 2020 at 10:49:35AM +0800, Ryan Chen wrote:
> > > > v2:
> > > >  -Changed : Add SCSI, BLK_DEV_SD, USB_STORAGE support.
> > > > v1:
> > > >  -Enable UHCI driver in aspeed_g5_defconfig.
> > > >
> > > > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > >
> > > Why do you need this in a defconfig?
> >
> > I would prefer configurations that are being used to be present in the
> > defconfig so we can test it. I think this is a sensible change.
> 
> Then it needs to be described in the changelog, otherwise we have no idea
> why this is happening :)
> 
Ok, will send new version describe it. 
