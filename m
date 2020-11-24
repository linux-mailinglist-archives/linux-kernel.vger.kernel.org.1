Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A46E2C221F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 10:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731577AbgKXJwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 04:52:45 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:32462 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728308AbgKXJwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:52:44 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AO9nVi7018574;
        Tue, 24 Nov 2020 01:52:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=MKtYJ5SibiKmMNX7myf78FZIEqeVBtQEonZz7rTwltw=;
 b=cA5ZHvYvhEFErQ0PAktHARlxH29Zq/ROagz/AXHaSfW5bFlbtxpOI1XG12fGpMNzPxtH
 wW4b8adn8SYVQhuil+/5wg5VglAfw1phQ72qDh5zq6qbgPogOKmFR++AH/wCxQpxZzw8
 Nbj3psc9m6zQL4GHJNqDlHWeVGctYsq4rUts8wpQ03z7rIh7GBYzG/5SOhytfpPIVe/s
 /J7PbN2n2slOP+w5MdNO7w+byUf+ncz5kYfm7OBVnrbqRX6C8GoFe8NCg1DRGZvu1flF
 If9tq7/xrckycypv6G3hEmvajBphGf5caXNyYP0Ij+IDcJPxk5BTps8j3JNG2HnUzbkJ Vg== 
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2050.outbound.protection.outlook.com [104.47.38.50])
        by mx0b-0014ca01.pphosted.com with ESMTP id 34y0bva6xs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Nov 2020 01:52:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MfaNBo3ANABUVHnXB7bIEB1PqDk2tORP/ZWJaTGRUczHnjnzmIHMIm+hGMvS05W9lWqEohgZ9uj18hswvw8XD7vMMwm7UWaxrnHNx4dWeq4lIOKDoN4sYN4gYtq5zm3XPQYonmc74dDKP9fDsbmjiuySeB2726SXri63tBIpEO6t/x3pYYggksYhivfM8xcmv0bbuX9RlkG5UE8GTSPLgfs+Dbw0yHshdjrgIX3HrNq8tJOjwXrDdmEgxx7XZT9BR+Bu+lXVGPTr1oY2H8bEMLUf6J8ZbbgpogpmHfy2ere7mNOaFxJlUf6E64v/1niVCOKEx7iWH077Kk3QMyl0Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKtYJ5SibiKmMNX7myf78FZIEqeVBtQEonZz7rTwltw=;
 b=IvFfurCCgegjjd6QSNfTbYRUBt7WOe5+KWDJGnf0JPk2F62aZ2jzqNdDY66z05nsowEgHpnsR1/w4wz3GmtrSWj17pgyQXbeEiEuXcAKX2eUtKwAcUgK09a4tj/5qqTjVunA8uhtDhGkLxoF+GqKELJadMRb8fllvJiqDx8pPSglNfUDnzI3bOcy5BfQ+k4oMnqX40FqFIMLg72BEkptMMXmjpbEbCd5MSNw71vCgmN4gQZ2CCoMxJkXk+ucX9aqwSTErGOqYMUIPuEuijC8pLDr9aAKNXPcQ40nAoHiR8cqV/f+eOf80vNY2rxwqXzKpqZ7RbsWIUukpTEfejvG9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKtYJ5SibiKmMNX7myf78FZIEqeVBtQEonZz7rTwltw=;
 b=PZrz/a/PRi0udnsnytAjxhXap8UMXuhtUqYUFwLHlDKdM0e9fWOh8tIU4MdOQ9v+rm68Vv1rtpcnO7q9W3EpUk68zxSYiq42vXWQT+Iku2opPFFcYJptLqyZS3TfiHAjx0sqiasO7DvhlTBpaKLNbUfSvUD4/ZkhyGUyFI7PdEk=
Received: from DM6PR07MB5529.namprd07.prod.outlook.com (2603:10b6:5:7a::30) by
 DM6PR07MB4313.namprd07.prod.outlook.com (2603:10b6:5:ca::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.30; Tue, 24 Nov 2020 09:52:03 +0000
Received: from DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::5c52:d1b0:b595:cfc1]) by DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::5c52:d1b0:b595:cfc1%3]) with mapi id 15.20.3589.022; Tue, 24 Nov 2020
 09:52:03 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Sekhar Nori <nsekhar@ti.com>, Peter Chen <peter.chen@nxp.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "rogerq@ti.com" <rogerq@ti.com>, Rahul Kumar <kurahul@cadence.com>,
        "Govindraju, Aswath" <a-govindraju@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: RE: [PATCH v3 00/10] Introduced new Cadence USBSSP DRD Driver.
