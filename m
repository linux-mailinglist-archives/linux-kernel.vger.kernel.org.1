Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C1027FBDB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 10:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731662AbgJAItG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 04:49:06 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:3446 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731618AbgJAItE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 04:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601542143; x=1633078143;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eDcd/aavWd+1Gl/qsYt4xpv47esqlEh6owhOzkIV+3E=;
  b=TlRmngErBBQ1QO7Hkt1C2iXUzVGFgJr5ysh/nwecTzZXj/8g03j+dAgY
   oqHS/FlHcAXxSMARi7wE5pVjA9+DeNtJB5YzDBAR1w/B7GVNGD8tRJKrW
   6dIvyx+Pxd8QDCwrbzUPchUC/gfRkPKv2mDnofHaKhNQEBLVDI1SUcQJO
   VJ5AejtCOmvt7VEUGJ4MPdiq8lNy/TyK4qUBV+QVLnn/0XKhCN1GZN7hL
   Ci6PweAChxoUMk+IBoqWnUjkAUvVG7uP4+W9Yx0Z0eafsk0XrqyHfuT/9
   6CGPO00oj7k1IcYn6uBugt5c3svoW/JdXVY6wCEDeSZ1ZJOivCEFMsxMh
   w==;
IronPort-SDR: 7Rm+MaAfkLLQWLlRvRmCPAgKvXWO5kZ7lnGyYk9jpm6Qe3kjRP90AhlIVBiSNi/DyoCtXpH+c8
 vrahKZXbKHoT9ZcXqjHJDSF/Ms9XWoePQHexa1eeV6g9CQTDXiy3ZE40uzJ+uD4nJrQrxhGNkC
 kROeNWOeXDE6Gs+BwyBp8b/83ci6Fm3WpMEVEzm5Es8sQjkNsyHqSjFOPGWvz9WG07uMc8vZ04
 TURECwWVDh/BPz2DWgjOFagdZWNkravXKJcJb4S+L/DnoQTx0URc+bes2ZAdCCto7hyWaoPVw3
 dFU=
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="93045611"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Oct 2020 01:49:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 1 Oct 2020 01:49:02 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Thu, 1 Oct 2020 01:49:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9F+uzB0HKFjzXLnRRK3RFC/v4gIjXqBci8f6r6QBeNwBl0wMMzbRMFc1htlTfaQCem77oIzmrPz7KwPIe9W/vOkBnzd7UtCBjd/EQeTNy/mKXHblAy7e2/Rd3sk5I1g3dErQ7XXGD08yiaqteuw2iy1uv75Vi9VZhEWLN/hM9ajsGvY+j051pnNWlUiSNPiKyr3gwAatUBKAyj0FHTJMjfO2aKLk8bLsCgw3uqkPA8BRnyeWu9tNMafisPas/YiiiFWUgPBWNmGKoKCfz0JaMYRPNX2b/UyQ8pb/AoTrce6CuLz1nKaSl5AzdqiOSU/To4SfMWHIbXZ9pBpCuKIJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDcd/aavWd+1Gl/qsYt4xpv47esqlEh6owhOzkIV+3E=;
 b=NZRWQwuJ5Dx5NVS+3jz/6j3cXk+7vZpT0wNkhn5y3nEzOd91meGIkjraU+CjyIo+hxd9Bm5GI8pt9BtifVVk+ieE8yc7cnxUy36I08iHesMcTKCYE2l3L7Thlw+NI00OxD49DKie+qv8h87q1nyoiYAJLJyQ6xMHlq8hkE4J0AWMcamMpGzE+T2MnjVJZMI+NPgagNV+FKtB+ekUul1Qv7xSqvfTweybq1dQiEVMnBQT786vRFt7DCUaGalailKJRyyWCFh20lGP93PcnM+Aw5DruIQwJJ8DS+jrrpnVB9o1K7hg6kdnE/sEdGfP6ySqR/46JNVJu3nqq0VV44KLIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDcd/aavWd+1Gl/qsYt4xpv47esqlEh6owhOzkIV+3E=;
 b=RGpqoUqSStq38uzX9uD+hlASx6DhAAC+tzkAggmSuyfTuOOidrUGuq1Ky4LhxI4zz0uZcXRCHwNDiheCYOyAh5cQCgzSSzBFbWegVpPblA16q10jDrJMofTBAN6Jj1RB71i3DQxaVuznLVz5IgvLS3lKziqzqYyr294R855jb84=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (2603:10b6:3:112::12)
 by DM5PR1101MB2154.namprd11.prod.outlook.com (2603:10b6:4:4e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Thu, 1 Oct
 2020 08:49:01 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a%4]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 08:49:01 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v14 03/15] mtd: spi-nor: add support for DTR protocol
