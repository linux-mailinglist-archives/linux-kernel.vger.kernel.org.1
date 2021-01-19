Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F542FB7B5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391298AbhASLZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 06:25:17 -0500
Received: from mail-eopbgr70058.outbound.protection.outlook.com ([40.107.7.58]:60757
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405346AbhASLO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 06:14:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AK2IdlLI6mdYsqE+YtinEYKSTqywuI8nYkQXVd7lcxTNsY79K/c4F/6v/OEMI6xuS03CRlUFSezlOLE8xyCETPlfWl6tnZiBghvwykCzpZ2NZaGBNaDbZPzFs7UPJ9AWi4DiI0RIheF9bmkor4Gv6W0VQ6hrTfO2vMCI+YePu+qgI5ZjRFWZLtY/Lb9fnSGu4/13zfO26q7zhze5bsT4YpjMTlD7SslaeLZsstqjp+XMIR4Sl+AlG/7mFJZg2HH8WOVUesurRx10sr2aLYacRYOBGGgCTsJT6A5V2UQIVMqUld36NAxZA6KZCU7Macx8gvbi02rjtbqp0tcbNO+ryQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+s2dIahgI8eFDdZxrvscdPNS5cJ/gbuAw9HnqMZh4k8=;
 b=WEeKolKBO6vqKqjarCPO1ZxvYuF9DmMBoM2Kmte+PYNy+s73vB85EbTlioic0DAfU2NrmtgfwSQu8m8arSu4FlTkWokbdvi9+qF4ersyaG+tnOSaBgD3mbO7MXj3vJIi/Bz3pWbEUZNkpKO/st7hFQ1ceELiQiJYX0n8jUsrddY4A25b8AGIaKPzkWKr7cz9e+f5hk4HFvOd6TP4fbIWVUzlnR1PJflHeVEfMBHo7G7El62tJ+6fGFuMfluEFjp1HtLoVjkPQNr8Wjp5xXqKjvzWtXcxQloZPMhNs1etuLSXm3ORqFsJB2NFZdMSCCH9RWCLVOqQQN8F8hlpFLfENw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+s2dIahgI8eFDdZxrvscdPNS5cJ/gbuAw9HnqMZh4k8=;
 b=BBkQNSaD7XnVF6eajFbAo3lYeNqNqN5aYui3OHLb/2fgYojbJpSxhIHo/mkbWhf+KbrbYpF+VmMXf9KWifz68/Ajixmrv3LZufV4nfe2TmK2GBCx6KwF1FMwpYwNtB5SiBrmBk4d1JKNrOma0HFNxjYGBzu9UV9wM1WbGDohAtw=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB8PR04MB5852.eurprd04.prod.outlook.com (2603:10a6:10:b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Tue, 19 Jan
 2021 11:13:29 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::b83c:2edc:17e8:2666]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::b83c:2edc:17e8:2666%4]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 11:13:29 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     John Garry <john.garry@huawei.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "irogers@google.com" <irogers@google.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: RE: [PATCH] perf metricgroup: Fix system PMU metrics
Thread-Topic: [PATCH] perf metricgroup: Fix system PMU metrics
Thread-Index: AQHW7ksGebtibLbnaUWJ/YJe+SCr+aouwcUwgAAHZgCAAACuQA==
Date:   Tue, 19 Jan 2021 11:13:29 +0000
Message-ID: <DB8PR04MB6795D26063D0719C93300DDDE6A30@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <1611050655-44020-1-git-send-email-john.garry@huawei.com>
 <DB8PR04MB67957F13AE831ECC67EFFD7BE6A30@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <86abd4dd-a92b-f69b-64e0-7f985506f717@huawei.com>
