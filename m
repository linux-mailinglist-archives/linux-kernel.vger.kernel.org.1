Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C17128B37E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 13:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387985AbgJLLMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 07:12:35 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:61152 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387635AbgJLLMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 07:12:35 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09CBCFAw022247;
        Mon, 12 Oct 2020 04:12:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=5l049TR5sUQin9S9yNTi46zIFmfy5mMRRTQLtnnbhEg=;
 b=jP8rUrBP5KMMeHUj/VXBI+mpyer2wX19yaMTM5qRTGcuTLWEUB0xwDI4GlLojkbOX056
 YVoeHJ69hEXqDOXypmsJ4aQLr8oOSmjWB3hgmYgXDb9pL98DFcj+7ZDJrfZOZ24Wbl/H
 koS4l27cU73vXv3eORJVR3vS0O7hs03f3ZRMi97+GWzCyvElKFzYRus/RqIXbMZgyytY
 XzhaodHn0neVgqPLy8pXvQ7PMdzyipGsV5Ks1feDdR/oae+Gyn/JuWiF0ntnFwuuR2bF
 64SEmFSDohRuHNAjbDX7g+pF6ck8pKH0wphWVs9gpdwuuyuoZj/yj3MxCDDX4Kcf5o2A xA== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3439gvwx5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Oct 2020 04:12:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMNrAd6lQDEzQUBeTyYDugw7iqhqA5tVKHxIXPToahesQ9g3412IZD4qpijUYFZDFjCX2uC10Mptmdwk56KBVdnFo7R9k1Xled1AtSAsikHsvuJV/W0RnQO8pvu6IaYjW04AgqjeZt2njYd40VmRw1xGaq8bGUeutHBQDj/O4Q6d2/0EhHNTZ38AXUqiZG2cQgWELPSF8gY1ITn6SIz9mwEQT5D4babMw+qzhuHkcdnw8C7njf7nsfnUzibIR68IzFgl/ysYyoPFOMO0fpLa3ab1fxTYhI1T4kaKws6cIMXxbBKVnamaK+YbrP9gMrQzupRTi+zyZnH/oBg2htcjPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5l049TR5sUQin9S9yNTi46zIFmfy5mMRRTQLtnnbhEg=;
 b=iEsgu1F7mZPvecnbEcNmom0i2kCDGU3rqp4H7RR1+zW/Hj8DOFdbRiNMqCMgEQ8O3gVA93pzSKYplDB8AF6lUU+0ycvuwdQSUA0S8mVns0XwxkXTgm+jB8u3QvwSDHAiep4zLs7wq8QnqnDZJYGt3kCljwtS8pfblX60I2fty8Rk9fesNLG5L2cRXlYDbmVCSLZmryFZDJOmWJDtpwM6JDVwNwlRUhgQ3aSJzirpIYiEaNf7U0DQnwtJ7I2ZNsy8MRuXXk5jqJRZt5VmTJ3kRlt64yQH6RaZWNinRLNk9Guww4mIFxTp1+xS2sActkEH9DrlLx4IOoCHTL2r/W0QNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5l049TR5sUQin9S9yNTi46zIFmfy5mMRRTQLtnnbhEg=;
 b=YiMZ1HiCTjAHzVtIY5glKIB7F6DKT5aa6kPg7WuDuSf+M2zfCpjJhZrZJIikwOF3976RqyfYIxpyyGcdSrWUT55J6qzvhV0iBUJpimiHAAzpiO6egmpfz4uNwmsLE2V4F2Qo17dBNY+ZHgBrW1pDs1+uGu0X8ur74xIH42mPR9M=
Received: from DM6PR07MB5529.namprd07.prod.outlook.com (2603:10b6:5:7a::30) by
 DM6PR07MB7977.namprd07.prod.outlook.com (2603:10b6:5:33::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.21; Mon, 12 Oct 2020 11:12:24 +0000
Received: from DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::2087:7f2b:5dc6:a960]) by DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::2087:7f2b:5dc6:a960%6]) with mapi id 15.20.3455.030; Mon, 12 Oct 2020
 11:12:24 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Roger Quadros <rogerq@ti.com>,
        "balbi@kernel.org" <balbi@kernel.org>
CC:     "peter.chen@nxp.com" <peter.chen@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v2] usb: cdns3: Rids of duplicate error message
Thread-Topic: [PATCH v2] usb: cdns3: Rids of duplicate error message
Thread-Index: AQHWoGM1FxWyT46v30e8Ja/DW+/1b6mTnxYAgAAk0IA=
Date:   Mon, 12 Oct 2020 11:12:23 +0000
Message-ID: <DM6PR07MB5529E8B3EC059F7DA43EEC25DD070@DM6PR07MB5529.namprd07.prod.outlook.com>
References: <20201012064256.8344-1-pawell@cadence.com>
 <e5ab2110-6bb0-ce06-be4f-010a030e307f@ti.com>
