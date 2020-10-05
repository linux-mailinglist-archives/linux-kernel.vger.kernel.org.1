Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717DB28327E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 10:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgJEItr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 04:49:47 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:32764 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725880AbgJEItr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 04:49:47 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0958l0Yj005536;
        Mon, 5 Oct 2020 01:49:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=LMukJo17GkDvBaE/BJfn8aZQLKtC2kOKmvvMuwAZ7N0=;
 b=Ld2YTzeuCuxHI5vXi5mUm1YZqrLmFrN4ndL1RvKJFctqYdRq9M79XdQpgCninEEaePlC
 2jitDtzpI1bU8iknDVFmK1pbSol4jqSw1KQTJ3AeZ6zXIz5KxhL/LC89W/XVcXmKB9Mu
 Zds4+ENI/NYjXjUbKNnmLOWerobjqq92R4gw2FsxHS7foCbGeuEsJ0P8aZhccSz4pMWv
 j5t3FbCQMFYsn3wpCmlBS6RpUBDL6yAm8YPE9tyD6mHfHSp8z/fHxClTzNREPpICafLi
 /yl+C8DYPnkEt6qBBO35vV+jLibNKtzI22bi5uyx14S4QLjFDriZjh5nwJPaCd6A91XE cg== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by mx0a-0014ca01.pphosted.com with ESMTP id 33xnuxcmrx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Oct 2020 01:49:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTXfR0hKohBW0967vJNVyK97U4N9UOo7RlkARK4W71gZzaKhyPr7ZK6yfcGcZjlMbi9o/y3/qlglOtlnXN3l7nKk/YCEBGk+HbISWceT0xJzCfk88ebOGCb1GLUScmEZJyi5ZNmLluJf/QyofZ/IfJdOp2B5BMWDHUALqWVAFaX/r6HYI1deRqDTo03NuTqZpwOFhS5z/GdQFjT1TROrZBm+7EFFnZWWuGH20gMnfi5JcGu0Wl8lhI5iJROyMB3cW9n7ud+nDM7MXQGQYD9jrL8gVIv0niFdTMQ9A1CPKJ6KtyBJs+U1Wp6cef+z6SCaWQ4h1xC3snRTLCbJKZj1sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMukJo17GkDvBaE/BJfn8aZQLKtC2kOKmvvMuwAZ7N0=;
 b=Hll12+TZbZM+wdXSfxvsiajdlgbV/YDThH+NVY3MTw4tOcgPqif6sVIMQyXRzgACuBlA9v1H64rLTGkfXtNsaPUDYFtTlqZaooBcnuarRbmA0YHgdlUzjh7TloUC8wTBRzsuNn7xZf1LXgNh8jJeuys7GKWAiLM+DmEPahDrOnk7UDWKx/swhfNsF5KQ66+2i+E4Z/PLitjK0qxp48xgBgS/xStY2SUdDmYSPg/5428hlTIiKqvCKU6sdU04wNfG3r+L+O1ldWe+Qu1wH+qpUoDlxE4V/n1PzdSppWcieHTDwpRc2+i0GhPXizekVCbE4/xjfhQIMbLnyOJnsXNS8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMukJo17GkDvBaE/BJfn8aZQLKtC2kOKmvvMuwAZ7N0=;
 b=KHWozRHJIQEzaTwqi2dtAnAG1g5/KvgK0qekHbr9Z3t5ZQFaV3G3QD85gx6nK7KxPMKnx3WOd7uFhmLB5zBI1A0zWI7eARb3bStmbN38vuqs0XQmmTc3QDBTyP6ss0vpKLHOrcOM6jqhraQW9pEeIjKBOd3SfZQxidJPQPEyKVo=
Received: from DM6PR07MB5529.namprd07.prod.outlook.com (2603:10b6:5:7a::30) by
 DM6PR07MB4921.namprd07.prod.outlook.com (2603:10b6:5:2d::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.38; Mon, 5 Oct 2020 08:49:34 +0000
Received: from DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::2087:7f2b:5dc6:a960]) by DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::2087:7f2b:5dc6:a960%6]) with mapi id 15.20.3433.044; Mon, 5 Oct 2020
 08:49:34 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Roger Quadros <rogerq@ti.com>,
        "balbi@kernel.org" <balbi@kernel.org>
CC:     Peter Chen <peter.chen@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH] usb: cdns3: platform_get_irq_byname_optional instead
 platform_get_irq_byname
