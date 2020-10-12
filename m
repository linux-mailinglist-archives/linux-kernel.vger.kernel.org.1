Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED62528B1EE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 12:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbgJLKDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 06:03:09 -0400
Received: from mail-eopbgr10045.outbound.protection.outlook.com ([40.107.1.45]:22019
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726104AbgJLKDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 06:03:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPuejc+ZmyJXkHDvX1OMSBMd1V1gJ0gTWtW0cddBmLeBWcT02+RlCo7lUqew53gtiFlXFbCtKNrBxQ2WiLKWYKyDIo9INvM0hxxFQkXK2fl5idiqU5byhKt+J4sbYLgGWYB6hhOrG7zrWhuPgO5CdEDkQ8xTjly87gtAQ1nBMzdoF6bL+xdVTi2aB6AFYA2maxT9cQRP/O+r2c3MrBhHUOu50Yrj09yl3ffyGdTowcQeRAMPgM/6+rkkCZjkkz1yf/pKU/XlMSqccULr+ICuabR31jmGbtnGI0UAtu7quPS9tdkW0xe+P2h1Dk5x91+nlxBHuc1lHOf6C2uUEfxZNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQFJ/2lb3Awrv0TQufOCJTLbREqGnbi4Y+cuSATbOiE=;
 b=kCLFhAJXtntuCTt3oqiQbqmz534SAC50XaRzZwuzZL8bjKqSxOybXciASoZ62cFt5Aau1YaDnH8jbH4oCgNQ1TIgEYJ2/Zj1e2k0A+5AmKbGSnbWaeHEq7ZzE4EoqppNUb/Tc6spzAyM30Ok4L9F7y531nPRN3BA5/UkQ4u0yS48EGQATwLQMcy3wdQPcXNIlT3muNvdPEwJSuOhS3BNtWjKQinETNyMaq/GuopAt2NTuxbQxHAmpb9ji00gxqEPNxOUXq9Yi1Q/xjy5b8EgO6oVt8dwfTtmacSYrTQ/EuXrxRMvJXoa/E/EDPy4Y+mjFp7J3/ZvIpFL5RGhMRwhXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQFJ/2lb3Awrv0TQufOCJTLbREqGnbi4Y+cuSATbOiE=;
 b=gTCa1uTDbojcSuA+Xap9GKkZHZPAy31flVHd0j7SPlt8r2FzHsh6lHVKAUhADbICMNkaEf7TRFoXSkJVfNy0usgGLkcslb+Osn75EYYUOrzozU2cN9DAweDj/sNS6cBRZvdozNfDrSx3Zbd/aqL+6oDalSJwiwOh2eiGFU4JCg8=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB7PR04MB5306.eurprd04.prod.outlook.com (2603:10a6:10:1f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.28; Mon, 12 Oct
 2020 10:03:02 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::d12e:689a:169:fd68]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::d12e:689a:169:fd68%8]) with mapi id 15.20.3455.030; Mon, 12 Oct 2020
 10:03:02 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     John Garry <john.garry@huawei.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "irogers@google.com" <irogers@google.com>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>
CC:     "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "zhangshaokun@hisilicon.com" <zhangshaokun@hisilicon.com>,
        "james.clark@arm.com" <james.clark@arm.com>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH RFC v4 13/13] perf vendor events: Add JSON metrics for
 imx8mm DDR Perf
Thread-Topic: [PATCH RFC v4 13/13] perf vendor events: Add JSON metrics for
 imx8mm DDR Perf
Thread-Index: AQHWnVx5VuSjzTQzMEWOnrIzGQXJWKmTwddg
Date:   Mon, 12 Oct 2020 10:03:02 +0000
Message-ID: <DB8PR04MB67950A459A08343CA3A779A4E6070@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <1602152121-240367-1-git-send-email-john.garry@huawei.com>
 <1602152121-240367-14-git-send-email-john.garry@huawei.com>
