Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA68327F70A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 03:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbgJABLR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 30 Sep 2020 21:11:17 -0400
Received: from mail-eopbgr1300109.outbound.protection.outlook.com ([40.107.130.109]:6608
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728660AbgJABLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 21:11:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nz8nMuJv5H3xx51PcDX5XFf/U6kdpvfPnzOyuV2mYJfadGtpiXR9EoJMY2kfThffuB3cmswKNxJBRhEghDy1SHJ4X2t0UJjpEP9zrGjjYEKCicZQk3Img6et1tTeOK9mulfXF7SgKoPVUVDcd95q1q4TFpwRZzbiEipOfBPpgIesJw5Hsktisz7/S/on2onSVoCoGypQh75bQQ3KxA0oe9l1hbhPPySYle7hg9J4CLSMwoyOBvwjx1A0gMLkfXNlnIVfxNMJx+PqoqXgA8nHJQLOZKKQnTocm6mDFLb8G1obx0XrLyFhLmI2x8LZ6FUgqyxB6Y6UuByX8fFdKLYecg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGAgkfbQwuOlzsqNaLqv9ag2x4edtVrzecvxDDzd+q4=;
 b=gujoRcT6Frh/V+gond7o8zeojmVKhaejk2Bb7SnWxKebb8XZkbeftuDULUqXOF8UV8x6JHSBizZA/YoaujgxoGNg6NrffiKfuV+dIH47TPVwU2DsqqoeEBIr8+6lQdU1vU/lDTNedjbvyx0TQ7xnulZv7nMJnHmdM4oKpYZtfiygczW16zF9l805t4ISSIpz7sWwWJxuQosNXS1dIlXZHBJEa0oUzRw+HG+s034b6MUF71nPdpHG6YeIr51j2jfhQLXZ1MRmPt3PsvxNU1FjB1fTag7/h2WEXUr7R6+Ql7cWPgz/z9ahVZoJcbeyIiwNlqP33pHYiJY9GxVqi/sLeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com (2603:1096:203:82::18)
 by HK2PR0601MB1924.apcprd06.prod.outlook.com (2603:1096:202:c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Thu, 1 Oct
 2020 01:11:08 +0000
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::6def:b61:3beb:f3d5]) by HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::6def:b61:3beb:f3d5%6]) with mapi id 15.20.3412.029; Thu, 1 Oct 2020
 01:11:08 +0000
From:   Ryan Chen <ryan_chen@aspeedtech.com>
To:     Andrew Jeffery <andrew@aj.id.au>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [RESEND PATCH] ARM: dts: aspeed-g6: Fix gpio memory region
Thread-Topic: [RESEND PATCH] ARM: dts: aspeed-g6: Fix gpio memory region
Thread-Index: AQHWlwjxAC+Kpafu9USq5zc4ADh2qqmB4Q0AgAAFh4CAAAgjEA==
Date:   Thu, 1 Oct 2020 01:11:08 +0000
Message-ID: <HK0PR06MB3380BC1CB19918128E5A60B3F2300@HK0PR06MB3380.apcprd06.prod.outlook.com>
References: <20200930051113.32465-1-billy_tsai@aspeedtech.com>
 <20200930090603.19891-1-billy_tsai@aspeedtech.com>
 <b7bcc925-b0da-446f-84a7-1a564a1f4f83@www.fastmail.com>
 <2b3c4303-ef63-4c34-be00-ff59abc32e69@www.fastmail.com>
In-Reply-To: <2b3c4303-ef63-4c34-be00-ff59abc32e69@www.fastmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: aj.id.au; dkim=none (message not signed)
 header.d=none;aj.id.au; dmarc=none action=none header.from=aspeedtech.com;
