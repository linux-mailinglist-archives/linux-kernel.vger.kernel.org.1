Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBFC2C42B4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 16:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbgKYPL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 10:11:29 -0500
Received: from mail-eopbgr1310052.outbound.protection.outlook.com ([40.107.131.52]:4470
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730030AbgKYPL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 10:11:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJxJjK8qQlAEIwn8/EBQ1tN4orFj48FAqTdRxRw/GUDvHXjBCdlfwUii+kMfhdpJkuiwpEHMeBo1fCjmjBc6+4skGTAZu1DTX7VIbWNGAwRzOJtpStC7oroZF1ghAZmhgjxCQneZ3/PEmT3qz0MeFksuxNeagXjqKJ8JLO2e629I9rPCKmGdJQJncgyxwtDiULxz42QgpHSSDdcwSn4hrfH86j/2tz5JdI12G4GgpoJqo1ShYcatupYXG35A9KvclV6Z6A5shiUUnxoilB1f+YpClHZc+xIeTZUYlmfFxeTzUiFDWXliODgM2fAw+Wx76mOMae+LW2JZlX9+XjV3Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSAMH5niaPvslgMFM4kx7dGzXWx/EvQYwiLpArzQfS8=;
 b=FQud4ZChKoDVPF0VW6d0hmEP01dxW6dCaFZpolMxV4EDOPG84jc3aKntB/1AMyjIB+o6/JWhdnpVihKL2doMN155rSYA3xYPe6phgQ6d+IBB3xcO8n6KmZmAuGfaF12VCttg8cBvROuuc3kohWQOIJZUk3UmrFO26uVr6JSoJSWkpwV+/rJu6MKhCnsvCqWU7DcJacWyLT4o1Pg5U6PuBeJ5zyC/bS3DONe29UTxEXSSyEiTuuqVpenPf1x7MfrJpCt706pdMJjmFe16I29E4Wc+kMzIGK8DPN7KsXZeCmLSnUy5JyGueS9OCmvNXTY9dmRbTYTvKQz9gWwsDzyosA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oppoglobal.onmicrosoft.com; s=selector1-oppoglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSAMH5niaPvslgMFM4kx7dGzXWx/EvQYwiLpArzQfS8=;
 b=bJKIjjaqqO3SEWeGf2KQfBSrQ1q3dXSmhpnjCrK80h3cGA8qr5qbHkdcTnITRDLooFlcxZeOHnEmIkN4jksXqPF89puphpSnzwF4y9Ls66E74J0TwsM/i1R8ShntMcxVznXp2tCbalZmLZ4QOtLj8DwMze21VXcH8tmPpsFu5n8=
Received: from HKAPR02MB4291.apcprd02.prod.outlook.com (2603:1096:203:d3::12)
 by HKAPR02MB4291.apcprd02.prod.outlook.com (2603:1096:203:d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.21; Wed, 25 Nov
 2020 15:11:21 +0000
Received: from HKAPR02MB4291.apcprd02.prod.outlook.com
 ([fe80::b9b8:aaf4:2afd:218b]) by HKAPR02MB4291.apcprd02.prod.outlook.com
 ([fe80::b9b8:aaf4:2afd:218b%3]) with mapi id 15.20.3611.022; Wed, 25 Nov 2020
 15:11:21 +0000
From:   =?utf-8?B?5b2t5rWpKFJpY2hhcmQp?= <richard.peng@oppo.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        "Suravee.Suthikulpanit@amd.com" <Suravee.Suthikulpanit@amd.com>
CC:     =?utf-8?B?a3ZtQHZnZXIua2VybmVsLm9yZ++8mw==?= <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] kvm/svm: fixed a potential register value inconsistent with
 variable ldr_reg
Thread-Topic: [PATCH] kvm/svm: fixed a potential register value inconsistent
 with variable ldr_reg
Thread-Index: AdbDPIYAtahQn+j1QPG6f/U6g0KNpg==
Date:   Wed, 25 Nov 2020 15:11:20 +0000
Message-ID: <HKAPR02MB429179237547D0B00A2F2C6FE0FA0@HKAPR02MB4291.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oppo.com;
x-originating-ip: [58.252.5.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d72e7c1-5ba5-4f90-d875-08d891545dd3
x-ms-traffictypediagnostic: HKAPR02MB4291:
x-microsoft-antispam-prvs: <HKAPR02MB42913C34B20F880FAA73A98FE0FA0@HKAPR02MB4291.apcprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GQvokqTCLsW9iHehWZYBlcRnHG6ry1An3ryqm96+Uugip2Mst9WMGsAwcCx1R4hlSa7INZ+m651e+ZLfmiJ0RohuY2P7AQHWhIBeXLPhGIsOadR8pR87kczoZiTNIdCVQSKk4BPFmJfKAduzVoTwRyetCXT3+egy41t/LoB2kJs/o8LDF+GujxlZlqoMPv2DNL6JYlEHyPSON3Xn5FYMp07wbDUogoXLVwdTTSLmW08TegNJa8z9iJY0QlgXLh8McNjTUS2odILds/TdeXogizO9GGvAHNqqeEtjdklLuJZlFYrvPjgy245dYJ0IZp+fFZrKGAz7uQIgYIchrfhDDSJZ7btuXW0eFlDl5Fc1qFlhfdUQBZ8ARlz72NoxDMyY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HKAPR02MB4291.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(85182001)(26005)(66946007)(7696005)(64756008)(66446008)(71200400001)(52536014)(66476007)(66556008)(33656002)(316002)(5660300002)(478600001)(8676002)(8936002)(83380400001)(76116006)(86362001)(55016002)(9686003)(110136005)(6506007)(186003)(4326008)(2906002)(11606006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YkQ2MUlCVWhDWnlWWXpGbEtUQmVubkl2Vm1obS92R0w1ZnNwVlhMajdEaWRk?=
 =?utf-8?B?dDJYSnQ2TVhiVW9ISS8xKzdQT1B2OUZQcU4xbzh6K1l6a09sV1pSdDk2MExM?=
 =?utf-8?B?QUJLWThjS0ZDTVp3QUR3MHNHNG1EWmNRMVdSNHd5TmYvVUd0Q3FBT1dmVmVk?=
 =?utf-8?B?RkEwVGUrL1YxT0tlWUIvNmlOSjF3T0wrekRxRE5QcUlSMExGVGNGbHNobG53?=
 =?utf-8?B?bGIraEdSNnNVcmpQSmpNaEt4bVd3OGUwWDlxMWhPWncvbER0WEY5YkVYZ1ZB?=
 =?utf-8?B?d0VYQXZCeFVaNHpCaTZoQ0lOdGhIOERHejNKVXcvRGlNZThXSFliNGJRUGdC?=
 =?utf-8?B?TWVXandmV084b0dkem02Mnk0RnJDVW14L1I1bkpMQ1o3ZnlUUnpRRFloTFZB?=
 =?utf-8?B?c2FRQUdkcU90Ky8zNm1Yc293ZisveTZqcjJoZVhhWTFpN3VPd3hJckNVOUwv?=
 =?utf-8?B?UzRVQ2sva1JEdVBHMGdyYnAybXAySVBvVmRUdWtLUGFTcXg5ejlXMmJwUlFx?=
 =?utf-8?B?TGdsekEzUHRVOVJOWTVoYi9qdGJyUVRlTjhTUjZGYjlIVEUycytBaTFwaDk1?=
 =?utf-8?B?V1ZXR0lodS96TnROZVVIR0ViZVVGZ2duV3A5OG9aTG5taktMeUVQNHNyVkhh?=
 =?utf-8?B?RjBSR0hXN290MldlWjJIaHlFb1lXbStqTkFxSU52YzZzRWZrOU5KZzhYMzNs?=
 =?utf-8?B?SlhPL2pBOGQ3ZXBzSEpnM0VrNG8ra3pnLzg2aEFoODcwNDIzU2hFam1YUHZs?=
 =?utf-8?B?UlMxMU9RUFI4L1l0bWM3M3E0d00xNXgyZ0FTYkNoaklYVlovN0oxSGJOMXk4?=
 =?utf-8?B?enpWSTkraGNwM2JJM25wOWtKVSt0bDdvUlo2MWlOeWFGZjVraWErblk1aGpD?=
 =?utf-8?B?bXl0dE1WSDB1RnBSd09GVDF6ZHUrVXJ2TjVFNzN0TGttSm0wK3BSVStwZWZH?=
 =?utf-8?B?MHlETU5PQThreXlaOXVMTzJPcHgrUHhFdUpGM3lCOWxEWHlWQWc2TUZPWUdi?=
 =?utf-8?B?cis3Q1BzRlRHb2RNMm56NWtNOXFnOUM1T3pudUdBbXc0dFRxZ0NoaVJ1RnhO?=
 =?utf-8?B?c2lnaHo1cXg4Ymx4aXFjUGZwSHplUFYzczR1Z0pibVZMcmZRWnU2RFBXOWl3?=
 =?utf-8?B?V28xNnVySkZjU1Z6M1J2VE1FYzNBSFlmWllncjhTWGVqZktUc25hZUFLL3Yv?=
 =?utf-8?B?T290V2hielhzc1hheUM1RjVwWFhrMmlNTzAvQWlTYU5hWFliZWFJOEszQnlz?=
 =?utf-8?B?aUxWUkRxclEvWXF2U2dvZU9wMSsrTURIU050Uk5oRHd3alUxQzJGajYrWVp6?=
 =?utf-8?Q?g21ihEoympIo4=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HKAPR02MB4291.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d72e7c1-5ba5-4f90-d875-08d891545dd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 15:11:20.8886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wNs6EJTutulFphl1nwxdDtm+52t8Z1VHR2r3fkcspCNG29o1U/wKeWT/XbzF5bRG933J75/CNCP6CRPj6gCK4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HKAPR02MB4291
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SWYgdGhlIGxkciB2YWx1ZSBpcyByZWFkIG91dCB0byB6ZXJvLCBpdCBkb2VzIG5vdCBjYWxsIGF2
aWNfbGRyX3dyaXRlIHRvIHVwZGF0ZQ0KdGhlIHZpcnR1YWwgcmVnaXN0ZXIsIGJ1dCB0aGUgdmFy
aWFibGUgbGRyX3JlZyBpcyB1cGRhdGVkLg0KDQpGaXhlczogOThkOTA1ODJiZTJlICgiU1ZNOiBG
aXggQVZJQyBERlIgYW5kIExEUiBoYW5kbGluZyIpDQpTaWduZWQtb2ZmLWJ5OiBQZW5nIEhhbyA8
cmljaGFyZC5wZW5nQG9wcG8uY29tPg0KLS0tDQogYXJjaC94ODYva3ZtL3N2bS9hdmljLmMgfCAx
NCArKysrKysrKy0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDYgZGVs
ZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vc3ZtL2F2aWMuYyBiL2FyY2gv
eDg2L2t2bS9zdm0vYXZpYy5jDQppbmRleCA4YzU1MDk5OWFjZTAuLjMxODczNWUwZjJkMCAxMDA2
NDQNCi0tLSBhL2FyY2gveDg2L2t2bS9zdm0vYXZpYy5jDQorKysgYi9hcmNoL3g4Ni9rdm0vc3Zt
L2F2aWMuYw0KQEAgLTQxNyw3ICs0MTcsNiBAQCBzdGF0aWMgdm9pZCBhdmljX2ludmFsaWRhdGVf
bG9naWNhbF9pZF9lbnRyeShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpDQoNCiBzdGF0aWMgaW50IGF2
aWNfaGFuZGxlX2xkcl91cGRhdGUoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KQ0KIHsNCi0gICAgICAg
aW50IHJldCA9IDA7DQogICAgICAgIHN0cnVjdCB2Y3B1X3N2bSAqc3ZtID0gdG9fc3ZtKHZjcHUp
Ow0KICAgICAgICB1MzIgbGRyID0ga3ZtX2xhcGljX2dldF9yZWcodmNwdS0+YXJjaC5hcGljLCBB
UElDX0xEUik7DQogICAgICAgIHUzMiBpZCA9IGt2bV94YXBpY19pZCh2Y3B1LT5hcmNoLmFwaWMp
Ow0KQEAgLTQyNywxMyArNDI2LDE2IEBAIHN0YXRpYyBpbnQgYXZpY19oYW5kbGVfbGRyX3VwZGF0
ZShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpDQoNCiAgICAgICAgYXZpY19pbnZhbGlkYXRlX2xvZ2lj
YWxfaWRfZW50cnkodmNwdSk7DQoNCi0gICAgICAgaWYgKGxkcikNCisgICAgICAgaWYgKGxkcikg
ew0KKyAgICAgICAgICAgICAgIGludCByZXQ7DQogICAgICAgICAgICAgICAgcmV0ID0gYXZpY19s
ZHJfd3JpdGUodmNwdSwgaWQsIGxkcik7DQoNCi0gICAgICAgaWYgKCFyZXQpDQotICAgICAgICAg
ICAgICAgc3ZtLT5sZHJfcmVnID0gbGRyOw0KLQ0KLSAgICAgICByZXR1cm4gcmV0Ow0KKyAgICAg
ICAgICAgICAgIGlmICghcmV0KQ0KKyAgICAgICAgICAgICAgICAgICAgICAgc3ZtLT5sZHJfcmVn
ID0gbGRyOw0KKyAgICAgICAgICAgICAgIGVsc2UNCisgICAgICAgICAgICAgICAgICAgICAgIHJl
dHVybiByZXQ7DQorICAgICAgIH0NCisgICAgICAgcmV0dXJuIDA7DQp9DQoNCiBzdGF0aWMgaW50
IGF2aWNfaGFuZGxlX2FwaWNfaWRfdXBkYXRlKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkNCi0tDQoy
LjE4LjQNCg==
