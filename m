Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 194152A2B0D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 13:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgKBMzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 07:55:49 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:3140 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbgKBMzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 07:55:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604321746; x=1635857746;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=r/0xkgPEEfEhY/gxwAVTk10BYHrwOfBwL3H8nGnppF4=;
  b=L8qf+v4/8lcFpl086FeRcUe8iMov3SzBcKwaisgpdgIpLGlrhWjH9q0L
   Uebd18MStiCyJbEWDfFvzl8SW7kTTcBtyNFXizxkNXDhjlXm+9mnGD2Iq
   F6Tshvv6KsQXykJ0yG1zZi8MssqkC7VolCnqsMRZoRJZYimUJ3jlSFpQH
   NvGr5/u4AVoqLhOuIe9UNY8/Td/qxn4Xy+LkNi7AaNUdEUzifZDWBRufJ
   9/mpIKkAJ/XYH2Axaj25XcpJcSKBYer14Wje6a29pdGYVLLG+S8KNlfdD
   GMUFsowVtJAmHR43euZi/74d0cezZU/qT5it3YF4nJafIKSKEtWw5rTSl
   w==;
IronPort-SDR: oo3tCiMGNtKkg10fpzhvNbUZzCXC6grJHJxvsdobQfb4MeYAdwE/b37EafddQHyd9SiyX3O5jY
 Z1ql8YaCSmb3CJ4Tp9QcqWN3lMq2yDEbE93X4kNyAhdj/ocuQwNx67kLJLb6Wy2w57+WsSPXAE
 /nkP0/yZJ1DAtVxP16PyaLAM0JX6vudMKB+FEXR1xo8aleBg1RiuaXF4aXhC9nGsMc6Uok5iJy
 iiwMyO+A90iRILp2pDXlxwoNR3hnSl6CqFZuRcoJO+EZDN8Hmm5vxjSEcpwFcRgLm2aBK6mlGX
 cgE=
X-IronPort-AV: E=Sophos;i="5.77,444,1596524400"; 
   d="scan'208";a="101816989"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2020 05:55:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 2 Nov 2020 05:55:45 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Mon, 2 Nov 2020 05:55:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMcns8pCRkvoKDhCtn4Y3DXAuRnYEpslAJy6cp8PFL5V8Fn7aetlN/oxA/SGIpCG9wXPorzs86O1NYqBaffTyZZVhk4OXYca6zH3Ymud16eBRzOnORGvj6vbfHcT3v6EqX+HYMrunSa8JIidoJzofVJXHtRxoCNYbOdRRA0fMOW3nBJAI2wTC2Oy5k3q04TNRqW8Q75Ur4rTxZt7/+9I/dKaOckwaLU4F0aWuegHTmJbq859eDRxyRXCKtu2Quvegb0/cQE+lRjreilkab30JkjZL12WXv1Swh06NbX0NinC5DVB0SauCXbHBeKMZyOPLMHxKQ0S9iMiQ18Hn7x+pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/0xkgPEEfEhY/gxwAVTk10BYHrwOfBwL3H8nGnppF4=;
 b=cgLy0soF74VI/x4bdIC+jjFTVGTLJ+NSdkvisXfakLJ9NFUOFbfuvt2vovp5J4uxUfro20GdtdOu4CCuD0pAlm4iTIIaJkICTlZq9JUeIs5yQ8KCUZq7CkMAFa9mndt0l8jeAeHDl+dWq1Rede3TgKZGOuKcr/Ya2uY40AUigJ2i7RN7SA1uYdUiAxISK+MI/b1KBwRkU6KTxzrUaaH9hEajBWJBYYFyhICEVDorJ/9cN/24k+Dkcg51+J0u6qvw50FXXTlBWy/5ocDT+kwQENbVXCPC3AQF4TMlYxu1qgsXmnuCeqvgUJvovIgYC/uVc8QYth1gjttHD3VBL7/4Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/0xkgPEEfEhY/gxwAVTk10BYHrwOfBwL3H8nGnppF4=;
 b=HxcYwDSbUjZk1oqkwEUeldTgQzRUZB+M+aL4pP5678dJe0aZLHTlp8AAJJA8oQdksXyhsFBkwzXBHK6WJgGDnrlmZxnexxTWJuO+kfWpZRRybXyjpINoAdml1ozRMXP+ZgGiqcXtVDLK/I1DpuqBzB8gRKTgrqC5aIijyccRfHc=
