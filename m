Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E7A285837
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 07:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgJGFpo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Oct 2020 01:45:44 -0400
Received: from mail-eopbgr1310130.outbound.protection.outlook.com ([40.107.131.130]:9376
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726009AbgJGFpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 01:45:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EeOIX+nClsn9k2j+GONJBgiJNV9Q/ggr+hpMQqMffBZPb6RfcLWCHTWB3Gn64dji68FiCM0IbjX3MGwvfBqLXUj9+f3m4b1AS3G+szzHQtXcsaLzdksObrV8LDhUq4LrkLCQRdcUBDS36a/LZ5AB9nHHZ47KXhKLQrVR5qMr7PCoZCAyQs+4nhelCIzDEt1WXMeWpPWJnMVbva68Sm+wRkpuSxGkVJ7G+lKkEiPHwWRklthHRJU4uM9MjsUtwR3Sk/jt8ePiXLzXB+NSD9KyX21YM3OnBsdr5KxX8gNtp2hfpIpmv2YNQMa4dpgImkP0X42CgWsCr+L5ML73FL/S1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUWjN1WVKYi3drU/WlRdtvW1gJ9triDkcc9haB+laDU=;
 b=JN4VKEevK7h3bRGLHjYX685AOaJB5xoo36alE6btA9RyrQkZd4xgI3tjOeHVvLq7esnBGPH1bO0hSU1sfsyXbsjZgC53gMrOScFmoQp72sWrx1mh9PPTW1OLnFnavbAltA9FPol282SZVUR1jLaKnfUXwoAfSQ/aeifE+4qSPc9Sslx8zkwa8oqPwXZq/jO4urb0XDsRkBghZ+cKit69LVwP72uNfSmvCnR1wVfhzWWm/+yy4u2L1zO0I8ABh+dZdsFASlxIUJ7gtEE5F5AcwCtoOLbth1H96RojjTHgR5Y1o1wOAFUyJcwQm1b8oGU1wFg6RKuy4uJA/wus8RaRLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com (2603:1096:203:82::18)
 by HK0PR06MB2338.apcprd06.prod.outlook.com (2603:1096:203:42::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Wed, 7 Oct
 2020 05:45:36 +0000
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::6def:b61:3beb:f3d5]) by HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::6def:b61:3beb:f3d5%6]) with mapi id 15.20.3455.021; Wed, 7 Oct 2020
 05:45:36 +0000
From:   Ryan Chen <ryan_chen@aspeedtech.com>
To:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH 0/3] Enable USB host for AST2600
Thread-Topic: [PATCH 0/3] Enable USB host for AST2600
Thread-Index: AQHWlt9bwGBF47qqVEyXPKyBIxahcKmLrDRg
Date:   Wed, 7 Oct 2020 05:45:36 +0000
Message-ID: <HK0PR06MB338033E8D9EA016D50615D2AF20A0@HK0PR06MB3380.apcprd06.prod.outlook.com>
References: <20200930040823.26065-1-ryan_chen@aspeedtech.com>
In-Reply-To: <20200930040823.26065-1-ryan_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: jms.id.au; dkim=none (message not signed)
 header.d=none;jms.id.au; dmarc=none action=none header.from=aspeedtech.com;
