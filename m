Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F7A2C94DC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 02:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgLABvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 20:51:38 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:38253 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgLABvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 20:51:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606787497; x=1638323497;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=p1FGfeAAn/Ui+wZeQlNFWrVFSt3E8KGHr08M29kMldk=;
  b=JsikjYAU9VpkS21+A6DNiBg9WZ2djA557kQUoMh/uUdpDgi7wKmV0COI
   CNfqRYLLdWTIq6iyjXclZgX33bKBCmjXfW6RIHlhJ1H/wcRbrfscAyWRl
   Nk+idVDbvtfw+Z/yMbRPdfjgGHb5YG5DUNtIy2crwXmElgZZeXNAAWSFd
   rFsWekcc14k0Fmo6pLoNuZ/Rvprs6NIvokaLhB9eH8P92RWz3qhFBpP6l
   iY/uBBXd7iBOMbqMNi8uqqWHhXvd94snu6HjS8M/3jgqHfWM5KIQ7OWZZ
   +MUQQu9O4fo5IfB+UWQ7bzDMxVufNquaU2JoWOnXJQVNhHWMny4FgdG7z
   w==;
IronPort-SDR: YCMn+67YuIr7X+UOnk1AhHfTCbDzidi9PrQgAEG75IFch+NgxYw4XXVpJoEWw1t5nx3kOfAUxs
 elChTc4Bl+MUDBdLTxDZp+qCDMojWsSUMQx0uIOSIIVvsL+1WG/c7m1A+IIMytoWpfaI3zdwdZ
 P6rO4Qtl/bDRv7RDsEv60WWble2CbMvf5KmeMkp5vn675kw18hatsmmVGsQCSXXXdpCco5FsCM
 +f+AetJmbius/0HoqfgZNby5lQL5wYRsL+di4mqDkgSdvLZoDCFDCCT9bNnGYBB1QDd9KQR3k7
 FdI=
X-IronPort-AV: E=Sophos;i="5.78,382,1599494400"; 
   d="scan'208";a="263994907"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
  by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2020 09:50:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNFaS5P4UDR1rB6sC5GpQYBK9/77AFVQSVGxIHpeUZyZ4YrK8cxLvDk8zfBlWJZrTWomjwMZN/8NGi1nl+J1Cn0yoAZpOgQrr17oWDciRyusePF9/SnXY6My0fQAvbmWzX3p9usSbtpK+XyM6HQ7wRgitrZ/WfwlRN09eUPRt71qJQouKVgpde1tlLbJqSgWguVNs9EO77hA5dVeO4flXUSXGLKfI0M6/UmXXd7twTjtRjeJmVr87siAU+g1S7xd02JAl9ueOHKuPwR6BioAQr02OlsWFl9sHqGtfpchqkgW2R8knL1J9S0ch5II0oJeDXKfou3JqQg8QJmlcNBxwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1FGfeAAn/Ui+wZeQlNFWrVFSt3E8KGHr08M29kMldk=;
 b=bLQ6RCRaT5+SRez9lkdLDU4mUhRUvOFz9RPDIzVAHJgCcQPMfRqe+HEfpnAduNuvcfuQsGx17XVbq1aJXKftK8fyIdI97/iFAcSzUIFcmMs2eVCXUrqBAE73wiUJrjjwjRNujgDcAY7zsT6ZMm7abHl08ZDKxh6CA4jsmLlCwS6DxcToW46bqGsJKR2vmQ70wfGc2MTwHWcgsxf9giCovMpFBS2gVh0XdI1MBPbuxlHheJZpeqy0/rycSTBmo3lekW921mHCN5Z1K4eShzwa8TAyyAta2fEijWpFNUeeBWBeTNFcZoaJgnfYcq4loW+zHOGqAVCis0AMVynJJJKGWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1FGfeAAn/Ui+wZeQlNFWrVFSt3E8KGHr08M29kMldk=;
 b=SpWp6Dl7L7kZGr5Jfc1Z0WZ/lUMFoufhSj2CrxG3cZrWg0wDzoa98GGdjXWGYK9x3VedzRmmyp7D1UkO2qMtfLMHu+aJ7D6JNVfV5Ne0Q+QLbYvgQkQxhZ5A8hdHuQR7LNEse5xlILkC+h21FKk2vXY78rsC6lAnTb7IwfMmDDs=