Thread-Topic: [PATCH v3 00/10] Introduced new Cadence USBSSP DRD Driver.
Thread-Index: AQHWvn5OSwS8ExQKVEepEyu7IWVrI6nW8BSAgAAYUOCAAAUNgIAAAg1g
Date:   Tue, 24 Nov 2020 09:52:02 +0000
Message-ID: <DM6PR07MB5529316FE42279C77BB43317DDFB0@DM6PR07MB5529.namprd07.prod.outlook.com>
References: <20201119141307.8342-1-pawell@cadence.com>
 <20201124075023.GC32310@b29397-desktop>
 <DM6PR07MB55299F262CEA81216999CB05DDFB0@DM6PR07MB5529.namprd07.prod.outlook.com>
 <45ffc5f8-f9de-e14d-3d03-9ef1f1c848d9@ti.com>
In-Reply-To: <45ffc5f8-f9de-e14d-3d03-9ef1f1c848d9@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYjI0NmI0YjItMmUzYS0xMWViLTg3NzUtYTQ0Y2M4MWIwYzU1XGFtZS10ZXN0XGIyNDZiNGI0LTJlM2EtMTFlYi04Nzc1LWE0NGNjODFiMGM1NWJvZHkudHh0IiBzej0iMzU2NCIgdD0iMTMyNTA2ODUxMjA5MDE4MTc4IiBoPSJSRENWMzAyRG9YRUVKYlhYNW04emZBU0oyY009IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06f153c4-22ab-4487-8195-08d8905e9870
x-ms-traffictypediagnostic: DM6PR07MB4313:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR07MB4313E3D4A30D0612412EF451DDFB0@DM6PR07MB4313.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sHzVZyswmIv067lcjh64sRsC6JLB/UXMODoelPDAu9TjznkhU/xylJ86tcpcViTZzi3aAJy0cP7UDghp44tEYSzSkoD4zPucSqDvAnj8GO/XJMQ2NZ5QnOgIlB+J4hsNZ3kksFtSh1DxsHDf8DdWSk6AOssBfmxlFliG0Uaz1gkxoE/c+FtZ9vybecy3UJAv9mqeBfPRj3RvtT0S2z4DZbFwnd+mBebf0wtmXnD/XCsyslOpGo+D6wZLFGZ72SIt18vJXiWYooU2cPkU/Dqr8mbLTMpV1rgGn5l7W+uDau3+ERAJKYyYINPLU06Z7xz0PF0M3jvW2lFl4G7Wsr4m2+qSL/bTQptoWvPU7TvRS67ArQCtAp0vaNuJBJgJ8W0v
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB5529.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(36092001)(9686003)(71200400001)(52536014)(66556008)(8676002)(5660300002)(64756008)(66946007)(76116006)(66446008)(66476007)(110136005)(7696005)(478600001)(33656002)(83380400001)(55016002)(86362001)(7416002)(26005)(4326008)(316002)(186003)(2906002)(54906003)(8936002)(6506007)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: XKl9TM91qUMg2+i9+wsxg6/ROgDaS7yVh+2p7kmyy3eZxDBsW3uqaMXwgSX2cJevgqrtQG5p/ONy1rAwamGxAIJiazHyxqddjKHjo1Y4S1a7tFFQnwlvZ9VMtfpL09x/p+QXQeQ1iiZrII3dv0IPIiT177a/7KS0DaRCgYeA8EwuboGoeoqf6sSfBO2mDTXwdNNKvx6QXx0jxTgJDfFpySB042FNrZ5FB1glBPGndXkUvxmZ2BILKb8vs1f3e0peRcrs5WsYI2UtD2J3zYgbctCRSMSpT/VU9yK8iIATKLnjI1uuAs+a4P970z5FTnw3MPSiIj3hmmVfGKpJSt5quYRY3xa2nC5xcemUQ/WFT9ZRyhohLx1yMXiWK6opDEN92E0PV+IKB5qAgYsMtBrk6bTthVAPTc2D4j/+mXUaQ/pJsPJpCDEBRm84QSKlg6ioI72od9k/3PW/9+3sp9AMRflLPR3K0NRy1WHI3vN9NkYjhh5HY1TaBKWJM1t/lKQPkUjuukMCBZcR8BlVkXsr9CJjZ1hQudEwUkbUuiX/wgl9+98dGqaxkxnZ1tcinnmAaERkg3wMfPe08i+Llj7vM+l7v0ZEHUUzgmptfwDkLiSajD1bmE2jago5lmsY6s8NImYQUQ6WNC+UG8hBVLB/Hk0zAiwLukqW+EPKv8rNwyxjxi2w8DolTlKcOAdpMHUSQ1f8FR8Sbnt3ElkCnsKzC5anAiUnRAjcmzzNy54ZtSqX2cMLTQXt0MRgaI5/VVue0bi15eqet729z45oUh1yJiuzUYaeD9LtP52xG1xNYyEyZWkOgTcxLoAHWAVQKDt6ZfNSHWgLFbOjKKubdrFX/S2unq8I/x07RotiRGvSbqOWjtU1ssl5sVv2/D+jPrxm4avGK10VgApFmoqKbLhEUA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB5529.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f153c4-22ab-4487-8195-08d8905e9870
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 09:52:03.0711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gwpn2vLxAP7Pg2o9CnOibiG0Z8Phsk5r2sanZWVs94NJuTNXN4pJZnnKecdxPBV+2x6etQMesV1hphKh7ajUwMj6DgBW7mJKT75Uom82ecQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4313
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-24_04:2020-11-24,2020-11-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=984 suspectscore=0
 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1011
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011240059
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U2VraGFyLA0KDQo+DQo+DQo+T24gMjQvMTEvMjAgMjo1MSBQTSwgUGF3ZWwgTGFzemN6YWsgd3Jv
dGU6DQo+PiBQZXRlciwNCj4+DQo+Pj4gT24gMjAtMTEtMTkgMTU6MTI6NTcsIFBhd2VsIExhc3pj
emFrIHdyb3RlOg0KPj4+PiBUaGlzIHBhdGNoIGludHJvZHVjZSBuZXcgQ2FkZW5jZSBVU0JTUyBE
UkQgZHJpdmVyIHRvIGxpbnV4IGtlcm5lbC4NCj4+Pj4NCj4+Pj4gVGhlIENhZGVuY2UgVVNCU1Mg
RFJEIENvbnRyb2xsZXIgaXMgYSBoaWdobHkgY29uZmlndXJhYmxlIElQIENvcmUgd2hpY2gNCj4+
Pj4gY2FuIGJlIGluc3RhbnRpYXRlZCBhcyBEdWFsLVJvbGUgRGV2aWNlIChEUkQpLCBQZXJpcGhl
cmFsIE9ubHkgYW5kDQo+Pj4+IEhvc3QgT25seSAoWEhDSSljb25maWd1cmF0aW9ucy4NCj4+Pj4N
Cj4+Pj4gVGhlIGN1cnJlbnQgZHJpdmVyIGhhcyBiZWVuIHZhbGlkYXRlZCB3aXRoIEZQR0EgYnVy
bmVkLiBXZSBoYXZlIHN1cHBvcnQNCj4+Pj4gZm9yIFBDSWUgYnVzLCB3aGljaCBpcyB1c2VkIG9u
IEZQR0EgcHJvdG90eXBpbmcuDQo+Pj4+DQo+Pj4+IFRoZSBob3N0IHNpZGUgb2YgVVNCU1MtRFJE
IGNvbnRyb2xsZXIgaXMgY29tcGxpYW5jZSB3aXRoIFhIQ0kNCj4+Pj4gc3BlY2lmaWNhdGlvbiwg
c28gaXQgd29ya3Mgd2l0aCBzdGFuZGFyZCBYSENJIExpbnV4IGRyaXZlci4NCj4+Pj4NCj4+Pj4g
VGhlIGRldmljZSBzaWRlIG9mIFVTQlNTIERSRCBjb250cm9sbGVyIGlzIGNvbXBsaWFudCB3aXRo
IFhIQ0kuDQo+Pj4+IFRoZSBhcmNoaXRlY3R1cmUgZm9yIGRldmljZSBzaWRlIGlzIGFsbW9zdCB0
aGUgc2FtZSBhcyBmb3IgaG9zdCBzaWRlLA0KPj4+PiBhbmQgbW9zdCBvZiB0aGUgWEhDSSBzcGVj
aWZpY2F0aW9uIGNhbiBiZSB1c2VkIHRvIHVuZGVyc3RhbmQgaG93DQo+Pj4+IHRoaXMgY29udHJv
bGxlciBvcGVyYXRlcy4NCj4+Pj4NCj4+Pj4gVGhpcyBjb250cm9sbGVyIGFuZCBkcml2ZXIgc3Vw
cG9ydCBGdWxsIFNwZWVkLCBIaWdodCBTcGVlZCwgU3VwcGVyIFNwZWVkDQo+Pj4+IGFuZCBTdXBw
ZXIgU3BlZWQgUGx1cyBVU0IgcHJvdG9jb2wuDQo+Pj4+DQo+Pj4+IFRoZSBwcmVmaXggY2Ruc3Ag
dXNlZCBpbiBkcml2ZXIgaGFzIGNob3NlbiBieSBhbmFsb2d5IHRvIGNkbjMgZHJpdmVyLg0KPj4+
PiBUaGUgbGFzdCBsZXR0ZXIgb2YgdGhpcyBhY3JvbnltIG1lYW5zIFBMVVMuIFRoZSBmb3JtYWwg
bmFtZSBvZiBjb250cm9sbGVyDQo+Pj4+IGlzIFVTQlNTUCBidXQgaXQncyB0byBnZW5lcmljIHNv
IEkndmUgZGVjaWRlZCB0byB1c2UgQ0ROU1AuDQo+Pj4+DQo+Pj4+IFRoZSBwYXRjaCAxOiBhZGRz
IHN1cHBvcnQgZm9yIERSRCBDRE5TUC4NCj4+Pj4gVGhlIHBhdGNoIDI6IHNlcGFyYXRlcyBjb21t
b24gY29kZSB0aGF0IGNhbiBiZSByZXVzYWJsZSBieSBjZG5zcCBkcml2ZXIuDQo+Pj4+IFRoZSBw
YXRjaCAzOiBtb3ZlcyByZXVzYWJsZSBjb2RlIHRvIHNlcGFyYXRlIG1vZHVsZS4NCj4+Pj4gVGhl
IHBhdGNoIDQ6IGNoYW5nZXMgcHJlZml4ZXMgaW4gcmV1c2FibGUgY29kZSBmcm9tIGNkbnMzIHRv
IGNvbW1vbiBjZG5zLg0KPj4+PiBUaGUgcGF0Y2ggNTogYWRvcHRzIGdhZGdldF9kZXYgcG9pbnRl
ciBpbiBjZG5zIHN0cnVjdHVyZSB0byBtYWtlIHBvc3NpYmxlDQo+Pj4+ICAgICAgICAgICAgICB1
c2UgaXQgaW4gYm90aCBkcml2ZXJzLg0KPj4+PiBUaGUgcGF0Y2hlcyA2LTg6IGFkZCB0aGUgbWFp
biBwYXJ0IG9mIGRyaXZlciBhbmQgaGFzIGJlZW4gaW50ZW50aW9uYWxseQ0KPj4+PiAgICAgICAg
ICAgICAgc3BsaXQgaW50byAzIHBhcnQuIEluIG15IG9waW5pb24gc3VjaCBkaXZpc2lvbiBzaG91
bGQgbm90DQo+Pj4+ICAgICAgICAgICAgICBhZmZlY3QgdW5kZXJzdGFuZGluZyBhbmQgcmV2aWV3
aW5nIHRoZSBkcml2ZXIsIGFuZCBjYXVzZSB0aGF0DQo+Pj4+ICAgICAgICAgICAgICBtYWluIHBh
dGNoICg3LzgpIGlzIGxpdHRsZSBzbWFsbGVyLiBQYXRjaCA2IGludHJvZHVjZXMgbWFpbg0KPj4+
PiAgICAgICAgICAgICAgaGVhZGVyIGZpbGUgZm9yIGRyaXZlciwgNyBpcyB0aGUgbWFpbiBwYXJ0
IHRoYXQgaW1wbGVtZW50cyBhbGwNCj4+Pj4gICAgICAgICAgICAgIGZ1bmN0aW9uYWxpdHkgb2Yg
ZHJpdmVyIGFuZCA4IGludHJvZHVjZXMgdHJhY2Vwb2ludHMuDQo+Pj4+IFRoZSBwYXRjaCA5OiBB
ZGRzIGNkbnMzIHByZWZpeGVzIHRvIGZpbGVzIHJlbGF0ZWQgd2l0aCBVU0JTUyBkcml2ZXIuDQo+
Pj4+IHRoZSBwYXRjaCAxMDogQWRkcyBVU0JTU1AgRFJEIElQIGRyaXZlciBlbnRyeSB0byBNQUlO
VEFJTkVSUyBmaWxlLg0KPj4+Pg0KPj4+PiBDaGFuZ2xvZyBmcm9tIHYyOg0KPj4+PiAtIHJlbW92
ZWQgbm90IHVzZWQgcGRldiBwYXJhbWV0ZXIgZnJvbSBjZG5zcF9yZWFkL3dpdGVfNjQgZnVuY3Rp
b25zDQo+Pj4+IC0gZml4ZWQgaW5jb3JyZWN0IHZhbHVlIGFzc2lnbmVkIHRvIENETlNQX0VORFBP
SU5UU19OVU0gKDMyIC0+IDMxKQ0KPj4+PiAtIHJlcGxhY2VkIHNvbWUgY29uc3RhbnQgdmFsdWUg
d2l0aCBDRE5TUF9FTkRQT0lOVFNfTlVNIG1hY3JvDQo+Pj4+IC0gcmVwbGFjZWQgJ3RydWUnIHdp
dGggJzEnIGluIGJpdHMgZGVzY3JpcHRpb24gaW4gY2Ruc3AtZ2FkZ2V0LmggZmlsZQ0KPj4+PiAt
IGZpeGVkIHNvbWUgdHlwb3MNCj4+Pj4gLSBzb21lIG90aGVyIGxlc3MgaW1wb3J0YW50IGNoYW5n
ZXMgc3VnZ2VzdGVkIGJ5IFBldGVyIENoZW4NCj4+Pg0KPj4+IEhpIFBhd2VsLA0KPj4+DQo+Pj4g
SSBoYXZlIHVwZGF0ZWQgbXkgLW5leHQgdHJlZSBhcyB0aGUgbGF0ZXN0IHVzYi1uZXh0IHRyZWUg
d2hpY2ggdjUuMTAtcmM0DQo+Pj4gaXMgaW5jbHVkZWQsIHdvdWxkIHlvdSBwbGVhc2UgcmViYXNl
IG15IHRyZWUgYW5kIHNlbmQgYWdhaW4sIEkgY291bGQgYXBwbHkgeW91cg0KPj4+IHBhdGNoZXMg
YW5kIHRlc3QsIGlmIHRlc3QgY291bGQgcGFzcywgSSB3aWxsIGFwcGx5IGl0IHRvIG15IC1uZXh0
IHRyZWUuDQo+Pj4gWW91IGRvbid0IG5lZWQgdG8gcmViYXNlIGFnYWluIHNpbmNlIGl0IGlzIGEg
aHVnZSBwYXRjaCBzZXQsIHdpbGwgdGFrZSBzb21lDQo+Pj4gZWZmb3J0cyBmb3IgcmViYXNlLg0K
Pj4+DQo+Pg0KPj4gSSdsbCB0cnkgdG8gcG9zdCBpdCB0b21vcnJvdy4NCj4NCj5QYXdlbCwgaGF2
ZSB5b3UgdGVzdGVkIFRJIEo3IGZvciByZWdyZXNzaW9ucyBhZnRlciB0aGlzIHNlcmllcz8gQWZ0
ZXINCj55b3VyIGxhdGVzdCBjaGFuZ2VzLCBjYW4geW91IHBvc3QgYSB0cmVlIHdoaWNoIHNvbWVv
bmUgaW4gVEkgY2FuIHRlc3Q/DQoNCk5vIEkgaGF2ZW4ndCB0ZXN0IGl0IG9uIEo3LiAgRm9yIHRl
c3RpbmcgSSdtIHVzaW5nIFBDSWUgYmFzZWQgcGxhdGZvcm0gZm9yDQpib3RoIGNuZHMzIGFuZCBj
ZG5zcCBkcml2ZXIuIA0KDQpXaHkgeW91IGNhbid0IHVzZSB0aGUgbGF0ZXN0IGtlcm5lbCB2ZXJz
aW9uIGFuZCBjdXJyZW50IHNlcmllcyA/IA0KDQotLQ0KDQpUaGFua3MNClBhd2VsDQoNCg==
