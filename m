Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A877E27B8F1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 02:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgI2Aib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 20:38:31 -0400
Received: from mail-eopbgr140074.outbound.protection.outlook.com ([40.107.14.74]:3054
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725272AbgI2Aib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 20:38:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIuW6a1MCQ+7aMhbjGnQzvFxRzx3bRCEpNOtGTQZkfo3KM45CbsWNKAAqoDzo2aldnFWecJuxfgT3jRy1/q0e8GmwTSAUI3lsxZXTFfjZBC341Y2M1CP4+c+UQW7k/qjhnGNX3G0J6ge2t4Z+912Azk/+kPHL39DbL72+O+BNR77ZGcD8sIykKim/cCq/PdFOFZmMtvM2ggmgesDtJJ4GNdjRqj2buuyacuc7etg1EaKhF9nBz/reB/JEs+l9f1cyhu5hmIuN8G4azqA08MIEOL5ImT5w65jgaiO2k7VlKiMT4Ni6NWGHkmoOSJl+H/yUpDYjHhhgHLSf1hXKuEqyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9kfZ3rsMnB2ITCkG8C4zZxFwXao9CE4TbemZE+QsY4=;
 b=i4swSEwS0yaUY4kZu/FP3ckCHjRN7GqG4mPqfpQN0NjS5C+19sqiq6AkrzcUSyynvUPuBO2QSHAjvz/INvNuFUP/PqW+Vy/PiUHzy6bFOWNMhv0Ipzs/PhSKAarImRdL7b2GdfkWrJllAHgAJDUI6bg86hyuOb9NM7J2y/NMffe6EVKb1pF2nZEwvn+yJoeJIIPpcnuTC2IFxz9C3/fHRGta+8cTCfNl1MpQb17/JOvnJGRzEPmD2BN+oP2kaJUEVYeCCSRjvLpv1iULYGSkvMHeWSMYD78uezfZCjaHrSY5mToydfNI4C0klFshlfhazHiGLmMp+WwJizT1py4ZkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9kfZ3rsMnB2ITCkG8C4zZxFwXao9CE4TbemZE+QsY4=;
 b=dNQUe/RjMX5Fg6X7dWM/olAclZcAh625IQyNoNqrJz2l78PCQNhob0lA1x2R+ZpuFUIYRO0n/jLQzTX6YBKDNNGge2080TNhe3QySNkz3kAU/s4quYhY7GfSwZ0uYSeizbf5O4ORK2mdlrghUymMwsnl24qfpibuoXih+on5nJc=
Received: from AM6PR04MB5413.eurprd04.prod.outlook.com (2603:10a6:20b:96::28)
 by AM6PR04MB4038.eurprd04.prod.outlook.com (2603:10a6:209:44::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.25; Tue, 29 Sep
 2020 00:38:28 +0000
Received: from AM6PR04MB5413.eurprd04.prod.outlook.com
 ([fe80::1953:c81a:cca2:60ec]) by AM6PR04MB5413.eurprd04.prod.outlook.com
 ([fe80::1953:c81a:cca2:60ec%7]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 00:38:27 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        "moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Biwen Li <biwen.li@nxp.com>
Subject: RE: [PATCH] arm64: dts: fix endianness of rcpm
Thread-Topic: [PATCH] arm64: dts: fix endianness of rcpm
Thread-Index: AQHWlcxr5OEh8vaZ40O3/VsyacaGZal+xYNQ
Date:   Tue, 29 Sep 2020 00:38:27 +0000
Message-ID: <AM6PR04MB54135ADC25CD2343619260F9F1320@AM6PR04MB5413.eurprd04.prod.outlook.com>
References: <20200928090455.34364-1-ran.wang_1@nxp.com>
 <CAOMZO5CrGi-=DCH8tfit2qZN7nJOGkfyN05g6ncu6MmrMT+2wA@mail.gmail.com>
In-Reply-To: <CAOMZO5CrGi-=DCH8tfit2qZN7nJOGkfyN05g6ncu6MmrMT+2wA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8bd55bec-5f27-4d1b-5be0-08d8640ffb81
x-ms-traffictypediagnostic: AM6PR04MB4038:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB4038D06A8B8630170A9E138BF1320@AM6PR04MB4038.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:561;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GKG1Fc5QNTxkqVcBffoxPjQZAPxMhLzjHy7Mb9hQdDfokp8r1gLM7O9VKNkmNKB5de7QQqGApb/d3DEJnUTqMnKDtDHXPa+Wm4cYD9LXA7gQfF96DMDnBwtgErZnQfXtg78M+EHYyrBSszhPUPHJU0xrMgISg7UbPyvWjIw7PaM2XlNK79DHEeF/Uy2tE8UUS54uG1pQ4dwkySt31oD8U59anwxv+Zp341ZCLSYUifQw+jLlmHjeYwv3FOX8XoH+B9G7zC9c2zYvkIia8wCRWTcCsBse5FPoeqPNgQbQGiwqAisoo+46ld9C2ohmTSjV2cUkbvXUkO2G1A3o6wk98yZIOSSVF/6vgI2AplGeTfEAFrpDUl9bUobXNfv9Ztom
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5413.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(8936002)(4326008)(83380400001)(8676002)(6916009)(55016002)(9686003)(53546011)(6506007)(26005)(7696005)(186003)(316002)(54906003)(478600001)(33656002)(4744005)(52536014)(71200400001)(64756008)(66446008)(66476007)(86362001)(5660300002)(66556008)(76116006)(66946007)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: U0i19P7GcvS8QxosE9YZJkyCirvT/i1BVPDQOFJ9NxyiTsdW4axSsjP5aGTEAbrE2DOYLBNWKCXieV306a2Bd2lAvH23pKIhIPmH17ZAy+eul+Pdq2ATS0u2ye1QYd01BajhqioTULSprvm9yvVHKNE8D40sQKFgqw1ciLMvsDnAowNRAF0Cd1jotnDfqo+ZUGSIeP2sX8A61SJ5nW7Q6OcZYHNL4/VUbC+J+v+GWFDVp8KVyE94CGtuJKgZe+GB8EH4LQsOm02/fb4IBn7uGuQEfvW+CO3Ia3s5+c2XMsxMc1nhqAkvnXPd4c3OzLgD74x8K2YpYRMPa2q6DRdoDy4n3dzhL8a0K8cwmnMmKcKiTfFpLOVBkjb/XtG3aUw3teVXALTiDpEIv8yJzm3opMh5ok4TvFFi8rdBijLTUKzC7yYIrrm5QHrJUlvnuoFO6YNMe7yXy66cxMKK3DWYXhz7rBlnJyHcF/xYhOO5LYH3O4eV6axhApe8ygtHIQKv3jhFbQJX7CBVVaDohlP1p262j/S+ppoVhvA4HY1iipO4+FLszd+neTgPK0l/vyTsc0Chl9ix0GH0SY/jEFeZiYiy0FVQK6HfQKoc/VR8oe7YKGShTGKegA778xbdIn38/GFwJBHdWGby+apFxjOOiA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5413.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd55bec-5f27-4d1b-5be0-08d8640ffb81
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 00:38:27.8991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LEI9R0kY6HvsYL+CjfL695QOxZsH2/BA+GRRqVxy5+Uvv4d1PNtZ6CxBkKQnXw6bmwDGGqiKVEhBeIq2G36dAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4038
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmFiaW8sDQoNCk9uIFR1ZXNkYXksIFNlcHRlbWJlciAyOSwgMjAyMCAzOjIwIEFNLCBGYWJp
byBFc3RldmFtIHdyb3RlOg0KPiANCj4gSGkgUmFuLA0KPiANCj4gT24gTW9uLCBTZXAgMjgsIDIw
MjAgYXQgNjoxNCBBTSBSYW4gV2FuZyA8cmFuLndhbmdfMUBueHAuY29tPiB3cm90ZToNCj4gPg0K
PiA+IEZyb206IEJpd2VuIExpIDxiaXdlbi5saUBueHAuY29tPg0KPiA+DQo+ID4gQWRkIGxpdHRs
ZS1lbmRpYW4gcHJvcGVydHkgb2YgcmNwbSBmb3IgbHMxMDI4YSxsczEwODhhLGxzMjA4eGENCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJpd2VuIExpIDxiaXdlbi5saUBueHAuY29tPg0KPiANCj4g
WW91IG1pc3NlZCB5b3VyIFNpZ25lZC1vZmYtYnkgdGFnLg0KDQpPaCwgdGhhbmtzIGZvciBwb2lu
dGluZyBvdXQsIHdpbGwgdXBkYXRlIGluIG5leHQgdmVyc2lvbi4NCiANCj4gV2hhdCBhYm91dCBh
ZGRpbmcgYSBGaXhlcyB0YWc/DQoNClN1cmUsIHdpbGwgYWRkIGl0Lg0KDQpSZWdhcmRzLA0KUmFu
DQo=