In-Reply-To: <1602152121-240367-14-git-send-email-john.garry@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6329e5e6-30c7-407e-c61d-08d86e9601bb
x-ms-traffictypediagnostic: DB7PR04MB5306:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB53069611F92C1C1F455A03ACE6070@DB7PR04MB5306.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XmlMnxQcsYsM4ysEv6RxchpjpFMysJaBFvv+J7OTB/JI2vmcQv3ZvBrmSHQTf+lanv2LH1vOVtky8sUNbxl6AXxkXg1TcfZWeVkjQdrxGFOfkcSzPxUpWv9rOTnHhz4Vn2ZFRm+fro7lhV68toOqle/p2BTHYeccy+LHl2VniwjVQltXFnZtk1axGM8xd1tOHVdESmCnrr2r7Lm5e6Yfwvn21qkzLrllhK91N1YiHoEiimK0tUuImTddSTa7mvvRZrPVA9ihJJmXJl8t55QKm8G9chli8fCKijsb9a5f4A+WSoWSLmnbHHnNoUMtEch+NaMFJP/tmrQPxWn7bPQ+lQsFLF02cDkoyrW3uBqkjMterAjNXlqvWdex9SIMpPNhJrWd/N/ei7Ca7BYwZQNZ1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(5660300002)(2906002)(52536014)(8936002)(86362001)(71200400001)(8676002)(83380400001)(7416002)(33656002)(316002)(76116006)(4326008)(478600001)(6506007)(64756008)(186003)(53546011)(66476007)(66946007)(54906003)(110136005)(26005)(9686003)(66446008)(55016002)(7696005)(66556008)(32563001)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: iZJJzI4P81uGE0bRyzQsykra5Unfjq0z1fG6yfbfwTU06eY2dtrL+krl0iCWea7PesPnpusE9Iw3n17BYSD2rB+LrpACWwSdJ64LHkQedCAqhxK56oJq+hnem1qpZnH/JJ+RqSuMie95TsByYzBDAgmJOQ8ANbPd9z8cWP1tuzSMgwlq8DQB09gmGY87C25bJYADpiYH2zKxLlipOXk5qhu1xMjE6eff25W2nXqwkkkvQcxd/AbUSbC5coyaNvNRLPIJBNTo1Un/mbZ64ptqEvY+ojavtUMtCF1kYLGme/1unLf2LZKfuyJs1RStVLBn259NMXZlgdgalhzPGejaSnSyTdftlxZhMemjdskj7PkYR7fIp01zdAYn2IEl19CyxF9qhVGCrLNMCSA4gKQ+Y7WTaGVpmHkKqOS3Q779iU0q0xvWbmFSqpgC2ZdqXw96jHhPD8NcZC3cN4QGesu1f/f/FM2jJVW4VM69IvGH5sXRuqmhVBViQIT8mHDFYx6D00RIF/8Z6Joz6u5Zp1yvlZWuJVdAZ9hGyV910Hh4Pjlsql9aZnaEbQCvU2WDXRX/0jZuNyV6XgWWhin+/9wT+t+DH0dLP9nb4At6oVnd0OfzOY9ijPtVT0PNQqd68lEms1cydI1mYjXWLLGq1RzOUQ==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6329e5e6-30c7-407e-c61d-08d86e9601bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2020 10:03:02.5142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZudHo/dkfXGswpvgSi/16IuwDIN6p7fP+f67oyGZOX/akzNAd+HL8coePie+ToxkJ5z+5a14TjpeOTufzI22bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5306
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvaG4gR2FycnkgPGpvaG4u
Z2FycnlAaHVhd2VpLmNvbT4NCj4gU2VudDogMjAyMMTqMTDUwjjI1SAxODoxNQ0KPiBUbzogYWNt
ZUBrZXJuZWwub3JnOyB3aWxsQGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOw0KPiBq
b2xzYUByZWRoYXQuY29tOyBpcm9nZXJzQGdvb2dsZS5jb207IGxlby55YW5AbGluYXJvLm9yZzsN
Cj4gcGV0ZXJ6QGluZnJhZGVhZC5vcmc7IG1pbmdvQHJlZGhhdC5jb207DQo+IGFsZXhhbmRlci5z
aGlzaGtpbkBsaW51eC5pbnRlbC5jb207IG5hbWh5dW5nQGtlcm5lbC5vcmc7DQo+IG1hdGhpZXUu
cG9pcmllckBsaW5hcm8ub3JnDQo+IENjOiBsaW51eGFybUBodWF3ZWkuY29tOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc7IEpvYWtpbSBaaGFuZw0KPiA8cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+OyB6aGFuZ3NoYW9r
dW5AaGlzaWxpY29uLmNvbTsNCj4gamFtZXMuY2xhcmtAYXJtLmNvbTsgZGwtbGludXgtaW14IDxs
aW51eC1pbXhAbnhwLmNvbT47IEpvaG4gR2FycnkNCj4gPGpvaG4uZ2FycnlAaHVhd2VpLmNvbT4N
Cj4gU3ViamVjdDogW1BBVENIIFJGQyB2NCAxMy8xM10gcGVyZiB2ZW5kb3IgZXZlbnRzOiBBZGQg
SlNPTiBtZXRyaWNzIGZvcg0KPiBpbXg4bW0gRERSIFBlcmYNCj4gDQo+IEZyb206IEpvYWtpbSBa
aGFuZyA8cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+DQo+IA0KPiBBZGQgSlNPTiBtZXRyaWNzIGZv
ciBpbXg4bW0gRERSIFBlcmYuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKb2FraW0gWmhhbmcgPHFp
YW5ncWluZy56aGFuZ0BueHAuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKb2huIEdhcnJ5IDxqb2hu
LmdhcnJ5QGh1YXdlaS5jb20+DQo+IC0tLQ0KPiAgLi4uL2FyY2gvYXJtNjQvZnJlZXNjYWxlL2lt
eDhtbS9zeXMvZGRyYy5qc29uIHwgMzkgKysrKysrKysrKysrKysrKysrKw0KPiAgLi4uL2FybTY0
L2ZyZWVzY2FsZS9pbXg4bW0vc3lzL21ldHJpY3MuanNvbiAgIHwgMTggKysrKysrKysrDQo+ICB0
b29scy9wZXJmL3BtdS1ldmVudHMvamV2ZW50cy5jICAgICAgICAgICAgICAgfCAgMSArDQo+ICAz
IGZpbGVzIGNoYW5nZWQsIDU4IGluc2VydGlvbnMoKykNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0K
PiB0b29scy9wZXJmL3BtdS1ldmVudHMvYXJjaC9hcm02NC9mcmVlc2NhbGUvaW14OG1tL3N5cy9k
ZHJjLmpzb24NCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiB0b29scy9wZXJmL3BtdS1ldmVudHMv
YXJjaC9hcm02NC9mcmVlc2NhbGUvaW14OG1tL3N5cy9tZXRyaWNzLmpzb24NCj4gDQo+IGRpZmYg
LS1naXQNCj4gYS90b29scy9wZXJmL3BtdS1ldmVudHMvYXJjaC9hcm02NC9mcmVlc2NhbGUvaW14
OG1tL3N5cy9kZHJjLmpzb24NCj4gYi90b29scy9wZXJmL3BtdS1ldmVudHMvYXJjaC9hcm02NC9m
cmVlc2NhbGUvaW14OG1tL3N5cy9kZHJjLmpzb24NCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4g
aW5kZXggMDAwMDAwMDAwMDAwLi4zNDA0YTg4MDU0MmQNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysg
Yi90b29scy9wZXJmL3BtdS1ldmVudHMvYXJjaC9hcm02NC9mcmVlc2NhbGUvaW14OG1tL3N5cy9k
ZHJjLmpzb24NCj4gQEAgLTAsMCArMSwzOSBAQA0KPiArWw0KPiArICAgew0KPiArICAgICAgICAg
ICAiQnJpZWZEZXNjcmlwdGlvbiI6ICJkZHIgY3ljbGVzIGV2ZW50IiwNCj4gKyAgICAgICAgICAg
IkV2ZW50Q29kZSI6ICIweDAwIiwNCj4gKyAgICAgICAgICAgIkV2ZW50TmFtZSI6ICJpbXg4X2Rk
ci5jeWNsZXMiLA0KQ291bGQgeW91IGhlbHAgY2hhbmdlIHRvIGlteDhtbV9kZHIuY3ljbGVzPyBU
aGFua3MgYSBsb3QhDQoNCj4gKyAgICAgICAgICAgIlVuaXQiOiAiaW14OF9kZHIiLA0KPiArICAg
ICAgICAgICAiQ29tcGF0IjogImkuTVg4TU0iDQo+ICsgICB9LA0KPiArICAgew0KPiArICAgICAg
ICAgICAiQnJpZWZEZXNjcmlwdGlvbiI6ICJkZHIgcmVhZC1jeWNsZXMgZXZlbnQiLA0KPiArICAg
ICAgICAgICAiRXZlbnRDb2RlIjogIjB4MmEiLA0KPiArICAgICAgICAgICAiRXZlbnROYW1lIjog
ImlteDhfZGRyLnJlYWRfY3ljbGVzIiwNClNhbWUgaGVyZS4NCg0KPiArICAgICAgICAgICAiVW5p
dCI6ICJpbXg4X2RkciIsDQo+ICsgICAgICAgICAgICJDb21wYXQiOiAiaS5NWDhNTSINCj4gKyAg
IH0sDQo+ICsgICB7DQo+ICsgICAgICAgICAgICJCcmllZkRlc2NyaXB0aW9uIjogImRkciB3cml0
ZS1jeWNsZXMgZXZlbnQiLA0KPiArICAgICAgICAgICAiRXZlbnRDb2RlIjogIjB4MmIiLA0KPiAr
ICAgICAgICAgICAiRXZlbnROYW1lIjogImlteDhfZGRyLndyaXRlX2N5Y2xlcyIsDQpTYW1lIGhl
cmUuDQoNCj4gKyAgICAgICAgICAgIlVuaXQiOiAiaW14OF9kZHIiLA0KPiArICAgICAgICAgICAi
Q29tcGF0IjogImkuTVg4TU0iDQo+ICsgICB9LA0KPiArICAgew0KPiArICAgICAgICAgICAiQnJp
ZWZEZXNjcmlwdGlvbiI6ICJkZHIgcmVhZCBldmVudCIsDQo+ICsgICAgICAgICAgICJFdmVudENv
ZGUiOiAiMHgzNSIsDQo+ICsgICAgICAgICAgICJFdmVudE5hbWUiOiAiaW14OF9kZHIucmVhZCIs
DQpTYW1lIGhlcmUuDQoNCj4gKyAgICAgICAgICAgIlVuaXQiOiAiaW14OF9kZHIiLA0KPiArICAg
ICAgICAgICAiQ29tcGF0IjogImkuTVg4TU0iDQo+ICsgICB9LA0KPiArICAgew0KPiArICAgICAg
ICAgICAiQnJpZWZEZXNjcmlwdGlvbiI6ICJkZHIgd3JpdGUgZXZlbnQiLA0KPiArICAgICAgICAg
ICAiRXZlbnRDb2RlIjogIjB4MzgiLA0KPiArICAgICAgICAgICAiRXZlbnROYW1lIjogImlteDhf
ZGRyLndyaXRlIiwNClNhbWUgaGVyZS4NCg0KPiArICAgICAgICAgICAiVW5pdCI6ICJpbXg4X2Rk
ciIsDQo+ICsgICAgICAgICAgICJDb21wYXQiOiAiaS5NWDhNTSINCj4gKyAgIH0NCj4gK10NCj4g
Kw0KPiArDQo+IGRpZmYgLS1naXQNCj4gYS90b29scy9wZXJmL3BtdS1ldmVudHMvYXJjaC9hcm02
NC9mcmVlc2NhbGUvaW14OG1tL3N5cy9tZXRyaWNzLmpzb24NCj4gYi90b29scy9wZXJmL3BtdS1l
dmVudHMvYXJjaC9hcm02NC9mcmVlc2NhbGUvaW14OG1tL3N5cy9tZXRyaWNzLmpzb24NCj4gbmV3
IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAwLi5lYzAwMjEyMzM2ZGUNCj4g
LS0tIC9kZXYvbnVsbA0KPiArKysgYi90b29scy9wZXJmL3BtdS1ldmVudHMvYXJjaC9hcm02NC9m
cmVlc2NhbGUvaW14OG1tL3N5cy9tZXRyaWNzLmpzb24NCj4gQEAgLTAsMCArMSwxOCBAQA0KPiAr
Ww0KPiArICAgew0KPiArCSAgICAiQnJpZWZEZXNjcmlwdGlvbiI6ICJieXRlcyBhbGwgbWFzdGVy
cyByZWFkIGZyb20gZGRyIGJhc2VkIG9uDQo+IHJlYWQtY3ljbGVzIGV2ZW50IiwNCj4gKwkgICAg
Ik1ldHJpY05hbWUiOiAiaW14OG1tX2Rkcl9yZWFkLmFsbCIsDQo+ICsJICAgICJNZXRyaWNFeHBy
IjogImlteDhfZGRyLnJlYWRfY3ljbGVzICogNCAqIDQiLA0KPiArCSAgICAiU2NhbGVVbml0Ijog
IjkuNzY1NjI1ZS1LQiIsDQoNCkEgdHlwbywgc2hvdWxkIGJlICJTY2FsZVVuaXQiOiAiOS43NjU2
MjVlLTRLQiIuDQoNCkJlc3QgUmVnYXJkcywNCkpvYWtpbSBaaGFuZw0KPiArCSAgICAiVW5pdCI6
ICJpbXg4X2RkciIsDQo+ICsJICAgICJDb21wYXQiOiAiaS5NWDhNTSINCj4gKyAgICB9LA0KPiAr
ICAgew0KPiArCSAgICAiQnJpZWZEZXNjcmlwdGlvbiI6ICJieXRlcyBhbGwgbWFzdGVycyB3cml0
ZSB0byBkZHIgYmFzZWQgb24NCj4gd3JpdGUtY3ljbGVzIGV2ZW50IiwNCj4gKwkgICAgIk1ldHJp
Y05hbWUiOiAiaW14OG1tX2Rkcl93cml0ZS5hbGwiLA0KPiArCSAgICAiTWV0cmljRXhwciI6ICJp
bXg4X2Rkci53cml0ZV9jeWNsZXMgKiA0ICogNCIsDQo+ICsJICAgICJTY2FsZVVuaXQiOiAiOS43
NjU2MjVlLTRLQiIsDQo+ICsJICAgICJVbml0IjogImlteDhfZGRyIiwNCj4gKwkgICAgIkNvbXBh
dCI6ICJpLk1YOE1NIg0KPiArICAgIH0NCj4gK10NCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYv
cG11LWV2ZW50cy9qZXZlbnRzLmMgYi90b29scy9wZXJmL3BtdS1ldmVudHMvamV2ZW50cy5jDQo+
IGluZGV4IDJlNTgxYmQ5YjBhNi4uYjRiZDQ4YjA3NmZkIDEwMDY0NA0KPiAtLS0gYS90b29scy9w
ZXJmL3BtdS1ldmVudHMvamV2ZW50cy5jDQo+ICsrKyBiL3Rvb2xzL3BlcmYvcG11LWV2ZW50cy9q
ZXZlbnRzLmMNCj4gQEAgLTI1Nyw2ICsyNTcsNyBAQCBzdGF0aWMgc3RydWN0IG1hcCB7DQo+ICAJ
eyAiaGlzaV9zY2NsLGhoYSIsICJoaXNpX3NjY2wsaGhhIiB9LA0KPiAgCXsgImhpc2lfc2NjbCxs
M2MiLCAiaGlzaV9zY2NsLGwzYyIgfSwNCj4gIAkvKiBpdCdzIG5vdCByZWFsaXN0aWMgdG8ga2Vl
cCBhZGRpbmcgdGhlc2UsIHdlIG5lZWQgc29tZXRoaW5nIG1vcmUNCj4gc2NhbGFibGUgLi4uICov
DQo+ICsJeyAiaW14OF9kZHIiLCAiaW14OF9kZHIiIH0sDQo+ICAJeyAic21tdXYzX3BtY2ciLCAi
c21tdXYzX3BtY2ciIH0sDQo+ICAJeyAiTDNQTUMiLCAiYW1kX2wzIiB9LA0KPiAgCXt9DQo+IC0t
DQo+IDIuMjYuMg0KDQo=