Thread-Topic: [PATCH v14 03/15] mtd: spi-nor: add support for DTR protocol
Thread-Index: AQHWl8b18X9JWcT5zkKq1MM32MT8Tg==
Date:   Thu, 1 Oct 2020 08:49:01 +0000
Message-ID: <2a34630d-1159-e678-1596-035328f412aa@microchip.com>
References: <20200930185732.6201-1-p.yadav@ti.com>
 <20200930185732.6201-4-p.yadav@ti.com>
 <67f14906-ef28-ff4c-b41f-3500c9212ad7@microchip.com>
 <20201001083737.iacunfb7l75elvex@ti.com>
In-Reply-To: <20201001083737.iacunfb7l75elvex@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [5.13.51.157]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9472962-2711-46c1-27b5-08d865e6d83b
x-ms-traffictypediagnostic: DM5PR1101MB2154:
x-microsoft-antispam-prvs: <DM5PR1101MB215451FFBE23BDD52CFAE2C2F0300@DM5PR1101MB2154.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WbLf0iIVayaA0Ve6jc3PgEXrHn43WjbW2pDnmbn5XPD0RfRB9fpObQBjhrHM5Lv7RlKYxKnW4jB156KYqRaKCbVUEe2NvLLdvjpRUfObu9IisltqHT5aRNceXzCSkcVOBJvaxcpJOfugr1h/sFlyG6Jf0VAjgBTKxECYL5fnTqES29W2OK/MPDQ+kLz4vWSMKv70Nwl66fpXbZxNay/URPzMArauyX8vsqzbMx+2E7ylhbd6nHuM9vtoRGMvzOdL0uS8vereOo3Ymbe6kznN3lOY8H33/HzqTs/FJjRwoIDjqUkaUrmCxBScAycvj2qZi7ZFYajTymRwH8Rb+duRD1MCnkAd2VPnhFQKuDVQbNm8WSZeR0zvFEytcfIsl8CyKYjCS7rVmVjLgBep9sU8gslxFV4URlc977BOMW9oQlQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(39860400002)(136003)(396003)(4326008)(54906003)(76116006)(66476007)(64756008)(478600001)(316002)(71200400001)(91956017)(66556008)(66446008)(2906002)(186003)(86362001)(66946007)(6916009)(26005)(36756003)(2616005)(31696002)(53546011)(5660300002)(8936002)(6486002)(8676002)(6506007)(31686004)(6512007)(43740500002)(352734003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 509z1soEmZeTjqfQxCSzF0xLGZk6GyFqbow2CvnV+HcbEkXN/mw2PbPO39fWTfV3bW4NVTCli431WzwPvMKYTlBW1gkKz4BoWVKNgXf7I0ZoiFbiB4E0B4OocVZra5FPvKz4fTl1yJHV/zeWuwciI5+NyHdM64bDsMSf6p9frcNLi0YW97YHIzc2h2VboM9i79JlHSFwARYILQ91/1fyWlIDIoqFK9uxlncvVUEP3Q44IQnB6iDVnJlGO/EtAUuHtKs8Wn4xfDPwpx7Aw+XQ0zQk8C0gDYfWPKruyLV3ytD5CtwQgdaqGF1RLnaifTa/aFG+0grip2eY8w295xg7S0BjuMSWJ/nDi+x4ErRltjo9uH7WoJGnALj06H8MxzaSCyND9Dk6phs/awXH4apxotwn6StzAtirRqBD88hUUNtmsVHSccUIGXfXDg3Cd2n/h5z9P05upoa5mF27P/revwVUwvDLIxXNgwJs+R5nG/Rp9EyWkETX+EASk/jSIbseX6n1azK/9jJNlyb3B8CwFn0XH00INawfD/fAOMrts5uBszEpR3ofFW4VKJKxhIEdfWYg5dazxG0gCWSUkgAMe7+tN38NPYnAz+N+WlxZHBl2LJ7Ipzqjlt8Go5iSoiM6wPIrgz303bNerRfXk4Bjyg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B21B636603C92459ECA51454C15DD1F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9472962-2711-46c1-27b5-08d865e6d83b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 08:49:01.6954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lvt/C0uXFqN2Opi99/kA1ImkM0SIWtR1I+7puZS80nDZowYDzsYpPmi1UQWpJSezXV3F5BrGd8xe08vat8fXaGwfj5G/j++MR8NmG0NxU70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2154
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMS8yMCAxMTozNyBBTSwgUHJhdHl1c2ggWWFkYXYgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMDEvMTAvMjAgMDc6NDZBTSwgVHVkb3Iu
QW1iYXJ1c0BtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gT24gOS8zMC8yMCA5OjU3IFBNLCBQcmF0
eXVzaCBZYWRhdiB3cm90ZToNCj4+PiBAQCAtMjM4NywxMiArMjQ5NiwxNiBAQCBzcGlfbm9yX3Nw
aW1lbV9hZGp1c3RfaHdjYXBzKHN0cnVjdCBzcGlfbm9yDQo+Pj4gKm5vciwgdTMyICpod2NhcHMp
DQo+Pj4gICAgICAgICBzdHJ1Y3Qgc3BpX25vcl9mbGFzaF9wYXJhbWV0ZXIgKnBhcmFtcyA9IG5v
ci0+cGFyYW1zOw0KPj4+ICAgICAgICAgdW5zaWduZWQgaW50IGNhcDsNCj4+Pg0KPj4+IC0gICAg
ICAgLyogRFRSIG1vZGVzIGFyZSBub3Qgc3VwcG9ydGVkIHlldCwgbWFzayB0aGVtIGFsbC4gKi8N
Cj4+PiAtICAgICAgICpod2NhcHMgJj0gflNOT1JfSFdDQVBTX0RUUjsNCj4+PiAtDQo+Pj4gICAg
ICAgICAvKiBYLVgtWCBtb2RlcyBhcmUgbm90IHN1cHBvcnRlZCB5ZXQsIG1hc2sgdGhlbSBhbGwu
ICovDQo+Pj4gICAgICAgICAqaHdjYXBzICY9IH5TTk9SX0hXQ0FQU19YX1hfWDsNCj4+Pg0KPj4+
ICsgICAgICAgLyoNCj4+PiArICAgICAgICAqIElmIHRoZSByZXNldCBsaW5lIGlzIGJyb2tlbiwg
d2UgZG8gbm90IHdhbnQgdG8gZW50ZXIgYSBzdGF0ZWZ1bA0KPj4+ICsgICAgICAgICogbW9kZS4N
Cj4+PiArICAgICAgICAqLw0KPj4+ICsgICAgICAgaWYgKG5vci0+ZmxhZ3MgJiBTTk9SX0ZfQlJP
S0VOX1JFU0VUKQ0KPj4+ICsgICAgICAgICAgICAgICAqaHdjYXBzICY9IH4oU05PUl9IV0NBUFNf
WF9YX1ggfCBTTk9SX0hXQ0FQU19YX1hfWF9EVFIpOw0KPj4NCj4+IFNOT1JfSFdDQVBTX1hfWF9Y
IGlzIGFscmVhZHkgbWFza2VkIG91dCBhYm92ZS4gRG8gd2UgbmVlZCB0byBkbyBpdCBhZ2Fpbj8N
Cj4gDQo+IFRoYXQgbWlnaHQgY2hhbmdlIGxhdGVyIGFuZCB0aGUgcGVyc29uIHJlbW92aW5nIHRo
YXQgbGluZSBtaWdodCBub3QNCj4gcmVtZW1iZXIgb3IgZXZlbiBrbm93IHRvIGFkZCBpdCBiYWNr
IGhlcmUuDQoNCm9rDQo=
