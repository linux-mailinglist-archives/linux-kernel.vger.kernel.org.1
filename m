Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A809D2C46DB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 18:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732807AbgKYRds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 12:33:48 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:42814 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730608AbgKYRdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 12:33:47 -0500
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0APHS3i0005414;
        Wed, 25 Nov 2020 17:33:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=yLIlhwCTbKixOSuv89T11DWMcmJZsLrc61jwdbaQ01s=;
 b=Er+LqKXD8YLr59QTogWTxjQLcVQTjrcj58NDbtSyjDFHEVwQUlhccn4IuebxD4NO4bFa
 PfHnQNAVT1h/4jAPxjwwuKO9K88I3OQhdqXuSzIWXC4UfAWBpTALgNY6/ZVapiwAzb5X
 MEAwyVFczyOsNfzDKxAP8NQo/0xFEp86qPiUEhlQmuXLy6/QYRjWZS6/ZCX5UJ2oDGyw
 eJXakQeGojg4jqrgp8eLgjMDsYdhiFrLMkghp1yMsIX8BP+zK5y4O7Abathhv8L55UH8
 5EiCgvqxBi3hYJ/p9TBorSou+oxBkRzd7h+d8OGb7+6w1TTD7ZYois6emttvfogIqMVA XQ== 
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0b-002e3701.pphosted.com with ESMTP id 351gycdgdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Nov 2020 17:33:06 +0000
Received: from G1W8106.americas.hpqcorp.net (g1w8106.austin.hp.com [16.193.72.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3425.houston.hpe.com (Postfix) with ESMTPS id 33495A1;
        Wed, 25 Nov 2020 17:33:05 +0000 (UTC)
Received: from G9W8672.americas.hpqcorp.net (16.220.49.31) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 25 Nov 2020 17:33:05 +0000
Received: from G9W9209.americas.hpqcorp.net (2002:10dc:429c::10dc:429c) by
 G9W8672.americas.hpqcorp.net (2002:10dc:311f::10dc:311f) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Wed, 25 Nov 2020 17:33:04 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (15.241.52.11) by
 G9W9209.americas.hpqcorp.net (16.220.66.156) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Wed, 25 Nov 2020 17:33:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQnyH2O02MAw4D+wHu8DaHrMMW25knaaV8w2QX8ffF6Eu5nODGK9WeubtxWSKcTJ4HPAJWs1B6I67w95xUT6DwaurtWAxc4eP5pwu5BmqxKjchNRHYdHW/5ccBMG//dZT2Qot9qEch8lbmQsN7cS4Ly0fkVbzDINe003ciz6M/woDfreqH7/VY+Uwtr8VdylQ9r2bpjBTfRQzBIrxoNK76HAtKoL49s8gUCb7FsSzbW/baEkXalOJ8X4Ey083yHH2ngdvVTWgs6QuKDu5pr21vW6XEZ4jusUK1CmkYo0sykaKKzAVqoJFF9lffcpXs7OW6Gm2HGTo3qIdwEvxI9CQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLIlhwCTbKixOSuv89T11DWMcmJZsLrc61jwdbaQ01s=;
 b=aWZF3+BEbvRwYMo9tuD8z69Azz+WHCJ8nWjcZQ+MNcdJFi5tjmQdC47iXoIdBPSmGCJHyDE6pU7srK98CHrF/SObL7oOfqvQCd9uaHM9k4/yASaB+rrX41tggXu6hP0qfdNC//K1bKKBK2xqDsbyRAW9FnMqq02HdmixKWreIxA8efQaX6lgtHxHRsIVT4Bjj24K/Fy8XVGg5YcdtcOmJ2lBYy+88fLYpSMC5cAG8e0Yo/GOGLBd4VFwm+tMZaiXjoryDoGzZnCzLm2GbAo2YsyU/YdOGzwYxP2RtszUbiD25LYpZl9ddI55SuSeEHq86PWnH3vujThbVayyIS13mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from TU4PR8401MB1311.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7709::9) by TU4PR8401MB0799.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:770e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Wed, 25 Nov
 2020 17:33:03 +0000
Received: from TU4PR8401MB1311.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::4c2b:8a3f:7ddf:a7e]) by TU4PR8401MB1311.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::4c2b:8a3f:7ddf:a7e%4]) with mapi id 15.20.3589.030; Wed, 25 Nov 2020
 17:33:02 +0000