Received: from BY5PR04MB6882.namprd04.prod.outlook.com (2603:10b6:a03:21b::19)
 by BY5PR04MB6755.namprd04.prod.outlook.com (2603:10b6:a03:22d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Tue, 1 Dec
 2020 01:50:30 +0000
Received: from BY5PR04MB6882.namprd04.prod.outlook.com
 ([fe80::1cfc:5636:1a0b:400c]) by BY5PR04MB6882.namprd04.prod.outlook.com
 ([fe80::1cfc:5636:1a0b:400c%8]) with mapi id 15.20.3611.031; Tue, 1 Dec 2020
 01:50:30 +0000
From:   Alistair Francis <Alistair.Francis@wdc.com>
To:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "palmerdabbelt@google.com" <palmerdabbelt@google.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
CC:     "anup@brainfault.org" <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] RISC-V: Use SBI SRST extension when available
Thread-Topic: [PATCH v3] RISC-V: Use SBI SRST extension when available
Thread-Index: AQHWwuphImGGKJSDJUiyRex0igl5mqnhf4gA
Date:   Tue, 1 Dec 2020 01:50:30 +0000
Message-ID: <44690aadd1362f528be7ee9dedd0d82cf1167570.camel@wdc.com>
References: <20201125051752.295572-1-anup.patel@wdc.com>
In-Reply-To: <20201125051752.295572-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.2 
authentication-results: sifive.com; dkim=none (message not signed)
 header.d=none;sifive.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2601:646:8e00:d1:fe06:9c12:652c:1449]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e6e551ac-f75c-4d3d-0d7e-08d8959b7bdb
