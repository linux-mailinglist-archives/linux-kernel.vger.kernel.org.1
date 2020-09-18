Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A9E26F24F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 04:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgIRC5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 22:57:41 -0400
Received: from mail-eopbgr30076.outbound.protection.outlook.com ([40.107.3.76]:49265
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728237AbgIRC53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 22:57:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pvxt32clE2td3LRp1w3iWjZ6JhMqWbH++TjbaEp+G9/VvSqusHK0kGWzKUWY0EM2FKTAy9WFxesCbJUkioaX4+GNAwNLygGvAB9WFTeofaH54GRapGWcoPteMXokWp0358jUyKUARlfjhxeOm+CzDSfr0Et3zGI4VtSFAL4jUNUpdnZlJr2rQ46enJ4S5bse5s8fyR/baAUTzVyMkeGsoGOtgEcHWX8zNNPb1b52bJ8bTpJuS53T9O6bNjyMHwMjSvDXt57NiHyImXYN3AVsrCSRseX7Zxu+9vHKHwKdDYy7wNE5znkqUKqAZ4Wx7nUQ9eOoEMBi4IVe26gYx3pXSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqvXQoNYL6UIGohOFmdPbR2afZjisQGy4HNhuqKknrk=;
 b=ASvpNst/6jnXnkuhJenlMzGsWD7w9bml8zVqPfLAW1zM9LrWAP/qlEXZJWW9Y6Pl5FF6VFbY034wvjtoA2pDTp7jaKbRXSGJ9+Rn1yZxcbFNAMQuiaUwI5zKmSBbkrnKtPX7aqLtPKwk+fGS1Xmwk9q33kGj+EgT3MotCC4DvBusiGf6IXPILq3cVKD7Z1Oc66zaV4gFATbWM6/QsXH8QBpwlNwpivmPCQY96kXqFTUTdjTa/gFh23+nD4GbShnmMHPpH1ZOUy4476sQuTI0iAp/Q8rezbI/XVbTDv6cSR/HSoANqu04GHiz/sZj8/+lnch5Nav6/lnNOz9txYjJjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqvXQoNYL6UIGohOFmdPbR2afZjisQGy4HNhuqKknrk=;
 b=UGguJ7x4pzIU2A7sC95O9MZLy44PnVtkEXdCQjjV9ls4afUJpER95ZVYsQ6r2c4LOVykBID66kox44VPe3qTzeOtkqQwb2qH47opPPEmCA17KnwW6f+eztusvCX831VmGk4WWmH6YpjmKdHD6F1PpUxqLBMEvYk5ILpNkD7l97Q=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR0402MB3336.eurprd04.prod.outlook.com (2603:10a6:209:12::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.19; Fri, 18 Sep
 2020 02:57:26 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::99b5:145d:16cc:78ca]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::99b5:145d:16cc:78ca%3]) with mapi id 15.20.3370.019; Fri, 18 Sep 2020
 02:57:26 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v3] dt-bindings: mailbox: fsl,mu: Add missing
 power-domains
Thread-Topic: [PATCH v3] dt-bindings: mailbox: fsl,mu: Add missing
 power-domains