Received: from CY4PR1101MB2341.namprd11.prod.outlook.com
 (2603:10b6:903:b1::22) by CY4PR11MB0069.namprd11.prod.outlook.com
 (2603:10b6:910:79::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Mon, 2 Nov
 2020 12:55:43 +0000
Received: from CY4PR1101MB2341.namprd11.prod.outlook.com
 ([fe80::908:a628:69ca:d62e]) by CY4PR1101MB2341.namprd11.prod.outlook.com
 ([fe80::908:a628:69ca:d62e%7]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 12:55:43 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <lee.jones@linaro.org>
CC:     <Nicolas.Ferre@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <richard.genoud@gmail.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
Subject: Re: [PATCH] ARM: dts: at91: add serial MFD sub-node for usart
Thread-Topic: [PATCH] ARM: dts: at91: add serial MFD sub-node for usart
Thread-Index: AQHWrq0BNGYIfVuhjkKKUxhuAsgrHKmwJpcAgARphwCAADUdAIAABSQAgAAHOAA=
Date:   Mon, 2 Nov 2020 12:55:43 +0000
Message-ID: <e2b038f0-81ea-3d2f-cb06-dd02f0b84860@microchip.com>
References: <20201030110702.886638-1-codrin.ciubotariu@microchip.com>
 <b054ce5c-58fd-dd86-2cb6-1e1f06a0899e@microchip.com>
 <20201102090122.GF4127@dell>
 <780303c7-2c32-f2e1-c9ce-1e2ee6bf0533@microchip.com>
 <20201102122952.GB4488@dell>
In-Reply-To: <20201102122952.GB4488@dell>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [86.121.145.173]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7db2f538-b548-4db4-29e5-08d87f2e9bc5
x-ms-traffictypediagnostic: CY4PR11MB0069:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB00691A57ADE727E24DA9518AE7100@CY4PR11MB0069.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nUvFQ/RN13HDalBK4tkXeRNsre15aoSjhXPBo8FQaryv+nYM/mGAjWTTgyfeuL5+apfZzjKmGdwNEeNWZ2X8EchlBzdTZW2Fm/6oNhzT2W/PeyYO/7eRBG4YI7tF74g/VO83BZSZn5iFnCs0PB1Ch0mXKuRyj5vCnY+rL9gL+iAYGwsJqwGXmbbPzi0qM02o/GMUcXuTixYnJFE19Hvx1K6t8GnbElEnTzImXntRCTiX0SOscRUoakxM8xrFPB2T8odxeJ6Cyj1575SVUBQYEsoNDcqoPc1cdGJoFEtYk1stdFUgqXa9Fa09eIotHqOQczzG9uX6aQSNG8ughx0GdL6QTUYyVm3OaEi5fG7Gj/ZFzCEehmJczEDggD7+C1e7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1101MB2341.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(39860400002)(396003)(346002)(91956017)(2906002)(64756008)(66446008)(86362001)(83380400001)(66476007)(66556008)(5660300002)(76116006)(66946007)(36756003)(107886003)(2616005)(53546011)(8676002)(54906003)(31686004)(8936002)(6486002)(71200400001)(6506007)(478600001)(186003)(6916009)(4326008)(26005)(31696002)(6512007)(316002)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: uLceJi5B+5MTR4wdznsGKOwGREsuAiAvCRMinDI67nwiBsYeYHUliAHO5gIbOY8HYHvohwP9V1iKGQEv++Knsi5Wo6IX0F/28Zl2or/nBByx8RDlV+uRQrHV9+M3JL3Mh/G8izEbM6h9G7KTKkql/3Vyg93czmZo24Xknt86K3SRRtLxVjLLaHknYA7haFaIkej2bdubEJOM6rQ7G6jCHphBeS59p/eX0+SDCRqUwWq31DeU3hrT65LMx9NekYM1sKmYYuYDmsBPX4O3W7RbknSlwYga/tfHhrv6eKD+PzeXWAL8EkHWfzqnVIK0Xf2pUQABCIZjFKFiqZW2EQ6WCW9cLU3at4mjXPfIpV6RzrEpSlJ0kvARkmnPzqjFvGCDpU+34AwD89C8q4Wr6eQ7H3gMzz/ZOOybtjdizV0LKBUN9jt0u+dgJPIiiRcEu8lqhCNmVqyVioe97vCYHsAlpZlkfdan00DW73iSLzZXVBSpnyVPo6a2Z1OEkRMM5oLK6YdZhxrHSglfmGlqH3s3gtwRx4nKGYn8pdmnnmGK8U82ys1Zw5oVsTjAvEZ6OaY/DhH8VPPE8FTGSKkhqoFv7cUPe4B8knjcIrg50ODsI+xxEtA/laZXo912XzdVOP7k+r2jO08zP00jB9t6vL2skg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <787EA4798AE5F64F9B5F0F038026A2D4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1101MB2341.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db2f538-b548-4db4-29e5-08d87f2e9bc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 12:55:43.0808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rq9guRFLodnmCH9wZ8XwUIM2RdlIzIANF0OAlYxvHHh2R9CjNH+a3O05Nj3Aox4dA5awCcfnG+EaeT+XadMs5HBpixNgEtye9vOQNF4LMw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB0069
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDIuMTEuMjAyMCAxNDoyOSwgTGVlIEpvbmVzIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDog
RG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIE1vbiwgMDIgTm92IDIwMjAsIENvZHJpbi5DaXVi
b3Rhcml1QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+IA0KPj4gT24gMDIuMTEuMjAyMCAxMTowMSwg
TGVlIEpvbmVzIHdyb3RlOg0KPj4+IE9uIEZyaSwgMzAgT2N0IDIwMjAsIE5pY29sYXMgRmVycmUg
d3JvdGU6DQo+Pj4NCj4+Pj4gT24gMzAvMTAvMjAyMCBhdCAxMjowNywgQ29kcmluIENpdWJvdGFy
aXUgd3JvdGU6DQo+Pj4+PiBUaGUgImF0bWVsLGF0OTFzYW05MjYwLXVzYXJ0IiBkcml2ZXIgaXMg
YSBNRkQgZHJpdmVyLCBzbyBpdCBuZWVkcyBzdWItbm9kZXMNCj4+Pj4+IHRvIG1hdGNoIHRoZSBy
ZWdpc3RlcmVkIHBsYXRmb3JtIGRldmljZS4gRm9yIHRoaXMgcmVhc29uLCB3ZSBhZGQgYSBzZXJp
YWwNCj4+Pj4+IHN1Ym5vZGUgdG8gYWxsIHRoZSAiYXRtZWwsYXQ5MXNhbTkyNjAtdXNhcnQiIHNl
cmlhbCBjb21wYXRpYmxlIG5vZHMuIFRoaXMNCj4+Pj4+IHdpbGwgYWxzbyByZW1vdmUgdGhlIGJv
b3Qgd2FybmluZzoNCj4+Pj4+ICJhdG1lbF91c2FydF9zZXJpYWw6IEZhaWxlZCB0byBsb2NhdGUg
b2Zfbm9kZSBbaWQ6IC0yXSINCj4+Pj4NCj4+Pj4gSSBkb24ndCByZW1lbWJlciB0aGlzIHdhcm5p
bmcgd2FzIHJhaXNlZCBwcmV2aW91c2x5IGV2ZW4gaWYgdGhlIE1GRCBkcml2ZXINCj4+Pj4gd2Fz
IGFkZGVkIGEgd2hpbGUgYWdvIChTZXB0LiAyMDE4KS4NCj4+Pj4NCj4+Pj4gSSB3b3VsZCBzYXkg
aXQncyBkdWUgdG8gNDY2YTYyZDc2NDJmICgibWZkOiBjb3JlOiBNYWtlIGEgYmVzdCBlZmZvcnQg
YXR0ZW1wdA0KPj4+PiB0byBtYXRjaCBkZXZpY2VzIHdpdGggdGhlIGNvcnJlY3Qgb2Zfbm9kZXMi
KSB3aGljaCB3YXMgYWRkZWQgb24gbWlkIEF1Z3VzdA0KPj4+PiBhbmQgY29ycmVjdGVkIHdpdGgg
MjIzODBiNjVkYzcwICgibWZkOiBtZmQtY29yZTogRW5zdXJlIGRpc2FibGVkIGRldmljZXMgYXJl
DQo+Pj4+IGlnbm9yZWQgd2l0aG91dCBlcnJvciIpIGJ1dCBtYXliZSBub3QgY292ZXJpbmcgb3Vy
IGNhc2UuDQo+Pj4+DQo+Pj4+IFNvLCB3ZWxsLCBJIGRvbid0IGtub3cgd2hhdCdzIHRoZSBiZXN0
IG9wdGlvbiB0byB0aGlzIGNoYW5nZS4gTW9yZW92ZXIsIEkNCj4+Pj4gd291bGQgc2F5IHRoYXQg
YWxsIG90aGVyIFVTQVJUIHJlbGF0ZWQgcHJvcGVydGllcyBnbyBpbnRvIHRoZSBjaGlsZCBub3Qg
aWYNCj4+Pj4gdGhlcmUgaXMgYSBuZWVkIGZvciBvbmUuDQo+Pj4+DQo+Pj4+IExlZSwgSSBzdXNw
ZWN0IHRoYXQgd2UncmUgbm90IHRoZSBvbmx5IG9uZXMgZXhwZXJpZW5jaW5nIHRoaXMgdWdseSB3
YXJuaW5nDQo+Pj4+IGR1cmluZyB0aGUgYm9vdCBsb2c6IGNhbiB5b3UgcG9pbnQgdXMgb3V0IGhv
dyB0byBkZWFsIHdpdGggaXQgZm9yIG91cg0KPj4+PiBleGlzdGluZyBhdG1lbF9zZXJpYWwuYyB1
c2Vycz8NCj4+Pg0KPj4+IFlvdSBzaG91bGQgbm90IGJlIGluc3RhbnRpYXRpbmcgZHJpdmVycyB0
aHJvdWdoIERldmljZSBUcmVlIHdoaWNoIGFyZQ0KPj4+IG5vdCBkZXNjcmliZWQgdGhlcmUuICBJ
ZiB0aGUgY29ycmVjdCByZXByZXNlbnRhdGlvbiBvZiB0aGUgSC9XIGFscmVhZHkNCj4+PiBleGlz
dHMgaW4gRGV2aWNlIFRyZWUgaS5lLiBubyBTUEkgYW5kIFVBUlQgSVAgcmVhbGx5IGV4aXN0cywg
dXNlIHRoZQ0KPj4+IE1GRCBjb3JlIEFQSSB0byByZWdpc3RlciB0aGVtIHV0aWxpc2luZyB0aGUg
cGxhdGZvcm0gQVBJIGluc3RlYWQuDQo+Pj4NCj4+PiBUaGlzIHNob3VsZCBkbyBpdDoNCj4+Pg0K
Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21mZC9hdDkxLXVzYXJ0LmMgYi9kcml2ZXJzL21mZC9h
dDkxLXVzYXJ0LmMNCj4+PiBpbmRleCA2YTgzNTFhNDU4OGUyLi45MzliZDIzMzJhNGY2IDEwMDY0
NA0KPj4+IC0tLSBhL2RyaXZlcnMvbWZkL2F0OTEtdXNhcnQuYw0KPj4+ICsrKyBiL2RyaXZlcnMv
bWZkL2F0OTEtdXNhcnQuYw0KPj4+IEBAIC0xNywxMiArMTcsMTAgQEANCj4+Pg0KPj4+ICAgIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgbWZkX2NlbGwgYXQ5MV91c2FydF9zcGlfc3ViZGV2ID0gew0KPj4+
ICAgICAgICAgICAubmFtZSA9ICJhdDkxX3VzYXJ0X3NwaSIsDQo+Pj4gLSAgICAgICAub2ZfY29t
cGF0aWJsZSA9ICJtaWNyb2NoaXAsYXQ5MXNhbTlnNDUtdXNhcnQtc3BpIiwNCj4+PiAgICB9Ow0K
Pj4+DQo+Pj4gICAgc3RhdGljIGNvbnN0IHN0cnVjdCBtZmRfY2VsbCBhdDkxX3VzYXJ0X3Nlcmlh
bF9zdWJkZXYgPSB7DQo+Pj4gICAgICAgICAgIC5uYW1lID0gImF0bWVsX3VzYXJ0X3NlcmlhbCIs
DQo+Pj4gLSAgICAgICAub2ZfY29tcGF0aWJsZSA9ICJhdG1lbCxhdDkxcm05MjAwLXVzYXJ0LXNl
cmlhbCIsDQo+Pj4gICAgfTsNCj4+Pg0KPj4+ICAgIHN0YXRpYyBpbnQgYXQ5MV91c2FydF9tb2Rl
X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+Pg0KPj4gW3NuaXBdDQo+Pg0K
Pj4gSGkgTGVlLCB0aGFuayB5b3UgZm9yIGxvb2tpbmcgdGhyb3VnaCBvdXIgdXNhcnQgZHJpdmVy
IGFuZCBmb3Igc2hhcmluZw0KPj4geW91ciB0aG91Z2h0cy4gUmVtb3ZpbmcgdGhlIHVzYWdlIG9m
IGNvbXBhdGlibGUgc3RyaW5nIG1lYW5zIHRoYXQgZm9yDQo+PiBzaW1pbGFyIHNlcmlhbC9TUEkg
SVBzIHdlIHdvdWxkIG5lZWQgdG8gY3JlYXRlIG5ldyBwbGF0Zm9ybSBkcml2ZXJzLg0KPiANCj4g
V2h5IHdvdWxkIHlvdSBuZWVkIHRvIGRvIHRoYXQ/DQoNCkluIHRoZSBjYXNlIHdlIHdpbGwgaGF2
ZSB0byBzdXBwb3J0IGFub3RoZXIgc2ltaWxhciBJUCwgYnV0IHdpdGggYSANCmRpZmZlcmVudCBz
ZXQgb2YgZmVhdHVyZXMuIE5vdCBhIG5ldyBwbGF0Zm9ybSBkcml2ZXIgZnJvbSBzY3JhdGNoLCBi
dXQgDQphdCBsZWFzdCBhIG5ldyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIGZvciBlYWNoIHZhcmlh
bnQuDQoNCj4gDQo+PiBUaGlzIGlzIG5vdCBpZGVhbCwgYnV0IGl0J3MgYSBzb2x1dGlvbi4gV2hh
dCBJIHByb3Bvc2VkIGlzIG1vcmUNCj4+IGZsZXhpYmxlLCBidXQsIGFzIHlvdSBwb2ludGVkIG91
dCwgSSBhbSBub3Qgc3VyZSBpdCBjb3JyZWN0bHkgZGVzY3JpYmVzDQo+PiB0aGUgSFcsIGJlY2F1
c2UgdGhlIGRlY2lzaW9uIG9mIHdoZXRoZXIgdG8gdXNlIHRoaXMgSVAgYXMgYSBzZXJpYWwgb3Ig
YQ0KPj4gU1BJIGlzIGEgY29uZmlndXJhYmxlIG9uZS4NCj4+DQo+PiBUaGFua3MgYW5kIGJlc3Qg
cmVnYXJkcywNCj4+IENvZHJpbg0KPiANCj4gLS0NCj4gTGVlIEpvbmVzIFvmnY7nkLzmlq9dDQo+
IFNlbmlvciBUZWNobmljYWwgTGVhZCAtIERldmVsb3BlciBTZXJ2aWNlcw0KPiBMaW5hcm8ub3Jn
IOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQXJtIFNvQ3MNCj4gRm9sbG93IExpbmFybzog
RmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZw0KPiANCg0K