x-originating-ip: [211.20.114.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d40c241-a1e0-412e-3c62-08d86a843733
x-ms-traffictypediagnostic: HK0PR06MB2338:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB2338A3BA0FD0D067CF3973D9F20A0@HK0PR06MB2338.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B6a6z7+AcB934lX2S/dUHo16fhir622/w+d8/Pz7Ui1gSmFhEprz7dOE78RhBGVufuOZszW0j5q+FtLIvAVJT34VRC0DeKesztOGRECMBpLRSXlBzaNGe2ICRq/ubPExmODYCVroEuh4/Z9NPcJGdW9Pj6n3xf2GtYcIHnZjnVDsQzVDHzBCmHVsOQtf/kSwwjNtPV9T/biJeb+xWphf2RYCby/rC3cr9BwXcpHbpDPHSLy+ey0eozMItIQhnj8fbrDqivU19jElwIDVjasEhyXNZ89urhLUMuLU9FZnxfcLsiXv02/7GEosukiP8wotCuAdvvbs0ZFC0K7XNBDdFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3380.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(376002)(39840400004)(396003)(8676002)(5660300002)(9686003)(86362001)(316002)(26005)(8936002)(66476007)(64756008)(66446008)(76116006)(66556008)(66946007)(83380400001)(4744005)(71200400001)(7696005)(53546011)(6636002)(6506007)(478600001)(2906002)(110136005)(55236004)(52536014)(33656002)(186003)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: QYxG+rA+cTSclNi11OWSAxGXI2EL7Q8UrZIR96OpsB/6S6e7OAiTNiXzekLQP18RXzqSAeIrE4pnD/mgG0CR+0y+baf9MpKxrgAGc+x2GSkcVDV/KJSLDM7vxmBBI9N8M61hkL63WwtqtXzH0pAvxmt17W49KVKcpD7XKfzWIwzPTizSncZKTBVpxO+8SJTDOX3NW8HaLRsap8BkuaUE2t+zu0ffAYxlp3MU3pp46vqzpMoi+mfdvPSLbZStYwY35W4/MYxDbeeEKKSIXdZn600syJPq9f40or0xfD90B8eP5rI8Qqc6jhUelwQ4/9QXWqzhYhYF/tdeOi0NPJDqhdZ5ZTm8lhdHibEDq1qwfQYHnFRUNqvSq6qIQi2zkzWp4svSv/GgpjsK1QYq1N7QnwC8MLOov1IUcjmjWo2Wk+l6l1XEqffGjSlBkjdHCRWjYl41XASmxfA7ndRjnj6+TGoLsAYKhpT0WqGFkEJhBoCzkJ7IZ237Kj5tArcfHOZtDRl0nSgrDYMEikLCI4kjo/NnRGPIFGyyN437Zi2LegUU+KNvF2D2bchX/MK+QV9bPn2wnVo1akiGhnkNiBIrsr9atZPOEFy63iOX8YU+INc1HTsOSB3UCSESB/qdRE+EfdQyGdpPkO/Pma19Z7kkQA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3380.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d40c241-a1e0-412e-3c62-08d86a843733
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2020 05:45:36.6557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4KKduNkKeppWXRyJvON8E+tac8QXMwkKwm1NdL9ts/0sLaVXiN48Ij9Jx7Ku+BuGibhLTMK5cVEf0asjcHQU8bMAF8XSlWtI1XPAPLu29JQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2338
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Joel,
	Have you take time review this patches ? 

Ryan Chen

Tel : 886-3-5751185 ext:8857

> -----Original Message-----
> From: Ryan Chen <ryan_chen@aspeedtech.com>
> Sent: Wednesday, September 30, 2020 12:08 PM
> To: Joel Stanley <joel@jms.id.au>; Andrew Jeffery <andrew@aj.id.au>;
> linux-arm-kernel@lists.infradead.org; linux-aspeed@lists.ozlabs.org;
> linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org; BMC-SW
> <BMC-SW@aspeedtech.com>
> Cc: Ryan Chen <ryan_chen@aspeedtech.com>
> Subject: [PATCH 0/3] Enable USB host for AST2600
> 
> The patches enable UHCI driver in AST2600 and also enable USB host in
> aspeed-ast2600-evb.dts.
> 
> Ryan Chen (3):
>   configs: aspeed: enable UHCI driver in defconfig
>   usb: host: add uhci compatible support for ast2600-uhci
>   ARM: dts: add ehci uhci enable in evb dts
> 
>  arch/arm/boot/dts/aspeed-ast2600-evb.dts | 8 ++++++++
>  arch/arm/configs/aspeed_g5_defconfig     | 1 +
>  drivers/usb/host/uhci-platform.c         | 3 ++-
>  3 files changed, 11 insertions(+), 1 deletion(-)
> 
> --
> 2.17.1

