Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847F82800E3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 16:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732329AbgJAOHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 10:07:02 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:52272 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732018AbgJAOHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 10:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601561221; x=1633097221;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JyAzKFrrQ+dS8KoTfqq62BPpyQFHY9kGh+E/fvQ5YDs=;
  b=Y1l74IByJ0bN9NAhiJrMmRft5IhBFPH0VNh90SRsYGuUq+5YFxNEEKw9
   VwGAJsdHJ1zh3ixpIgTj8ghLw/keHy/sWlKUc0FeT4Ql6knyew20uTiEV
   O7Ny1OWyj/p/mkQvLa9PyX9ehxNc37yYq2G0ELp7VsNqPPrPT3d8Tb0hb
   GTJA/iWfcRQR6/xvZSwvHbNBNkz5zsJj8rhPr2XoJOhjmeQV/5kqvdgi9
   n1Ymnk+SMmKWViry9V2T5tXkaiu2nbkOfx5gBr/vyeOXb/d9BOaHR4TQe
   dEj2TLu+OWuA+9GRLIFq+3rUJCf6925WXJbkTkdHPucaeP0io7HkHF4oZ
   g==;
IronPort-SDR: +FmVu+k/7cU+zhMh/RW5ny7reimyHQBW6uGXDihl5Tyxwv6iYmEj9yMpLsjLE0F6CXXPgPB0zM
 yA/GfJDFsaBigzXGs1E61rEgyC1op8grRR6MsfzBbooC+TUbwqCQGjfi6OqMH2ZRTabPRFhngt
 6hfJhkwHDryQsF23R/o8pk7VtzmlEzVdohRU2B1ztCKEDsoKXE/Q87gpA9PbrkDWSGQ1TTT7Hy
 82TfTid1xAo6h1sOZS1HvnNVFtNv8jvf8qGVQNYS6HTUVsbTuuIZKC0ggBb35elH7vh9a+4ROi
 fzY=
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="93080388"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Oct 2020 07:07:00 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 1 Oct 2020 07:06:34 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Thu, 1 Oct 2020 07:06:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ff0HtnNEOc24X+CfzSYZ7WIFkx+SVbbZrltxieSjt/YYATnL8jYd/2cyL5rRKuKbYhr6qZXVNJ7qiL8JDSG8pnM8MPKJOKXsztuHbYjbsQEg3E980KqLNg0WNYzVGnVHwnfeirojT70ubnBFOeF2eI5o8VUPSZo9wpZmCeoqinOdZINFIJyFHtXbuOwEv1TdFo51RwAfMGHzSfAVugKgH7QN5VvJ1/cUQL3xi8OQp6pqoLOHknKmoRNipH+ZoyrQfRvcvCPrjdVTFjvfc0kOgsuD/ZWKBPs23Ex0vwCz3ah8lSFTN+Btux+MbgnkTpMy0l/1D39k5Vv7j88+a0uISA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyAzKFrrQ+dS8KoTfqq62BPpyQFHY9kGh+E/fvQ5YDs=;
 b=GyHpdaUyDjB7G1+/r2Oxz/gWpZ8U0aSD+pEIS5psdFSSUisgcOVDjpC3AE9kIrC1ATSNzM7j7eEcTZl4CZHvqrOtAFDZUv3QP/q5ifk0RKXMOsobahCv8O2Y8sJg9/QrTYk7D7sDE37q73xlVypiq/WAynzUGcpNDNxwzAWUnIl3bp0gAyyjDU6iU5KA/qz4dM1nQagnlfislx+FY1sCY67doCNynKVD57bJr+8p9uH1kRS67ve76Vc7dEyjOWE2pQoMFPjgWy2TjaxiG7TOXqlVD+qDL7tjjJ2O1msJta1ZyB3/qZCdKc/79UcD7SZQGT11iQxi/oyEcMZS+7I2kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyAzKFrrQ+dS8KoTfqq62BPpyQFHY9kGh+E/fvQ5YDs=;
 b=gu3JY99Y2ClrH/SHWD6lk6IuroC7hUR/xuyM1M3Ou3IHZMFR+2OCc4gZUBvhW+Cl7Hfazzb+mIFqDsG37A9YvP269tX5tAe0jFwNM6PZIN1fE9iS+Uf8BeNpCw0/gyc+5DcsniqMtH+w0Cv9pxsUzYm1GYhYciCwbUt2zCWy0xk=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (2603:10b6:3:112::12)
 by DM5PR11MB1257.namprd11.prod.outlook.com (2603:10b6:3:12::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37; Thu, 1 Oct
 2020 14:06:58 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a%4]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 14:06:58 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
