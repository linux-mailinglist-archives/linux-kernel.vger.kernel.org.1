Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67DC92BA696
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbgKTJvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:51:55 -0500
Received: from mail-eopbgr80070.outbound.protection.outlook.com ([40.107.8.70]:56197
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726118AbgKTJvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:51:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FarNGhUif77UWGzvf0FsW9K1cXA4QWLs87F7s2L7U3epvP6cuRbYC+/zFKJ81V4XedaLWS49R4PcIsuTBZzTYr82Oy3qMGqHGGhaPpewunTmmgCcjIIVRBgmF6JQboSw6hCrnaCDaXw2yP8DNuyZIJggOBEkQaQ1VpEfUcJQiijQkkdMxJNuJDNlN8q8cKG4YQgAfF1ZNWZmGvv35REErgZv4Xvr1WZ+ZUHjyb8+ZjZddcrpAXtnVpkRCfOasYbLRHO7VZnq7iHHCA+akwiWZIhWeSfgzxNk5vrelSUlLkqXRSpCNVad8CRcdW78dj8g9Tq9kz2lzUeHSfNT8uT97Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJXQILvcV1qtNYycEV8I698uJwftNSt9q9ELOCoec9g=;
 b=cWynsro6MAJuGpgxZSSvkbQAFq+qFkf01DQ0fiWlkPt/TkCbFUbFza+T6jRGNLzmGa968RR8uYtkPGi2t4iXtxHumRgs2nzVrJiOxUZQ6UQ/PkHcXTed12m2l5i0FQFSN6mOUmES7kQR4Omq8vOMhcLn6oC6vSTB3Uf4F8+STAW6yBu828jpTjer+6HutdhCufn/lC7O7RSUsIYLYdxHMaGYQblgVh1zZ25VuGuonovCE2zOrWblg9RS3p6aaIv/iDFzY2ipYVljqajDcPFyE4jEKWZBtjx2o3iyg/qQm8fyWauA2sWIk7mRuNqC90MyXxtewkrXuRvyysbThSttzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJXQILvcV1qtNYycEV8I698uJwftNSt9q9ELOCoec9g=;
 b=NnQcIJfXZB5+tieTPeuVNwoS4BjRcRcZZCDL86L144AzyNbW6DZdawDYOTELY9vghM5NdjVW0ifPEw+/+y8yzR7HxY/qPsTt143lbNcq08cgyicIAbumSFavH+D+j3nb5Nxtps2obZNTGuFPvHOLAYau1MzhJ2Dz5tmpuwZl3c8=
Received: from HE1PR04MB3196.eurprd04.prod.outlook.com (2603:10a6:7:21::31) by
 HE1PR0401MB2314.eurprd04.prod.outlook.com (2603:10a6:3:24::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.22; Fri, 20 Nov 2020 09:51:49 +0000
Received: from HE1PR04MB3196.eurprd04.prod.outlook.com
 ([fe80::a5f9:47b0:c473:7ddf]) by HE1PR04MB3196.eurprd04.prod.outlook.com
 ([fe80::a5f9:47b0:c473:7ddf%7]) with mapi id 15.20.3564.028; Fri, 20 Nov 2020
 09:51:49 +0000
From:   Ashish Kumar <ashish.kumar@nxp.com>
To:     Michael Walle <michael@walle.cc>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        "Y.b. Lu" <yangbo.lu@nxp.com>, Xiaowei Bao <xiaowei.bao@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: RE: [EXT] Re: [PATCH v3 4/9] arm64: dts: ls1028a: use constants in
 the clockgen phandle
Thread-Topic: [EXT] Re: [PATCH v3 4/9] arm64: dts: ls1028a: use constants in
 the clockgen phandle
Thread-Index: AQHWvyD6jxkZgeSzMUWX/NSrBeW1EKnQxs7Q
Date:   Fri, 20 Nov 2020 09:51:49 +0000
Message-ID: <HE1PR04MB319630198F85E59B2547046095FF0@HE1PR04MB3196.eurprd04.prod.outlook.com>
References: <20201108185113.31377-1-michael@walle.cc>
 <20201108185113.31377-5-michael@walle.cc>
 <HE1PR04MB319684750CF7D1920DCCCDD095FF0@HE1PR04MB3196.eurprd04.prod.outlook.com>
 <08b751d01cfc82fcfe425833793dcda9@walle.cc>
In-Reply-To: <08b751d01cfc82fcfe425833793dcda9@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [122.177.30.104]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6170d506-4acb-42dd-6a15-08d88d39e6ad
x-ms-traffictypediagnostic: HE1PR0401MB2314:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR0401MB2314D987C279E0AA7E83B3E595FF0@HE1PR0401MB2314.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IhIFRrdkCbAJB7SOdbW0KIcFSclQCu3NorKSAAHHjk15/GCM7HgUwlfCGxGDAOENzUINoNnobIhJn3qrLmq8M0ciwlrnnK6JyyZl+dz0LQjh3LpoHR4m33lscdS9+isgGxekPZRtEOlf3ybmyXOJVVT31VMcXCXyRgEkArZT8p7rAn8jcZgr+xAA/eFY3qEKgW1maAucbIUqtC9JwsemFzL5bK/m+auCYIs4YPKhV36geyfb6gC1Q+qCQRYka4LpRog56kLRjKCxENyBqdb3xT2vHCHdL9fcGiHe7uVtMAm3d6RxtI8LM9J7WcExSF9bFQz7UaxH7xI4ln1SMNbxzcCdPF67XgxLlWsqlT4TrZBCH+NTB6Hsh3tf/W0t3DswMGavUIYQPHBEZ7biV/hEXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR04MB3196.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(8936002)(52536014)(55016002)(6506007)(966005)(53546011)(66446008)(76116006)(64756008)(2906002)(66476007)(66556008)(66946007)(26005)(316002)(5660300002)(9686003)(186003)(55236004)(44832011)(7696005)(4326008)(33656002)(478600001)(4001150100001)(6916009)(71200400001)(8676002)(83380400001)(86362001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: dEkvIc0Bb5dQV7gsfqC8WLOjGEMXRvRgTj6WnlPlVrQOHAQLogEUtAGhQ6hbMunGgPQJk5//CeZLMHyCYU5g4RQJG5bTbCgJv6yRBayQHiAJLIhzEKZx5BdGa4rORhHZPENcQd+CUTtEb6tZ6UR/sA+02XeW5h7xnuzxl2jYpxSuuRDq9k+0Dx5qi2jygmxMqqGSZHjp1wtd0mXyUOXIFMQzWpUZYhBYMlG/Cyob3tRo/MUxkfrka3g3k2Vpvbb7y0MKgXHSFpJ1VMP/PoCwkLDAvdeaWrbPTOBWt7ONWh4pNE/wRNKriuPQNv8K3VzLcpSdGUmHDPQGrdEN4BBE0pap00KzadeftkMhbFcjDxkYGtPojTIR1rJmPUZQQYkKnpJh6WQVsWYCq6imBYrsJlFcKp0M80EJZV8zDblnfRvodrWeWJ8jjJDUMSWndIUZRSwkMGMI8NUXZ8mEOFc4CCqwuyWpYyFp3KKiWK/CvhDu2VmBBO+HW8gpsj7F342QPpLA50bYmDZPMtrxg0+A9ZLmD6mJGDu8dW5L3NxMUzvJw38kvt/MeiEeQltknWpkooabGIOB2FclpDswrWAihDhwuB8fO/ej+hD5O2w16LnmmgPo1RfY+K1ZA7D+iT+UgvuV4hMV+ZLSXapWvkW0Yw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR04MB3196.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6170d506-4acb-42dd-6a15-08d88d39e6ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2020 09:51:49.4662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8FwO5OrX3xD/AE4IwcnoCZecpO+nrZZIljQUJV/mfeVkAMJSJcsgKPtr53ZSgcPGYa6NylqUj6TYmrAdMMbnIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2314
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michelle,

> -----Original Message-----
> From: Michael Walle <michael@walle.cc>
> Sent: Friday, November 20, 2020 3:09 PM
> To: Ashish Kumar <ashish.kumar@nxp.com>
> Cc: linux-clk@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Michael
> Turquette <mturquette@baylibre.com>; Stephen Boyd <sboyd@kernel.org>;
> Rob Herring <robh+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Leo
> Li <leoyang.li@nxp.com>; Y.b. Lu <yangbo.lu@nxp.com>; Xiaowei Bao
> <xiaowei.bao@nxp.com>; Vladimir Oltean <vladimir.oltean@nxp.com>
> Subject: [EXT] Re: [PATCH v3 4/9] arm64: dts: ls1028a: use constants in t=
he
> clockgen phandle
>=20
> Caution: EXT Email
>=20
> Hi Ashish,
>=20
> Am 2020-11-20 10:25, schrieb Ashish Kumar:
> > I am not able to apply this patch cleanly, does it have any dependency
> > patch that I have missed?
>=20
> What is your base? I've just tried to apply this series (stand-alone) ont=
o linux-
> next and it applied cleanly.
I used https://github.com/torvalds/linux.git should I try this git://git.ke=
rnel.org/pub/scm/linux/kernel/git/clk/linux.git ?

Regards
Ashish=20
>=20
> > My assumption is that this patch series is superset of Series 1: [1/4]
> > dt-bindings: clock: document the fsl-flexspi-clk driver And Series 2:
> > [v2,1/5] clk: divider: add
> > devm_clk_hw_register_divider_table()
>=20
> That is correct.
>=20
> -michael
