Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B15429D554
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgJ1V71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:59:27 -0400
Received: from mail-eopbgr50055.outbound.protection.outlook.com ([40.107.5.55]:11908
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728525AbgJ1V7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:59:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8XU5dQrW49RgLcWcZpMUKI09ZaMSD7ZRe7IEn6VjK6E5YjKbrPcxXw8bNmpngIDA7OjtQbsUyQkcNUr66qO06QGs08Hw8b68d8HGzE2Wi90ilfnCgrSLliUoj7J5N7Ic8b1cQlWTVqLuiYgKAWi4C3UuqxLFjMarxqn26O7+u1ErunSfzy7JKPQ5CsXfzNjwZEModo/0XpK0UigtXb6ojpNwYy6AAfcIFUOBwgfvntDamh99nNHx+otvwWwQeKTlS7AOCs6IOyDEU7i/NCgCZ5QZRO/kglNKUxkWFMbUlhvJT6K1F3ZVsDyMDc+jlapB4G/XLoL8by1ezoMDBa9eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVnrNtmSNrcnstdnfe++jgQ6JbtiFJ5L+ycCliDzrm0=;
 b=CIZdvE4yoSnVVkI0CTsGwe9AgL44tWpJU/Dii2EpcfjNZv0qJH0k3zvRrVSPGo7Fa5uN55V/yePc9wzVVndXA+t4G0lflRQb18JKmgqfgpUOQl1Dcsd6gFxMaUubADQPNsaIfEjAvUcEmN/DM7ljG5PUJyYJt9Kid4lf/GGW8+JsGgz7tvXwU2avWTlRelBP1mPlWKnZrcKlR3ay+PcxInknHt66EXpEmmf6qUkmJ3PMCPLJkB6y/OFpjN5qigCgeaiPDyV5T8J6RTZYaNeyB+VF3/pDx7Th0iBcprsggVH1qvEUpK/KINzjXKqviB/R3DjwFpedjomo2e3IFcPTjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVnrNtmSNrcnstdnfe++jgQ6JbtiFJ5L+ycCliDzrm0=;
 b=YaHeh8YPqKX9lMqYZm/SLQ0rCmQVmx3eYUnUZhNEHpiyABI5ihj+OZiVtSUVU5jvKfjns/DFuJn2IiQVqNupZ+rBfsx2ckjLikUeJFjj7NJ9WPUlBn3A4qSY+OAQp+m33v++xcgo/xBScuD3TQfT5fi3f+hnCy2Ylri+zYsrX98=
Received: from AM0PR04MB4947.eurprd04.prod.outlook.com (2603:10a6:208:c8::16)
 by AM0PR04MB5044.eurprd04.prod.outlook.com (2603:10a6:208:c0::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Wed, 28 Oct
 2020 06:29:23 +0000
Received: from AM0PR04MB4947.eurprd04.prod.outlook.com
 ([fe80::2a:11b5:6807:7518]) by AM0PR04MB4947.eurprd04.prod.outlook.com
 ([fe80::2a:11b5:6807:7518%5]) with mapi id 15.20.3477.028; Wed, 28 Oct 2020
 06:29:23 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     "Dutt, Sudeep" <sudeep.dutt@intel.com>,
        "vincent.whitchurch@axis.com" <vincent.whitchurch@axis.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Dixit, Ashutosh" <ashutosh.dixit@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>
Subject: RE: [PATCH V3 2/4] misc: vop: do not allocate and reassign the used
 ring
Thread-Topic: [PATCH V3 2/4] misc: vop: do not allocate and reassign the used
 ring
Thread-Index: AQHWqDFSEBaTQE/ZZ0S8iz1mc9AwNqmk7OMAgARJc3CAAc3rAIAABx/AgACLBgCAAK8V0IAAHQyAgAAuEfA=
Date:   Wed, 28 Oct 2020 06:29:23 +0000
Message-ID: <AM0PR04MB4947F01860DE953B8496FA8892170@AM0PR04MB4947.eurprd04.prod.outlook.com>
References: <20201022050638.29641-1-sherry.sun@nxp.com>
         <20201022050638.29641-3-sherry.sun@nxp.com>
         <20201023092650.GB29066@infradead.org>
         <VI1PR04MB4960E9ECD7310B8CA1E053DC92190@VI1PR04MB4960.eurprd04.prod.outlook.com>
         <20201027062802.GC207971@kroah.com>
         <VI1PR04MB4960C0E76374B2775D99A82192160@VI1PR04MB4960.eurprd04.prod.outlook.com>
         <20201027151106.e4skr6dsbwvo4al6@axis.com>
         <VI1PR04MB49603783EF3FD3F3635FCDAF92170@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <93bd1c60ea4d910489a7592200856eaf8022ced0.camel@intel.com>
In-Reply-To: <93bd1c60ea4d910489a7592200856eaf8022ced0.camel@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a6e8a3a7-2b12-435b-c630-08d87b0acf98
x-ms-traffictypediagnostic: AM0PR04MB5044:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5044AA5AD23CA63AC5A7A7D892170@AM0PR04MB5044.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8ZhBtR9k1dtnC5jUhJQpdmbKfIAgH2s7KHaVp9sVLmYLGHysndBWL6/SfzLSnSj6YEksRy9AKonL1Q9X6AuDtieGOCVjV9oP2BtETm/kmeiB5R0sl24a9q7fo1TJNi8vNxvv3NaWOzjTywVQByZAmfCpj9kTzJ58sFTZHbXmc+u6fFngPFgrd07AXfG2PM9/uUaz1jnmGlFjW4jOKDtY4ecFKMLI65fEnaZ74de4i6OSWR3ch9scasEcJuTtKd2ZLpZGHFYHBMzG975DZ1T3eUZ+Ba5a/ECAVtvltImgB1zOnoV3ejZLMfENiZctjxhfO85ZaaLDijfwP/5WrZ6NEA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4947.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(55016002)(54906003)(86362001)(9686003)(33656002)(110136005)(8676002)(316002)(71200400001)(2906002)(186003)(83380400001)(4001150100001)(26005)(8936002)(7696005)(64756008)(76116006)(66556008)(66476007)(5660300002)(66946007)(6506007)(52536014)(66446008)(4326008)(44832011)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: miZ2/86rzVWeXSC8N4hPZBSLmoqeYmsURK9w9nrVm0MPNEZTTYqUL4cxxzF9GJplk1zWS2y5sy2BEfkv2v61tgorL6Ky5ZtYGu+hOPJh4ul55zQyU0KR6iaeIL1YV1aTiN5pzEHLIMc0a3udTVJ44LbuNG2UOXNHCXPI/8LGKNuuLZ3X5NgGzrNv2sibxuCWUi4ORl8K/xPnrta+4pRkhv5r8OF6LEex8SZNpqaMJtIMubS55TH4A1PN/VKuNc0gg6m09x1LN5PHnzgZGQaOfNitqMgkrMdCzuVjgRGQgK1JfwExBofliU7hPJ1ZqmBs+bNN5vay/9grWUbarKL/MMe15aCZP7onhQ5JFxpyFvBgS6pZEYqGNhkFHXvjEnigm8/SQ8rUtOiwp4+KYHKjIbQE0Kr2EdRT/wo5ThWbl7upW5ITArdBNl0BrJDxU6ajuWmsOiFv4rkVZN+ABqrG/WetYlmQ893kyAAV030bgC68jOJqQ4EJwGTL3UU8e3YfcPVlnExXzowXZ+sMOxdbpUfAxU5nR/6yFEgOKXx1aDkZCXQxUasuA9qdbl7O6UH1mqqz2sgAW+dhNCUJOxRqnEkTwMTkxLS6rAGn/dJYKzdVAl5eMCxyifO/MDxPeeuCzW0RFrOwdvSzvZW/cSsbdw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4947.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e8a3a7-2b12-435b-c630-08d87b0acf98
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 06:29:23.5030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zMTSCVcnLIYT5gyYboqT8xSMc1FL/A8P/v0z+Oog6mk1rwl179UYWS/lA+M/dmd+6+Yn8POJxeRgOFYtZHvKwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5044
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3VkZWVwLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMi80XSBtaXNjOiB2b3A6IGRv
IG5vdCBhbGxvY2F0ZSBhbmQgcmVhc3NpZ24gdGhlIHVzZWQNCj4gcmluZw0KPiANCj4gT24gV2Vk
LCAyMDIwLTEwLTI4IGF0IDAxOjQ3ICswMDAwLCBTaGVycnkgU3VuIHdyb3RlOg0KPiA+IEhpIFZp
bmNlbnQsDQo+ID4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMi80XSBtaXNjOiB2b3A6
IGRvIG5vdCBhbGxvY2F0ZSBhbmQgcmVhc3NpZ24NCj4gPiA+IHRoZSB1c2VkIHJpbmcNCj4gPiA+
DQo+ID4gPiBPbiBUdWUsIE9jdCAyNywgMjAyMCBhdCAwODowNTo0M0FNICswMTAwLCBTaGVycnkg
U3VuIHdyb3RlOg0KPiA+ID4gPiBDYW4geW91IGhlbHAgdGVzdCB0aGUgcGF0Y2ggYWJvdXQgcmVt
b3ZpbmcgdGhlIGNvZGVzIG9mIHJlYXNzaWduDQo+ID4gPiA+IHVzZWQgcmluZywgYW5kIGNvbW1l
bnQgb24gdGhlIGltcGFjdCBmb3IgSW50ZWwgTUlDIHBsYXRmb3JtPw0KPiA+ID4gPiBUaGFua3Mg
Zm9yIGFueSBoZWxwLg0KPiA+ID4NCj4gPiA+IEkgZG9uJ3QgaGF2ZSBhY2Nlc3MgdG8gTUlDIGhh
cmR3YXJlIG15c2VsZiwgZWl0aGVyLg0KPiA+ID4NCj4gPiA+IEJ1dCB0aGlzIHBhdGNoIGlzIHF1
aXRlIGNlcnRhaW5seSBnb2luZyB0byBicmVhayBpdCBzaW5jZSBndWVzdHMNCj4gPiA+IHVzaW5n
IGEga2VybmVsIHdpdGhvdXQgdGhlIHBhdGNoIHdpbGwgbm90IHdvcmsgd2l0aCBob3N0cyB3aXRo
IGENCj4gPiA+IGtlcm5lbCB3aXRoIHRoZSBwYXRjaC4NCj4gPg0KPiA+IFRoYW5rcyBmb3IgeW91
ciByZXBseS4NCj4gPiBUaGlzIHBhdGNoIGNhbiBiZSB1c2VkIGJ5IGJvdGggZ3Vlc3RzIGFuZCBo
b3N0cy4NCj4gPiBJIGhhdmUgdGVzdGVkIGl0IG9uIGlteDhxbSBwbGF0Zm9ybShib3RoIGd1ZXN0
IGFuZCBob3N0IGFyZSBBUk02NA0KPiA+IGFyY2hpdGVjdHVyZSksIGFuZCBpdCB3b3JrcyB3ZWxs
Lg0KPiA+IFNvIEkgZ3Vlc3MgSW50ZWwgTUlDIHdvbid0IG1lZXQgYmlnIHByb2JsZW1zIHdoZW4g
Ym90aCBndWVzdCBhbmQNCj4gDQo+IEhpIEdyZWcvU2hlcnJ5LA0KPiANCj4gQm90aCBBc2h1dG9z
aCBhbmQgSSBoYXZlIG1vdmVkIG9uIHRvIG90aGVyIHByb2plY3RzLiBUaGUgTUlDIGRldmljZXMg
aGF2ZQ0KPiBiZWVuIGRpc2NvbnRpbnVlZC4gSSBoYXZlIGp1c3Qgc2VudCBhY3Jvc3MgYSBwYXRj
aCB0byByZW1vdmUgdGhlIE1JQyBkcml2ZXJzDQo+IGZyb20gdGhlIGtlcm5lbCB0cmVlLg0KPiAN
Cj4gV2UgYXJlIHZlcnkgZ2xhZCB0byBzZWUgdGhhdCBTaGVycnkgaXMgYWJsZSB0byByZXVzZSBz
b21lIG9mIHRoZSBWT1AgbG9naWMNCj4gYW5kIGl0IGlzIHdvcmtpbmcgd2VsbC4gSXQgaXMgYmVz
dCBpZiB0aGUgTUlDIGRyaXZlcnMgYXJlIHJlbW92ZWQgc28gU2hlcnJ5IGNhbg0KPiBhZGQgdGhl
IHNwZWNpZmljIFZPUCBsb2dpYyByZXF1aXJlZCBmb3IgaW14OHFtIHN1YnNlcXVlbnRseSB3aXRo
b3V0IGhhdmluZw0KPiB0byB3b3JyeSBhYm91dCBvdGhlciBkcml2ZXIgZGVwZW5kZW5jaWVzLg0K
PiBIb3BpbmcgdGhpcyByZXN1bHRzIGluIGEgY2xlYW5lciBpbXg4cW0gZHJpdmVyIG1vdmluZyBm
b3J3YXJkLg0KDQpJJ20gb2sgd2l0aCB5b3VyIHBhdGNoLg0KU2luY2UgeW91IGhhdmUgZGVwcmVj
YXRlZCB0aGUgTUlDIHJlbGF0ZWQgY29kZSwgbWF5IEkgYXNrIGRvIHlvdSBoYXZlIGEgYmV0dGVy
IHNvbHV0aW9uIGluc3RlYWQgb2Ygdm9wL3NjaWY/DQoNCkJlc3QgcmVnYXJkcw0KU2hlcnJ5IA0K
PiANCj4gVGhhbmtzLA0KPiBTdWRlZXAgRHV0dA0K
