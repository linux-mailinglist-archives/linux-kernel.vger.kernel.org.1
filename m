Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C904A28B1DB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 11:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbgJLJ6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 05:58:20 -0400
Received: from mail-eopbgr00042.outbound.protection.outlook.com ([40.107.0.42]:27014
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726104AbgJLJ6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 05:58:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4wPL5lKEBlcAVhOjURJtzpQeCjqqU516582akIDjdp+nwcG8QNuGwffZdWxWdF8Jgs2ylrYKGSrYptjv/9t3HkmgoMM307W0jtkUxszyKIwzH8hNxCiCQ7u19yIEL+hjLDg6kh8jUbuthDCGRZvsqaWrSnXUdY5vIyXtjrmie7zqd9QUUZV91llFJQ3OB8tp5hiVLOuEg1uOvz6WeDfTO5Wcg6CsxCl+zJDs7dtESnPV/7oB+zF5gaBeyP1WVUamQUDYpOyOHEaUyMliyeJN3VnL6LY3jFyvItf+bARxGO0ahkiY0JdY64OafrQBi4NVsgoqYwJ5vpT/0G+TF+hWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRSSapvlObmIyyBOy/1x2/FtKGsKdyFw3YVT25YRwsU=;
 b=I4FLan3CykHPwbs9o3VFaRnmxdVsWae3ZLg8kSSqeSMk204joftB0R0ks6JorZ43y8V/3tIb35OTNrDZxH/ne1HFXpb3ssB8DQBq6BcdeQ/Toq0BvwAN1glUuLPv6j7VVrPlh8Yj1wTaq7pfPvpnlo7eO/qIJMJGjgOn9AsFmDhZAmnJGCS409jclk5t2Ld4QmKj4+bBWIwQHQmchNWDY9bYjD25l2BAz28wFYvvq+TF4f0kJoHTEHyNC6X0ZChmdie6tmVQlpEMbQR62J6au9zCNIoQJZ7hDO/vvUjC/uMtGNRAf4dCvySJUc1L/bYrb4wFPK9TG17Y+fubrayXIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRSSapvlObmIyyBOy/1x2/FtKGsKdyFw3YVT25YRwsU=;
 b=r6FOFJPTUvzrw/TmFIRsIeH3rWUst/hnGXw0GPJH6R5s5j0jHGXDxOaHoUm88vmXdNLHWW2Xv9Avl/IkXijIyG3cWlKSff+teosWHn2fUUP8aQTlDh6fFiJKRe7PqUQBgSiooHW390c+WzpbHbmjvuI/irOkVdpaa6acxaShip0=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB8PR04MB5786.eurprd04.prod.outlook.com (2603:10a6:10:a8::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Mon, 12 Oct
 2020 09:58:15 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::d12e:689a:169:fd68]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::d12e:689a:169:fd68%8]) with mapi id 15.20.3455.030; Mon, 12 Oct 2020
 09:58:15 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     John Garry <john.garry@huawei.com>, Frank Li <frank.li@nxp.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "zhangshaokun@hisilicon.com" <zhangshaokun@hisilicon.com>
CC:     "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "irogers@google.com" <irogers@google.com>
Subject: RE: [PATCH v2 2/4] bindings/perf/imx-ddr: update compatible string
Thread-Topic: [PATCH v2 2/4] bindings/perf/imx-ddr: update compatible string
Thread-Index: AQHWnVWj7VjhBh5bJUetpW1Kg95xr6mTwOYw
Date:   Mon, 12 Oct 2020 09:58:14 +0000
Message-ID: <DB8PR04MB67956E85AEB823FEB859063BE6070@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <1602149181-237415-1-git-send-email-john.garry@huawei.com>
 <1602149181-237415-3-git-send-email-john.garry@huawei.com>
