Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855762930EE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 00:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387851AbgJSWEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 18:04:55 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:51972 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387838AbgJSWEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 18:04:51 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 060C3C008A;
        Mon, 19 Oct 2020 22:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1603145088; bh=0PDkxOfG0uZ1iDwQvpeSHqXQCCHejjpnAUvYR7lJjjM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=NfgAw12Rh+qNye9GHVDUc7FbVOOx0gL/sA8/XIbwzIbRxWTs/plMeXQdWVpIJ0nzq
         +VrhZBYROFu9vrF8QtuJ1rFZ/92N4br4RVdm4C2vyrVhamI8IjD8r8+0BSJGUe9sq3
         Jw+3vZu18lwg1U5gz67n8MGgIaiHY/azF5gUvDXYWxnAVICdu3f3xX6c8MD2vK3z6C
         8XdX4Z4K6TH3YSwCorJZcT02Ju7ItRTI/3e+Is/YWxgoNQ0y2PBmU7QtNAWANjekhD
         jQHiwS9VxXC3wP3MJd4bqcnExDwREdZJVWwDOw41NxNC/z44jVjv99OiQZT6Ub27s4
         KNQiP3C+NeRPg==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 66BD2A0067;
        Mon, 19 Oct 2020 22:04:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0621580233;
        Mon, 19 Oct 2020 22:04:44 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="lcf72tX+";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nr5N/UwyUmbmzWjOHYOihjx/kv36RSSfV6zUsE+jNSdou13suf1xnvMgHRE4vJ/2F4BWp4V5YLA5WRlgdRH5IypKPDyMMKGLP3hgkDEzx3itv3x02pIuoaRcT1S4qi/kQVXaRGAgb6z6PcQlUzms2z+UJc7Rs8E/QRYtBAA7gPOJXQMVeVD5LL3mzI8Qdz9D/lNoucilb2ljx/DBDz749guBm4LCmi+ZOT5KiiGJ51g1Xy1u9o/x0DBcZrVS9lM+z8xd+r3l341cOyFbRsPkrUu0xnspGNJL24x1oDCojzu5w5gtTQvbn6837ZKn69bxf2B0gSD+98MBqH6GgeT9QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PDkxOfG0uZ1iDwQvpeSHqXQCCHejjpnAUvYR7lJjjM=;
 b=O9K3e0/nFKm+GgWwfWz5iWh9+nc+76s5kgvwbslMEd6Plq6s3gJD1X2buekXh3sk2qlnQTvHwWhERH7Jzn0lp4ADqq5c7FS3EPWWmHr9gi0VmCaZ58RLbquFC8YeSAOJWT3THp6nmu37U1k728Siy0x4RNkYssqj9uIAHdOBlQpdJopj/O/NdBYcht9q2pF8/+K3Orep6RUBCNAP60LkT3Kl9uZXvuAr73MvyXO2f5da8X2GVfOnvzYv60uNX9v+s8+uv/3wriCxg4mEj5daS1vdLZQzeRtP3knGxQ/3lYqo1oE5pSE8+vpVoB+hDwX3VUBAqojrDYMNOHBvRu719w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PDkxOfG0uZ1iDwQvpeSHqXQCCHejjpnAUvYR7lJjjM=;
 b=lcf72tX+Wo7Wnrao8iQjQ7NrTX2F8T84rmqM2hSAB/XXMsx/sz+WlhpQfyL4yOPJ3xmo5O6f068fHBTfO7fH+XtRxIaG14Vx2+m5LMIM0ZXUppSEiw7R5+0D9/TtafW1loH4yIUo1EmG0Bo0lOoIS3jJH0kMi/Fpc1/wKc/nFe4=
