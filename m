Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79242F449F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 07:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbhAMGmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 01:42:21 -0500
Received: from mail-eopbgr1310139.outbound.protection.outlook.com ([40.107.131.139]:9248
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725843AbhAMGmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 01:42:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmtL6BAUpxuaQ0mAm6Db7FKMvihJ1p7bQ91fPNMdaNpDMDx8saOTW5YOwG5XHcIoP3WG0SPMDCU01Biv+DMLvllisbAwqIYBQHrq6NZxRi2pjqk6KRvOG1uDHr/A+kmQAvjGeMpJJcednry3Yx6OdSP7MUigp3RPG10SgH25dRxaIUaOjRnNvPG0uNyR9I5CUlp2YvqsWysRkw6epf/neXU/QHxAEefjn5dCTREjdUunNLn9ZcZFVUqoZRT3BGXBIArWnIB5M5dyBLegrLTLnClkYUt1LmjNSM97+8qqiuUgsEYBKvd35ElVN0Caaaxo5wDbapNPK0y9S7T1NtgfEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQFx8nBOHYeKChxRhx7b6f+PuFTU0g03fjAngY/bTJQ=;
 b=mRzVzySbBJMfDR69KJAYTXpMGWx4xiBLXrFD5RoMcAH+4Q/AhYDFdxQminiNpw55fCikfk+2THs8cUpD/dG+LKsKdRTuiq7s9FsudSn90XNw4deneBG2QQJ/X5ArV3qvHrOd/nFTeJbcUSo8vrTPi9UxhL5KedKunEWDxZCJngKPn0uAeW34GJfRjn+yHWWcl5XqFRYZsiheEtwxZvIyIA8Sqaq4KIUkJwrBRd9F10tsVomd9viHT2QrAkWe6YE2nnLyzXR4pBdwWeWKBrA5ZnR2TUJWUsBeGWxFwIDbFVh/9phfLc3bwVr0+KtY18K4hzOEn5UmSTc1HDptR5GHhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cn.digi-group.com; dmarc=pass action=none
 header.from=cn.digi-group.com; dkim=pass header.d=cn.digi-group.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=digiworld.onmicrosoft.com; s=selector2-digiworld-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQFx8nBOHYeKChxRhx7b6f+PuFTU0g03fjAngY/bTJQ=;
 b=A061io8J94z7bdnZvshfkqzPpDcRkUVULGQcqMC9jr+2VocgTeNVV6HyUsrndV3oYB/9u8iwUIcbl3pVKU+zmpVqFFMEmRmYa5BqMw/g5UPaf3h5KwxxsWP9eA0jT8I7m7ZWfJ9LFbeQXQbUEeAAIJrMKiSn2n8MEHCssJ5tGHs=
Received: from HK0PR06MB3825.apcprd06.prod.outlook.com (2603:1096:203:ad::15)
 by HK0PR06MB2211.apcprd06.prod.outlook.com (2603:1096:203:40::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 13 Jan
 2021 06:40:44 +0000
Received: from HK0PR06MB3825.apcprd06.prod.outlook.com
 ([fe80::f5c6:1f35:5fd5:9501]) by HK0PR06MB3825.apcprd06.prod.outlook.com
 ([fe80::f5c6:1f35:5fd5:9501%7]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 06:40:44 +0000
From:   Jin Chen Xin <cx.jin@cn.digi-group.com>
To:     Johan Hovold <johan@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] drivers: add new VID/PID for supporting Teraoka AD2000
Thread-Topic: [PATCH] drivers: add new VID/PID for supporting Teraoka AD2000
Thread-Index: Adbpdt5nat7f+AvPRjaK1ubQJbikvQ==
Date:   Wed, 13 Jan 2021 06:40:44 +0000
Message-ID: <HK0PR06MB38251CB5A6EA6CC81EB34A0B9FA90@HK0PR06MB3825.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=cn.digi-group.com;
x-originating-ip: [116.228.41.234]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7f13b8a-27cb-494e-fa4e-08d8b78e272c
x-ms-traffictypediagnostic: HK0PR06MB2211:
x-microsoft-antispam-prvs: <HK0PR06MB22115A6C860CB4799B2BFD339FA90@HK0PR06MB2211.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EjCBB6z231BWd2nb0uzZWizL6bHg0Bhh0kjkvXoE5TMnhhXO78mjzVdSJoyIxuh1F6Jw8kkZ/n9jVVr74wwUoZRADS8v98UFT5NN/RW0vVkIoOGmHqZZpV1D3o/mlp/cdKLvWRmMVETberX24DDwGGQXr0F9JFZryUZceGm7gJwITfOETRaWICTknxGeQaDFmA5PtY3H3nV0NglUABK8ZYhLi7dWY6XkZem/eZw4L/Lt5/jkg8kmYqHvUKy1KQebmEBDWlkkslPE/ssqVVVxMiN0cAHcUw2kVAolvCFvLuxAbwarjv4lcYjNvLy8T3xnYZaovDoObFz61zG7OXsgT9q0mgsdO1vcDLwRTO9Pvt1S1mB//II/M3VvBGIYSbZLK0iYlPgVGXrQlSl+LRy09A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3825.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(66476007)(76116006)(64756008)(54906003)(66616009)(66556008)(66946007)(52536014)(9686003)(7696005)(6916009)(55016002)(186003)(316002)(26005)(8936002)(66446008)(83380400001)(2906002)(4744005)(6506007)(5660300002)(478600001)(8676002)(86362001)(99936003)(71200400001)(4326008)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: VS8oS+gGnYUSfhKUQb26mBTDZkmnW+poeX4pV3f+L3RcpjRrxg+jLsNhhtFOKWne3hSxDOlFTGOgY8fMBdJF2w/FxWbP2cxDwTyHrMw1WtmQzr5MB9PEMJfa+PLJtOLy/tv6Ft9YDBTmy18vNcYAD49m2LqUWH5r3qXhtFK5yM86JiVfL9TbBpoD8ZFp0TR0iNnq8rfVJ0jINbRldPm+ayMhTo+DVwPK9vU6sumzTkMgn4rvAnZ7V5+59Y/7qD1z9Zao4y4xWvunm3P2vs30zVj0HMz34PYLnu7puHJoqQn6FQZ0Gcnw0HY3Z6ca2I7NqG1Y1t684vU4ysy38Fv1/Z0U5hIoeUW7U5PLGbt4EA/w6+rPp8lwPsSCqvuH/gWgUfoseX0Lg0u2EJFFEOp4RH7OrnsogLqjQVp12lgXNecqnbNIJz1GcH++tkl8JcJ1NH7V2yzw1JcRELT2BvqA2SYIKRw5DTUegvse94M4+DLL8xcSEq7W9ztn0cXAUMeOebnuSLY0k0mvlHXhqEU8khpA+mrIhfqM7ob5QkP8vanQ/uRLsAxmy0a9rLL6NxtrsmAOdY+y+tSYPeTxGCeZp3wZcWw+3M89XlPagLMUa/GQE2Zyt0W2EoCnpg+qhk3HrDt8pPArvf4+emF/0e+l5odzOA5wm4Ky411r3AtZFBAqW/HnjF5k+xDweP98iX75JwkATYx1ZdTcAMx3bBCBvGTlmkyiDIJ4OXjneD0ZZ4U=
x-ms-exchange-transport-forked: True
Content-Type: multipart/mixed;
        boundary="_002_HK0PR06MB38251CB5A6EA6CC81EB34A0B9FA90HK0PR06MB3825apcp_"
MIME-Version: 1.0
X-OriginatorOrg: cn.digi-group.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3825.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f13b8a-27cb-494e-fa4e-08d8b78e272c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 06:40:44.1144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 05a6dd31-dbec-4a4f-a8cd-2eada561cecf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2K2wOBBF+29knGQ/X2XUtlH93J18fHMYHRuw/0Z1Dmfuozj+laYRuo3nj3Lxdby+L1tsK2WaUh741KTTETDYSl0/c0mHE9inaIMa5zHHNts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2211
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_HK0PR06MB38251CB5A6EA6CC81EB34A0B9FA90HK0PR06MB3825apcp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCg0KDQpCZXN0IFJlZ2FyZHMsDQoNCkppbiBDaGVuLVhpbg0KU29mdHdhcmUgRGV2ZWxvcG1l
bnQgRGVwdC4NClNoYW5naGFpIFRlcmFva2EgRWxlY3Ryb25pYyBDby4sIEx0ZC4NCg0KKiBUaGUg
aW5mb3JtYXRpb24gY29udGFpbmVkIGluIHRoaXMgbWVzc2FnZSBpcyBpbnRlbmRlZCBmb3IgdGhl
IHVzZSBvZiB0aGUgaW5kaXZpZHVhbHMgdG8gd2hvbSBpdCBpcyBhZGRyZXNzZWQgYW5kIG1heSBj
b250YWluIGluZm9ybWF0aW9uIHRoYXQgaXMgcHJpdmlsZWdlZCBhbmQgY29uZmlkZW50aWFsLiBJ
ZiB5b3UgaGF2ZSByZWNlaXZlZCB0aGlzIGVtYWlsIGJ5IG1pc3Rha2UsIHBsZWFzZSBkaXNjYXJk
IHRoaXMgZW1haWwgaW1tZWRpYXRlbHkuIERvIG5vdCBkaXNjbG9zZSwgZm9yd2FyZCBvciBjb3B5
Lg0KKiDkv6Hmga/lronlhajlo7DmmI7vvJrmnKzpgq7ku7Yo5YyF5ous5YW25Lu75L2V6ZmE5Lu2
77yJ55qE5L+h5oGv77yM5LuF55So5LqO6YKu5Lu25YiX5Ye655qE5o6l5pS26ICF5L2/55So77yM
5bm25LiU5Y+v6IO95YyF5ZCr5pyJ54m56K645ZKM5py65a+G55qE5L+h5oGv44CC5aaC5p6c5oKo
6K+v5pS25Yiw6L+Z5bCB55S15a2Q6YKu5Lu277yM6K+36YCa55+l5Y+R5Lu25Lq677yM5bm256uL
5Y2z5Yig6Zmk5a6D77yM6K+35Yu/6YCP6Zyy44CB6L2s5Y+R5oiW5aSN5Yi244CCDQo=

--_002_HK0PR06MB38251CB5A6EA6CC81EB34A0B9FA90HK0PR06MB3825apcp_
Content-Type: application/octet-stream;
	name="0001-drivers-add-new-VID-PID-for-supporting-Teraoka-AD200.patch"
Content-Description:
 0001-drivers-add-new-VID-PID-for-supporting-Teraoka-AD200.patch
Content-Disposition: attachment;
	filename="0001-drivers-add-new-VID-PID-for-supporting-Teraoka-AD200.patch";
	size=1056; creation-date="Wed, 13 Jan 2021 06:35:43 GMT";
	modification-date="Wed, 13 Jan 2021 06:35:43 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxZGYxMTljZmExMDUzODNhMGUwNDdhNjg2MDJiM2E5ZGM0ZjgxYzNjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKaW4gQ2hlbi1YaW4gPGN4LmppbkBjbi5kaWdpLWdyb3VwLmNv
bT4KRGF0ZTogV2VkLCAxMyBKYW4gMjAyMSAxNDowOTowNyArMDgwMApTdWJqZWN0OiBbUEFUQ0hd
IGRyaXZlcnM6IGFkZCBuZXcgVklEL1BJRCBmb3Igc3VwcG9ydGluZyBUZXJhb2thIEFEMjAwMAoK
VGVyYW9rYSBBRDIwMDAgdXNlcyB0aGUgQ1AyMTB4IGRyaXZlciwgYnV0IHRoZSBjaGlwIFZJRC9Q
SUQgaXMKY3VzdG9taXplZCB3aXRoIDA5ODgvMDU3OC4gV2UgbmVlZCB0aGUgZHJpdmVyIHRvIHN1
cHBvcnQgdGhlIG5ldyBWSUQvUElELgoKU2lnbmVkLW9mZi1ieTogSmluIENoZW4tWGluIDxjeC5q
aW5AY24uZGlnaS1ncm91cC5jb20+Ci0tLQogZHJpdmVycy91c2Ivc2VyaWFsL2NwMjEweC5jIHwg
MSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L3VzYi9zZXJpYWwvY3AyMTB4LmMgYi9kcml2ZXJzL3VzYi9zZXJpYWwvY3AyMTB4LmMKaW5kZXgg
ZmJiMTBkZi4uYzI3NGNjMyAxMDA2NDQKLS0tIGEvZHJpdmVycy91c2Ivc2VyaWFsL2NwMjEweC5j
CisrKyBiL2RyaXZlcnMvdXNiL3NlcmlhbC9jcDIxMHguYwpAQCAtMjM0LDYgKzIzNCw3IEBAIHN0
YXRpYyBpbnQgY3AyMTB4X3Rpb2Ntc2V0X3BvcnQoc3RydWN0IHVzYl9zZXJpYWxfcG9ydCAqcG9y
dCwKIAl7IFVTQl9ERVZJQ0UoMHgzMTk1LCAweEYyODEpIH0sIC8qIExpbmsgSW5zdHJ1bWVudHMg
TVNPLTI4ICovCiAJeyBVU0JfREVWSUNFKDB4MzkyMywgMHg3QTBCKSB9LCAvKiBOYXRpb25hbCBJ
bnN0cnVtZW50cyBVU0IgU2VyaWFsIENvbnNvbGUgKi8KIAl7IFVTQl9ERVZJQ0UoMHg0MTNDLCAw
eDk1MDApIH0sIC8qIERXNzAwIEdQUyBVU0IgaW50ZXJmYWNlICovCisJeyBVU0JfREVWSUNFKDB4
MDk4OCwgMHgwNTc4KSB9LCAvKiBUZXJhb2thIEFEMjAwMCAqLwogCXsgfSAvKiBUZXJtaW5hdGlu
ZyBFbnRyeSAqLwogfTsKIAotLSAKMS44LjMuMQoK

--_002_HK0PR06MB38251CB5A6EA6CC81EB34A0B9FA90HK0PR06MB3825apcp_--
