Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9092B7CEF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 12:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgKRLlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 06:41:09 -0500
Received: from mail-eopbgr30118.outbound.protection.outlook.com ([40.107.3.118]:58626
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727934AbgKRLlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 06:41:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NObPGOavpdxwFJEvXon6GBFJUEez5SnYJgoSxRhoUY9fbr0r9RyHXdh/lLdblXBRKOXuc+hdguYvHzfZoR0jOSDpa8Xrn5S/QxvswjfSeCvDobR+qaKMZGVbI9QyL3tXLm8L+hF4TKleFD7pKdWgHJBxxkN4R8bay5ASwAwR1cUnwC7stOe737ebM4NZE+YuS6NyTNK8wnZ7KaKnFKHdt6r7zpAzso4bMmOnXdO4LbsWWZY9T6BGrI2J7ZSl8t8TBkn+P+mFOl+4gt/Kyp49IC7LPQy8uJYpB+gzJ88XUvEf9kQAZLCt2DydxsYkVh0AofZ7xBmCoQxeVxuBVGddtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7TY4LU8J0Vgx3og1l1/8w3y9E9lx13/Z8lUd82Yqcs=;
 b=DCB2vhS0Whl4VmImo2DaDId+3b/rqmYHdCEYwzdzHfjpg36H7RlR9frHgjUxpQKM6q2B1vKwYSHPpzJewgk0qGg2C2o0DEFqAI/0K7jPpANX4JBRbKwVHwXnlwZad0zxcj0OiipkZgENFg+cHctJe8Y9rkINy9UJ4s9431KMWfEQR1y2smwLPkgjgy4SBwLIUXyVslzecBA/uMlH6DB6hSp+879/tPJNY/QIhMvMONTz6B698WNRFbPKgh2Exrn60XWa39tBJss4GyFFr/yMEHWZ/nWvzlkYGUGLS7PGQ+aqPKd1IIaFuIrESm9eZmhJkA+gSNCVQcK+K+UIWsZMYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7TY4LU8J0Vgx3og1l1/8w3y9E9lx13/Z8lUd82Yqcs=;
 b=AQ78mzZ5gEwbaqD1Rf2PAZ4NKfv/DY0IYlHNzCTaMdQ6aUuduOQWjWIZErQPOmq8wvVe8dcGPCrbXcVBrlF9Yz2x+PJ1SXx3Qs4yj5OAsKHg3fWr+qaOI08VE85QrVWZkFkEq3VGOvlQhTs5Bk7UsK3EoOB3HCJnakTrcVoP6ec=
Received: from AM7PR07MB6707.eurprd07.prod.outlook.com (2603:10a6:20b:1af::11)
 by AM6PR07MB5430.eurprd07.prod.outlook.com (2603:10a6:20b:83::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.12; Wed, 18 Nov
 2020 11:41:04 +0000
Received: from AM7PR07MB6707.eurprd07.prod.outlook.com
 ([fe80::f5d7:501f:102d:60c3]) by AM7PR07MB6707.eurprd07.prod.outlook.com
 ([fe80::f5d7:501f:102d:60c3%9]) with mapi id 15.20.3589.017; Wed, 18 Nov 2020
 11:41:04 +0000
From:   "Wiebe, Wladislav (Nokia - DE/Ulm)" <wladislav.wiebe@nokia.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wiebe, Wladislav (Nokia - DE/Ulm)" <wladislav.wiebe@nokia.com>
Subject: [PATCH v2] clk: move orphan_list back to DEBUG_FS section
Thread-Topic: [PATCH v2] clk: move orphan_list back to DEBUG_FS section
Thread-Index: Ada9n4NB6hDYxXYFR/+k6gHQvOBp6Q==
Date:   Wed, 18 Nov 2020 11:41:04 +0000
Message-ID: <AM7PR07MB670712A8DB95BC63C0569262FAE10@AM7PR07MB6707.eurprd07.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=none action=none header.from=nokia.com;
x-originating-ip: [109.192.217.238]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a70cdcf3-493a-432a-b98f-08d88bb6d51c
x-ms-traffictypediagnostic: AM6PR07MB5430:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR07MB5430D703836CB0A13F035B02FAE10@AM6PR07MB5430.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:229;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ME9aP6pThZZimIqrX7nrva0SrtbMmWW0ydkez/ZZ/woDwBvREZ0znFez4Gvax+gPQiIxNjAW4POkLLDOC0zDwEZlC+DW51om8n4WjGw9MTOMD3Caq//Rzxfby7gkJDxqgpbWZXC/gDO10Cg8jVQEd1YKUig9ZeGObXuRBspHp29bbK/Kb65s7QRb3l4z/j9Qljvz+/EdoJsPfMLBUijqLp3mm3InhVWUAPo0pUx48GT4Z0cPfckRFB6LBJIgYgpS1NqET6fPds9BNDi/JdT+JgY+IF6s/xy160OrSNmfDJ/ACVbqpISf/hUtREE6VFRndvs/H4X9RM4dcAz4C9M7tA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR07MB6707.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(76116006)(107886003)(316002)(9686003)(71200400001)(54906003)(6506007)(186003)(110136005)(55016002)(66446008)(66476007)(66556008)(66946007)(8676002)(5660300002)(8936002)(52536014)(2906002)(64756008)(7696005)(26005)(86362001)(33656002)(478600001)(4326008)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: mnuHnBB8JuBeMDi4xfqe00oI61sj9SMhpwdraQDOxYl8OzccihiVjMDMSIVZEFa/alr0aHo2xP+pD7aVTGaaVApRnPTVYtfNQ2eIBLn+GzOPAlrnDrE91OMGCPZjGPRhrhDQ1njJ3+b1MCzGqmdd36cZ0KoiAaiJaFq3AFrakQTPPDZ3CCMmTLC626ZaJ/fRn7GaPOY4NpBYHlna7U5Pt/ZF8H7e8og4YiSHhlkmsdIh80I5qRC8c6xebLw5+YNG2/3OHUG91j3fQtMW6st2jO2Qre5nlhM5pQfBLIRSrEF9yYO+uRKlk+rWqS66ObQx7Qj1PPqm1EISIa+q0DtFjv+iR2kOyC12y2rNq/0bIBnzNGi3xCyOyGSM/EwKLEAypmZXVY96qRxn/UHm4fvzY0fo7Jhqekhw5nIS9452tyEEu5ZsHRZbRGnbk7r6YKaorZiyjx+Ij1Gtb5N36ievFY3duRBTg+DEUTKNg0RtMMKNIEY6s43jQxuuXhIuSI99gsuIFsdv9Z1VA1wz4JQBv32dox/KqRxbcpZdRE5bhDuqLP7v3fcgCsYzOU67guwHPJVssPtH+2ZG8tX+FOSzp9y1kpazREJBEeOdoRoveXMDyCv7hyXxRgFVb/M3jarUwdcZzfYEr/p4NpmK8jM4sIYq61mZ7iTzfY6QkMAD9dQPirWUSNo+fRrtw1EhEYysS8qz/10/OjbliM9pHkykjh9mn6Y7BkVnn8Q1sp2jr9YKBJTY7AeXjh6/kN6ZLvDG604RPQeiqX/yfI83mni+ameymizQRBpvfbk825XKUfI1bV9YXN0r3+ovMsSGA5BjKdnLW9uYmr8IOuwex8Qw4OwyO+J2eKJLNqJTDGtW8XGubuz7qmDwNjEUslGoOD+lsJFwe2P7qGJdhvNHVygZkQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR07MB6707.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a70cdcf3-493a-432a-b98f-08d88bb6d51c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2020 11:41:04.7767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R+z+L5WNmz8ktQFHl1A4vEoSco2Rt6i3a7MEvdAhbp/jnU/vj9p82O2I4orr4920lUjPXfWtt04E/BmrNQxV7g1xLoS9vZq6D/KaaQx/N3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR07MB5430
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 903c6bd937ca ("clk: Evict unregistered clks from parent caches")
in v4.19.142 moves orphan_list to global section which is not used when
CONFIG_DEBUG_FS is disabled.

Fixes:
drivers/clk/clk.c:49:27: error: 'orphan_list' defined but not used
[-Werror=3Dunused-variable]
 static struct hlist_head *orphan_list[] =3D {
                           ^~~~~~~~~~~

Fixes: 903c6bd937ca ("clk: Evict unregistered clks from parent caches")
Cc: stable@vger.kernel.org
Signed-off-by: Wladislav Wiebe <wladislav.wiebe@nokia.com>

---
 drivers/clk/clk.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index c5cf9e77fe86..925dd84293f4 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -46,11 +46,6 @@ static struct hlist_head *all_lists[] =3D {
 	NULL,
 };
=20
-static struct hlist_head *orphan_list[] =3D {
-	&clk_orphan_list,
-	NULL,
-};
-
 /***    private data structures    ***/
=20
 struct clk_core {
@@ -2629,6 +2624,11 @@ static int inited =3D 0;
 static DEFINE_MUTEX(clk_debug_lock);
 static HLIST_HEAD(clk_debug_list);
=20
+static struct hlist_head *orphan_list[] =3D {
+	&clk_orphan_list,
+	NULL,
+};
+
 static void clk_summary_show_one(struct seq_file *s, struct clk_core *c,
 				 int level)
 {
--=20
2.29.2