x-originating-ip: [211.20.114.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5eb95f2-699b-4b5f-f51e-08d865a6e129
x-ms-traffictypediagnostic: HK2PR0601MB1924:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK2PR0601MB19249004FA1E7164D34B556BF2300@HK2PR0601MB1924.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FbFNCTOrQ/4R+cTsfGjWzizZlxwa75/fgFyU2Vh9NPVXRaEsHLKtVNLM9k8LdMD0cpEr4J5qBNLgUtQ9xdV78CBh81Nbvz6ZmFhf+WtuAgJOrFcar5DwggsVUL5CavDT7/+shFQjTXW3e2B1DuMyZUF2tzfHpAm7dsQGs8NwmBgokvJOR38zME3iu2LYHG5TcZ48HDa2nXfgUYXj9aOz4mT60tPBBA8+mqg9JhU+jZv17GBAQ9Ew/065dKBZU649iHE+TgVNZIsqs8/ZvDTEfwN0ZjYBV/qLVBpGBBFpiDKfXpRs6sbiQoNcz5tlwXdUZfHyuNnSyddFAV8ZQVLM+olZNHkQCY3629W6kgMQFpRvIcMlagtKuhIDZW2u2H6S
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3380.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(366004)(396003)(136003)(376002)(346002)(66946007)(186003)(53546011)(110136005)(316002)(66476007)(66556008)(66446008)(64756008)(55236004)(71200400001)(6506007)(76116006)(9686003)(26005)(8936002)(55016002)(8676002)(4326008)(2906002)(7696005)(33656002)(83380400001)(478600001)(107886003)(52536014)(86362001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 2b8KwpkZCDVJ+u7uTmeD8ITsIKBtTPdMQm5rjGoaD0kHM/x5/CmcZjgg0pug2hr5Q8wAKcVP5VDMtVJ8syFEYb0cHzqj5tTlTSqE/wxfnR7WyeyKdO8/9ApbjcX/RCXKZFYDbic3H0uB4KKAsoYz4jFjtxoJYgN5LCGu43FqO7iELpXALX49qzIYPCUDbDzf2C7IaP3T9sI6VK3tSYpjB6iwOq9hBPgIlDRrOecoUrJYIgTr8sqVPLV2Eav5TaK+X7w15CNzP3K/rZinveFUs8lF7LKA7QzPdxRdgfx9MfwNZGQqiyiU1bt4Qr5wyd0QyCto2erL+g5CklT52ZSbqm5JQeg7CUHazGULI1vcadj7xmllInlFHkO43J4VzM3qts60IdVJpO8RqFwBR7syf6sB1wCUD2UvpBQM03IucN0rG20BmfWMGRxRLx7RtkQ7YVS8cuN6qafLxiKjweWlCroXe6Mi5gqtwS8QmKayGj7efEljXnG13GFLOXtjAFZBCgTkZiNWy7Ng62zdKh81+jRHBUM1g+IOQjyxXiLBsuqy45rKI1esGLFWkw/U/KlTSHquG0PK7mL0B25poRfqFCPBUbx4nZuB9xe0PeDTW8ID2C6cG1I7eq8V9nGeOVkTDj0vO11iAet1M/kzfgKkEw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3380.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5eb95f2-699b-4b5f-f51e-08d865a6e129
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 01:11:08.8625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E5ksiEVii7gr0rlzPEfjYMuXYZUPt4APnN/a1M9GtH/v2JLKutChcZH0TX7Opf7Ce4JGZ5fZ+bqlYWJbW4aTu1ASnxy7L39qbnLScE1IwdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR0601MB1924
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Andrew Jeffery <andrew@aj.id.au>
> Sent: Thursday, October 1, 2020 8:32 AM
> To: Billy Tsai <billy_tsai@aspeedtech.com>; Rob Herring <robh+dt@kernel.org>;
> Joel Stanley <joel@jms.id.au>; devicetree@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-aspeed@lists.ozlabs.org;
> linux-kernel@vger.kernel.org; Ryan Chen <ryan_chen@aspeedtech.com>
> Cc: BMC-SW <BMC-SW@aspeedtech.com>
> Subject: Re: [RESEND PATCH] ARM: dts: aspeed-g6: Fix gpio memory region
> 
> 
> 
> On Thu, 1 Oct 2020, at 09:42, Andrew Jeffery wrote:
> > Hi Billy,
> >
> > On Wed, 30 Sep 2020, at 18:36, Billy Tsai wrote:
> > > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> > > ---
> > >  arch/arm/boot/dts/aspeed-g6.dtsi | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi
> > > b/arch/arm/boot/dts/aspeed-g6.dtsi
> > > index 97ca743363d7..b9ec8b579f73 100644
> > > --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> > > +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> > > @@ -357,7 +357,7 @@
> > >  				#gpio-cells = <2>;
> > >  				gpio-controller;
> > >  				compatible = "aspeed,ast2600-gpio";
> > > -				reg = <0x1e780000 0x800>;
> > > +				reg = <0x1e780000 0x500>;
> >
> > We took the 0x800 value from the memory space layout table in the
> > datasheet for the 2600. Should that be updated too? Or are you just
> > limiting the region to the registers currently described rather than the
> allocated address space?
> 
> Ah, actually, I see what's going on. We really have this layout (taking some
> liberties):
> 
> 0x1e785000 - 0x1e785500: PGPIO 3.3V
> 0x1e785500 - 0x1e785600: SGPM1
> 0x1e785600 - 0x1e785700: SGPM2
> 0x1e785700 - 0x1e785740: SPGS1
> 0x1e785740 - 0x1e785780: SPGS2
> 0x1e785800 - 0x1e786000: PGPIO 1.8V
> 
> Ryan: Can you change the address space layout table to reflect this? That way it
> still functions as a quick - but accurate - reference.

Yes will resend the patch for update the table. 
0x1e780000 ~ 0x1e780400 PGPIO 3.3V
0x1e780500 - 0x1e780600: SGPM1
0x1e780600 - 0x1e780700: SGPM2
0x1e780700 - 0x1e780740: SPGS1
0x1e780740 - 0x1e780780: SPGS2
0x1e780800 - 0x1e781000: PGPIO 1.8V