Thread-Index: AQHWjSqv+vRdwNPnyk6kbXq1g9UTUqlts8WQ
Date:   Fri, 18 Sep 2020 02:57:26 +0000
Message-ID: <AM6PR04MB49666BA21F10B42EF0FB2499803F0@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <20200917194220.6625-1-krzk@kernel.org>
In-Reply-To: <20200917194220.6625-1-krzk@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 18030737-c163-4429-eff6-08d85b7e92f6
x-ms-traffictypediagnostic: AM6PR0402MB3336:
x-microsoft-antispam-prvs: <AM6PR0402MB3336807E3E9BF3C3A914E90E803F0@AM6PR0402MB3336.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:514;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ggC3HNO9SyJkKtcLi2eBMz0XlZO6RBxob7VGCFbKRW7jnxaCYlAwOsQ9V3nmQxku9BA8gybnXGbkKm7AReamQYi/3MVHv30UBFLlknY3S4Mx2pt1yciPEsAjDZhHEtFKe6PTXUaJye2SEHlP/t2qVjsunDcIDU8BiXC6lwNm7icc/pH3qDNos5RiLhW/L12Jw+ttWzp9YiwZFdfvWUdclc9cIO/gZsvym90tuZXi58nzJv9/P4DtCi8Lw39U2tOtP/PKY3//E6iMUK9gcfgbA6BY09B5MlxhlD8imYtneKPt5VmkICEIOzUZmyznk+YmBl9/67o0ma4cnr59geQVOyiPtqYYHqWYVcJ8y5rQQuBKvPHFSgFAC+SrusdCKs+l
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(64756008)(110136005)(52536014)(71200400001)(66446008)(5660300002)(33656002)(86362001)(66476007)(4744005)(66556008)(66946007)(76116006)(83380400001)(9686003)(15650500001)(8936002)(316002)(6506007)(44832011)(186003)(8676002)(7696005)(55016002)(2906002)(478600001)(26005)(142933001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: lA3wipagi59zdSA/UWN7pI0+4r6SFMqaUDNYWgi7KA+nwuOQ+qTsXnILJd0pUYv4ewDVxSARmpLOmwUNNwvrgH4pTeRNN92Qblq1abFI5SPZOeNZbHG80aES8DnbGbmCxrSfUtd/HtwE/wvnhygMMVfMCWx1DnjkOS4wYY0WOHzxMr6LBFWilmlu7LSi66eypdenMcq5/y6f7co4EVQZ03G8f7yxcm57v6fDV1aSJepBt8GziiiwFDrXY3igXIjZyr60/qiB1RUO5WAz2Rfwr9HeItottpVrGpEncNHCoS2e+KbBgCCye546bMi0DVzjHISbKCJ6tv5inWbEhrhnck+PI3yQETfldgSLRBLg+dJW/jc/d3pAfJV6Usc35omQNWRMXOkniMJoXFKnWksQJhWCszsVfdtJPqlXApoHYNTo1FHKrUcX2ACl+CI3Xfg1weBfMB5OwuVuWv1uwOTyR8cAieLlKYB3ispLln5UkzlAvhInPU1fDIHSYTgqMJGt4Aeg2PKeT/5FdCGq8r3D1bcoBPyHFGe2uuRV401S09xFHokpHw2nw5ySN8CjpmHin1hyDNI0lre3QR2qcdt72DIqb5CjCE54kLyO4c3INwSDyQ8b2URPXnbtVZjfmcenrhMalokdL9bbs7BuqMPGQQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18030737-c163-4429-eff6-08d85b7e92f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2020 02:57:26.1949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WAHi6MrGGxsVe3M163eB0fubsnMlYZFB2NcCKxZtB/hLnp1qeVlCFyN7ZKHGIWhc23CfK0qTo3GquisjeRUbvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3336
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IEZy
aWRheSwgU2VwdGVtYmVyIDE4LCAyMDIwIDM6NDIgQU0NCj4gDQo+IEFkZCBxdWl0ZSBjb21tb24g
cHJvcGVydHkgLSBwb3dlci1kb21haW5zIC0gdG8gZml4IGR0YnNfY2hlY2sgd2FybmluZ3MNCj4g
bGlrZToNCj4gDQo+ICAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHF4cC1tZWsu
ZHQueWFtbDoNCj4gICAgIG1haWxib3hANWQyODAwMDA6ICdwb3dlci1kb21haW5zJyBkb2VzIG5v
dCBtYXRjaCBhbnkgb2YgdGhlIHJlZ2V4ZXM6DQo+ICdwaW5jdHJsLVswLTldKycNCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4NCg0KUmV2
aWV3ZWQtYnk6IERvbmcgQWlzaGVuZyA8YWlzaGVuZy5kb25nQG54cC5jb20+DQoNClJlZ2FyZHMN
CkFpc2hlbmcNCg==