In-Reply-To: <1602149181-237415-3-git-send-email-john.garry@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6d4dbb3e-5681-42d7-70b7-08d86e955650
x-ms-traffictypediagnostic: DB8PR04MB5786:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB57866783AE8F8D42D7FB9672E6070@DB8PR04MB5786.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LrWCBf8Aas24TrC5JdBdnTse4yy87W2BAscMUp2IW+1MjHujgn18DPgVHACJWSmO/tVQU95fZanqxyEL6EBtrbV9Zo5Fe6qlNN9fXRq4o5DxX+zHwf+Ukp3tK6tnsh+WFlS75IOcIn82mQgYXHwC/Q2yBZDr2Qtb4NV4OIoXitiMIdlks7vNTiEJ2kUUnPxqFmyjKk2xjd2zkEoCldFgpRH94hTNabF6DLlkifpZCi9DwgJ0XWgkGy3nE3xpaMC/a28eEdv2uB5X+Fmp/DIpL2jGERF6okmAP7Lk+/9mQJp8PVrygDj6WpbqdTVvL/StCq/Y3I62emIncw9mm03wmJu7LdYNkMTcStqjSXEl6crGqGW6izFUx6Ft+78vfeGgPg4RSLr7wVqT4ZBxo5k24Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(186003)(33656002)(83380400001)(76116006)(478600001)(966005)(6506007)(66476007)(66556008)(66446008)(86362001)(55016002)(26005)(8936002)(5660300002)(4326008)(64756008)(53546011)(66946007)(2906002)(83080400001)(7416002)(54906003)(110136005)(15650500001)(8676002)(71200400001)(316002)(9686003)(7696005)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: xek4z2eZEOMJ0LokoVAjmvQwYBXWc0LbDvBmM92WBuPztqdFOXQOuDrCoX/sAi2AwsKVSsoi2H0C+It2AeT6CsZtMbf2GEckO4d27wX66wJOd9LcSayzEzRnM1gy8wQO6uXAYsEEn+jbN8C6MTmd2dtnUj3CD4fbaxThDlHR3TaJu4XHsN7veEUzMz5xmh5IiSHqsyJ4B4eo87ZjeSlPV6m7fovZ9nLouArzVgaZ6ZAVt24DFlVVWE3f6iXV/7EOsc4DtgGYWBTT6IqoSRXK2Baef4A39PXIZbJxJnW7K73OoPd9iwiCr/y78Kq9m+nj4UCszSRXBJ2xH4ahhk1wmO+OJaa2CT6qZCv5BYptRLkDnTf/mj1v3Prf2WQvEfpJnQ3XG64v8t1sp2EuK42i1iBbZ1bHsVoN51PHQkh2+XWyEMZYoUhMhFvFHQ+yYcpHTCCKUbhZN0ZtX2ocPT9WkFSc2eOMdkUppsb3O+3t22sG3rK3i7v73cCe6HlC0Z54nEjYPmndh7lEWrg6iA86ZJHOm6iMpv6MMB2c3whs+avxqs4FMczruKXznVttPzOoS3BkVaG8jp+TPswPLCn2LJKywdFI1r77mL/dXvo9DVq5NiQhvMjRkqECbkpLIgPynffsonQc9J2EaLEbka1x0w==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4dbb3e-5681-42d7-70b7-08d86e955650
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2020 09:58:14.9473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rcyBtTJaMYmtsi9YH3GWi6XUwt6S1frsxZzeNdTq/RY4mcePDfpZxVYfmKbk2kAFdahcjk+I41+JHyrAvgq5Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5786
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBKb2huLA0KDQpJIHNhdyB0aGlzIGJpbmRpbmcgZmlsZSBoYXMgY2hhbmdlZCB0byB5YW1s
IGZvcm1hdCwgdGhpcyBwYXRjaCBzZWVtcyBub3QgbmVlZCBhbnkgbW9yZS4NCmh0dHBzOi8vZ2l0
Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25leHQvbGludXgtbmV4dC5naXQv
dHJlZS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGVyZi9mc2wtaW14LWRkci55
YW1sP2g9bmV4dC0yMDIwMTAwOQ0KDQpCZXN0IFJlZ2FyZHMsDQpKb2FraW0gWmhhbmcNCg0KPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb2huIEdhcnJ5IDxqb2huLmdhcnJ5
QGh1YXdlaS5jb20+DQo+IFNlbnQ6IDIwMjDE6jEw1MI4yNUgMTc6MjYNCj4gVG86IEZyYW5rIExp
IDxmcmFuay5saUBueHAuY29tPjsgd2lsbEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNv
bTsNCj4gcm9iaCtkdEBrZXJuZWwub3JnOyB6aGFuZ3NoYW9rdW5AaGlzaWxpY29uLmNvbTsgSm9h
a2ltIFpoYW5nDQo+IDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNvbT4NCj4gQ2M6IGxpbnV4YXJtQGh1
YXdlaS5jb207IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGFj
bWVAa2VybmVsLm9yZzsgam9sc2FAcmVkaGF0LmNvbTsgaXJvZ2Vyc0Bnb29nbGUuY29tOyBKb2hu
IEdhcnJ5DQo+IDxqb2huLmdhcnJ5QGh1YXdlaS5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2MiAy
LzRdIGJpbmRpbmdzL3BlcmYvaW14LWRkcjogdXBkYXRlIGNvbXBhdGlibGUgc3RyaW5nDQo+IA0K
PiBGcm9tOiBKb2FraW0gWmhhbmcgPHFpYW5ncWluZy56aGFuZ0BueHAuY29tPg0KPiANCj4gVXBk
YXRlIGNvbXBhdGlibGUgc3RyaW5nIGFjY29yZGluZyB0byBkcml2ZXIgY2hhbmdlLg0KPiANCj4g
W2pwZzoga2VlcCAiZnNsLGlteDhtLWRkci1wbXUiLCB3aGljaCB3YXMgYmVpbmcgcmVtb3ZlZF0N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpvYWtpbSBaaGFuZyA8cWlhbmdxaW5nLnpoYW5nQG54cC5j
b20+DQo+IFNpZ25lZC1vZmYtYnk6IEpvaG4gR2FycnkgPGpvaG4uZ2FycnlAaHVhd2VpLmNvbT4N
Cj4gLS0tDQo+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGVyZi9mc2wtaW14
LWRkci50eHQgfCAzICsrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wZXJmL2Zz
bC1pbXgtZGRyLnR4dA0KPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wZXJm
L2ZzbC1pbXgtZGRyLnR4dA0KPiBpbmRleCA3ODIyYTgwNmVhMGEuLmNjMzhjN2ZkNzA0OSAxMDA2
NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BlcmYvZnNsLWlt
eC1kZHIudHh0DQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wZXJm
L2ZzbC1pbXgtZGRyLnR4dA0KPiBAQCAtNSw2ICs1LDkgQEAgUmVxdWlyZWQgcHJvcGVydGllczoN
Cj4gIC0gY29tcGF0aWJsZTogc2hvdWxkIGJlIG9uZSBvZjoNCj4gIAkiZnNsLGlteDgtZGRyLXBt
dSINCj4gIAkiZnNsLGlteDhtLWRkci1wbXUiDQo+ICsJImZzbCxpbXg4bXEtZGRyLXBtdSINCj4g
KwkiZnNsLGlteDhtbS1kZHItcG11Ig0KPiArCSJmc2wsaW14OG1uLWRkci1wbXUiDQo+ICAJImZz
bCxpbXg4bXAtZGRyLXBtdSINCj4gDQo+ICAtIHJlZzogcGh5c2ljYWwgYWRkcmVzcyBhbmQgc2l6
ZQ0KPiAtLQ0KPiAyLjI2LjINCg0K