From:   "Ernst, Justin" <justin.ernst@hpe.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "Ingo Molnar" <mingo@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Wahl, Steve" <steve.wahl@hpe.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        "Travis, Mike" <mike.travis@hpe.com>
Subject: RE: [PATCH v2 0/5] Add uv_sysfs platform driver
Thread-Topic: [PATCH v2 0/5] Add uv_sysfs platform driver
Thread-Index: AQHWvcqVyHA7mbXxSEKqLRCB3ihmRqnXLqyAgAHqRvA=
Date:   Wed, 25 Nov 2020 17:33:02 +0000
Message-ID: <TU4PR8401MB13111832006369332C14E4E687FA0@TU4PR8401MB1311.NAMPRD84.PROD.OUTLOOK.COM>
References: <20201118164747.236259-1-justin.ernst@hpe.com>
 <dbf50917-8425-2eb8-8ccf-cf6645bd1891@redhat.com>
In-Reply-To: <dbf50917-8425-2eb8-8ccf-cf6645bd1891@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hpe.com;
x-originating-ip: [165.225.61.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d5009fc9-92f8-44e3-9cff-08d891682962
x-ms-traffictypediagnostic: TU4PR8401MB0799:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TU4PR8401MB0799465CA2A7394C9604862187FA0@TU4PR8401MB0799.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P1kP3A9fg9K7+5K1QqovQeFbuTETyycvot9CE6ELAI5WQyUtHjymxBmNWI/w2B8cJLZiF7apJGzjRBqmnWsbl8JSov8k/oD46toOtpU9xyM5ag1oDFZwYXTw7oI1gu0MXMsHPriu+3ivEn1jBINBCUbyDZQOjcEr2OdTE8u6notAaGwIyL0KxUgCFzZcG6XExoU1ToyPi49JcXwNCuuAPTrTblXaDmulfH9oT4jIYt+cjLj4snn4+VnnVSqp5foVnMNx05TFXh8GfbCx8cjpoWhgSFFcJZ8T1BsP+7nUDiTNfJvoxzrf3WpwrWjOYHw69BQbaP9Xcs8/hPsjl/BwXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TU4PR8401MB1311.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(136003)(39860400002)(346002)(396003)(366004)(66446008)(66556008)(54906003)(86362001)(9686003)(64756008)(55236004)(2906002)(316002)(4326008)(83380400001)(53546011)(66476007)(110136005)(76116006)(8676002)(66946007)(8936002)(71200400001)(33656002)(55016002)(7416002)(186003)(52536014)(5660300002)(6506007)(26005)(7696005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 2+2zTPE03VoKAkyTgwGJsr1/SevN9k9C7/OJLwyXJqkQmw9ryNlBEhqyeHnKCMr6mZqeUYcy0JopL6lsXi2U5QNzoNb8b5QKloQEsDaYTz2H32TfHJnPA89bVZqJRfwtnt7FPOiFp+J3sKuE3BdEoqmxOZvsL55A5xkZ0RulBDvZkXRssoVG+1kcVonLBdNtNBAA6BBAI1oYaNJwCQmI8eqM6kjXNg4MdVjTOM9Vp6WObAVSrQOVV6y4gtPIQKw1uSXtOt37Lnq4AJq8gybRmGrrU+1Qq7cT1mowgmF4kuc6A3deI0aChgfJjJz7Bo2dDdo543p5zxPrXS0TkrT9twpRXdXhmL26ewQ80xhc4sxCELr025ZMNHna6FN3St/HoUuoHfTHnKS8bkKKToDu64yMXkzJyqm8MIYo8iyA4Gn5oTNPSsSv/0kGWkFTWyUcWX2KZ/KembOl0qjua83XTrGApmMqx9F0DgFVm6pyTVgGFCVtXCgz2RukKYuejkD1dAzCS9YLLT+4m0NqAZOfhmMYYj/aKRypFJqAwlMTHif9AV+Q8pIbhN1U6PQ+72Ta4/StSWdrHNeY2J8wnGNah0L2zS/etRs1s4vCF5rWmhzKOgV/ZA9rxmTO5RLT2rCnv+EdKhJW42TxdKh7CKevKA/5YG5cwnjVohJELeVyNDUhjSv/jwSn9iJa9ostCtj/Fg7ZsCf+fFsCCCm91OXgQWUetWC2oVPnVkzypsaaYf8a1rGtrfQdZdytq065vTX7KzNVvSa7rNJDnygs9jJJgWh1KuluCMU17r2L+TriyOzzRwtx8pl9qeD7Ebesvy+zhgxvvALqkhjkWp6i7PHToqZwzDqncS9kaBF3JTxYwAhu2aTKMvPomj1P88tIZxh/Our2BcEB+spVkJ7ed2S7gA==
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TU4PR8401MB1311.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d5009fc9-92f8-44e3-9cff-08d891682962
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 17:33:02.7721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KCSUht/1mWAzWHP8JaLXPQpeo2wGa+jQQS+fmby/P3FlL6+VnEn6AkjsoX3EXRbXg5VvLMk8ZqHzNHoF/fgTDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TU4PR8401MB0799
X-OriginatorOrg: hpe.com
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-25_10:2020-11-25,2020-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011250110
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGFucywNClRoYW5rIHlvdSBmb3IgeW91ciBBY2sgb2YgbXkgcGF0Y2ggc2V0Lg0KDQpJJ3ZlIGZv
dW5kIGEgY291cGxlIGJ1Z3MgdGhhdCBuZWVkIGZpeGluZzoNCg0KMS4gSW4gbXkgcmUtaW50cm9k
dWN0aW9uIG9mIC9zeXMvZmlybXdhcmUvc2dpX3V2L2NvaGVyZW5jZV9pZCwgSSBmYWlsZWQgdG8g
ZXhwb3J0IHRoZSBhc3NvY2lhdGVkIHNuX2NvaGVyZW5jeV9pZCB2YXJpYWJsZSwgY2F1c2luZyB0
aGUgYnVpbGQgdG8gZmFpbCB3aGVuIFVWX1NZU0ZTPW0NCg0KMi4gQSBudWxsIHBvaW50ZXIgZGVy
ZWZlcmVuY2UgaW4gZHJpdmVycy9wbGF0Zm9ybS94ODYvdXZfc3lzZnMuYzp1dl9wb3J0c19leGl0
KCkgY2F1c2VkIGJ5IGNhbGxpbmcga29iamVjdF9wdXQoKSBvbiBhbiBvdXQgb2YgcmFuZ2UgaW5k
ZXggdmFsdWUuDQoNCkkgd2lsbCBiZSByZXN1Ym1pdHRpbmcgdGhlIHBhdGNoIHNlcmllcyBzaG9y
dGx5IGFzIHYzLg0KDQpJIGFwb2xvZ2l6ZSBmb3IgdGhlIGhpY2N1cC4NCg0KVGhhbmtzLA0KSnVz
dGluDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGFucyBkZSBHb2Vk
ZSBbbWFpbHRvOmhkZWdvZWRlQHJlZGhhdC5jb21dDQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVy
IDI0LCAyMDIwIDU6MzAgQU0NCj4gVG86IEVybnN0LCBKdXN0aW4gPGp1c3Rpbi5lcm5zdEBocGUu
Y29tPjsgQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+OyBJbmdvIE1vbG5hcg0KPiA8bWlu
Z29AcmVkaGF0LmNvbT47IE1hcmsgR3Jvc3MgPG1ncm9zc0BsaW51eC5pbnRlbC5jb20+OyBUaG9t
YXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT47IFdhaGwsDQo+IFN0ZXZlIDxzdGV2ZS53
YWhsQGhwZS5jb20+OyB4ODZAa2VybmVsLm9yZw0KPiBDYzogQW5keSBTaGV2Y2hlbmtvIDxhbmR5
QGluZnJhZGVhZC5vcmc+OyBEYXJyZW4gSGFydCA8ZHZoYXJ0QGluZnJhZGVhZC5vcmc+OyBTaXZh
bmljaCwgRGltaXRyaQ0KPiA8ZGltaXRyaS5zaXZhbmljaEBocGUuY29tPjsgSCAuIFBldGVyIEFu
dmluIDxocGFAenl0b3IuY29tPjsgQW5kZXJzb24sIFJ1c3MgPHJ1c3MuYW5kZXJzb25AaHBlLmNv
bT47DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHBsYXRmb3JtLWRyaXZlci14ODZA
dmdlci5rZXJuZWwub3JnOyBDZXphcnkgUm9qZXdza2kNCj4gPGNlemFyeS5yb2pld3NraUBpbnRl
bC5jb20+OyBJbHlhIERyeW9tb3YgPGlkcnlvbW92QGdtYWlsLmNvbT47IEpvbmF0aGFuIENhbWVy
b24NCj4gPEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT47IE1hdXJvIENhcnZhbGhvIENoZWhh
YiA8bWNoZWhhYitodWF3ZWlAa2VybmVsLm9yZz47IFZhaWJoYXYgSmFpbg0KPiA8dmFpYmhhdkBs
aW51eC5pYm0uY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDAvNV0gQWRkIHV2X3N5c2Zz
IHBsYXRmb3JtIGRyaXZlcg0KPiANCj4gSGksDQo+IA0KPiBRdWljayBzZWxmIGludHJvIGZvciB0
aGUgeDg2L3RpcCBtYWludGFpbmVyczogSSBoYXZlIHRha2Ugb3Zlcg0KPiBkcml2ZXJzL3BsYXRm
b3JtL3g4NiBtYWludGFpbmVyc2hpcCBmcm9tIEFuZHkuDQo+IA0KPiBPbiAxMS8xOC8yMCA1OjQ3
IFBNLCBKdXN0aW4gRXJuc3Qgd3JvdGU6DQo+ID4gSW50cm9kdWNlIGEgbmV3IHBsYXRmb3JtIGRy
aXZlciB0byBnYXRoZXIgdG9wb2xvZ3kgaW5mb3JtYXRpb24gZnJvbSBVViBzeXN0ZW1zDQo+ID4g
YW5kIGV4cG9zZSB0aGF0IGluZm9ybWF0aW9uIHZpYSBhIHN5c2ZzIGludGVyZmFjZSBhdCAvc3lz
L2Zpcm13YXJlL3NnaV91di8uDQo+ID4NCj4gPiBUaGlzIGlzIHZlcnNpb24gMiB3aXRoIHRoZXNl
IGNoYW5nZXMgc2luY2UgdmVyc2lvbiAxOg0KPiA+DQo+ID4gICogUmUtaW50cm9kdWNlZCAvc3lz
L2Zpcm13YXJlL3NnaV91di9jb2hlcmVuY2VfaWQgZmlsZSBpbiB0aGUgbmV3IGRyaXZlciBhZnRl
cg0KPiA+IAlyZW1vdmluZyBpdCBpbiBQYXRjaCAxLzUuIFRoaXMga2VlcHMgdGhlIHVzZXJzcGFj
ZSBBUEkgdW5icm9rZW4uDQo+ID4NCj4gPiBKdXN0aW4gRXJuc3QgKDUpOg0KPiA+ICAgeDg2L3Bs
YXRmb3JtL3V2OiBSZW1vdmUgZXhpc3RpbmcgL3N5cy9maXJtd2FyZS9zZ2lfdXYvIGludGVyZmFj
ZQ0KPiA+ICAgeDg2L3BsYXRmb3JtL3V2OiBBZGQgYW5kIGV4cG9ydCB1dl9iaW9zXyogZnVuY3Rp
b25zDQo+ID4gICB4ODYvcGxhdGZvcm0vdXY6IEFkZCBuZXcgdXZfc3lzZnMgcGxhdGZvcm0gZHJp
dmVyDQo+ID4gICB4ODYvcGxhdGZvcm0vdXY6IFVwZGF0ZSBBQkkgZG9jdW1lbnRhdGlvbiBvZiAv
c3lzL2Zpcm13YXJlL3NnaV91di8NCj4gPiAgIHg4Ni9wbGF0Zm9ybS91djogVXBkYXRlIE1BSU5U
QUlORVJTIGZvciB1dl9zeXNmcyBkcml2ZXI+DQo+ID4gIC4uLi9BQkkvdGVzdGluZy9zeXNmcy1m
aXJtd2FyZS1zZ2lfdXYgICAgICAgICB8IDE0MSArKy0NCj4gPiAgTUFJTlRBSU5FUlMgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA2ICsNCj4gPiAgYXJjaC94ODYvaW5jbHVk
ZS9hc20vdXYvYmlvcy5oICAgICAgICAgICAgICAgIHwgIDQ5ICsNCj4gPiAgYXJjaC94ODYvaW5j
bHVkZS9hc20vdXYvdXZfZ2VvLmggICAgICAgICAgICAgIHwgMTAzICsrKw0KPiA+ICBhcmNoL3g4
Ni9wbGF0Zm9ybS91di9NYWtlZmlsZSAgICAgICAgICAgICAgICAgfCAgIDIgKy0NCj4gPiAgYXJj
aC94ODYvcGxhdGZvcm0vdXYvYmlvc191di5jICAgICAgICAgICAgICAgIHwgIDU0ICsrDQo+ID4g
IGFyY2gveDg2L3BsYXRmb3JtL3V2L3V2X3N5c2ZzLmMgICAgICAgICAgICAgICB8ICA2MyAtLQ0K
PiA+ICBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9LY29uZmlnICAgICAgICAgICAgICAgICAgfCAgMTEg
Kw0KPiA+ICBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9NYWtlZmlsZSAgICAgICAgICAgICAgICAgfCAg
IDMgKw0KPiA+ICBkcml2ZXJzL3BsYXRmb3JtL3g4Ni91dl9zeXNmcy5jICAgICAgICAgICAgICAg
fCA4NjIgKysrKysrKysrKysrKysrKysrDQo+ID4gIDEwIGZpbGVzIGNoYW5nZWQsIDEyMTYgaW5z
ZXJ0aW9ucygrKSwgNzggZGVsZXRpb25zKC0pDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNo
L3g4Ni9pbmNsdWRlL2FzbS91di91dl9nZW8uaA0KPiA+ICBkZWxldGUgbW9kZSAxMDA2NDQgYXJj
aC94ODYvcGxhdGZvcm0vdXYvdXZfc3lzZnMuYw0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJp
dmVycy9wbGF0Zm9ybS94ODYvdXZfc3lzZnMuYw0KPiANCj4gU28gdGhpcyB0b3VjaGVzIGZpbGVz
IHVuZGVyIGJvdGggYXJjaC94ODYvIGFuZCBkcml2ZXJzL3BsYXRmb3JtL3g4Ni8gLA0KPiBJIGJl
bGlldmUgdGhpcyBpcyBiZXN0IG1lcmdlZCB0aHJvdWdoIHRoZSB4ODYvdGlwIHRyZWUgYW5kIEkg
ZG9uJ3QNCj4gZXhwZWN0IGNvbmZsaWN0cyBmb3IgdGhlIGRyaXZlcnMvcGxhdGZvcm0veDg2L3tL
Y29uZmlnLE1ha2VmaWxlfSBjaGFuZ2VzLg0KPiANCj4gU28gaGVyZSBpcyBteSBhY2sgZm9yIG1l
cmdpbmcgdGhpcyBzZXJpZXMgdGhyb3VnaCB0aGUgeDg2L3RpcCB0cmVlOg0KPiANCj4gQWNrZWQt
Ynk6IEhhbnMgZGUgR29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+DQo+IA0KPiBSZWdhcmRzLA0K
PiANCj4gSGFucw0KPiANCg0K