In-Reply-To: <86abd4dd-a92b-f69b-64e0-7f985506f717@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8ff1a293-d369-4eef-7dfc-08d8bc6b4045
x-ms-traffictypediagnostic: DB8PR04MB5852:
x-microsoft-antispam-prvs: <DB8PR04MB585268A0D62A72B17B691ACAE6A30@DB8PR04MB5852.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MOorEUWx/MpLatHJfuFAZ9374syXuhfb1RFt5Sr0BZRjJSpBLOqcoPrxnVmE4bUbUdthQOlkhfeiVc1nRLhRvmwhKTeJjaVZ9rISZ37NJi0rCCk15PFCinTEHjQ4rGQf1XiGZFWYGyjWQ3n0+SQ3CfnspUXwUuWoxCZw2k3gQs4zM4AplZXGRzJpAVP1bKdTu1bqhED+svk3Ks1D5jEnIVvxz6uR/XgFkbOfhTNjdTebiBZjsday7UlJqFE8xtf7LLWBaToA9zKO0WvhzDfi15JgWr8vqehd9F9V7Of4xiREQpD2eAW38YRM0LCesWkAPhuw77O1vk8kRQa9eUfvcNY6okuChWqlos0Ak2jwLyZaehEGUBItdPbpNeM/X4jtgJt6MW/qFg1KPnoYZY+4n70QUONbCNShSvNe8EfHAHi0zT5n92hRnBfCDX92dyBv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(478600001)(4326008)(64756008)(9686003)(2906002)(52536014)(66946007)(76116006)(66556008)(66446008)(66476007)(186003)(5660300002)(71200400001)(53546011)(55016002)(83380400001)(26005)(54906003)(6506007)(110136005)(86362001)(7696005)(33656002)(921005)(8676002)(8936002)(7416002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?a1hqUW5qK0hvL2toOUwvWDF4Tmxxcll1d2FBMjhTWi9sR1BvbXJaNktaR3Zj?=
 =?gb2312?B?Vm0rdk81ZGVKVnRpblFjdktyYW4vcDFxR0xWdnY3anByZ1h5VXNYM0UwaUZW?=
 =?gb2312?B?c3h0UU5ZaGJXeWVGVXEvcGo5MXhDTHZ4SGVWd0R2TnJQZGhST2M4QUF2S2o4?=
 =?gb2312?B?Q2VwSm95TWRyUkpoSnNraWUwclNpdTBKRDFqbXFFcmhOQWgwRVpSQTM0Um5Z?=
 =?gb2312?B?Ui9sdHR2VFdQazBkcmQyZENuOVRDSUNvSExZZVVOYnRnU0RWQ1R0VXBSeWZh?=
 =?gb2312?B?NUQraGFjVUVROGxLTDZBL3hFNEN3alV0Sk93QUczeTZoczZoTThBS3JvVE8y?=
 =?gb2312?B?UGFRL3BxaXZaNzkrSVpGQmJLU0hDbVRERUQya3hMTVl0cGgyK2RyeXRHWTFQ?=
 =?gb2312?B?bEF4TkJRM1hEVjlxWjdIMlpDcW5EQzNyN2hkWWI0L0psZGhMdm5telNhVHNm?=
 =?gb2312?B?QUtCNVp6NXlISi94di9mQVNEQUROQ2dmRWFCN3RKa2djUEU0c082UEd1RVpD?=
 =?gb2312?B?TVY4N0QyanFYUktmZk96L3BySVlYOE03SWJaSmxKWk5VRTI1a24yam1QeDk0?=
 =?gb2312?B?YWtJVyt1bnluaDV4NUQ0bGc3QmVtQ1E0aXkwWU5wNktkNllVWWJZREN6ckVD?=
 =?gb2312?B?L3FnREtzWE12YXFiV1gvSDA3V1FuekxKZkJsalFLNERQUTFjTmFsclVKM1M2?=
 =?gb2312?B?UktucVBDOGUzUEY1eG92MnluR2c0bjdBdUtEOVV3Mzl3Sm5yUGptQnRpZUps?=
 =?gb2312?B?SW1qY3UzSUZCd2FzV2dtaTdvQUJxZnVWYVE0VUhsYnNqYVVqVWl4Mm5VNWlu?=
 =?gb2312?B?QTRTY1dBSERvNFFVSHBrdEFwSnovM2hHNHE5UXl3V2NRbGNsWWVJMTVZZ0dP?=
 =?gb2312?B?T29nblpwWWpWR25nMWNwRTlTN3dEWnlpbVZ5S1NJWVZEZFF5ZHpHbkJFQkFo?=
 =?gb2312?B?TmtQNzc2aXlFdWw5VUJqMkZYdEtZekNjbXI4a2tpRnZHank4c3lLL05QNEkz?=
 =?gb2312?B?Z1NaQ3NEdFErdW1nbURkTW9XUkZKQWZkMmFMbGgzZGx2VkhtZURlcGJpYkJw?=
 =?gb2312?B?clhZMTVHZWMvZ2lGbGIrYzk5WEFkRksxODU4NXpqWHExRUM4VyswNnlCZXNS?=
 =?gb2312?B?SmdSTXNNQjBnM0thc2tJTjdYbkFuK0gyT0JyOUxiaEVLdEdiRzNaS0h2YVhx?=
 =?gb2312?B?NmNlaCtiZWFHQXpmTnRJOGtTWjc5eTZBVWVPZFFmdmZZUzhzdkZZU1VhdFZO?=
 =?gb2312?B?c29WcXQzdW45SjFzc1ZQWG5wb2w2V1BaQ2VMQk11blJBVzVVYnVsUm13dkN4?=
 =?gb2312?Q?P8oHPnoNSjLVM=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff1a293-d369-4eef-7dfc-08d8bc6b4045
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2021 11:13:29.7768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7EqJFPN3WDCBI06MeXtqrkkAqTVNuZlLiZY5sVa6kLzmyt6KnLhL/8ut20ZEaNpuww2FcyM7w4zlNr8DeS03sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5852
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvaG4gR2FycnkgPGpvaG4u
Z2FycnlAaHVhd2VpLmNvbT4NCj4gU2VudDogMjAyMcTqMdTCMTnI1SAxOTowNQ0KPiBUbzogSm9h
a2ltIFpoYW5nIDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNvbT47IHBldGVyekBpbmZyYWRlYWQub3Jn
Ow0KPiBtaW5nb0ByZWRoYXQuY29tOyBhY21lQGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0u
Y29tOw0KPiBhbGV4YW5kZXIuc2hpc2hraW5AbGludXguaW50ZWwuY29tOyBqb2xzYUByZWRoYXQu
Y29tOw0KPiBuYW1oeXVuZ0BrZXJuZWwub3JnOyBpcm9nZXJzQGdvb2dsZS5jb207IGtqYWluQGxp
bnV4LmlibS5jb20NCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4YXJt
QG9wZW5ldWxlci5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gcGVyZiBtZXRyaWNncm91cDog
Rml4IHN5c3RlbSBQTVUgbWV0cmljcw0KPiANCj4gT24gMTkvMDEvMjAyMSAxMDo1NiwgSm9ha2lt
IFpoYW5nIHdyb3RlOg0KPiA+PiBKb2FraW0gcmVwb3J0cyB0aGF0IGdldHRpbmcgInBlcmYgc3Rh
dCIgZm9yIG11bHRpcGxlIHN5c3RlbSBQTVUNCj4gPj4gbWV0cmljcw0KPiA+PiBzZWdmYXVsdHM6
DQo+ID4+IC4vcGVyZiBzdGF0IC1hIC1JIDEwMDAgLU0gaW14OG1tX2Rkcl93cml0ZS5hbGwsaW14
OG1tX2Rkcl93cml0ZS5hbGwNCj4gPj4gU2VnbWVudGF0aW9uIGZhdWx0DQo+ID4+DQo+ID4+IFdo
aWxlIHRoZSBzYW1lIHdvcmtzIHdpdGhvdXQgaXNzdWUgZm9yIGEgc2luZ2xlIG1ldHJpYy4NCj4g
Pj4NCj4gPj4gVGhlIGxvZ2ljIGluIG1ldHJpY2dyb3VwX19hZGRfbWV0cmljX3N5c19ldmVudF9p
dGVyKCkgaXMgYnJva2VuLCBpbg0KPiA+PiB0aGF0DQo+ID4+IGFkZF9tZXRyaWMoKSBAbSBhcmd1
bWVudCBzaG91bGQgYmUgTlVMTCBmb3IgZWFjaCBuZXcgbWV0cmljLiBGaXggYnkNCj4gPj4gbm90
IHBhc3NpbmcgYSBob2xkZXIgZm9yIHRoYXQsIGFuZCByYXRoZXIgbWFrZSBsb2NhbCBpbg0KPiA+
PiBtZXRyaWNncm91cF9fYWRkX21ldHJpY19zeXNfZXZlbnRfaXRlcigpLg0KPiA+Pg0KPiA+PiBG
aXhlczogYmUzMzVlYzI4ZWZhICgicGVyZiBtZXRyaWNncm91cDogU3VwcG9ydCBhZGRpbmcgbWV0
cmljcyBmb3INCj4gPj4gc3lzdGVtDQo+ID4+IFBNVXMiKQ0KPiA+PiBSZXBvcnRlZC1ieTogSm9h
a2ltIFpoYW5nPHFpYW5ncWluZy56aGFuZ0BueHAuY29tPg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBK
b2huIEdhcnJ5PGpvaG4uZ2FycnlAaHVhd2VpLmNvbT4NCj4gPiByb290QGlteDhtbWV2azp+IyAu
L3BlcmYgc3RhdCAtYSAtSSAxMDAwIC1NDQo+IGlteDhtbV9kZHJfcmVhZC5hbGwsaW14OG1tX2Rk
cl93cml0ZQ0KPiANCj4gICAgICAgIC5hbGwNCj4gPiAjICAgICAgICAgICB0aW1lICAgICAgICAg
ICAgIGNvdW50cyB1bml0IGV2ZW50cw0KPiA+ICAgICAgIDEuMDAxNDQ2NTAwICAgICAgICAgICAg
ICA0MDgzMg0KPiBpbXg4bW1fZGRyLnJlYWRfY3ljbGVzICAgICMgICAgNjM4LjAgS0IgIGlteDht
bV9kZHJfcmVhZC5hbGwNCj4gPiAgICAgICAxLjAwMTQ0NjUwMCAgICAgICAgICAgICAgMTY5NzMN
Cj4gaW14OG1tX2Rkci53cml0ZV9jeWNsZXMgICAjICAgIDI2NS4yIEtCICBpbXg4bW1fZGRyX3dy
aXRlLmFsbA0KPiA+ICAgICAgIDIuMDAzMTUwMjUwICAgICAgICAgICAgICAyODgzNg0KPiBpbXg4
bW1fZGRyLnJlYWRfY3ljbGVzICAgICMgICAgNDUwLjYgS0IgIGlteDhtbV9kZHJfcmVhZC5hbGwN
Cj4gPiAgICAgICAyLjAwMzE1MDI1MCAgICAgICAgICAgICAgIDY3MDUNCj4gaW14OG1tX2Rkci53
cml0ZV9jeWNsZXMgICAjICAgIDEwNC44IEtCICBpbXg4bW1fZGRyX3dyaXRlLmFsbA0KPiA+DQo+
ID4gRm9yIHRoaXMgaXNzdWUsIFRlc3RlZC1ieTogSm9ha2ltIFpoYW5nPHFpYW5ncWluZy56aGFu
Z0BueHAuY29tPg0KPiA+DQo+ID4gSGkgSm9obiwNCj4gPg0KPiA+IEl0IHNlZW1zIGhhdmUgb3Ro
ZXIgaXNzdWUgY29tcGFyZWQgdG8gNS4xMCBrZXJuZWwgYWZ0ZXIgc3dpdGNoaW5nIHRvIHRoaXMN
Cj4gZnJhbWV3b3JrLCBiZWxvdyBtZXRyaWMgY2FuJ3Qgd29yay4NCj4gPiAiTWV0cmljRXhwciI6
ICIoKCBpbXg4X2RkcjBAcmVhZFxcLWN5Y2xlc0AgKyBpbXg4X2RkcjBAd3JpdGVcXC1jeWNsZXNA
ICkNCj4gKiA0ICogNCAvIGR1cmF0aW9uX3RpbWUpIC8gKDc1MCAqIDEwMDAwMDAgKiA0ICogNCki
DQo+ID4gQWZ0ZXIgY2hhbmdlIHRvOg0KPiA+ICJNZXRyaWNFeHByIjogIigoIGlteDhtbV9kZHIu
cmVhZF9jeWNsZXMgKyBpbXg4bW1fZGRyLndyaXRlX2N5Y2xlcyApICoNCj4gPiA0ICogNCAvIGR1
cmF0aW9uX3RpbWUpIC8gKDc1MCAqIDEwMDAwMDAgKiA0ICogNCkiLA0KPiANCj4gSG1tbS4uLiBu
b3Qgc3VyZSB3aGF0IHlvdSBtZWFuIGJ5ICJjb21wYXJlZCB0byA1LjEwIGtlcm5lbCIuIEFzIGZh
ciBhcyBJJ20NCj4gY29uY2VybmVkLCBub25lIG9mIHRoaXMgd2FzIHN1cHBvcnRlZCBpbiA1LjEw
IGFuZCBtZXRyaWNzIGRpZCBub3Qgd29yayBmb3INCj4gYXJtNjQuIFN1cHBvcnQgZm9yIHN5cyBQ
TVUgZXZlbnRzK21ldHJpY3Mgb25seSBjYW1lIGluIDUuMTEtcmMuDQoNClllcywgNS4xMCBkb2Vz
bid0IHN1cHBvcnQgQVJNNjQuIEkgYWRkIHNvbWUgY29kZSBsZXQgaXQgd29yayBsb2NhbGx5LiBB
bmQsDQoiTWV0cmljRXhwciI6ICIoKCBpbXg4X2RkcjBAcmVhZFxcLWN5Y2xlc0AgKyBpbXg4X2Rk
cjBAd3JpdGVcXC1jeWNsZXNAICkgKiA0ICogNCAvIGR1cmF0aW9uX3RpbWUpIC8gKDc1MCAqIDEw
MDAwMDAgKiA0ICogNCkiDQpBYm92ZSBtZXRyaWMgZXhwcmVzc2lvbiBjYW4gd29yayBmaW5lLg0K
DQo+IEFueXdheSwgY2FuIHlvdSBzaGFyZSB0aGUgZnVsbCBtZXRyaWMgZXZlbnQgd2hpY2ggeW91
IHNheSBkb2VzIG5vdCB3b3JrLCBub3QNCj4ganVzdCB0aGUgIk1ldHJpY0V4cHIiPw0KDQpPSywg
Q291bGQgaGVscCBjaGVjayBiZWxvdyBtZXRyaWM/IFRoYW5rcy4NCiJNZXRyaWNFeHByIjogIigo
IGlteDhfZGRyMEByZWFkXFwtY3ljbGVzQCArIGlteDhfZGRyMEB3cml0ZVxcLWN5Y2xlc0AgKSAq
IDQgKiA0IC8gZHVyYXRpb25fdGltZSkgLyAoNzUwICogMTAwMDAwMCAqIDQgKiA0KSINCm9yDQoi
TWV0cmljRXhwciI6ICIoKCBpbXg4bW1fZGRyLnJlYWRfY3ljbGVzICsgaW14OG1tX2Rkci53cml0
ZV9jeWNsZXMgKSAqIDQgKiA0IC8gZHVyYXRpb25fdGltZSkgLyAoNzUwICogMTAwMDAwMCAqIDQg
KiA0KSINCg0KQmVzdCBSZWdhcmRzLA0KSm9ha2ltIFpoYW5nDQogDQo+IFRoYW5rcywNCj4gSm9o
bg0K