x-ms-traffictypediagnostic: BY5PR04MB6755:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB67552089CDD1E2B5CE99A2B690F40@BY5PR04MB6755.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HaCsvzlINbHWCG6mTlnj87H5Q8RblWCfEQ+1t2EeM9OXdEZkAKIZVa+vUIZX7/YNQ4UhQ3KfNfG0wIrCGbg6kExjmnQiT9wKIZG1Qqvi/48ekswtvA2nVQj0RDNTXWi/hg5OfVB+Rvz9VhUoKfrHc5PSm9tq1inrhTLfxAzEVGSUL9OB/OtQB0jU77ZU1Q/ftenW+mFxZRfQM6aAZigHyI17wrh7NkAeWfMx0OWR3EbfAsmrW5S/8k9qFylq6UMWukRrGpHh8IZVwI0lK3iJTIn9PrOCUc0ieS65A1Jrpy7WHS4T0kynOfS/g2bAJbCH7Y88mlRULAvFW+IdmgMwDjOY3JLVYcERbIzkzlvUCCuUZMY3FHCYzQPcMH7ET1BiDVmkIVVIyKNXgD6JmLDzFg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6882.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(66946007)(8936002)(5660300002)(76116006)(66556008)(83380400001)(186003)(4326008)(66476007)(2906002)(66446008)(8676002)(64756008)(86362001)(71200400001)(36756003)(2616005)(6486002)(966005)(110136005)(54906003)(316002)(6512007)(6506007)(478600001)(4001150100001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RWVGcXQ1NGYrZHBDZElvTVo3TWh0cmVMcmZKM1JQU2xrMy9LUExFQmJ6MENa?=
 =?utf-8?B?RXpzaGMyVVZwM1NETVYzZlZ2V1dQY0oxdWY2ZWRTZHJQcXJhaHZaMVR4dm1M?=
 =?utf-8?B?QUhXc0tkU0pWYlZ3UFdHcjJCRUlEVmhhQy85RzZVemE4YVNDOWNtRitIbTc4?=
 =?utf-8?B?WmlZb2FOMWtpc2Z4Q2tCUzFaWU1CT0ZESFVIZTBTY0Rjbm1ya3QrNG95UkRZ?=
 =?utf-8?B?TFpwaDdrdUpLZjZoM054eGU4OXRMZUs4d3h6VTFGQXYwSFVTbis4d0NMQzh0?=
 =?utf-8?B?V3prRkZkMnI1WDByTEIxcUY4VWZ3UmdwUzFiRkx0MlZkZXh1cWJWbGpEZVlm?=
 =?utf-8?B?dEVNamVlQ2VJTFlLWVRNejNYZmNGRlRQOHZjRDQ2WkFyaXkrRUVQelJsR2RM?=
 =?utf-8?B?VDlhYzBENDdjR0RWUVVSYmdmSVlLR2tWM0NXZlpvY1BQZVhuZmttM2R0aDRM?=
 =?utf-8?B?NGNjcFpFNTNiUXNpUWY1ZTVvb3R3TFk0NWp4TndnY3hGRG5yYi9JOFFYaWV6?=
 =?utf-8?B?aENoSEwvVXk0UkttbEphc00weFhuYzEvVnhweHM0c2NTdDdUbmsyaytla25Y?=
 =?utf-8?B?NmE0Qk1WTVR3cXI5WWVOY3QyM0ptMXgrK0VEdERac1Q5bEVUaWk2N3J3M3Nv?=
 =?utf-8?B?M3poSi84dC9zeGo3cFptTE9iQytXMUJISVArWDBPQ3FZYzVLSHF5L0YvTHVP?=
 =?utf-8?B?ZHp3Z2ROQ011UlNMbi9DT1hFOXNhWEhZbnNWYlRtaVltNU8rMnNxbGdFckFs?=
 =?utf-8?B?Q2JmYjlXajV4WXpWSTFJbFlWdXFqNExZZzY5QmZsVGlqY3lKZjUvUWFENFJ0?=
 =?utf-8?B?akN5V1BlaElsQkhsMkcySXlBcHB6SVkvVVM1QWh5aHNwVW1HKzhPL013M25k?=
 =?utf-8?B?U0d1N2d2ckliRHdjYmE4aFQrM2duY3RtNzJJYW5KVEI3WjZESzViWnF0SFhH?=
 =?utf-8?B?Nk9xK2lRR1Q2SXY5NWNsY1lSVE9TWVBkSG9zRmJtWUJKRjdFY2M3aCtBSTE0?=
 =?utf-8?B?WmRGdis4TnhaWVNGeERJWWozL3doaGNjZDZ2Rjk1N3Z4aEdwaWorRXJGeVQ5?=
 =?utf-8?B?d1E5NkhDc1JCSFl3eGlRejhMOElza1hnMjk3RWpNVXhSNWFvQ0J0T2NSUUpz?=
 =?utf-8?B?ZHM4dHJLU2JiTVhMS2tBQjNwNXRiNStYMnpQYUJxRWp4ekE1VHhINVgySTkx?=
 =?utf-8?B?cDNFRStkbkhxeityUkphYkxTaldhcmdoN09mb09nVllWMTVnMUdSRTQrVUFw?=
 =?utf-8?B?Q3dxOXB3WWg4cHBrREZjRjlvT2dWc2pEL3o4KzF6dGNzYlZPRldiTk5kQm5N?=
 =?utf-8?B?QUxDVHZXaTZwRkJLakNyZFErQmNsck0zRzh1eTF6dlByVUl0L3ZVUXJWWi9H?=
 =?utf-8?B?TUtJSHNKd3pQV0JpUCtFZjdTWlhLZzZTc21uVUNxQTJYSlJsSy8wV1VtOEVj?=
 =?utf-8?Q?pLg0vL/b?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C41B849268855948AF280C40B18F5EE7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6882.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e551ac-f75c-4d3d-0d7e-08d8959b7bdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 01:50:30.2551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4NmXCTGAr8ipXuKPw6prmr38JTGpY7PBkD5S7KdL+6PEwgqOKXHAo2a6cfrtBXB4j5mTXgvezNRXoyRlCs2WkPzImNJDfh8opGc/6Bn01no=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6755
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTExLTI1IGF0IDEwOjQ3ICswNTMwLCBBbnVwIFBhdGVsIHdyb3RlOg0KPiBU
aGUgU0JJIFNSU1QgZXh0ZW5zaW9uIHByb3ZpZGVzIGEgc3RhbmRhcmQgd2F5IHRvIHBvd2Vyb2Zm
IGFuZA0KPiByZWJvb3QgdGhlIHN5c3RlbSBpcnJlc3BlY3RpdmUgdG8gd2hldGhlciBMaW51eCBS
SVNDLVYgUy1tb2RlDQo+IGlzIHJ1bm5pbmcgbmF0aXZlbHkgKEhTLW1vZGUpIG9yIGluc2lkZSBH
dWVzdC9WTSAoVlMtbW9kZSkuDQo+IA0KPiBUaGUgU0JJIFNSU1QgZXh0ZW5zaW9uIGlzIGF2YWls
YWJsZSBpbiBsYXRlc3QgU0JJIHYwLjMtZHJhZnQNCj4gc3BlY2lmaWNhdGlvbiBhdDogaHR0cHM6
Ly9naXRodWIuY29tL3Jpc2N2L3Jpc2N2LXNiaS1kb2MuDQo+IA0KPiBUaGlzIHBhdGNoIGV4dGVu
ZHMgTGludXggUklTQy1WIFNCSSBpbXBsZW1lbnRhdGlvbiB0byBkZXRlY3QNCj4gYW5kIHVzZSBT
QkkgU1JTVCBleHRlbnNpb24uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbnVwIFBhdGVsIDxhbnVw
LnBhdGVsQHdkYy5jb20+DQoNCkFja2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5m
cmFuY2lzQHdkYy5jb20+DQoNCkFsaXN0YWlyDQoNCj4gLS0tDQo+IENoYW5nZXMgc2luY2UgdjI6
DQo+IMKgLSBSZWJhc2VkIG9uIExpbnV4LTUuMTAtcmM1DQo+IMKgLSBVcGRhdGVkIHBhdGNoIGFz
LXBlciBTQkkgU1JTVCBleHRlbnNpb24gYXZhaWxhYmxlIGluIHRoZSBsYXRlc3QNCj4gwqDCoCBT
QkkgdjAuMy1kcmFmdCBzcGVjaWZpY2F0aW9uDQo+IENoYW5nZXMgc2luY2UgdjE6DQo+IMKgLSBV
cGRhdGVkIHBhdGNoIGFzLXBlciBsYXRlc3QgU0JJIFNSU1QgZXh0ZW5zaW9uIGRyYWZ0IHNwZWMg
d2hlcmUNCj4gwqDCoCB3ZSBoYXZlIG9ubHkgb25lIFNCSSBjYWxsIHdpdGggInJlc2V0X3R5cGUi
IHBhcmFtZXRlcg0KPiAtLS0NCj4gwqBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3NiaS5oIHwgMTYg
KysrKysrKysrKysrKysrKw0KPiDCoGFyY2gvcmlzY3Yva2VybmVsL3NiaS5jwqDCoMKgwqDCoCB8
IDM0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gwqAyIGZpbGVzIGNoYW5n
ZWQsIDUwIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2luY2x1
ZGUvYXNtL3NiaS5oDQo+IGIvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9zYmkuaA0KPiBpbmRleCA2
NTNlZGIyNWQ0OTUuLjViMmQ2ZDYxNGMyMCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9yaXNjdi9pbmNs
dWRlL2FzbS9zYmkuaA0KPiArKysgYi9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3NiaS5oDQo+IEBA
IC0yNyw2ICsyNyw3IEBAIGVudW0gc2JpX2V4dF9pZCB7DQo+IMKgwqDCoMKgwqDCoMKgwqBTQklf
RVhUX0lQSSA9IDB4NzM1MDQ5LA0KPiDCoMKgwqDCoMKgwqDCoMKgU0JJX0VYVF9SRkVOQ0UgPSAw
eDUyNDY0RTQzLA0KPiDCoMKgwqDCoMKgwqDCoMKgU0JJX0VYVF9IU00gPSAweDQ4NTM0RCwNCj4g
K8KgwqDCoMKgwqDCoMKgU0JJX0VYVF9TUlNUID0gMHg1MzUyNTM1NCwNCj4gwqB9Ow0KPiDCoA0K
PiDCoGVudW0gc2JpX2V4dF9iYXNlX2ZpZCB7DQo+IEBAIC03MCw2ICs3MSwyMSBAQCBlbnVtIHNi
aV9oc21faGFydF9zdGF0dXMgew0KPiDCoMKgwqDCoMKgwqDCoMKgU0JJX0hTTV9IQVJUX1NUQVRV
U19TVE9QX1BFTkRJTkcsDQo+IMKgfTsNCj4gwqANCj4gK2VudW0gc2JpX2V4dF9zcnN0X2ZpZCB7
DQo+ICvCoMKgwqDCoMKgwqDCoFNCSV9FWFRfU1JTVF9SRVNFVCA9IDAsDQo+ICt9Ow0KPiArDQo+
ICtlbnVtIHNiaV9zcnN0X3Jlc2V0X3R5cGUgew0KPiArwqDCoMKgwqDCoMKgwqBTQklfU1JTVF9S
RVNFVF9UWVBFX1NIVVRET1dOID0gMCwNCj4gK8KgwqDCoMKgwqDCoMKgU0JJX1NSU1RfUkVTRVRf
VFlQRV9DT0xEX1JFQk9PVCwNCj4gK8KgwqDCoMKgwqDCoMKgU0JJX1NSU1RfUkVTRVRfVFlQRV9X
QVJNX1JFQk9PVCwNCj4gK307DQo+ICsNCj4gK2VudW0gc2JpX3Nyc3RfcmVzZXRfcmVhc29uIHsN
Cj4gK8KgwqDCoMKgwqDCoMKgU0JJX1NSU1RfUkVTRVRfUkVBU09OX05PTkUgPSAwLA0KPiArwqDC
oMKgwqDCoMKgwqBTQklfU1JTVF9SRVNFVF9SRUFTT05fU1lTX0ZBSUxVUkUsDQo+ICt9Ow0KPiAr
DQo+IMKgI2RlZmluZSBTQklfU1BFQ19WRVJTSU9OX0RFRkFVTFTCoMKgwqDCoMKgwqDCoDB4MQ0K
PiDCoCNkZWZpbmUgU0JJX1NQRUNfVkVSU0lPTl9NQUpPUl9TSElGVMKgwqDCoDI0DQo+IMKgI2Rl
ZmluZSBTQklfU1BFQ19WRVJTSU9OX01BSk9SX01BU0vCoMKgwqDCoDB4N2YNCj4gZGlmZiAtLWdp
dCBhL2FyY2gvcmlzY3Yva2VybmVsL3NiaS5jIGIvYXJjaC9yaXNjdi9rZXJuZWwvc2JpLmMNCj4g
aW5kZXggMjI2Y2NjZTBmOWUwLi4zM2I4MzRlY2QxOTUgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvcmlz
Y3Yva2VybmVsL3NiaS5jDQo+ICsrKyBiL2FyY2gvcmlzY3Yva2VybmVsL3NiaS5jDQo+IEBAIC03
LDYgKzcsNyBAQA0KPiDCoA0KPiDCoCNpbmNsdWRlIDxsaW51eC9pbml0Lmg+DQo+IMKgI2luY2x1
ZGUgPGxpbnV4L3BtLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvcmVib290Lmg+DQo+IMKgI2luY2x1
ZGUgPGFzbS9zYmkuaD4NCj4gwqAjaW5jbHVkZSA8YXNtL3NtcC5oPg0KPiDCoA0KPiBAQCAtNTAx
LDYgKzUwMiwzMiBAQCBpbnQgc2JpX3JlbW90ZV9oZmVuY2VfdnZtYV9hc2lkKGNvbnN0IHVuc2ln
bmVkDQo+IGxvbmcgKmhhcnRfbWFzaywNCj4gwqB9DQo+IMKgRVhQT1JUX1NZTUJPTChzYmlfcmVt
b3RlX2hmZW5jZV92dm1hX2FzaWQpOw0KPiDCoA0KPiArc3RhdGljIHZvaWQgc2JpX3Nyc3RfcmVz
ZXQodW5zaWduZWQgbG9uZyB0eXBlLCB1bnNpZ25lZCBsb25nIHJlYXNvbikNCj4gK3sNCj4gK8Kg
wqDCoMKgwqDCoMKgc2JpX2VjYWxsKFNCSV9FWFRfU1JTVCwgU0JJX0VYVF9TUlNUX1JFU0VULCB0
eXBlLCByZWFzb24sDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAwLCAwLCAw
LCAwKTsNCj4gK8KgwqDCoMKgwqDCoMKgcHJfd2FybigiJXM6IHR5cGU9MHglbHggcmVhc29uPTB4
JWx4IGZhaWxlZFxuIiwNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoF9fZnVuY19f
LCB0eXBlLCByZWFzb24pOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50IHNiaV9zcnN0X3JlYm9v
dChzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKnRoaXMsDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBsb25nIG1vZGUsIHZvaWQgKmNt
ZCkNCj4gK3sNCj4gK8KgwqDCoMKgwqDCoMKgc2JpX3Nyc3RfcmVzZXQoKG1vZGUgPT0gUkVCT09U
X1dBUk0gfHwgbW9kZSA9PSBSRUJPT1RfU09GVCkgPw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIFNCSV9TUlNUX1JFU0VUX1RZUEVfV0FSTV9SRUJPT1QgOg0K
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFNCSV9TUlNUX1JF
U0VUX1RZUEVfQ09MRF9SRUJPT1QsDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgU0JJX1NSU1RfUkVTRVRfUkVBU09OX05PTkUpOw0KPiArwqDCoMKgwqDCoMKg
wqByZXR1cm4gTk9USUZZX0RPTkU7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBzdHJ1Y3Qgbm90aWZp
ZXJfYmxvY2sgc2JpX3Nyc3RfcmVib290X25iOw0KPiArDQo+ICtzdGF0aWMgdm9pZCBzYmlfc3Jz
dF9wb3dlcl9vZmYodm9pZCkNCj4gK3sNCj4gK8KgwqDCoMKgwqDCoMKgc2JpX3Nyc3RfcmVzZXQo
U0JJX1NSU1RfUkVTRVRfVFlQRV9TSFVURE9XTiwNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBTQklfU1JTVF9SRVNFVF9SRUFTT05fTk9ORSk7DQo+ICt9DQo+
ICsNCj4gwqAvKioNCj4gwqAgKiBzYmlfcHJvYmVfZXh0ZW5zaW9uKCkgLSBDaGVjayBpZiBhbiBT
QkkgZXh0ZW5zaW9uIElEIGlzIHN1cHBvcnRlZA0KPiBvciBub3QuDQo+IMKgICogQGV4dGlkOiBU
aGUgZXh0ZW5zaW9uIElEIHRvIGJlIHByb2JlZC4NCj4gQEAgLTU5Myw2ICs2MjAsMTMgQEAgaW50
IF9faW5pdCBzYmlfaW5pdCh2b2lkKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oH0gZWxzZSB7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoF9fc2JpX3JmZW5jZcKgwqDCoMKgPSBfX3NiaV9yZmVuY2VfdjAxOw0KPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0NCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGlmIChzYmlfcHJvYmVfZXh0ZW5zaW9uKFNCSV9FWFRfU1JTVCkgPiAwKSB7DQo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcHJfaW5mbygiU0JJIHYwLjIg
U1JTVCBleHRlbnNpb24NCj4gZGV0ZWN0ZWRcbiIpOw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBtX3Bvd2VyX29mZiA9IHNiaV9zcnN0X3Bvd2VyX29m
ZjsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzYmlf
c3JzdF9yZWJvb3RfbmIubm90aWZpZXJfY2FsbCA9DQo+IHNiaV9zcnN0X3JlYm9vdDsNCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzYmlfc3JzdF9yZWJv
b3RfbmIucHJpb3JpdHkgPSAxOTI7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgcmVnaXN0ZXJfcmVzdGFydF9oYW5kbGVyKCZzYmlfc3JzdF9yZWJvb3Rf
bmIpDQo+IDsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0NCj4gwqDCoMKgwqDC
oMKgwqDCoH0gZWxzZSB7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgX19zYmlf
c2V0X3RpbWVyID0gX19zYmlfc2V0X3RpbWVyX3YwMTsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBfX3NiaV9zZW5kX2lwacKgwqA9IF9fc2JpX3NlbmRfaXBpX3YwMTsNCg0K