Received: from BYAPR12MB2917.namprd12.prod.outlook.com (2603:10b6:a03:130::14)
 by BYAPR12MB3125.namprd12.prod.outlook.com (2603:10b6:a03:dc::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Mon, 19 Oct
 2020 22:04:41 +0000
Received: from BYAPR12MB2917.namprd12.prod.outlook.com
 ([fe80::c17e:c3dd:7cda:e2dc]) by BYAPR12MB2917.namprd12.prod.outlook.com
 ([fe80::c17e:c3dd:7cda:e2dc%4]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 22:04:41 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Dejin Zheng <zhengdejin5@gmail.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "sergei.shtylyov@gmail.com" <sergei.shtylyov@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: core: fix a issue about clear connect state
Thread-Topic: [PATCH v2] usb: dwc3: core: fix a issue about clear connect
 state
Thread-Index: AQHWpcBu8ug2r+BCtEOz/JWZV5B7W6mffC0A
Date:   Mon, 19 Oct 2020 22:04:41 +0000
Message-ID: <58ce8257-422f-1e47-bc95-61262a3706f5@synopsys.com>
References: <20201019023435.5482-1-zhengdejin5@gmail.com>
In-Reply-To: <20201019023435.5482-1-zhengdejin5@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [98.248.94.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08f0d287-8633-498f-7bb3-08d8747afad2
x-ms-traffictypediagnostic: BYAPR12MB3125:
x-microsoft-antispam-prvs: <BYAPR12MB3125B3D2B3EF8872FDBD99E1AA1E0@BYAPR12MB3125.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SRr8ecQ0vu/jNukRjCoKr2C67Adm4OrZYql9sqkWx6O7loz9i3YEcWMl+XuEIz8vrXGSFh6daO4Zwor++Vc73s8nTUoWtKNy6DsMc207H9E5PXOh11v9W0G+isyDInHyw43tEZLeOeYUhdVCi/Vy/ueoBCgVwui7eG5FF6EgJV73woUR76kDbwLyfOEpo4i+GKE1EDm1J39xxuE5G46k3/Go7gqEwidOhU3/hIl8XOJg2mDnda5dJeXhrCoeTynwbNfHCQMo/gP1cZaJwNPYyNXrjeu3b+KCjCjeiyn4qsaeBDSGamI83MrZQcH1X4BpiqP9vigU3wMhU1k7Z68kgynRxx3QuZcZTfVUNoWeZ+d4DIUaVP+PFXwIf7WJ6xBm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2917.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(31696002)(5660300002)(83380400001)(66946007)(8676002)(66556008)(76116006)(66446008)(36756003)(66476007)(6512007)(71200400001)(64756008)(2616005)(4326008)(186003)(478600001)(2906002)(31686004)(26005)(86362001)(6506007)(8936002)(110136005)(6486002)(316002)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: vlL9mw5VUD7oDSpEhwA4Xx5sLyE/A6HrK56dTA18Nkz1pkp0sNIICh5m9hy1OCFu0tAgw7ddlcYa9/fP+n3P7S2qbNjAlas2cLeBv449C9kFp4FMxUnPC0CSrH/JE/5HTO5LDu7Xyoexmq+o9B9BjaDHqcviJRmbtA5t7++u1bwgn7e2iJaBQKxGfLavV8vpQ3tpi4VDkIbAgrlnXolZBnFH5/zw9Z98Nq4HjldbVGV8SJvWNiSXLda3UCUsynKpM1w7SJvfuL7v8fiIxhmLU2uvdGUUT5scgDviKETJHD1r4SDvb9xWpblpLCTAZo0/RNCMwYtL8dLfobV2J1fpMfm0FGwHhItZA6U8PbcZrSQUfNFXsDwbH+nnVNkYOaRPQQbIMUMPbG7Nn3nrYQOnmVWZ45y4E+ifRwQkA1JHzmkg3AdaiQdYMwfKLxicHQaqpORiOHKHxwZX8gWBmW3MmKXtW0+FeR8Qlni6k9rGOpYuryy4rVW+eyfmjaKCS/kEYY14JrH9ci3Lj7mCdXwTknQ26D//6AGcf7yBcomO+RhUKO8nbm6gzbQHv3S8WEqNHWexy4RgA8GOWF52Oitn3hmKdAoC2OClw67Z79Sk8HE5GqER+79wdazcEZlj0hOsQ6o36MzWVNIsgwpxnN/Zhw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D15105B861FA5946AA91ED9A86F04755@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2917.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f0d287-8633-498f-7bb3-08d8747afad2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2020 22:04:41.4726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AvIfqE1KPFPgAV4WDEI5rE3znQghOWtCvDxlIzzUAhz4g5fhVj8Rn7Jh5keFngPCmL9EaRAZkUNTWs/2nulj4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3125
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVqaW4gWmhlbmcgd3JvdGU6DQo+IEFjY29yZGluZyB0byBTeW5vcHN5cyBQcm9ncmFtbWluZyBH
dWlkZSBjaGFwdGVyIDIuMiBSZWdpc3RlciBSZXNldHMsDQo+IGl0IGNhbm5vdCByZXNldCB0aGUg
RENUTCByZWdpc3RlciBieSBzZXR0aW5nIERDVEwuQ1NGVFJTVCBmb3IgY29yZSBzb2Z0DQo+IHJl
c2V0LCBpZiBEV0MzIGNvbnRyb2xsZXIgYXMgYSBzbGF2ZSBkZXZpY2UgYW5kIHN0YXkgY29ubmVj
dGVkIHdpdGggYSB1c2INCj4gaG9zdCwgdGhlbiwgd2hpbGUgcmVib290aW5nIGxpbnV4LCBpdCB3
aWxsIGZhaWwgdG8gcmVpbml0aWFsaXplIGR3YzMgYXMgYQ0KPiBzbGF2ZSBkZXZpY2Ugd2hlbiB0
aGUgRFdDMyBjb250cm9sbGVyIGRpZCBub3QgcG93ZXIgb2ZmLg0KDQpJZiB5b3UgcmVib290IHRo
ZSBPUywgd291bGRuJ3QgaXQgZ28gdGhyb3VnaCB0aGUgZHJpdmVyIHRlYXItZG93bg0Kc2VxdWVu
Y2UgYW5kIGNsZWFyIHRoZSBydW5fc3RvcCBiaXQgYW55d2F5Pw0KSG93ZXZlciwgSSBjYW4gc2Vl
IGhvdyB0aGlzIGNhbiBiZSBhbiBpc3N1ZS4NCg0KPiAgYmVjYXVzZSB0aGUNCj4gY29ubmVjdGlv
biBzdGF0dXMgaXMgaW5jb3JyZWN0LCBzbyB3ZSBhbHNvIG5lZWQgdG8gY2xlYXIgRENUTC5SVU5f
U1RPUA0KPiBiaXQgZm9yIGRpc2FibGluZyBjb25uZWN0IHdoZW4gZG9pbmcgY29yZSBzb2Z0IHJl
c2V0Lg0KPg0KPiBGaXhlczogZjU5ZGNhYjE3NjI5M2I2ICgidXNiOiBkd2MzOiBjb3JlOiBpbXBy
b3ZlIHJlc2V0IHNlcXVlbmNlIikNCj4gU2lnbmVkLW9mZi1ieTogRGVqaW4gWmhlbmcgPHpoZW5n
ZGVqaW41QGdtYWlsLmNvbT4NCj4gLS0tDQo+IHYxIC0+IHYyOg0KPiAJKiBtb2RpZnkgc29tZSBj
b21taXQgbWVzc2FnZXMgYnkgU2VyZ2VpJ3Mgc3VnZ2VzdCwgVGhhbmtzDQo+IAkgIHZlcnkgbXVj
aCBmb3IgU2VyZ2VpJ3MgaGVscCENCj4NCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jIHwgMSAr
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4NCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gaW5kZXgg
MmViMzRjOGI0MDY1Li4yMzk2MzZjNDU0YzIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3
YzMvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IEBAIC0yNTYsNiAr
MjU2LDcgQEAgc3RhdGljIGludCBkd2MzX2NvcmVfc29mdF9yZXNldChzdHJ1Y3QgZHdjMyAqZHdj
KQ0KPiAgDQo+ICAJcmVnID0gZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNfRENUTCk7DQo+ICAJ
cmVnIHw9IERXQzNfRENUTF9DU0ZUUlNUOw0KPiArCXJlZyAmPSB+RFdDM19EQ1RMX1JVTl9TVE9Q
Ow0KPiAgCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19EQ1RMLCByZWcpOw0KPiAgDQo+ICAJ
LyoNCg0KVGhlcmUgd2lsbCBzdGlsbCBiZSBvdGhlciBzdGFsZSBjb25maWd1cmF0aW9uIGluIERD
VEwgaWYgeW91IGRvIHRoaXMuIEkNCnRoaW5rIGl0J3MgYmV0dGVyIHRvIHJlc2V0IHRoZSBvdGhl
ciBmaWVsZHMgb2YgRENUTCB0byB0aGUgZGVmYXVsdA0KKHNob3VsZCBiZSBhbGwgMHMpIGluc3Rl
YWQgb2YgZG9pbmcgcmVnaXN0ZXIgcmVhZC1tb2RpZnktd3JpdGUgYXMgd2hhdA0Kd2UncmUgZG9p
bmcgaGVyZS4gSWYgbm90LCBhdCBsZWFzdCB3ZSBzaG91bGQgdXNlDQpkd2MzX2dhZGdldF9kY3Rs
X3dyaXRlX3NhZmUoKS4NCg0KVGhhbmtzLA0KVGhpbmgNCg0K
