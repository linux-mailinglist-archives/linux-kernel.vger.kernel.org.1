Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0357628BAE9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 16:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388881AbgJLOeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 10:34:23 -0400
Received: from mx07-001d1705.pphosted.com ([185.132.183.11]:28512 "EHLO
        mx07-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726963AbgJLOeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 10:34:23 -0400
X-Greylist: delayed 418 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Oct 2020 10:34:19 EDT
Received: from pps.filterd (m0209325.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09CEIcCH028823;
        Mon, 12 Oct 2020 14:26:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=S1;
 bh=I8Krdx3MIlmpPrOJYraBkt0DIGaTXXjOICWm+WQhqVY=;
 b=GSrZ28U/XJk3p3mLPx6iknS7qL2+xoTkdaZBI6ypkay67B7gpD2nlmgrh2Qysjs60kHz
 xLXwE0onkBDYF6m5saspWUIY6medr9xCwGegF7wC0q38gY8JiLhvrhyxFdf9YA8/LWjA
 sTG5w5krEnFCR60JybQ5ruYMwBiP0hsBkoImlsdsLIt3p7kgjg8JGZboDe/1NVZjf2l/
 5ZmUQliU4LOWA7e7lDAT7nIsintmMYyUYuuSX8Ymm/CwCKSmuxCfS5ifrWsaU4JJb6l3
 3DJ3SezHrASqFlTyVJT8qT44plzMy2UrcnhxSJRqnS/L3av8EID2lBWG6ClmsKJsyyMY sw== 
Received: from eur03-ve1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2050.outbound.protection.outlook.com [104.47.9.50])
        by mx08-001d1705.pphosted.com with ESMTP id 34326y96e6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Oct 2020 14:26:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVLcPDAKy0dBsZFmkxYdCgw3Q4lvc392dgZN0vL69NHAcL+jRY98FiN0Dcs8K16IURlFq/TbyxI9ej66il3lRwXQpXKI0ZVM9mFQGZIkwCp2UPpOo4qreXCJE00qFb7FjBU/xduuuJGggOZXNON5JF0CEaDO8uY6SN/CwiR1W48ANpbOznsgQmv7yDSwQpBVKm1zWXU5XCGw0jYLRS8sFbWaY+U8KjHUZ2STlIFlFuSbB1ORcP1U9iozMCp8JLqnyUJuC4CFFsKgYv8IzqhAI9hdB3uWJ9Mu1l/PpJmikJ4QFdWAL9oIMaThWXQIkh+R2EiWrQLFD30/V9xE+Ph5jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8Krdx3MIlmpPrOJYraBkt0DIGaTXXjOICWm+WQhqVY=;
 b=ciS6cb1YhVHnAJ0u+dU9gEa+4XjjJFt4UCfWCwB6y737RkC49W00OcmqgGnEKOfwxkrgcmOLn+flOXsosFWzoUV8IKuz0qOUjbtyS6oQjsXBrjXrBlKe3UuehZa6fLyKQ8ySr+ry0igTFVKJW//fmGuhSDKS3WVj+IcKirVqIn0XubpBeP+UMMffGcDesuWoVE8NTGfhGIQlJKfEPlpvr8mvEIH94EwuLjg+N27zcmCsJ6T/ixqeKYxy9gOshCb5EqcOPIt7DUvUYWvCJgpS9Nwc8s6EylShugB6zkBLAoJY5TDyE5tQTmIRi3htOjjRxBETGhgiqYDsTzGNJRacMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from AM0P193MB0626.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:14b::8)
 by AM9P193MB0886.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1f6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Mon, 12 Oct
 2020 14:26:48 +0000
Received: from AM0P193MB0626.EURP193.PROD.OUTLOOK.COM
 ([fe80::7008:9da:f727:c8a6]) by AM0P193MB0626.EURP193.PROD.OUTLOOK.COM
 ([fe80::7008:9da:f727:c8a6%4]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 14:26:48 +0000
From:   "Enderborg, Peter" <Peter.Enderborg@sony.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] trace: Return ENOTCONN instead of EBADF
Thread-Topic: [PATCH] trace: Return ENOTCONN instead of EBADF
Thread-Index: AQHWoHF1xEgIyHKD4EaIBfYgpnQprqmT/TcAgAAJVQA=
Date:   Mon, 12 Oct 2020 14:26:48 +0000
Message-ID: <55b99d8d-f75a-e095-63fa-3d5df8b77f1b@sony.com>
References: <20201012082642.1394-1-peter.enderborg@sony.com>
 <20201012095324.78996fd2@gandalf.local.home>
In-Reply-To: <20201012095324.78996fd2@gandalf.local.home>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none header.from=sony.com;
x-originating-ip: [37.139.156.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 14c29493-f10f-4ba6-489e-08d86ebadae0
x-ms-traffictypediagnostic: AM9P193MB0886:
x-microsoft-antispam-prvs: <AM9P193MB088666AB51C4CE558677B30F86070@AM9P193MB0886.EURP193.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V+S5bU58F4K54m2ylVL7/IDa2F2544xZV4nLftVITE6kpY/LOb2nQKUeT+nn/ezRneSx8qL7bybJMDJ+Uv8sbmalrN2m5FfMP/tKmETnv1yW8HpC3DU9KeKtnuxTeGxFNsNVPSpDdeUbc/4sTDhOf2jloIglTqmvA+7ycifTtjYET2GnkMCCV/H7ebsfkpStcdWvG+K31jZcsD9inzK+D8xoDxPM6/x2d6Tt6Q/nuCf5EruqJ5arnmZadT8x+Le71dSod24eOhHd2N9Bz6xm5SVbwpV4RrsYdd+QdxTNWh1u478tNBxul2a1wxaV/p1R3U3W9zaqal5JeF59VhThwZBmLcsnujGDpEiArPdcClLCowqEQYmj4gv31UyPnzec
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P193MB0626.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(8936002)(6506007)(53546011)(71200400001)(5660300002)(2616005)(86362001)(6512007)(83380400001)(66476007)(6916009)(66446008)(66946007)(66556008)(64756008)(91956017)(4326008)(8676002)(478600001)(316002)(6486002)(26005)(36756003)(54906003)(31686004)(186003)(31696002)(2906002)(76116006)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 23x2+WSt00Os9hA+YFE0w7ZCzQw/NffdjdL/ugjm9nDUX3HvoFHwQ5J7XSWt69ZV41WxxRC/rlIZPFaMYMB2XUIKEqAhY9+HSOng7Ej/aoGY7WxZbK/58b6Cdla8vdHdXYjJtVaU0VLOlDP4Slv3YLK5VjZ3Noxp094BSFk1x2f0/1CY2te6TAQYOkxB5QjFQSErlMj+4paeWcVxzJE0iBEXYuuath6OU0S2JP016SiXDrWDtXq0Pt14uYRNtRwwiLFUZVIn57tQ9w2DZ+aEDoQdrO/tggSPuYvV0Ni1GhSWcUpYtFsNNY2aYsy+AS2hC3ZrkOZX0BUc9fZ2VelQQ4J3VqvHMnLa9dMWMB3ImX+CyXMxkaov3TX6xmp9FI31Aon0i3/8ruxsBfszw/vgYt3QcdYZftCHlvuqyXR7SjvykfalF+1Z3+qHaN9a3IjH6S3yjdmOLpHj42j2nhuQKMhNzxkqfIApzZr7PApatOf2a2M78UrDDLZjAenuKPDiQdXw6r80G710zN/Uft1cQrgUu8qh641egkQJsaCOJaJCWzpoAte0rjSq4HxmDmz6PcBpzDwJL/KG5t065+GwuFLRiWLoQjLt4OgEJazuRMyUTI8XKLDOVZppK9S7b1kfcyuwtVk7oqXWibLPCBboZQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EB306CDD00993488C09F3EBE140E2F6@EURP193.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0P193MB0626.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c29493-f10f-4ba6-489e-08d86ebadae0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2020 14:26:48.6973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T5aEZw1H8bvhCEduVDfQTMI3t7+udHSrOAB5ZLZLv5KQKnFYeXhrt3lRrNVRhT6fgCe4MPukfMfNuE9nt1/p60Ccc3HnThYsmepVWG7x6OY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB0886
X-Sony-Outbound-GUID: Hk3JqiqqZMOZOuRM_awH0QT5yrdtPFQT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-12_09:2020-10-12,2020-10-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1011 malwarescore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010120115
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMTIvMjAgMzo1MyBQTSwgU3RldmVuIFJvc3RlZHQgd3JvdGU6DQo+IE9uIE1vbiwgMTIg
T2N0IDIwMjAgMTA6MjY6NDIgKzAyMDANCj4gUGV0ZXIgRW5kZXJib3JnIDxwZXRlci5lbmRlcmJv
cmdAc29ueS5jb20+IHdyb3RlOg0KPg0KPj4gV2hlbiB0aGVyZSBpcyBubyBjbGllbnRzIGxpc3Rl
bmluZyBvbiBldmVudCB0aGUgdHJhY2UgcmV0dXJuDQo+PiBFQkFERi4gVGhlIGZpbGUgaXMgbm90
IGEgYmFkIGZpbGUgZGVzY3JpcHRvciBhbmQgdG8gZ2V0IHRoZQ0KPj4gdXNlcnNwYWNlIGFibGUg
dG8gZG8gYSBwcm9wZXIgZXJyb3IgaGFuZGxpbmcgaXQgbmVlZCBhIGRpZmZlcmVudA0KPj4gZXJy
b3IgY29kZSB0aGF0IHNlcGFyYXRlIGEgYmFkIGZpbGUgZGVzY3JpcHRvciBmcm9tIGEgZW1wdHkg
bGlzdGVuaW5nLg0KPiBJIGhhdmUgbm8gcHJvYmxlbSB3aXRoIHRoaXMgcGF0Y2gsIGJ1dCB5b3Vy
IGRlc2NyaXB0aW9uIGlzIGluY29ycmVjdC4gQW5kDQo+IGJlZm9yZSBtYWtpbmcgdGhpcyBjaGFu
Z2UsIEkgd2FudCB0byBtYWtlIHN1cmUgdGhhdCB3aGF0IHlvdSB0aGluayBpcw0KPiBoYXBwZW5p
bmcgaXMgYWN0dWFsbHkgaGFwcGVuaW5nLg0KPg0KPiBUaGlzIGhhcyBub3RoaW5nIHRvIGRvIHdp
dGggImNsaWVudHMgbGlzdGVuaW5nIi4gVGhpcyBoYXBwZW5zIHdoZW4gdGhlIHJpbmcNCj4gYnVm
ZmVyIGlzIGRpc2FibGVkIGZvciBzb21lIHJlYXNvbi4gVGhlIG1vc3QgbGlrZWx5IGNhc2Ugb2Yg
dGhpcyBoYXBwZW5pbmcNCj4gaXMgaWYgc29tZW9uZSBzZXRzIC9zeXMva2VybmVsL3RyYWNpbmcv
dHJhY2luZ19vbiB0byB6ZXJvLg0KDQpJIHNlZSB0aGF0IGFzIG5vIG9uZSBpcyBsaXN0ZW5pbmcu
IFlvdSBzdGFydCB0byBsaXN0ZW4gYnkgc2V0dGluZyB0aGlzIHRyYWNpbmcgb24NCnNvbWUgaW5z
dGFuY2UsIGJ1dCB0aGF0IGlzIGZvciB0cmFjZV9waXBlLiBJcyBpdCB0aGUgc2FtZSBmbGFnIGZv
ciByYXcgYWNjZXNzIGFuZCBhbGwgd2F5cyB5b3UNCmNhbiBpbnZva2UgYSB0cmFjZT8NCg0KV291
bGQNCg0KIldoZW4gdGhlcmUgaXMgbm8gaW5zdGFuY2VzIGxpc3RlbmluZyBvbiBldmVudHMgdGhl
IHRyYWNlIHJldHVybg0KRUJBREYsIGl0IGlzIHdoZW4gdGhlIHRyYWNpbmdfb24gaXMgb2ZmIGds
b2JhbGx5LiBUaGUgZmlsZSBpcyBub3QgYSBiYWQgZmlsZQ0KZGVzY3JpcHRvciBhbmQgdG8gZ2V0
IHRoZSB1c2Vyc3BhY2UgYWJsZSB0byBkbyBhIHByb3BlciBlcnJvciBoYW5kbGluZyBpdCBuZWVk
IGEgZGlmZmVyZW50DQplcnJvciBjb2RlIHRoYXQgc2VwYXJhdGUgYSBiYWQgZmlsZSBkZXNjcmlw
dG9yIGZyb20gYSBlbXB0eSBsaXN0ZW5pbmcuIg0KDQpiZSBhIG9rPw0KDQoNCj4gSWYgdGhpcyBp
cyBzdGlsbCBzb21ldGhpbmcgeW91IHdhbnQgYXBwbGllZCwgcGxlYXNlIHVwZGF0ZSB0aGUgY2hh
bmdlIGxvZw0KPiB0byBhIG1vcmUgYWNjdXJhdGUgc2NlbmFyaW8uDQo+DQo+IFRoYW5rcywNCj4N
Cj4gLS0gU3RldmUNCj4NCj4NCj4+IFNpZ25lZC1vZmYtYnk6IFBldGVyIEVuZGVyYm9yZyA8cGV0
ZXIuZW5kZXJib3JnQHNvbnkuY29tPg0KPj4gLS0tDQo+PiAga2VybmVsL3RyYWNlL3RyYWNlLmMg
fCA4ICsrKystLS0tDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxl
dGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEva2VybmVsL3RyYWNlL3RyYWNlLmMgYi9rZXJu
ZWwvdHJhY2UvdHJhY2UuYw0KPj4gaW5kZXggZDNlNWRlNzE3ZGYyLi42ZTU5MmJmNzM2ZGYgMTAw
NjQ0DQo+PiAtLS0gYS9rZXJuZWwvdHJhY2UvdHJhY2UuYw0KPj4gKysrIGIva2VybmVsL3RyYWNl
L3RyYWNlLmMNCj4+IEBAIC02NjUxLDggKzY2NTEsOCBAQCB0cmFjaW5nX21hcmtfd3JpdGUoc3Ry
dWN0IGZpbGUgKmZpbHAsIGNvbnN0IGNoYXIgX191c2VyICp1YnVmLA0KPj4gIAlldmVudCA9IF9f
dHJhY2VfYnVmZmVyX2xvY2tfcmVzZXJ2ZShidWZmZXIsIFRSQUNFX1BSSU5ULCBzaXplLA0KPj4g
IAkJCQkJICAgIGlycV9mbGFncywgcHJlZW1wdF9jb3VudCgpKTsNCj4+ICAJaWYgKHVubGlrZWx5
KCFldmVudCkpDQo+PiAtCQkvKiBSaW5nIGJ1ZmZlciBkaXNhYmxlZCwgcmV0dXJuIGFzIGlmIG5v
dCBvcGVuIGZvciB3cml0ZSAqLw0KPj4gLQkJcmV0dXJuIC1FQkFERjsNCj4+ICsJCS8qIFJpbmcg
YnVmZmVyIGRpc2FibGVkLCByZXR1cm4gYXMgaWYgbm90IGNvbm5lY3RlZCAqLw0KPj4gKwkJcmV0
dXJuIC1FTk9UQ09OTjsNCj4+ICANCj4+ICAJZW50cnkgPSByaW5nX2J1ZmZlcl9ldmVudF9kYXRh
KGV2ZW50KTsNCj4+ICAJZW50cnktPmlwID0gX1RISVNfSVBfOw0KPj4gQEAgLTY3MzEsOCArNjcz
MSw4IEBAIHRyYWNpbmdfbWFya19yYXdfd3JpdGUoc3RydWN0IGZpbGUgKmZpbHAsIGNvbnN0IGNo
YXIgX191c2VyICp1YnVmLA0KPj4gIAlldmVudCA9IF9fdHJhY2VfYnVmZmVyX2xvY2tfcmVzZXJ2
ZShidWZmZXIsIFRSQUNFX1JBV19EQVRBLCBzaXplLA0KPj4gIAkJCQkJICAgIGlycV9mbGFncywg
cHJlZW1wdF9jb3VudCgpKTsNCj4+ICAJaWYgKCFldmVudCkNCj4+IC0JCS8qIFJpbmcgYnVmZmVy
IGRpc2FibGVkLCByZXR1cm4gYXMgaWYgbm90IG9wZW4gZm9yIHdyaXRlICovDQo+PiAtCQlyZXR1
cm4gLUVCQURGOw0KPj4gKwkJLyogUmluZyBidWZmZXIgZGlzYWJsZWQsIHJldHVybiBub3QgY29u
bmVjdGVkICovDQo+PiArCQlyZXR1cm4gLUVOT1RDT05OOw0KPj4gIA0KPj4gIAllbnRyeSA9IHJp
bmdfYnVmZmVyX2V2ZW50X2RhdGEoZXZlbnQpOw0KPj4gIA0KDQo=