Subject: Re: [RFC PATCH 1/2] mtd: spi-nor: atmel: remove global
 SNOR_F_HAS_LOCK
Thread-Topic: [RFC PATCH 1/2] mtd: spi-nor: atmel: remove global
 SNOR_F_HAS_LOCK
Thread-Index: AQHWl/wfolQmpEhmZUmGKx8TlQY45g==
Date:   Thu, 1 Oct 2020 14:06:58 +0000
Message-ID: <5eb8f95c-e9d5-6043-fb7d-bffcda044262@microchip.com>
References: <20201001122828.23186-1-michael@walle.cc>
In-Reply-To: <20201001122828.23186-1-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [5.13.51.157]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa1a74fd-3b96-4123-0521-08d8661342ce
x-ms-traffictypediagnostic: DM5PR11MB1257:
x-microsoft-antispam-prvs: <DM5PR11MB1257B5BAEC5CF329F2ABAD4DF0300@DM5PR11MB1257.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rYdOGS2Sy0iGUWCRNYMgSh5/dBTc0PegDpBMN6hnmKB/7teX9uHA9vEdXWgoUQ4QufzFH53pJRqXveDNB5zWnGJvOds0GS9SlrCViE46/fc1P2Gw71/tzLJtGuDyCZh+ABYFSwZoYpjiXi/sFO2PsjZtVNrLcTG75EjSSpGyy6yIq+qt9oJxqYbwaEc+v8jCZQt5ao0kQFijNTdmEPNiq/dxC8pH94XfDfStdU8cMakGzz3Zr7mec0WGXzv13Yy8SXRy/KpCBH3NIfY2MHbt0g57ssZR+v+B7efxJozmAeqW8IQEOJYcK0aVrUfS6I37w4GKePzRzYvEvJOWI2Oks3no+eTmaaQTiG2cAbVtmvdrAXbSWGZd5vWJYiCsuQfcrG3AVzFPNzSc2V75B5EZL4ybEtQZimABFgpdzs1R6t4RlrKPjZ1aER2nt8cS9cthz5uTKX5k61MJB5LpiCIYV7Hi714hZXGn3IRpvOmYY2DI8Yeq6Nfc0ED/RBDMj/E2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(346002)(136003)(376002)(396003)(186003)(83080400001)(6486002)(83380400001)(91956017)(64756008)(66556008)(66476007)(76116006)(8676002)(66946007)(26005)(4326008)(8936002)(66446008)(6506007)(53546011)(966005)(110136005)(36756003)(86362001)(31686004)(31696002)(5660300002)(6512007)(2906002)(316002)(54906003)(71200400001)(478600001)(2616005)(15398625002)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 1+n3WJ9h4HwbvbBTfxyAUGxQCwrsPdl2ixV0fvnXByqc728IEahEf62cJlJ0E+s1XHwaTtzZWwCMo1bYwoZiRy3HraM0dr9HlQfo1BmhJIo+zoLTbTDMWeI61TqibBPI973gYWveHCYmYwtFkoFsrvvgBw47BB4Wfao50SQDNnk9vTdNgq8AilzXxKnpSvFZVY7rqcuCV9dQ982hlJ4Tcbi/6w7smVAKiJHcA6fdWPP/HYUetWFTpSOuxhNzoh+eE24jw2oQDCROXCsTXndf38Ml8Pm2A89rlBbkEvdOYb65iI9VhVYW0n+/ll6xpDEaSkxVNTRYN4if3mplFAiE7F7R3mQOiiSVkuV1GiiTQUTOK4xUe1Aph5oAM4ORqNHbf3h9vLTb7Hj3+N7TK6wGyoQUWrwJYMlE8X/O+dbAN79DYBw7p9Ni37S9R9u2HUJWvP6ye2js46/pGRcEIMWMIjmSm1FpgqrlYO0LJUgQVdEfJ7pUTqcPVUA4nQP3Rppn5JubfSmQ8GozW80xDGKzr4A7vo++JGO3o3BKc9uJo3m0m6FauoLg4phNShN3VuTmJeXJW97dcGChAGssAPHr89TLX6zmHcXP+WTMDFHFRKDYIDYnYuX4kzTvAu9vKlhonI1XNfX4iMnAzKZyo7YpOA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <242952F3BEE92D4FA24F74B8DF4272CA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1a74fd-3b96-4123-0521-08d8661342ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 14:06:58.2815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hEg0WO0ET1tVwSOMdxxFu77xL05gB94eD2E3TA4n164qBOR8MGrh1M/SVVp+52+cbG+DfALuOWdNZfIIAxShewmF25VrKmsoihiqS8QU6kI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1257
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMS8yMCAzOjI4IFBNLCBNaWNoYWVsIFdhbGxlIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFRoaXMgaXMgY29uc2lkZXJlZCBiYWQgZm9yIHRo
ZSBmb2xsb3dpbmcgcmVhc29uczoNCj4gICgxKSBXZSBvbmx5IHN1cHBvcnQgdGhlIGJsb2NrIHBy
b3RlY3Rpb24gd2l0aCBCUG4gYml0cyBmb3Igd3JpdGUNCj4gICAgICBwcm90ZWN0aW9uLiBOb3Qg
YWxsIEF0bWVsIHBhcnRzIHN1cHBvcnQgdGhpcy4NCj4gICgyKSBOZXdseSBhZGRlZCBmbGFzaCBj
aGlwIHdpbGwgYXV0b21hdGljYWxseSBpbmhlcml0IHRoZSAiaGFzDQo+ICAgICAgbG9ja2luZyIg
c3VwcG9ydCBhbmQgdGh1cyBuZWVkcyB0byBleHBsaWNpdGx5IHRlc3RlZC4gQmV0dGVyDQo+ICAg
ICAgYmUgb3B0LWluIGluc3RlYWQgb2Ygb3B0LW91dC4NCj4gICgzKSBUaGVyZSBhcmUgYWxyZWFk
eSBzdXBwb3J0ZWQgZmxhc2hlcyB3aGljaCBkb24ndCBzdXBwb3J0IHRoZSBsb2NraW5nDQo+ICAg
ICAgICAgIHNjaGVtZS4gU28gSSBhc3N1bWUgdGhpcyB3YXNuJ3QgcHJvcGVybHkgdGVzdGVkIGJl
Zm9yZSBhZGRpbmcgdGhhdA0KPiAgICAgICAgICBjaGlwOyB3aGljaCBlbmZvcmNlcyBteSBwcmV2
aW91cyBhcmd1bWVudCB0aGF0IGxvY2tpbmcgc3VwcG9ydCBzaG91bGQNCj4gICAgICAgICAgYmUg
YW4gb3B0LWluLg0KPiANCj4gUmVtb3ZlIHRoZSBnbG9iYWwgZmxhZyBhbmQgYWRkIGluZGl2aWR1
YWwgZmxhZ3MgdG8gYWxsIGZsYXNoZXMNCj4gd2hpY2ggc3VwcG9ydHMgQlAgbG9ja2luZy4gSW4g
cGFydGljdWxhciB0aGUgZm9sbG93aW5nIGZsYXNoZXMNCj4gZG9uJ3Qgc3VwcG9ydCB0aGUgQlAg
c2NoZW1lOg0KPiAgLSBBVDI2RjAwNA0KPiAgLSBBVDI1U0wzMjENCj4gIC0gQVQ0NURCMDgxRA0K
PiANCj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBXYWxsZSA8bWljaGFlbEB3YWxsZS5jYz4NCj4g
LS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL2F0bWVsLmMgfCAyOCArKysrKysrKystLS0tLS0t
LS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxOSBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL2F0bWVsLmMg
Yi9kcml2ZXJzL210ZC9zcGktbm9yL2F0bWVsLmMNCj4gaW5kZXggM2Y1ZjIxYTQ3M2E2Li40OWQz
OTJjNmM4YmMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvYXRtZWwuYw0KPiAr
KysgYi9kcml2ZXJzL210ZC9zcGktbm9yL2F0bWVsLmMNCj4gQEAgLTEwLDM3ICsxMCwyNyBAQA0K
PiANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZmxhc2hfaW5mbyBhdG1lbF9wYXJ0c1tdID0gew0K
PiAgICAgICAgIC8qIEF0bWVsIC0tIHNvbWUgYXJlIChjb25mdXNpbmdseSkgbWFya2V0ZWQgYXMg
IkRhdGFGbGFzaCIgKi8NCj4gLSAgICAgICB7ICJhdDI1ZnMwMTAiLCAgSU5GTygweDFmNjYwMSwg
MCwgMzIgKiAxMDI0LCAgIDQsIFNFQ1RfNEspIH0sDQo+IC0gICAgICAgeyAiYXQyNWZzMDQwIiwg
IElORk8oMHgxZjY2MDQsIDAsIDY0ICogMTAyNCwgICA4LCBTRUNUXzRLKSB9LA0KPiArICAgICAg
IHsgImF0MjVmczAxMCIsICBJTkZPKDB4MWY2NjAxLCAwLCAzMiAqIDEwMjQsICAgNCwgU0VDVF80
SyB8IFNQSV9OT1JfSEFTX0xPQ0spIH0sDQo+ICsgICAgICAgeyAiYXQyNWZzMDQwIiwgIElORk8o
MHgxZjY2MDQsIDAsIDY0ICogMTAyNCwgICA4LCBTRUNUXzRLIHwgU1BJX05PUl9IQVNfTE9DSykg
fSwNCg0KYWZ0ZXIgYSBxdWljayBsb29rIGluIHRoZSBkYXRhc2hlZXRzIG9mIHRoZXNlIGZsYXNo
ZXMsIEkgc3VzcGVjdCB0aGF0DQp3aGF0IHdlIGhhdmUgbm93IGluIHRoZSBTUEkgTk9SIGNvcmUg
Zm9yIFNSIGxvY2tpbmcgZG9lcyBub3Qgd29yayBmb3INCnRoZW0uIFRoZXkgcHJvYmFibHkgc3Vw
cG9ydGVkIGp1c3QgInVubG9jayBhbGwiLCBjbGVhcmluZyBhbGwgdGhlDQpCUCBiaXRzLiBBbnl3
YXksIGRpZmZlcmVudCBwcm9ibGVtLg0KPiANCj4gLSAgICAgICB7ICJhdDI1ZGYwNDFhIiwgSU5G
TygweDFmNDQwMSwgMCwgNjQgKiAxMDI0LCAgIDgsIFNFQ1RfNEspIH0sDQo+IC0gICAgICAgeyAi
YXQyNWRmMzIxIiwgIElORk8oMHgxZjQ3MDAsIDAsIDY0ICogMTAyNCwgIDY0LCBTRUNUXzRLKSB9
LA0KPiAtICAgICAgIHsgImF0MjVkZjMyMWEiLCBJTkZPKDB4MWY0NzAxLCAwLCA2NCAqIDEwMjQs
ICA2NCwgU0VDVF80SykgfSwNCj4gLSAgICAgICB7ICJhdDI1ZGY2NDEiLCAgSU5GTygweDFmNDgw
MCwgMCwgNjQgKiAxMDI0LCAxMjgsIFNFQ1RfNEspIH0sDQo+ICsgICAgICAgeyAiYXQyNWRmMDQx
YSIsIElORk8oMHgxZjQ0MDEsIDAsIDY0ICogMTAyNCwgICA4LCBTRUNUXzRLIHwgU1BJX05PUl9I
QVNfTE9DSykgfSwNCg0KdGhpcyBvbmUgZG9lcyBub3Qgc3VwcG9ydCBCUCBsb2NraW5nOiBodHRw
czovL3d3dy5hZGVzdG90ZWNoLmNvbS93cC1jb250ZW50L3VwbG9hZHMvZG9jMzY2OC5wZGYNCg0K
PiArICAgICAgIHsgImF0MjVkZjMyMSIsICBJTkZPKDB4MWY0NzAwLCAwLCA2NCAqIDEwMjQsICA2
NCwgU0VDVF80SyB8IFNQSV9OT1JfSEFTX0xPQ0spIH0sDQoNCm5laXRoZXIgdGhpcyBvbmU6IGh0
dHBzOi8vZGF0YXNoZWV0Lm9jdG9wYXJ0LmNvbS9BVDI1REYzMjEtUzNVLUF0bWVsLWRhdGFzaGVl
dC04NzAwODk2LnBkZg0KDQo+ICsgICAgICAgeyAiYXQyNWRmMzIxYSIsIElORk8oMHgxZjQ3MDEs
IDAsIDY0ICogMTAyNCwgIDY0LCBTRUNUXzRLIHwgU1BJX05PUl9IQVNfTE9DSykgfSwNCg0Kbm9y
IHRoaXMgb25lOiBodHRwczovL3d3dy5hZGVzdG90ZWNoLmNvbS93cC1jb250ZW50L3VwbG9hZHMv
ZG9jMzY4Ni5wZGYNCg0KPiArICAgICAgIHsgImF0MjVkZjY0MSIsICBJTkZPKDB4MWY0ODAwLCAw
LCA2NCAqIDEwMjQsIDEyOCwgU0VDVF80SyB8IFNQSV9OT1JfSEFTX0xPQ0spIH0sDQoNCm5vciB0
aGlzIG9uZTogaHR0cHM6Ly93d3cuYWRlc3RvdGVjaC5jb20vd3AtY29udGVudC91cGxvYWRzL2Rv
YzM2ODAucGRmDQoNCkkgc3RvcCBoZXJlLg0KDQo+IA0KPiAgICAgICAgIHsgImF0MjVzbDMyMSIs
ICBJTkZPKDB4MWY0MjE2LCAwLCA2NCAqIDEwMjQsIDY0LA0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFNFQ1RfNEsgfCBTUElfTk9SX0RVQUxfUkVBRCB8IFNQSV9OT1JfUVVBRF9SRUFE
KSB9LA0KPiANCj4gICAgICAgICB7ICJhdDI2ZjAwNCIsICAgSU5GTygweDFmMDQwMCwgMCwgNjQg
KiAxMDI0LCAgOCwgU0VDVF80SykgfSwNCj4gLSAgICAgICB7ICJhdDI2ZGYwODFhIiwgSU5GTygw
eDFmNDUwMSwgMCwgNjQgKiAxMDI0LCAxNiwgU0VDVF80SykgfSwNCj4gLSAgICAgICB7ICJhdDI2
ZGYxNjFhIiwgSU5GTygweDFmNDYwMSwgMCwgNjQgKiAxMDI0LCAzMiwgU0VDVF80SykgfSwNCj4g
LSAgICAgICB7ICJhdDI2ZGYzMjEiLCAgSU5GTygweDFmNDcwMCwgMCwgNjQgKiAxMDI0LCA2NCwg
U0VDVF80SykgfSwNCj4gKyAgICAgICB7ICJhdDI2ZGYwODFhIiwgSU5GTygweDFmNDUwMSwgMCwg
NjQgKiAxMDI0LCAxNiwgU0VDVF80SyB8IFNQSV9OT1JfSEFTX0xPQ0spIH0sDQo+ICsgICAgICAg
eyAiYXQyNmRmMTYxYSIsIElORk8oMHgxZjQ2MDEsIDAsIDY0ICogMTAyNCwgMzIsIFNFQ1RfNEsg
fCBTUElfTk9SX0hBU19MT0NLKSB9LA0KPiArICAgICAgIHsgImF0MjZkZjMyMSIsICBJTkZPKDB4
MWY0NzAwLCAwLCA2NCAqIDEwMjQsIDY0LCBTRUNUXzRLIHwgU1BJX05PUl9IQVNfTE9DSykgfSwN
Cj4gDQo+ICAgICAgICAgeyAiYXQ0NWRiMDgxZCIsIElORk8oMHgxZjI1MDAsIDAsIDY0ICogMTAy
NCwgMTYsIFNFQ1RfNEspIH0sDQo+ICB9Ow0KPiANCj4gLXN0YXRpYyB2b2lkIGF0bWVsX2RlZmF1
bHRfaW5pdChzdHJ1Y3Qgc3BpX25vciAqbm9yKQ0KPiAtew0KPiAtICAgICAgIG5vci0+ZmxhZ3Mg
fD0gU05PUl9GX0hBU19MT0NLOw0KPiAtfQ0KPiAtDQo+IC1zdGF0aWMgY29uc3Qgc3RydWN0IHNw
aV9ub3JfZml4dXBzIGF0bWVsX2ZpeHVwcyA9IHsNCj4gLSAgICAgICAuZGVmYXVsdF9pbml0ID0g
YXRtZWxfZGVmYXVsdF9pbml0LA0KPiAtfTsNCj4gLQ0KPiAgY29uc3Qgc3RydWN0IHNwaV9ub3Jf
bWFudWZhY3R1cmVyIHNwaV9ub3JfYXRtZWwgPSB7DQo+ICAgICAgICAgLm5hbWUgPSAiYXRtZWwi
LA0KPiAgICAgICAgIC5wYXJ0cyA9IGF0bWVsX3BhcnRzLA0KPiAgICAgICAgIC5ucGFydHMgPSBB
UlJBWV9TSVpFKGF0bWVsX3BhcnRzKSwNCj4gLSAgICAgICAuZml4dXBzID0gJmF0bWVsX2ZpeHVw
cywNCj4gIH07DQo+IC0tDQo+IDIuMjAuMQ0KPiANCg0K
