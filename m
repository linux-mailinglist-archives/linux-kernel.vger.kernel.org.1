Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2982952D3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 21:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504848AbgJUTOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 15:14:55 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:51168 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2409949AbgJUTOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 15:14:55 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 09D754019C;
        Wed, 21 Oct 2020 19:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1603307694; bh=mnqZVXHsbYcyCCAWtkM0B9K8pQIfTzLF0F5KerLvUNE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=kwLu3rHt7lHBp5oluxP4MhXNEZkeVAbTnU01mY+GJlJw70bsm0V45K85jo9KCGj1O
         KVBvtPQa2QbS/fbisR9/05RLElZIPuReeEFJOQmHJLrPtB+ntAcsfxZYIQzpWg1JTM
         OGKnICbm9rKyDkXXBgM0QHxhnEmvL8DvEUa+0jANA/AiHqaOhKHkf+GO6v34tF9WOr
         kwYvd3cCjnMOVlhNFEpvYDazF2VqjzkLIO56K/U9T8poPfZbU/T7BH8gnvT58P9ldS
         bOTlfnps+7YF6A/583zwk9i5Fh2BTBwdcepBcNk+IVPQa2X1IYd3KP4laKRnFX0g4+
         OVr66707wduaQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id A3083A0071;
        Wed, 21 Oct 2020 19:14:52 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2058.outbound.protection.outlook.com [104.47.36.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 8850340044;
        Wed, 21 Oct 2020 19:14:51 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="cgY4XT/a";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/Khpg02iO4prP89MmE6DNJVirHBaEC6KRMhoE/DL+E4TzdMYrufOzhWtfcQ1PqjWFdlGsoHzdEg1VEcQuPmdTCWcs/VO7Bjcbg5jUmWeD2MtRQGI++TLqEOX4KNYvTgNgUfJJrbpaJMFOLPuGOp0S071mC1Hz+Ct+7M/TebvGDM3E1oXJ5z3eqlVzDa71ALw4QkDKiJqhdh4MZJAFY/jTUZ3yTKBdixa5T3EwtO8HuiDndW2Kff6V4lXO1YVBMyxDXZDZARsfYqhU1QWtTY72ThXux3F6ThPVR/z/k2aKkkJuoKHjWejaVop/WsmDmQ/ZgrJSREZyNNenjP/tmywA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnqZVXHsbYcyCCAWtkM0B9K8pQIfTzLF0F5KerLvUNE=;
 b=XqS4Na3ufGtbiX8Dtdzrcx0GIelEpFMX26ci0LeAM5eHRIRhtPBTTNkAyst+7tlB/ATb7EWJLZfhXDSFr9djsC9OobX+RQdUbBYpBGq/0JlFQc2VF9IhBrY78Y6ZylkdWfPw46b8n6Z1jNUpna4WrFN6UbKlkArjIaoDMzKBZ/s465BdOji7M6tPu3md7jJ2UV9olyIhDp5Ig93DCAGF8dPB1X27mcHfyvpmL7kLKRdWlHaIXtw+Lwy+KLCvyeMhiBXkXY2c1QB4nLjLh0+SGYi2e7vSFhVlkFcVPRfdfs2sL7cgts4z3b71VRV+W7iS11pGeT13z+Aw/VIh7TrOpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnqZVXHsbYcyCCAWtkM0B9K8pQIfTzLF0F5KerLvUNE=;
 b=cgY4XT/alAhexxPtNaDJQus2G+REwIiw1IlOOVc47BfLlYf8ZroQHRUrzJXbpSQVl5MgerrZ/SSTNKqhUSWnPjzretAuQ3NQpc+BEdp4F+JB6V1SRfmWZ8ZuvNXac9rxzGR24kC/Rf7lT/pIxWr30+YZsB83YxVKxNd3zyW8FY4=
Received: from BYAPR12MB2917.namprd12.prod.outlook.com (2603:10b6:a03:130::14)
 by BYAPR12MB3064.namprd12.prod.outlook.com (2603:10b6:a03:da::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 21 Oct
 2020 19:14:48 +0000
Received: from BYAPR12MB2917.namprd12.prod.outlook.com
 ([fe80::c17e:c3dd:7cda:e2dc]) by BYAPR12MB2917.namprd12.prod.outlook.com
 ([fe80::c17e:c3dd:7cda:e2dc%4]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 19:14:48 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
CC:     Yu Chen <chenyu56@huawei.com>, Felipe Balbi <balbi@kernel.org>,
        Tejas Joglekar <Tejas.Joglekar@synopsys.com>,
        Yang Fei <fei.yang@intel.com>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [RFC][PATCH] usb: dwc3: Add quirk to trigger a GCTL soft reset
 for Hisilicon Kirin Soc Platform
Thread-Topic: [RFC][PATCH] usb: dwc3: Add quirk to trigger a GCTL soft reset
 for Hisilicon Kirin Soc Platform
Thread-Index: AQHWp9aIkJFDKNCGCUiVTQabIh4cmKmibTSA
Date:   Wed, 21 Oct 2020 19:14:48 +0000
Message-ID: <77de4aaa-14a5-6078-bd0b-c4942e97ab36@synopsys.com>
References: <20201021181803.79650-1-john.stultz@linaro.org>
In-Reply-To: <20201021181803.79650-1-john.stultz@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [98.248.94.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e2f2ebc-88cd-4eb0-ed39-08d875f59430
x-ms-traffictypediagnostic: BYAPR12MB3064:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3064E18327D3EF3B2B4703A7AA1C0@BYAPR12MB3064.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v6I2LdCh3t4gTV05vFHBxc1nCz5tepnj1loJfarVkZeIwZa0G8phRiEhl4E5wsUMHi70+rm/B8/1xG5mI/pBDwCEFH+WzTRONZKT5qaZn5cvQ0c4CMgPs7cix8r58ZlCb1qH0SHam9Jr+kE/PjMMpGAw788iZp4abKy+Gq1kIA29Aky80arKSb5T62y1uRF0qiR3gQs2lkAFv/xKfVVGPkxeUGix8ztcem9jYr7A+qqDoO2qGdqdjcUVQOO8SmuGMY+gGJmzlbo1obthdeBClCiApINRr+vAA+HPpSNy9gxVOuP6Aw0qoMFWObqzsAWzeeuWz/+4tMTBTUI8KgLyScFZOf1PMIuvtA1seNL+ZwXC+tAVlNXCNQixaXJjULCu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2917.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(7416002)(31696002)(186003)(83380400001)(71200400001)(4326008)(2616005)(31686004)(8936002)(6486002)(26005)(36756003)(54906003)(6512007)(5660300002)(86362001)(8676002)(110136005)(66476007)(2906002)(66946007)(6506007)(478600001)(64756008)(76116006)(66446008)(66556008)(316002)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: NutFe08r/bMUivGDVeSHgdmAJ7tF5UeX+N3I0pRAEILQHm3vbTgwWzma27R5EszAeGtbIcHc7/Kxz9pNBWbidk4kkOA4RxccNyrmzyVXlHFqtPzOBEXWi1eGkRsDlny2OgtuhK9HYwXUAJvfBpMZIX80WPJ3vGrv9LWfQW6Qwp0AFeAnJrIBPInx6Uq9JAExa7R4dqh60WnALnPfynwZudnlIIU11gXaM1yP2HdoZs66/+yoc/9hxDNCVDVDmuPe7TTzU+iJrj+nNDnn/LbRjrvVFbFDj3ljR5S+tx67LfWqQtQ9XhQI6A0Mv7zGc1UAWMp237I0LoARiiWtzoFPNNc0o7BsxuAxO9eXxO8D55X6tqlK9cPd16Gsk35+DZ3L4xEWF0BJvDGumGJT1TiFN/FmI0jUpT47Gr2eTu7iYdJyi4g92bosnxjxB+iLs+6TbV4q1a5Kc7glVXUrQP1xb+wCQYRUpn2IIZ55043TKXAThh0Yg+YcQjzWrodKtGkJAXpU/4i5ZjQc5NRfpZxnSn7tpFmdokyUW/QHJyhkUvqMcqLM2M6qDMLEGhttn55bW+x+oM68QNjqoi8xsc5WIrFTiT15HmokSvgt9Igb1Q4z27w/wq3V17FV+Xranr/ixdkWNM4SetN4zgyMD0Jc0A==
Content-Type: text/plain; charset="utf-8"
Content-ID: <54B41B6F1F1D4F488ED3958D9B1A2DBB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2917.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2f2ebc-88cd-4eb0-ed39-08d875f59430
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2020 19:14:48.5407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cW17g4rbZnPrVS90XiOGx6GdwaZfq9bXub5raM3LBHZI2Ip/ZfxZqpxVgycE3GxyBS4SAKre03sYaboBy6y4ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3064
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sm9obiBTdHVsdHogd3JvdGU6DQo+IEZyb206IFl1IENoZW4gPGNoZW55dTU2QGh1YXdlaS5jb20+
DQo+DQo+IFdpdGggdGhlIGN1cnJlbnQgZHdjMyBjb2RlIG9uIHRoZSBIaUtleTk2MCB3ZSBvZnRl
biBzZWUgdGhlDQo+IENPUkVJRExFIGZsYWcgZ2V0IHN0dWNrIG9mZiBpbiBfX2R3YzNfZ2FkZ2V0
X3N0YXJ0KCksIHdoaWNoDQo+IHNlZW1zIHRvIHByZXZlbnQgdGhlIHJlc2V0IGlycSBhbmQgY2F1
c2VzIHRoZSBVU0IgZ2FkZ2V0IHRvDQo+IGZhaWwgdG8gaW5pdGlhbGl6ZS4NCj4NCj4gV2UgaGFk
IHNlZW4gb2NjYXNpb25hbCBpbml0aWFsaXphdGlvbiBmYWlsdXJlcyB3aXRoIG9sZGVyDQo+IGtl
cm5lbHMgYnV0IHdpdGggcmVjZW50IDUueCBlcmEga2VybmVscyBpdCBzZWVtZWQgdG8gYmUgYmVj
b21pbmcNCj4gbXVjaCBtb3JlIGNvbW1vbiwgc28gSSBkdWcgYmFjayB0aHJvdWdoIHNvbWUgb2xk
ZXIgdHJlZXMgYW5kDQo+IHJlYWxpemVkIEkgZHJvcHBlZCB0aGlzIHF1aXJrIGZyb20gWXUgQ2hl
biBkdXJpbmcgdXBzdHJlYW1pbmcNCj4gYXMgSSBjb3VsZG4ndCBwcm92aWRlIGEgcHJvcGVyIHJh
dGlvbmFsIGZvciBpdCBhbmQgaXQgZGlkbid0DQo+IHNlZW0gdG8gYmUgbmVjZXNzYXJ5LiBJIG5v
dyByZWFsaXplIEkgd2FzIHdyb25nLg0KPg0KPiBPbiB0aGUgdXBzaWRlLCBJIGNhbiBub3cgdW5k
ZXJzdGFuZCBtb3JlIHdoeSBzdWNoIGEgcXVpcmsgaXMNCj4gbmVlZGVkLg0KDQpUaGlzIHNob3Vs
ZG4ndCBiZSBhIHF1aXJrLiBJdCdzIHBhcnQgb2YgdGhlIHByb2dyYW1taW5nIGd1aWRlIHdoZW4N
CnN3aXRjaGluZyBtb2RlIGluIERSRC4gSSBkb24ndCBrbm93IGhvdyB3ZSBtaXNzZWQgdGhpcy4N
Cg0KPg0KPiBTbyB0byBhZGRyZXNzIGEgcXVpcmsgaW4gdGhlIERlc2lnbldhcmUgVVNCMyBEUkQg
Q29yZSBvZg0KPiBIaXNpbGljb24gS2lyaW4gU29DcywgdGhpcyBwYXRjaCBhZGRzIGEgcXVpcmsg
ZmxhZyB3aGljaA0KPiBleGVjdXRlcyBhIEdDVEwgc29mdCByZXNldCB3aGVuIHdlIHN3aXRjaCBt
b2Rlcy4NCj4NCj4gQ2M6IEZlbGlwZSBCYWxiaSA8YmFsYmlAa2VybmVsLm9yZz4NCj4gQ2M6IFRl
amFzIEpvZ2xla2FyIDx0ZWphcy5qb2dsZWthckBzeW5vcHN5cy5jb20+DQo+IENjOiBZYW5nIEZl
aSA8ZmVpLnlhbmdAaW50ZWwuY29tPg0KPiBDYzogWW9uZ1FpbiBMaXUgPHlvbmdxaW4ubGl1QGxp
bmFyby5vcmc+DQo+IENjOiBBbmRyemVqIFBpZXRyYXNpZXdpY3ogPGFuZHJ6ZWoucEBjb2xsYWJv
cmEuY29tPg0KPiBDYzogVGhpbmggTmd1eWVuIDx0aGluaG5Ac3lub3BzeXMuY29tPg0KPiBDYzog
SnVuIExpIDxsaWp1bi5rZXJuZWxAZ21haWwuY29tPg0KPiBDYzogTWF1cm8gQ2FydmFsaG8gQ2hl
aGFiIDxtY2hlaGFiK2h1YXdlaUBrZXJuZWwub3JnPg0KPiBDYzogUm9iIEhlcnJpbmcgPHJvYmgr
ZHRAa2VybmVsLm9yZz4NCj4gQ2M6IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91
bmRhdGlvbi5vcmc+DQo+IENjOiBsaW51eC11c2JAdmdlci5rZXJuZWwub3JnDQo+IENjOiBkZXZp
Y2V0cmVlQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBZdSBDaGVuIDxjaGVueXU1
NkBodWF3ZWkuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKb2huIFN0dWx0eiA8am9obi5zdHVsdHpA
bGluYXJvLm9yZz4NCj4gLS0tDQo+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvZHdjMy50
eHQgICAgICAgICAgfCAgMyArKysNCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jICAgICAgICAg
ICAgICAgICAgICAgICB8IDE5ICsrKysrKysrKysrKysrKysrKysNCj4gIGRyaXZlcnMvdXNiL2R3
YzMvY29yZS5oICAgICAgICAgICAgICAgICAgICAgICB8ICAxICsNCj4gIDMgZmlsZXMgY2hhbmdl
ZCwgMjMgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3VzYi9kd2MzLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy91c2IvZHdjMy50eHQNCj4gaW5kZXggMWFhZTJiNjE2MGMxLi5mNDM1YmFlMGYxNzIg
MTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvZHdj
My50eHQNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9kd2Mz
LnR4dA0KPiBAQCAtODEsNiArODEsOSBAQCBPcHRpb25hbCBwcm9wZXJ0aWVzOg0KPiAgIC0gc25w
cyxkaXMtc3BsaXQtcXVpcms6IHdoZW4gc2V0LCBjaGFuZ2UgdGhlIHdheSBVUkJzIGFyZSBoYW5k
bGVkIGJ5IHRoZQ0KPiAgCQkJIGRyaXZlci4gTmVlZGVkIHRvIGF2b2lkIC1FUFJPVE8gZXJyb3Jz
IHdpdGggdXNiaGlkDQo+ICAJCQkgb24gc29tZSBkZXZpY2VzIChIaWtleSA5NzApLg0KPiArIC0g
c25wcyxnY3RsLXJlc2V0LXF1aXJrOiBXaGVuIHNldCwgZXhlY3V0ZSBhIHNvZnQgcmVzZXQgb24g
bW9kZSBjaGFuZ2VzLg0KPiArICAgICAgICAgICAgICAgICAgICAgICAgTmVlZGVkIHRvIGF2b2lk
IENPUkVJRExFIGdldHRpbmcgc3R1Y2sgb2ZmIGFuZCB0aGUNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgIGdhZGdldCB0byBmYWlsIHRvIGluaXRpYWxpemUgKEhpS2V5OTYwKS4NCj4gICAtIHNu
cHMsaXMtdXRtaS1sMS1zdXNwZW5kOiB0cnVlIHdoZW4gRFdDMyBhc3NlcnRzIG91dHB1dCBzaWdu
YWwNCj4gIAkJCXV0bWlfbDFfc3VzcGVuZF9uLCBmYWxzZSB3aGVuIGFzc2VydHMgdXRtaV9zbGVl
cF9uDQo+ICAgLSBzbnBzLGhpcmQtdGhyZXNob2xkOiBISVJEIHRocmVzaG9sZA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0K
PiBpbmRleCBiZGYwOTI1ZGE2YjYuLmIxMzhjNjdlMzg5MiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy91c2IvZHdjMy9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gQEAg
LTExNCw2ICsxMTQsMTkgQEAgdm9pZCBkd2MzX3NldF9wcnRjYXAoc3RydWN0IGR3YzMgKmR3Yywg
dTMyIG1vZGUpDQo+ICAJZHdjLT5jdXJyZW50X2RyX3JvbGUgPSBtb2RlOw0KPiAgfQ0KPiAgDQo+
ICtzdGF0aWMgdm9pZCBkd2MzX2djdGxfY29yZV9zb2Z0X3Jlc2V0KHN0cnVjdCBkd2MzICpkd2Mp
DQo+ICt7DQo+ICsJaW50IHJlZzsNCj4gKw0KPiArCXJlZyA9IGR3YzNfcmVhZGwoZHdjLT5yZWdz
LCBEV0MzX0dDVEwpOw0KPiArCXJlZyB8PSAoRFdDM19HQ1RMX0NPUkVTT0ZUUkVTRVQpOw0KPiAr
CWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19HQ1RMLCByZWcpOw0KPiArDQo+ICsJcmVnID0g
ZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNfR0NUTCk7DQo+ICsJcmVnICY9IH4oRFdDM19HQ1RM
X0NPUkVTT0ZUUkVTRVQpOw0KPiArCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19HQ1RMLCBy
ZWcpOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMgdm9pZCBfX2R3YzNfc2V0X21vZGUoc3RydWN0IHdv
cmtfc3RydWN0ICp3b3JrKQ0KPiAgew0KPiAgCXN0cnVjdCBkd2MzICpkd2MgPSB3b3JrX3RvX2R3
Yyh3b3JrKTsNCj4gQEAgLTE3OCw2ICsxOTEsMTAgQEAgc3RhdGljIHZvaWQgX19kd2MzX3NldF9t
b2RlKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykNCj4gIAkJfQ0KPiAgCQlicmVhazsNCj4gIAlj
YXNlIERXQzNfR0NUTF9QUlRDQVBfREVWSUNFOg0KPiArCQkvKiBFeGVjdXRlIGEgR0NUTCBDb3Jl
IFNvZnQgUmVzZXQgd2hlbiBzd2l0Y2ggbW9kZSAqLw0KPiArCQlpZiAoZHdjLT5nY3RsX3Jlc2V0
X3F1aXJrKQ0KPiArCQkJZHdjM19nY3RsX2NvcmVfc29mdF9yZXNldChkd2MpOw0KPiArDQoNClRo
aXMgc2hvdWxkIGJlIGRvbmUgYmVmb3JlIGR3YzNfc2V0X3BydGNhcCgpLCBhbmQgdGhpcyBhcHBs
aWVzIHdoZW4NCnN3aXRjaGluZyBmcm9tIGRldmljZSB0byBob3N0IG1vZGUgYWxzby4gTWFrZSBz
dXJlIHRvIGNoZWNrIGlmIHRoZQ0KY29udHJvbGxlciBpcyBEUkQgYmVmb3JlIGRvaW5nIHRoaXMu
DQoNCj4gIAkJZHdjM19ldmVudF9idWZmZXJzX3NldHVwKGR3Yyk7DQo+ICANCj4gIAkJaWYgKGR3
Yy0+dXNiMl9waHkpDQo+IEBAIC0xMzU3LDYgKzEzNzQsOCBAQCBzdGF0aWMgdm9pZCBkd2MzX2dl
dF9wcm9wZXJ0aWVzKHN0cnVjdCBkd2MzICpkd2MpDQo+ICANCj4gIAlkd2MtPmRpc19zcGxpdF9x
dWlyayA9IGRldmljZV9wcm9wZXJ0eV9yZWFkX2Jvb2woZGV2LA0KPiAgCQkJCSJzbnBzLGRpcy1z
cGxpdC1xdWlyayIpOw0KPiArCWR3Yy0+Z2N0bF9yZXNldF9xdWlyayA9IGRldmljZV9wcm9wZXJ0
eV9yZWFkX2Jvb2woZGV2LA0KPiArCQkJCSJzbnBzLGdjdGwtcmVzZXQtcXVpcmsiKTsNCj4gIA0K
PiAgCWR3Yy0+bHBtX255ZXRfdGhyZXNob2xkID0gbHBtX255ZXRfdGhyZXNob2xkOw0KPiAgCWR3
Yy0+dHhfZGVfZW1waGFzaXMgPSB0eF9kZV9lbXBoYXNpczsNCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdXNiL2R3YzMvY29yZS5oIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gaW5kZXggNzQz
MjNiMTBhNjRhLi45OTNmMjQzYWVkYzggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMv
Y29yZS5oDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+IEBAIC0xMjUyLDYgKzEy
NTIsNyBAQCBzdHJ1Y3QgZHdjMyB7DQo+ICAJdW5zaWduZWQJCWRpc19tZXRhc3RhYmlsaXR5X3F1
aXJrOjE7DQo+ICANCj4gIAl1bnNpZ25lZAkJZGlzX3NwbGl0X3F1aXJrOjE7DQo+ICsJdW5zaWdu
ZWQJCWdjdGxfcmVzZXRfcXVpcms6MTsNCj4gIA0KPiAgCXUxNgkJCWltb2RfaW50ZXJ2YWw7DQo+
ICB9Ow0KDQpCUiwNClRoaW5oDQo=