Thread-Topic: [PATCH] usb: cdns3: platform_get_irq_byname_optional instead
 platform_get_irq_byname
Thread-Index: AQHWlvch/Roy1G/8IkO8ykqpdGeiF6mEBTKAgAAA+RCAABNFAIAEbf+wgAAx5YCAAACZIA==
Date:   Mon, 5 Oct 2020 08:49:34 +0000
Message-ID: <DM6PR07MB5529E919C70D3E4D0C572691DD0C0@DM6PR07MB5529.namprd07.prod.outlook.com>
References: <20200930065758.23740-1-pawell@cadence.com>
 <722fa58e-604b-bc34-d404-caf7939bb176@ti.com>
 <DM6PR07MB5529095F1B656C5065CBA8B4DD310@DM6PR07MB5529.namprd07.prod.outlook.com>
 <b73f6bb7-8e5e-d5f9-5adf-f6b10bdb5fb6@ti.com>
 <DM6PR07MB55297B8671A649E8AED7231FDD0C0@DM6PR07MB5529.namprd07.prod.outlook.com>
 <5ca1fdf6-fd91-a223-92cc-a771ffa3c068@ti.com>
In-Reply-To: <5ca1fdf6-fd91-a223-92cc-a771ffa3c068@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYWYwNWU2NmMtMDZlNy0xMWViLTg3NmItMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGFmMDVlNjZlLTA2ZTctMTFlYi04NzZiLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iNTI4MCIgdD0iMTMyNDYzNjEzNzE4NzQzMDY0IiBoPSIzdjkxSzAvcHNWdjluTzhSV1BxcmlTQnNkU0U9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a2e77b0-25c4-4cba-6505-08d8690b9553
x-ms-traffictypediagnostic: DM6PR07MB4921:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR07MB49211D44295216D0BAF810D0DD0C0@DM6PR07MB4921.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sCHDPtVADo/YWEsL+Xuf6McCEFRAvB5neG+Hmz0VZpEk8QuZb59Y7OH783MnRNOMw1Mh8ek+cQPOFWISxIafH8ZczhGWhKc2Rqy6zkx62hXro26JN03NvcM9sWDH+zRQefvTvgV7UyQFbqiW2m8Y+yyBiWCW+IfODkV/QSPlPxAUL74ARfAkVciXaJcEMlm+LmIi/CrxRfP/RlauIEKnc+vWEmsvYBGA/RjvAHXLtvgS9N9axnyxhLhtEq96kfwLKvnNOjwnPzfGpoZrzytdUGdOKDQOuFwYbujPZlQigkk3gOrXySPYw7JUvUHrTnTV73qdUW8jv7pzqGxzxIAAAHCgxWR0hyy+ARAZC7nRT4GGTDj2dIogtjSOQcKoJS6f
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB5529.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(36092001)(76116006)(8676002)(316002)(9686003)(5660300002)(55016002)(478600001)(54906003)(66446008)(64756008)(66556008)(53546011)(6506007)(66946007)(83380400001)(110136005)(66476007)(186003)(8936002)(33656002)(86362001)(2906002)(4326008)(52536014)(107886003)(7696005)(71200400001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: VUjSKBjXmzWd2RfAkCU20dKeZbNzejmv1y3VZs8OL+jzuxOdYSDmUS9d6h1XDhe4MTH8yswv4d0lf16AdtusAbobTGFD6nG4VOu3w8QEFS1vGT9f3Gzkwe9/4Jk41Rnr9xWfqM7y2KtWc2EEkU0TKhD8DHwHmKtJv/gIwqwa93mHO2hfu19pU3oZLBcHvQ0K3hIR0PD5vekf/t4ohoGP+PWJ6E8Pw6s4LvhEjx/+PKS/m8Cqj+BBDNPlH8+13R2N82oeN4flI4OBSmdhp+6nhtDRsYQduLun2vO9zbM+a5l7FMIzSv6krEMh8XifaKbbKTT6lKkqhkhORQDDZEEiI3jmwTjjNcu7m4KmrS71ZYaO9HsbxSG1AIDSMARQZqPTYBp9GX6QGvXHaWXoY8KYrLYUbwnQEogwv3s+TBkM9Iip4EKDH0CItc8c/PSg9W9QqUCz6HzhDxgqvwEhP9aFM3VIXKUAjOEdCvUNI98ezIRxfXb62bXstGJB+Z866rGhhcdzmjPB9lBqHHs6s71TEA9Rq393Kvu/OhGA0MCBeaqVLodzT7pO+NOWdaMXhyVtPFcjk0iPAYANpNOG53rlzdlAb84W4AIhHw+is2yrlYarksejbx76yDuoMrKAtWL2YS2efplMo/N8aQVdaHkZQw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB5529.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a2e77b0-25c4-4cba-6505-08d8690b9553
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2020 08:49:34.2743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h2fZmS17Zm5vYWvln9gAWZI0bh4uQvmHjfK22c2k0+QBUpoUpa8bluxU7ccCX26eM07MzKTRTWCEEMZa1xcUuL4BjMUgJMgzJfaZHoPdRVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4921
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-05_06:2020-10-02,2020-10-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 mlxscore=0 mlxlogscore=649 priorityscore=1501 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010050067
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Um9nZXIsDQoNCj5QYXdlbCwNCj4NCj5PbiAwNS8xMC8yMDIwIDA4OjU0LCBQYXdlbCBMYXN6Y3ph
ayB3cm90ZToNCj4+IFJvZ2VyLA0KPj4+DQo+Pj4gUGF3ZWwsDQo+Pj4NCj4+PiBPbiAwMi8xMC8y
MDIwIDEyOjA4LCBQYXdlbCBMYXN6Y3phayB3cm90ZToNCj4+Pj4gUm9nZXIsDQo+Pj4+DQo+Pj4+
Pg0KPj4+Pj4gT24gMzAvMDkvMjAyMCAwOTo1NywgUGF3ZWwgTGFzemN6YWsgd3JvdGU6DQo+Pj4+
Pj4gVG8gYXZvaWQgZHVwbGljYXRlIGVycm9yIGluZm9ybWF0aW9uIHBhdGNoIHJlcGxhY2VzIHBs
YXRmb3JtX2dldF9pcnFfYnluYW1lDQo+Pj4+Pj4gaW50byBwbGF0Zm9ybV9nZXRfaXJxX2J5bmFt
ZV9vcHRpb25hbC4NCj4+Pj4+DQo+Pj4+PiBXaGF0IGlzIGR1cGxpY2F0ZSBlcnJvciBpbmZvcm1h
dGlvbj8NCj4+Pj4NCj4+Pj4gVGhlIGZ1bmN0aW9uIHBsYXRmb3JtX2dldF9pcnFfYnluYW1lIHBy
aW50Og0KPj4+PiAiIGRldl9lcnIoJmRldi0+ZGV2LCAiSVJRICVzIG5vdCBmb3VuZFxuIiwgbmFt
ZSk7IiBpZiBlcnJvciBvY2N1cnJlZC4NCj4+Pj4NCj4+Pj4gSW4gY29yZS5jIHdlIGhhdmUgdGhl
IGFub3RoZXIgZXJyb3IgbWVzc2FnZSBiZWxvdyBpbnZva2luZyB0aGlzIGZ1bmN0aW9uLg0KPj4+
PiBlLmcNCj4+Pj4gCWlmIChjZG5zLT5kZXZfaXJxIDwgMCkNCj4+Pj4gCQlkZXZfZXJyKGRldiwg
ImNvdWxkbid0IGdldCBwZXJpcGhlcmFsIGlycVxuIik7DQo+Pj4+DQo+Pj4+IFNvLCBpdCdzIGxv
b2tzIGxpa2Ugb25lIGRldl9lcnIgaXMgIHJlZHVuZGFudC4NCj4+Pg0KPj4+IElmIHdlIHdhbnQg
YWxsIDMgSVJRcyB0byBiZSB2YWxpZCBpcnJlc3BlY3RpdmUgb2YgZHJfbW9kZSB0aGVuIHdlIHNo
b3VsZA0KPj4+IHVzZSBwbGF0Zm9ybV9nZXRfaXJxX2J5bmFtZSgpIGFuZCBlcnJvciBvdXQgaW4g
cHJvYmUgaWYgKHJldCA8IDAgJiYgcmV0ICE9IC1FUFJPQkVfREVGRVIpLg0KPj4+DQo+Pj4gV2Ug
Y2FuIGdldCByaWQgb2YgdGhlIGlycSBjaGVjayBhbmQgZHVwbGljYXRlIGVycm9yIG1lc3NhZ2Ug
aW4gb3RoZXIgcGxhY2VzLg0KPj4NCj4+IFRvIGJlIHN1cmUgd2UgdW5kZXJzdGFuZCBlYWNoIG90
aGVyIGNvcnJlY3RseS4NCj4+DQo+PiBBcmUgWW91IHN1Z2dlc3RpbmcgIHRvIGxlYXZlIHRoZSAg
cGxhdGZvcm1fZ2V0X2lycV9ieW5hbWUoKQ0KPj4gYW5kIHJpZCBvZiBmcm9tIGNvcmUuYyB0aGUg
Zm9sbG93aW5nIGxpbmVzIDoNCj4+DQo+PiBpZiAoY2Rucy0+ZGV2X2lycSA8IDApDQo+PiAJZGV2
X2VycihkZXYsICJjb3VsZG4ndCBnZXQgcGVyaXBoZXJhbCBpcnFcbiIpOw0KPj4NCj4+IGFuZA0K
Pj4NCj4+IGRldl9lcnIoZGV2LCAiY291bGRuJ3QgZ2V0IG90ZyBpcnFcbiIpOw0KPj4gPw0KPg0K
Plllcy4NCj4NCj4+DQo+PiBBIHdvcmQgb2YgZXhwbGFuYXRpb24gd2h5IHRoaXMgcGF0Y2ggaGFz
IGJlZW4gc2VudC4NCj4+IER1cmluZyByZXZpZXdpbmcgdGhlIGNkbnNwIGRyaXZlciBDaHVuZmVu
ZyBZdW4gYWRkIHN1Y2ggY29tbWVudDoNCj4+DQo+PiAiDQo+Pj4gKwljZG5zLT5kZXZfaXJxID0g
cGxhdGZvcm1fZ2V0X2lycV9ieW5hbWUocGRldiwgInBlcmlwaGVyYWwiKTsNCj4+PiArCWlmIChj
ZG5zLT5kZXZfaXJxID09IC1FUFJPQkVfREVGRVIpDQo+Pj4gKwkJcmV0dXJuIGNkbnMtPmRldl9p
cnE7DQo+Pj4gKw0KPj4+ICsJaWYgKGNkbnMtPmRldl9pcnEgPCAwKQ0KPj4+ICsJCWRldl9lcnIo
ZGV2LCAiY291bGRuJ3QgZ2V0IHBlcmlwaGVyYWwgaXJxXG4iKTsNCj4+IFVzZSBwbGF0Zm9ybV9n
ZXRfaXJxX2J5bmFtZV9vcHRpb25hbD8gb3RoZXJ3aXNlIG5vIG5lZWQgcHJpbnQgdGhpcyBsb2cs
DQo+PiBwbGF0Zm9ybV9nZXRfaXJxX2J5bmFtZSgpIHdpbGwgcHJpbnQgaXQuDQo+PiAiDQo+Pg0K
Pj4gSW4gdGhpcyBwYXRjaCBJJ3ZlIGNob3NlbiB0aGUgcGxhdGZvcm1fZ2V0X2lycV9ieW5hbWVf
b3B0aW9uYWwgYmVjYXVzZSBib3RoDQo+PiBmdW5jdGlvbiBkbyB0aGUgc2FtZSBidXQgdGhlIGVy
cm9yIG1lc3NhZ2UgZnJvbSBjb3JlLmMgdGVsbCB1cyBsaXR0bGUgbW9yZSB0aGVuDQo+PiBnZW5l
cmljIG1lc3NhZ2UgZnJvbSBwbGF0Zm9ybV9nZXRfaXJxX2J5bmFtZS4NCj4NCj5Vc2luZyBwbGF0
Zm9ybV9nZXRfaXJxX2J5bmFtZV9vcHRpb25hbCgpIHNheXMgZHJpdmVyIGV4cGVjdHMgaXQgaXMg
b3B0aW9uYWwgYnV0DQo+b25seSB0byBmYWlsIGxhdGVyLiBJdCB3aWxsIGJlIGNvbmZ1c2luZyB0
byBuZXcgcmVhZGVyIHRoYXQncyBhbGwuIEkgbGVhdmUgaXQgdG8NCj55b3UgdG8gZGVjaWRlIHdo
YXQgYXBwcm9hY2ggdG8gdGFrZS4NCg0KVGhhbmtzIGZvciBjbGFyaWZpY2F0aW9uLiANCkkgd2ls
bCBzZW5kICBuZXcgcGF0Y2ggd2l0aCBwbGF0Zm9ybV9nZXRfaXJxX2J5bmFtZS4NCg0KQ2hlZXJz
LA0KUGF3ZWwNCg0KPg0KPj4+DQo+Pj4+DQo+Pj4+Pg0KPj4+Pj4+DQo+Pj4+Pj4gQSBjaGFuZ2Ug
d2FzIHN1Z2dlc3RlZCBkdXJpbmcgcmV2aWV3aW5nIENETlNQIGRyaXZlciBieSBDaHVuZmVuZyBZ
dW4uDQo+Pj4+Pj4NCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBQYXdlbCBMYXN6Y3phayA8cGF3ZWxs
QGNhZGVuY2UuY29tPg0KPj4+Pj4+IC0tLQ0KPj4+Pj4+ICAgICBkcml2ZXJzL3VzYi9jZG5zMy9j
b3JlLmMgfCA0ICsrLS0NCj4+Pj4+PiAgICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkNCj4+Pj4+Pg0KPj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Vz
Yi9jZG5zMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9jZG5zMy9jb3JlLmMNCj4+Pj4+PiBpbmRleCBh
MGY3M2Q0NzExYWUuLmEzZjZkYzQ0Y2YzYSAxMDA2NDQNCj4+Pj4+PiAtLS0gYS9kcml2ZXJzL3Vz
Yi9jZG5zMy9jb3JlLmMNCj4+Pj4+PiArKysgYi9kcml2ZXJzL3VzYi9jZG5zMy9jb3JlLmMNCj4+
Pj4+PiBAQCAtNDY1LDcgKzQ2NSw3IEBAIHN0YXRpYyBpbnQgY2RuczNfcHJvYmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikNCj4+Pj4+Pg0KPj4+Pj4+ICAgICAJY2Rucy0+eGhjaV9yZXNb
MV0gPSAqcmVzOw0KPj4+Pj4+DQo+Pj4+Pj4gLQljZG5zLT5kZXZfaXJxID0gcGxhdGZvcm1fZ2V0
X2lycV9ieW5hbWUocGRldiwgInBlcmlwaGVyYWwiKTsNCj4+Pj4+PiArCWNkbnMtPmRldl9pcnEg
PSBwbGF0Zm9ybV9nZXRfaXJxX2J5bmFtZV9vcHRpb25hbChwZGV2LCAicGVyaXBoZXJhbCIpOw0K
Pj4+Pj4NCj4+Pj4+IEFzIHBlciBEVCBiaW5kaW5nIGRvY3VtZW50LCB0aGVzZSBhcmUgbWFuZGF0
b3J5IHByb3BlcnRpZXMNCj4+Pj4NCj4+Pj4gSSB0aGluayB0aGF0IG5hbWUgcGxhdGZvcm1fZ2V0
X2lycV9ieW5hbWVfb3B0aW9uYWwgaXMgbGl0dGxlIGNvbmZ1c2luZy4NCj4+Pj4gRnVuY3Rpb24g
ZGVzY3JpcHRpb25zIHNob3cgdGhhdCBib3RoIGFyZSBhbG1vc3QgaWRlbnRpY2FsOg0KPj4+PiAv
KioNCj4+Pj4gICAgKiBwbGF0Zm9ybV9nZXRfaXJxX2J5bmFtZV9vcHRpb25hbCAtIGdldCBhbiBv
cHRpb25hbCBJUlEgZm9yIGEgZGV2aWNlIGJ5IG5hbWUNCj4+Pj4gICAgKiBAZGV2OiBwbGF0Zm9y
bSBkZXZpY2UNCj4+Pj4gICAgKiBAbmFtZTogSVJRIG5hbWUNCj4+Pj4gICAgKg0KPj4+PiAgICAq
IEdldCBhbiBvcHRpb25hbCBJUlEgYnkgbmFtZSBsaWtlIHBsYXRmb3JtX2dldF9pcnFfYnluYW1l
KCkuIEV4Y2VwdCB0aGF0IGl0DQo+Pj4+ICAgICogZG9lcyBub3QgcHJpbnQgYW4gZXJyb3IgbWVz
c2FnZSBpZiBhbiBJUlEgY2FuIG5vdCBiZSBvYnRhaW5lZC4NCj4+Pj4gICAgKg0KPj4+PiAgICAq
IFJldHVybjogbm9uLXplcm8gSVJRIG51bWJlciBvbiBzdWNjZXNzLCBuZWdhdGl2ZSBlcnJvciBu
dW1iZXIgb24gZmFpbHVyZS4NCj4+Pj4gICAgKi8NCj4+Pj4NCj4+Pj4+DQo+Pj4+PiAgICAtIGlu
dGVycnVwdHM6IEludGVycnVwdHMgdXNlZCBieSBjZG5zMyBjb250cm9sbGVyOg0KPj4+Pj4gICAg
ICAgICAgICJob3N0IiAtIGludGVycnVwdCB1c2VkIGJ5IFhIQ0kgZHJpdmVyLg0KPj4+Pj4gICAg
ICAgICAgICJwZXJpcGhlcmFsIiAtIGludGVycnVwdCB1c2VkIGJ5IGRldmljZSBkcml2ZXINCj4+
Pj4+ICAgICAgICAgICAib3RnIiAtIGludGVycnVwdCB1c2VkIGJ5IERSRC9PVEcgIHBhcnQgb2Yg
ZHJpdmVyDQo+Pj4+Pg0KPj4+Pj4gZm9yIGRyX21vZGUgPT0gIm90ZyIgLT4gYWxsIDMgYXJlIG1h
bmRhdG9yeS4NCj4+Pj4+IGZvciBkcl9tb2RlID09ICJob3N0IiAtPiAib3RnIiBhbmQgInBlcmlw
aGVyYWwiIElSUXMgYXJlIG5vdCByZXF1aXJlZC4NCj4+Pj4+IGZvciBkcl9tb2RlID09ICJwZXJp
cGhlYXJhbCIgLT4gIm90ZyIgYW5kICJob3N0IiBJUlFzIGFyZSBub3QgcmVxdWlyZWQuDQo+Pj4+
Pg0KPj4+Pj4+ICAgICAJaWYgKGNkbnMtPmRldl9pcnEgPT0gLUVQUk9CRV9ERUZFUikNCj4+Pj4+
PiAgICAgCQlyZXR1cm4gY2Rucy0+ZGV2X2lycTsNCj4+Pj4+Pg0KPj4+Pj4+IEBAIC00NzcsNyAr
NDc3LDcgQEAgc3RhdGljIGludCBjZG5zM19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KPj4+Pj4+ICAgICAJCXJldHVybiBQVFJfRVJSKHJlZ3MpOw0KPj4+Pj4+ICAgICAJY2Ru
cy0+ZGV2X3JlZ3MJPSByZWdzOw0KPj4+Pj4+DQo+Pj4+Pj4gLQljZG5zLT5vdGdfaXJxID0gcGxh
dGZvcm1fZ2V0X2lycV9ieW5hbWUocGRldiwgIm90ZyIpOw0KPj4+Pj4+ICsJY2Rucy0+b3RnX2ly
cSA9IHBsYXRmb3JtX2dldF9pcnFfYnluYW1lX29wdGlvbmFsKHBkZXYsICJvdGciKTsNCj4+Pj4+
PiAgICAgCWlmIChjZG5zLT5vdGdfaXJxID09IC1FUFJPQkVfREVGRVIpDQo+Pj4+Pj4gICAgIAkJ
cmV0dXJuIGNkbnMtPm90Z19pcnE7DQo+Pj4+Pj4NCj4+Pj4+Pg0KPj4+Pj4NCj4+Pj4NCj4+Pj4g
UmVnYXJkcywNCj4+Pj4gUGF3ZWwNCj4+Pj4NCj4+Pg0KPj4+IC0tDQo+Pj4gVGV4YXMgSW5zdHJ1
bWVudHMgRmlubGFuZCBPeSwgUG9ya2thbGFua2F0dSAyMiwgMDAxODAgSGVsc2lua2kuDQo+Pj4g
WS10dW5udXMvQnVzaW5lc3MgSUQ6IDA2MTU1MjEtNC4gS290aXBhaWtrYS9Eb21pY2lsZTogSGVs
c2lua2kNCj4NCj4tLQ0KPlRleGFzIEluc3RydW1lbnRzIEZpbmxhbmQgT3ksIFBvcmtrYWxhbmth
dHUgMjIsIDAwMTgwIEhlbHNpbmtpLg0KPlktdHVubnVzL0J1c2luZXNzIElEOiAwNjE1NTIxLTQu
IEtvdGlwYWlra2EvRG9taWNpbGU6IEhlbHNpbmtpDQo=
