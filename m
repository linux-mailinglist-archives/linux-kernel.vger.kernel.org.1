Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3112FB7A0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405250AbhASLMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 06:12:42 -0500
Received: from mail-eopbgr130079.outbound.protection.outlook.com ([40.107.13.79]:14990
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732624AbhASK5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 05:57:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azAhsJW+T231fhc65gY3P78zc0iewkKrVVvBHnQwQeJmEXcZlAC3kBsVsIxQ2ponZnlLHHdbpVSNUwMVwL1taXKe0FgBkuHKP341xj8Bzyrt8DwakO/TVNSbM543ScnmpQxNdqmiqfs/TTdjf4hM1k8joo+O8rotXzE2bQPIC4vg0Uzm7mD39UJqrzn5fGVeNDSlX7QjF9FUnrIB9eFMS//WlihLO3O9t9oHj2bydqW+W+2PmK293VF/n97sv5EKcl+RkVqKa95Myq/gEs9pPVWnl9jCNShU2hOtIWvKevo3mDtoQrzG36UuNGjWnKwh01XSO0LlNcXqH25n8XHWkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3WAumpmZVS1i3hR8kd0YusQvJboD/OFulx82cSMU5M=;
 b=P1SvaEjPnQZyF8dPqnhY2p7dL2kFbKl4sSZG4gWoq4Ozw/oakNQBm7vI4LoCVqzL34TBG3RJ27eh4E9tcjcjYEZmn+MTtyUCz6wtMaP81XYwkhhnF2P5+FeKYQUsGwXCQ1rrv/frWifj8Aay9790gQ3RSFhy7YmSLnfNVNsdhTUm6/LD5L9bwjHnguqfnHM2Q8VUhJFRYea//zcj9It3fbi/GW6R5lU+bst9kmc53KEoHCEX7cmwLLJz4cklDDtCZCebzFMvAMQXIPRwT7XHEwXGYw9chkiGDtjYFO4CLOp03VoyFt/lpdfSqfswmoNhnlBFhBOQ03q+AopQQslkgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3WAumpmZVS1i3hR8kd0YusQvJboD/OFulx82cSMU5M=;
 b=XZsmP/41tbj4kLZWQBfFNj7f4Dq5e5h3HRAQ8P2ckFxXMC1ZrZ42RhOwDOyTk+rwaw9ErIGa7u3niMeIHdToaqmw9V/fcfyHXONsYF00Eii7jid0ED+3VKnET+zr1/oezWGBhgOl2Dfby01nuV6vQuzQlQGPiQaW9EgQRaC5Wf0=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB7PR04MB4522.eurprd04.prod.outlook.com (2603:10a6:5:35::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.12; Tue, 19 Jan
 2021 10:56:46 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::b83c:2edc:17e8:2666]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::b83c:2edc:17e8:2666%4]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 10:56:46 +0000
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
Thread-Index: AQHW7ksGebtibLbnaUWJ/YJe+SCr+aouwcUw
Date:   Tue, 19 Jan 2021 10:56:46 +0000
Message-ID: <DB8PR04MB67957F13AE831ECC67EFFD7BE6A30@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <1611050655-44020-1-git-send-email-john.garry@huawei.com>
In-Reply-To: <1611050655-44020-1-git-send-email-john.garry@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 31c482d9-7644-4b4b-0bca-08d8bc68ea21
x-ms-traffictypediagnostic: DB7PR04MB4522:
x-microsoft-antispam-prvs: <DB7PR04MB452276B47F9931A24F607CEAE6A30@DB7PR04MB4522.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2z4b5HCSLvL+tE/cKnsQBZCQUc/2CqfrqMHdy28PCNc+UeiDsTMoFSTi90WSl2nO205efLDiTjfxkidZBZeck43tEVA8m9yx9XNUHleHVmK3z3kUHdX4UKXCtKtvOLDZuOzAjqhmUj3GtxOUJGmxDBoGfA2v1s5PiaqsSGkKuxU7xqzlrgjGfVcCDStlgadObDZwJrjr+tcml8Z6RLo8d2Y/xIW+lh2NQ5u4RbwpIfUz6OMERuSkK52V918t0e7vHd0XitJg5XuSoCaB4fGwon/7DEoDnJSp8SR7y3zI9jBnSzL+DQSHiYacI/4k66hHBO1QpgJgwWvOgopM8DOzkM8Af+CCV81KyTRuGZQUIzqVYfNkzwI2wTkxtfa8qKVKaCr2G9sbRq0XUw27HqtQxCneJbUJgOfKHz4xhGjEaTLiFv4/eOZxx6982nwcU21KxORoH4A5t/jnmfItwbelfsbh9W43MPd8Z1ERGh+6gb4aZ/73UVwv4mikAtyVNpguyetkVFsaR+0NQfxysc6IhizCFeqq6hRINAGA5HGngeyB40NQ0ABZFYaBUtB31p99
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(346002)(39850400004)(376002)(6506007)(8936002)(316002)(64756008)(4326008)(7696005)(921005)(8676002)(9686003)(53546011)(55016002)(478600001)(5660300002)(110136005)(54906003)(7416002)(66946007)(186003)(52536014)(26005)(2906002)(66476007)(66556008)(66446008)(33656002)(76116006)(86362001)(71200400001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?SnpWMTRMK0VzQm5QbjBKZFB1V21HMlRTNHliQWtScHIxT3lIYisrZmNtclg2?=
 =?gb2312?B?VzRtNUYycU9YWjMxODVzM2o5eDdFbzNQSHVEeVRQdlFpczdoU1lPSXY3enB2?=
 =?gb2312?B?eFNRazA5bFdsaFcySHduVlppM1JPMnprSEFNbHVjVmJ3RjU1SWovQ3NvUWdl?=
 =?gb2312?B?LythVXZKSCtGZkE4KzQ4T2pZZ0t2UUVuZVVxQWRrQ0RENE9BWHpNUDBQeXBk?=
 =?gb2312?B?RTQxa1VuREpZSXpTRGpwK1ZZNGpTN01zeG1sWUVpK0JuTFpWUXZpS3pXNkM2?=
 =?gb2312?B?RWdDVHluNk4yRzh0YjRCZkpTeDhCRng1RmhnQXdSUUJ5eGU1am9tdXZpU0Nr?=
 =?gb2312?B?MXhSUFl1L01QbWltRjFLMERnY3didkVSblJFY3VCMzk5TmtiNFNWMmFHSW9m?=
 =?gb2312?B?QTZzQW4zaDZIWTNUNFBoVEtMWmpEdWxjclB4TVV5TDNQNFlDd3VUWHpLNE1S?=
 =?gb2312?B?MmcwUjAvYm1pWDdxM3Jud0Q4cjZOYWpqR1Z4UGhDdDBDK3FneU03a1NubTRN?=
 =?gb2312?B?MU5Gc2hVR1RVQzZRcER5Ty91aVlUUktZNmJ6RFd0dGV6c2liUEVMVjhWZm8z?=
 =?gb2312?B?M1BBdXlXRlJTN3N6TW0rcVkwa0JodDJnekxhNXQxdVRoaHg0anRaOXFCV1A5?=
 =?gb2312?B?djF3aUEvZjJTUHhtWG9mdGdrOEtxWU1iWUNYQVlTRXlXZVRzMUpScUl6Vy9z?=
 =?gb2312?B?TnFiUDBBNjhjU0lFOG1hQm1hbDFwNDdteGVsb3RSZmVkWkh3aGJXM1UzbWVR?=
 =?gb2312?B?czR3OHdEZWplL2NWYlVQc214ekFBSXlsUjVQTGthSWJrU2hsTm53c3hGZUs5?=
 =?gb2312?B?WS9qU2Rmc0htY29NQVBsaGVrNlR0Ni9JekFKVEdWQkJaeHBDRHRlWWZhQkd2?=
 =?gb2312?B?enQyMitjYzZ1eExFdHM4U1d4ci9Ubk9RQ084Vmw1U2k2bEtOdldQS2hubElE?=
 =?gb2312?B?aUQrV1ZJQTFUUjlLaWZOWnZsQUpUTFZYY2p4VmlOSGpQWGNyL0I1L2haNXZq?=
 =?gb2312?B?Tm9MYmgrL0w0SGxZQU0zVkV5REJ5MHF5ZGx4TWpsWUt3WG5wclFsa3EySUZL?=
 =?gb2312?B?amxrUWVYUkdKNlpzZTc2ZWpRaFI4bGsrT2FXRUpwZnNvS3BScU5qSzJ3eWZH?=
 =?gb2312?B?Z2xjb3o4eEFtbFBGc1V0cmxBcklKQkFHdFUrK0l1R0IyUXpGTkxoeHlDRnNx?=
 =?gb2312?B?TTlzdUtUcU5qbFZXTDM2U3JxaldhaGttT2dqNmdwRzBNZllmTjJjemxadVBT?=
 =?gb2312?B?NTVSRTh1QW0rUitMU0hUZjd3L2c3ZldJWVB1WFptZUYrQjBQb3d0aWxmRU1k?=
 =?gb2312?Q?5qDyr49vNFutg=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c482d9-7644-4b4b-0bca-08d8bc68ea21
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2021 10:56:46.3092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DyaulaF8eSlwuX+e7DC8LCrvT3titUDc3fJZmy8zVAPh+G7mOQeNeo4w1CaQ0aGNTq5QS16rau6/iPEkcf0g/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4522
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvaG4gR2FycnkgPGpvaG4u
Z2FycnlAaHVhd2VpLmNvbT4NCj4gU2VudDogMjAyMcTqMdTCMTnI1SAxODowNA0KPiBUbzogcGV0
ZXJ6QGluZnJhZGVhZC5vcmc7IG1pbmdvQHJlZGhhdC5jb207IGFjbWVAa2VybmVsLm9yZzsNCj4g
bWFyay5ydXRsYW5kQGFybS5jb207IGFsZXhhbmRlci5zaGlzaGtpbkBsaW51eC5pbnRlbC5jb207
DQo+IGpvbHNhQHJlZGhhdC5jb207IG5hbWh5dW5nQGtlcm5lbC5vcmc7IGlyb2dlcnNAZ29vZ2xl
LmNvbTsNCj4ga2phaW5AbGludXguaWJtLmNvbQ0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgbGludXhhcm1Ab3BlbmV1bGVyLm9yZzsgSm9ha2ltIFpoYW5nDQo+IDxxaWFuZ3Fp
bmcuemhhbmdAbnhwLmNvbT47IEpvaG4gR2FycnkgPGpvaG4uZ2FycnlAaHVhd2VpLmNvbT4NCj4g
U3ViamVjdDogW1BBVENIXSBwZXJmIG1ldHJpY2dyb3VwOiBGaXggc3lzdGVtIFBNVSBtZXRyaWNz
DQo+IA0KPiBKb2FraW0gcmVwb3J0cyB0aGF0IGdldHRpbmcgInBlcmYgc3RhdCIgZm9yIG11bHRp
cGxlIHN5c3RlbSBQTVUgbWV0cmljcw0KPiBzZWdmYXVsdHM6DQo+IC4vcGVyZiBzdGF0IC1hIC1J
IDEwMDAgLU0gaW14OG1tX2Rkcl93cml0ZS5hbGwsaW14OG1tX2Rkcl93cml0ZS5hbGwNCj4gU2Vn
bWVudGF0aW9uIGZhdWx0DQo+IA0KPiBXaGlsZSB0aGUgc2FtZSB3b3JrcyB3aXRob3V0IGlzc3Vl
IGZvciBhIHNpbmdsZSBtZXRyaWMuDQo+IA0KPiBUaGUgbG9naWMgaW4gbWV0cmljZ3JvdXBfX2Fk
ZF9tZXRyaWNfc3lzX2V2ZW50X2l0ZXIoKSBpcyBicm9rZW4sIGluIHRoYXQNCj4gYWRkX21ldHJp
YygpIEBtIGFyZ3VtZW50IHNob3VsZCBiZSBOVUxMIGZvciBlYWNoIG5ldyBtZXRyaWMuIEZpeCBi
eSBub3QNCj4gcGFzc2luZyBhIGhvbGRlciBmb3IgdGhhdCwgYW5kIHJhdGhlciBtYWtlIGxvY2Fs
IGluDQo+IG1ldHJpY2dyb3VwX19hZGRfbWV0cmljX3N5c19ldmVudF9pdGVyKCkuDQo+IA0KPiBG
aXhlczogYmUzMzVlYzI4ZWZhICgicGVyZiBtZXRyaWNncm91cDogU3VwcG9ydCBhZGRpbmcgbWV0
cmljcyBmb3Igc3lzdGVtDQo+IFBNVXMiKQ0KPiBSZXBvcnRlZC1ieTogSm9ha2ltIFpoYW5nIDxx
aWFuZ3FpbmcuemhhbmdAbnhwLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSm9obiBHYXJyeSA8am9o
bi5nYXJyeUBodWF3ZWkuY29tPg0KDQpyb290QGlteDhtbWV2azp+IyAuL3BlcmYgc3RhdCAtYSAt
SSAxMDAwIC1NIGlteDhtbV9kZHJfcmVhZC5hbGwsaW14OG1tX2Rkcl93cml0ZSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAuYWxsDQojICAgICAgICAgICB0aW1lICAg
ICAgICAgICAgIGNvdW50cyB1bml0IGV2ZW50cw0KICAgICAxLjAwMTQ0NjUwMCAgICAgICAgICAg
ICAgNDA4MzIgICAgICBpbXg4bW1fZGRyLnJlYWRfY3ljbGVzICAgICMgICAgNjM4LjAgS0IgIGlt
eDhtbV9kZHJfcmVhZC5hbGwNCiAgICAgMS4wMDE0NDY1MDAgICAgICAgICAgICAgIDE2OTczICAg
ICAgaW14OG1tX2Rkci53cml0ZV9jeWNsZXMgICAjICAgIDI2NS4yIEtCICBpbXg4bW1fZGRyX3dy
aXRlLmFsbA0KICAgICAyLjAwMzE1MDI1MCAgICAgICAgICAgICAgMjg4MzYgICAgICBpbXg4bW1f
ZGRyLnJlYWRfY3ljbGVzICAgICMgICAgNDUwLjYgS0IgIGlteDhtbV9kZHJfcmVhZC5hbGwNCiAg
ICAgMi4wMDMxNTAyNTAgICAgICAgICAgICAgICA2NzA1ICAgICAgaW14OG1tX2Rkci53cml0ZV9j
eWNsZXMgICAjICAgIDEwNC44IEtCICBpbXg4bW1fZGRyX3dyaXRlLmFsbA0KDQpGb3IgdGhpcyBp
c3N1ZSwgVGVzdGVkLWJ5OiBKb2FraW0gWmhhbmcgPHFpYW5ncWluZy56aGFuZ0BueHAuY29tPg0K
DQpIaSBKb2huLA0KDQpJdCBzZWVtcyBoYXZlIG90aGVyIGlzc3VlIGNvbXBhcmVkIHRvIDUuMTAg
a2VybmVsIGFmdGVyIHN3aXRjaGluZyB0byB0aGlzIGZyYW1ld29yaywgYmVsb3cgbWV0cmljIGNh
bid0IHdvcmsuDQoiTWV0cmljRXhwciI6ICIoKCBpbXg4X2RkcjBAcmVhZFxcLWN5Y2xlc0AgKyBp
bXg4X2RkcjBAd3JpdGVcXC1jeWNsZXNAICkgKiA0ICogNCAvIGR1cmF0aW9uX3RpbWUpIC8gKDc1
MCAqIDEwMDAwMDAgKiA0ICogNCkiDQpBZnRlciBjaGFuZ2UgdG86DQoiTWV0cmljRXhwciI6ICIo
KCBpbXg4bW1fZGRyLnJlYWRfY3ljbGVzICsgaW14OG1tX2Rkci53cml0ZV9jeWNsZXMgKSAqIDQg
KiA0IC8gZHVyYXRpb25fdGltZSkgLyAoNzUwICogMTAwMDAwMCAqIDQgKiA0KSIsDQoNCg0KQmVz
dCBSZWdhcmRzLA0KSm9ha2ltIFpoYW5nDQo+IGRpZmYgLS1naXQgYS90b29scy9wZXJmL3V0aWwv
bWV0cmljZ3JvdXAuYyBiL3Rvb2xzL3BlcmYvdXRpbC9tZXRyaWNncm91cC5jIGluZGV4DQo+IGVl
OTRkM2U4ZGQ2NS4uMmU2MGVlMTcwYWJjIDEwMDY0NA0KPiAtLS0gYS90b29scy9wZXJmL3V0aWwv
bWV0cmljZ3JvdXAuYw0KPiArKysgYi90b29scy9wZXJmL3V0aWwvbWV0cmljZ3JvdXAuYw0KPiBA
QCAtNzY2LDcgKzc2Niw2IEBAIGludCBfX3dlYWsgYXJjaF9nZXRfcnVudGltZXBhcmFtKHN0cnVj
dCBwbXVfZXZlbnQNCj4gKnBlIF9fbWF5YmVfdW51c2VkKSAgc3RydWN0IG1ldHJpY2dyb3VwX2Fk
ZF9pdGVyX2RhdGEgew0KPiAgCXN0cnVjdCBsaXN0X2hlYWQgKm1ldHJpY19saXN0Ow0KPiAgCWNv
bnN0IGNoYXIgKm1ldHJpYzsNCj4gLQlzdHJ1Y3QgbWV0cmljICoqbTsNCj4gIAlzdHJ1Y3QgZXhw
cl9pZHMgKmlkczsNCj4gIAlpbnQgKnJldDsNCj4gIAlib29sICpoYXNfbWF0Y2g7DQo+IEBAIC0x
MDU4LDEyICsxMDU3LDEzIEBAIHN0YXRpYyBpbnQNCj4gbWV0cmljZ3JvdXBfX2FkZF9tZXRyaWNf
c3lzX2V2ZW50X2l0ZXIoc3RydWN0IHBtdV9ldmVudCAqcGUsDQo+ICAJCQkJCQkgIHZvaWQgKmRh
dGEpDQo+ICB7DQo+ICAJc3RydWN0IG1ldHJpY2dyb3VwX2FkZF9pdGVyX2RhdGEgKmQgPSBkYXRh
Ow0KPiArCXN0cnVjdCBtZXRyaWMgKm0gPSBOVUxMOw0KPiAgCWludCByZXQ7DQo+IA0KPiAgCWlm
ICghbWF0Y2hfcGVfbWV0cmljKHBlLCBkLT5tZXRyaWMpKQ0KPiAgCQlyZXR1cm4gMDsNCj4gDQo+
IC0JcmV0ID0gYWRkX21ldHJpYyhkLT5tZXRyaWNfbGlzdCwgcGUsIGQtPm1ldHJpY19ub19ncm91
cCwgZC0+bSwgTlVMTCwNCj4gZC0+aWRzKTsNCj4gKwlyZXQgPSBhZGRfbWV0cmljKGQtPm1ldHJp
Y19saXN0LCBwZSwgZC0+bWV0cmljX25vX2dyb3VwLCAmbSwgTlVMTCwNCj4gK2QtPmlkcyk7DQo+
ICAJaWYgKHJldCkNCj4gIAkJcmV0dXJuIHJldDsNCj4gDQo+IEBAIC0xMTE0LDcgKzExMTQsNiBA
QCBzdGF0aWMgaW50IG1ldHJpY2dyb3VwX19hZGRfbWV0cmljKGNvbnN0IGNoYXINCj4gKm1ldHJp
YywgYm9vbCBtZXRyaWNfbm9fZ3JvdXAsDQo+ICAJCQkJLm1ldHJpY19saXN0ID0gJmxpc3QsDQo+
ICAJCQkJLm1ldHJpYyA9IG1ldHJpYywNCj4gIAkJCQkubWV0cmljX25vX2dyb3VwID0gbWV0cmlj
X25vX2dyb3VwLA0KPiAtCQkJCS5tID0gJm0sDQo+ICAJCQkJLmlkcyA9ICZpZHMsDQo+ICAJCQkJ
Lmhhc19tYXRjaCA9ICZoYXNfbWF0Y2gsDQo+ICAJCQkJLnJldCA9ICZyZXQsDQo+IC0tDQo+IDIu
MjYuMg0KDQo=