In-Reply-To: <e5ab2110-6bb0-ce06-be4f-010a030e307f@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctY2JhYjM4NGMtMGM3Yi0xMWViLTg3NmItMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGNiYWIzODRkLTBjN2ItMTFlYi04NzZiLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTgzNyIgdD0iMTMyNDY5NzQ3NDEzNTQxNDc0IiBoPSI4ZDhwM1Y2VWtJTXVCVkR2Rkx2TUtENU1IN3M9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f643dfe-47fa-4646-fc4f-08d86e9fb243
x-ms-traffictypediagnostic: DM6PR07MB7977:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR07MB7977B14FE764FE69576A42D3DD070@DM6PR07MB7977.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MNetEur9AVksy8HnYVhKo/rh01TjzKuxKrdMwBEcIAdwN3IbRNF+rFrVjC7yb72+OnyfObq09ae6fRh4fQpPyg6uvQgZh8wJxGLD406dk6CPc/5XuY8oSXr1WtEohVpg3OOQEM5Cusp9gDXiZKv9aYJhU/qgZBtjvlEkYYXCpXSv6sKm6utUqbRlrM3N3CD/IiEStnaewx1ZrHPcYxOmpvwBp0CjobczjekST5h5be1C79MqpAkhUw95K8gvo2oUojSvueM0et3lIz93JOtJ+l27IEooG+4KNfOtITY3Hwp7YAOnnAx7onCqIEayM8x1QfNiVqjpPl/2Ic9JwO/jJNbbGXZDPk0FdFjKRFn3UDQUxQbytAVPKxW3igP4slUx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB5529.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(36092001)(5660300002)(66946007)(76116006)(33656002)(107886003)(4326008)(86362001)(15650500001)(66446008)(66556008)(66476007)(64756008)(52536014)(2906002)(83380400001)(478600001)(71200400001)(186003)(8936002)(26005)(55016002)(7696005)(8676002)(54906003)(53546011)(6506007)(110136005)(9686003)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: OoGmdKqroGHm5jyTcZWNNNfHe2NM50uyH7o7IUXDoZy1BP8/gaV3XRXFBpTiaQMmjxu2bYGdU6fYu8smriCOHOrzWmwA1LxNSEOTNH41itZdE3oLRyLFGY/zntXRr+8hfZaWSHm75kWOET7UsyS891pe8BuLFxLKuB1d8PMVNRZ80azC0I8qHek+UCl6yEMrdu3ETrJTlZSqvluF4D6mr1L4EjUA1Ltx8Ft5mEQtKeacMsHRIvvO1Zgnh8G2ZvFaYYakUCCZg3sML3zKN7ogwghD9gqRztrXBCxJGPchKRYU3wRHoQ6DzpjYVPNsKklauP/sYKqpoxNcmsMNoCkMp19PAya8yMIKoj5EomJ9RWvmny17y4ZWh1D9cu9de5KV8soANsGPksXni/u/R+l5HFbqCi7sKu/ZGtLkSgVHvTaQMu/OfjC/EzldrY3CQbTs8YZ8ccijhvrVc78qwZmxFyIQWhELV8Olm4gHi+axTXLRSCTFsU9agXOgzQESJzd86xWK44Qgy2ZKtK6clwxWwmuIFa+cSEgssOXd5cgLqcsLEyf0xgnUzJ+8cCL+EfkvaROwDH0Nq7ZQ07Sf0dh9L98NGhAIrdqzRZU7marzCW1Lq9hubRgi0bHmG4O6JdURt05LoK+t2cjS94HKLGqZ0g==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB5529.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f643dfe-47fa-4646-fc4f-08d86e9fb243
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2020 11:12:24.0131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lB/um+izrRS44CFCz8a/XXf0qcN+2ZaXJhI85eM+TKF0Tc8MTzfh4QLQtXyfiKSOE/q3PP7AQs57WSttoJb3yXqsEXyikc05B+RyH6yVjIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB7977
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-12_09:2020-10-12,2020-10-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010120093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9nZXIsDQoNCk9uIDEyLzEwLzIwMjAgMDk6NDIsIFBhd2VsIExhc3pjemFrIHdyb3RlOg0K
PiBPbiBmYWlsdXJlLCB0aGUgcGxhdGZvcm1fZ2V0X2lycV9ieW5hbWUgcHJpbnRzIGFuIGVycm9y
IG1lc3NhZ2UNCj4gc28sIHBhdGNoIHJlbW92ZXMgZXJyb3IgbWVzc2FnZSByZWxhdGVkIHRvIHRo
aXMgZnVuY3Rpb24gZnJvbQ0KPiBjb3JlLmMgZmlsZS4NCj4gDQo+IEEgY2hhbmdlIHdhcyBzdWdn
ZXN0ZWQgZHVyaW5nIHJldmlld2luZyBDRE5TUCBkcml2ZXIgYnkgQ2h1bmZlbmcgWXVuLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogUGF3ZWwgTGFzemN6YWsgPHBhd2VsbEBjYWRlbmNlLmNvbT4NCj4g
LS0tDQo+IENoYW5nZWxvZzoNCj4gdjINCj4gLSBzaW1wbGlmaWVkIGNvZGUgYXMgc3VnZXN0ZWQg
YnkgUm9nZXIgUXVhZHJvcy4NCj4gDQo+ICAgZHJpdmVycy91c2IvY2RuczMvY29yZS5jIHwgMTAg
Ky0tLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgOSBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9jZG5zMy9jb3JlLmMgYi9kcml2
ZXJzL3VzYi9jZG5zMy9jb3JlLmMNCj4gaW5kZXggYTBmNzNkNDcxMWFlLi44NWVmMzAyNWIyOTMg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2NkbnMzL2NvcmUuYw0KPiArKysgYi9kcml2ZXJz
L3VzYi9jZG5zMy9jb3JlLmMNCj4gQEAgLTQ2OSwyMiArNDY5LDE0IEBAIHN0YXRpYyBpbnQgY2Ru
czNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gICAJaWYgKGNkbnMtPmRl
dl9pcnEgPT0gLUVQUk9CRV9ERUZFUikNCg0KU2hvdWxkbid0IHRoaXMgYmUNCglpZiAoY2Rucy0+
ZGV2X2lycSA8IDApDQo/DQoNCk5vLCBzdWNoIGxpbmUgd2lsbCBjaGFuZ2UgdGhlIG9yaWdpbmFs
IGJlaGF2aW9yIG9mIGRyaXZlci4NCg0KQ3VycmVudCBwYXRjaCBhbGxvd3MgdG8gcnVuIGRyaXZl
ciB3aGVuIHdlIHN1cHBvcnQgb25seSBob3N0LiANCkluIHN1Y2ggY2FzZSB0aGUgZGV2X2lycSBj
YW4gYmUgPCAwIGFuZCB3ZSBzdGlsbCBjYW4gdXNlIGhvc3QgIHNpZGUuDQoNClJlZ2FyZHMsDQpQ
YXdlbCBMYXN6Y3phaw0KDQo+ICAgCQlyZXR1cm4gY2Rucy0+ZGV2X2lycTsNCj4gICANCj4gLQlp
ZiAoY2Rucy0+ZGV2X2lycSA8IDApDQo+IC0JCWRldl9lcnIoZGV2LCAiY291bGRuJ3QgZ2V0IHBl
cmlwaGVyYWwgaXJxXG4iKTsNCj4gLQ0KPiAgIAlyZWdzID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFw
X3Jlc291cmNlX2J5bmFtZShwZGV2LCAiZGV2Iik7DQo+ICAgCWlmIChJU19FUlIocmVncykpDQo+
ICAgCQlyZXR1cm4gUFRSX0VSUihyZWdzKTsNCj4gICAJY2Rucy0+ZGV2X3JlZ3MJPSByZWdzOw0K
PiAgIA0KPiAgIAljZG5zLT5vdGdfaXJxID0gcGxhdGZvcm1fZ2V0X2lycV9ieW5hbWUocGRldiwg
Im90ZyIpOw0KPiAtCWlmIChjZG5zLT5vdGdfaXJxID09IC1FUFJPQkVfREVGRVIpDQo+IC0JCXJl
dHVybiBjZG5zLT5vdGdfaXJxOw0KPiAtDQo+IC0JaWYgKGNkbnMtPm90Z19pcnEgPCAwKSB7DQo+
IC0JCWRldl9lcnIoZGV2LCAiY291bGRuJ3QgZ2V0IG90ZyBpcnFcbiIpOw0KPiArCWlmIChjZG5z
LT5vdGdfaXJxIDwgMCkNCj4gICAJCXJldHVybiBjZG5zLT5vdGdfaXJxOw0KPiAtCX0NCj4gICAN
Cj4gICAJcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlX2J5bmFtZShwZGV2LCBJT1JFU09VUkNF
X01FTSwgIm90ZyIpOw0KPiAgIAlpZiAoIXJlcykgew0KPiANCg0K
