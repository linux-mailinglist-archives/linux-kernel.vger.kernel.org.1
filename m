Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA0F28013D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 16:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732552AbgJAOZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 10:25:49 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:19554 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732099AbgJAOZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 10:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601562350; x=1633098350;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cYcEymMfZwjrmZu0S1RNxbeTkh1eoTfaW1Wix03jS+U=;
  b=h15AZmlMvz5r7O1Z+LlhGaCPt1AjVmVHfGybb1J19ecC9+wQJG72Q8G9
   j0ZX7dGurDYlfouIONT05WBmbr2oq0VxyMo8oS63Ji4q57gpOPHt0KjY1
   i+KbU4R1l0upo0Nu5wKhIVUAMoRp1zI+4WC5MxKGGpUA5YEZneNqCshcR
   ZUtqpvNellYyqTtonXTWa0zKJv6HbU0qDdVRBN8LAZPraohsVvzboXOl4
   0nQ8/rzEajLL9IJtqLIOKuN1Ke5zPbX7b8BKvhFibrEMPv6TKwmdwSXH6
   hxUeHcv+GJAOqUATTSCdrVqg8IS6jUY7qXzmkAD2nxuIPGW355oN0yA39
   Q==;
IronPort-SDR: t8GzAMJyKkP7/CxeiixPXcgQkeKDhMP956o5mYkWy+FzhedDij2fL4TCfewvwU+oYtVsNZoc3E
 j8ZwBLYcMO0wuYa2GTcLEsDHFekUUAoqSThwYtY4lJbpaAuTHpWeWeiTzIc7RcbSS6nsgEIxkZ
 wRW8UiX4vmbsighe6adlMHt6mpb1WDsCCI4DPqzC/iMm7BW0ajANvY+Tu5SSh5fT76kUcchjBH
 W3YME8adeorml7OS6XU+ko9ZmekPjT/1TcDbiKYzMC8TIaWiIo2+psGGsTaDVHtPDde/GcjaVv
 +Is=
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="93083902"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Oct 2020 07:25:49 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 1 Oct 2020 07:25:21 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Thu, 1 Oct 2020 07:25:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSGfjzuOcjy2o9ph9xMdK6bYe4ljpVy3723XqvoWXQzCcL5TCYKBB9rv9ooaMJEriGTgFR4wWSmu1ZooDoT5OBZ26dxAHZwzl5VWlxYRWIAzfW9/PMF/cwQHT2laQdYJmebSQizIUjByuQ1pB+4aLkdqxOx4Q8RYBzxhcq9Ka9oRQ4BQhFBLm/6aAgvMmQA/fWcGP22JxGHSv89NPXrWNJhGdEo0tCSFnhKcchmF+lsrR2wgFvNMKTsf3Vw3Cj1vfnp4T5YvEOP5G5LYnzXdK5AoLzQxBQfyxxhmjeUx7g8l6Lk3Egu1FDkjAeZmyfoyP0ZB28fGMa3D96LR5GLiuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYcEymMfZwjrmZu0S1RNxbeTkh1eoTfaW1Wix03jS+U=;
 b=URd2B+3qo1wyjXRrNe/KZ7XdfiMFS2kRVivIDCMsi+IO9HwoVHJgh8o0RhcBccjefhV4DaehwnmKLzPkPa1T+4v48dOwQ+Hba/TWcDaK9lXOy2yp1jCZTquRkbiLnF0tlRUuwQ6mpT7G1M6tzh4+k+rDwE5IWY3B28SKojbUo7cqnDUmsQW4HBoyzDn/8T/4lsgROxmUrj28bLT4fyETSQ8o44mXrOwe11CcnRkJsQSVO0m6jWKo0+kWHwO8kt+duxdLzNpnrLi1ZqVsuMQz4vcTotWoSPZcPMFGpyDEulTtkho1fK3eal/fwzwJIoa6lw9zE6b60paNOsRfRaIE5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYcEymMfZwjrmZu0S1RNxbeTkh1eoTfaW1Wix03jS+U=;
 b=QTqLd5nBYbrSy/Cd75jATJjAcHqpSTM+hzFRpOSMIWiI9bmvRV8DtPlWKfb1GGi3DhYepUUfGd0v5mqrFTffD1PHxsM6GUTdQhMguXhrjnQIxHtnqk6r8nWkd+H4neQajPj8dqfzIiVJvEiskGI2oc6vMrrS1Oyz7MkZYFAvSC8=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (2603:10b6:3:112::12)
 by DM5PR11MB1772.namprd11.prod.outlook.com (2603:10b6:3:112::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Thu, 1 Oct
 2020 14:25:43 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a%4]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 14:25:43 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>
Subject: Re: [RFC PATCH 1/2] mtd: spi-nor: atmel: remove global
 SNOR_F_HAS_LOCK
Thread-Topic: [RFC PATCH 1/2] mtd: spi-nor: atmel: remove global
 SNOR_F_HAS_LOCK
Thread-Index: AQHWl/wfolQmpEhmZUmGKx8TlQY45g==
Date:   Thu, 1 Oct 2020 14:25:43 +0000
Message-ID: <137692b0-ab6d-b9be-17c2-68e3b3146076@microchip.com>
References: <20201001122828.23186-1-michael@walle.cc>
 <5eb8f95c-e9d5-6043-fb7d-bffcda044262@microchip.com>
 <871da0d058ba89320615098ee26150b3@walle.cc>
In-Reply-To: <871da0d058ba89320615098ee26150b3@walle.cc>
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
x-ms-office365-filtering-correlation-id: eca62cdc-33f6-4011-10ba-08d86615e15f
x-ms-traffictypediagnostic: DM5PR11MB1772:
x-microsoft-antispam-prvs: <DM5PR11MB177276F7D5C0D74414787196F0300@DM5PR11MB1772.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jXX5ImIK00UrziI5YFQPAJQ/X3SEFZ19gXGArRgGGU2qCMXxC+F7O5HsABoKxi27SPvBweIn72QOsZS6X2+S/isZl+ueikgBWzXFjdqlVE/rKphiRqvJLNV7MhmpZMT5UPWVrlB9igQBYC2Te0TFEmbGWymp8omvD7tgFubiSNTLz56XSLZFtp8PWYr6B1HsWXtD/i5X+6Rm8HkxqzM0SwdRf+UDPPt8CCV7tE540D5dOazmF6v6vVikF1JbPVePZoDFkHAP7Qo8VcBIecKrfXKz558TUbFNl3mGyn4KBMaIwoM4muM8+4xwyDHY/fg8LuqF8yEfxsiRrmc1ECldC/0TkPZZOBQx+Y+ZsWgw3pBsxm0Yt0RgOD+uEiyiK6JtRtfO2Yh4f3gE/nlYDFWzuNQDIcO3e6ncIV3D1smLvW20WZaKvFnVfGsf14jKfLoI1Mr3wGY4Mr6/0i7yA5t2l0gjXuA6CA/T4hA4FjfFFsml57aCChri4b/FiNKQi9Fc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(396003)(39860400002)(136003)(54906003)(71200400001)(66476007)(316002)(86362001)(64756008)(478600001)(66556008)(91956017)(66446008)(186003)(66946007)(76116006)(2906002)(6916009)(5660300002)(83080400001)(26005)(6486002)(2616005)(8676002)(83380400001)(8936002)(31696002)(6506007)(36756003)(31686004)(53546011)(966005)(6512007)(4326008)(43740500002)(15398625002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: gwBCjqeskqOBHPkWht/y2w1ERwdC5Zs5JW/fUCLUAVslIDVW70b09rjECZLfUPEXx+FFkOb16IyHUOnQBxt8k7/2lXqCOo5a6C7KihCwrVsHH5C8l6PDfZ8/WLSwprHh0ztcjUgmOQ5OMw/IzxcsP5rwqxgwIGHD/yylFRD2Y/cIeXehYq/O/vm4QadcMy0c/6qmUwmM6Z2idjmEuGMAGHW9Q/tfG2QcbVN6uhJneY46LIhzDsaF+OcDDE+kWF2wXqS+uGPX4nZbNQ69lAGjbDyQH6q+e68ke+avIEzjTpgsakwsbfkDMBHY42LwB/bwSrOWki2/Q53lvsTIIl7cgdZY8uGjaOm1yh4t12VFsDnxoG2rwLSymmQA5KlAvMotvyonsLohkX46QT9ArDgvRCVW5mdYk7vZCzXsDvyoC3wD3qggfY7VLTD7f+ZLA1bH/0n9AJ1xJK7jdmswzp0nvf7yNdqTfgvbremphH1qLbCHYIDeqdAyry5H/PXNuJ6ubVyMipaLzReXJGsNtq78s3eszkfhvkr0wD0dJIMSZJwCHAxfevrmA8ipyDnr+XSaYXGeZET6WSrbN+Zzhy2MzbxDjcgZd16Qr8baXwH1Awivydo4O2eP/R2e9k8ZJh1qvRPGT5ufCH70pI3G/TW86Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C62AFE34A66E74394C974DE983FE199@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eca62cdc-33f6-4011-10ba-08d86615e15f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 14:25:43.3125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: syS4qQ2ikMglW8W2m+WZUTe+nzeN6KWkdog+usci8haZU11tFazfgJoy2+zNHNlPzL++SAb+VNtU6QvG7pkVLwnyMc6hZ/5vyF7rl9yzPC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1772
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMS8yMCA1OjEyIFBNLCBNaWNoYWVsIFdhbGxlIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEFtIDIwMjAtMTAtMDEgMTY6MDYsIHNjaHJpZWIg
VHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tOg0KPj4gT24gMTAvMS8yMCAzOjI4IFBNLCBNaWNo
YWVsIFdhbGxlIHdyb3RlOg0KPj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mg
b3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cNCj4+PiB0aGUgY29udGVudCBpcyBz
YWZlDQo+Pj4NCj4+PiBUaGlzIGlzIGNvbnNpZGVyZWQgYmFkIGZvciB0aGUgZm9sbG93aW5nIHJl
YXNvbnM6DQo+Pj4gwqAoMSkgV2Ugb25seSBzdXBwb3J0IHRoZSBibG9jayBwcm90ZWN0aW9uIHdp
dGggQlBuIGJpdHMgZm9yIHdyaXRlDQo+Pj4gwqDCoMKgwqAgcHJvdGVjdGlvbi4gTm90IGFsbCBB
dG1lbCBwYXJ0cyBzdXBwb3J0IHRoaXMuDQo+Pj4gwqAoMikgTmV3bHkgYWRkZWQgZmxhc2ggY2hp
cCB3aWxsIGF1dG9tYXRpY2FsbHkgaW5oZXJpdCB0aGUgImhhcw0KPj4+IMKgwqDCoMKgIGxvY2tp
bmciIHN1cHBvcnQgYW5kIHRodXMgbmVlZHMgdG8gZXhwbGljaXRseSB0ZXN0ZWQuIEJldHRlcg0K
Pj4+IMKgwqDCoMKgIGJlIG9wdC1pbiBpbnN0ZWFkIG9mIG9wdC1vdXQuDQo+Pj4gwqAoMykgVGhl
cmUgYXJlIGFscmVhZHkgc3VwcG9ydGVkIGZsYXNoZXMgd2hpY2ggZG9uJ3Qgc3VwcG9ydCB0aGUN
Cj4+PiBsb2NraW5nDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoCBzY2hlbWUuIFNvIEkgYXNzdW1lIHRo
aXMgd2Fzbid0IHByb3Blcmx5IHRlc3RlZCBiZWZvcmUgYWRkaW5nDQo+Pj4gdGhhdA0KPj4+IMKg
wqDCoMKgwqDCoMKgwqAgY2hpcDsgd2hpY2ggZW5mb3JjZXMgbXkgcHJldmlvdXMgYXJndW1lbnQg
dGhhdCBsb2NraW5nDQo+Pj4gc3VwcG9ydCBzaG91bGQNCj4+PiDCoMKgwqDCoMKgwqDCoMKgIGJl
IGFuIG9wdC1pbi4NCj4+Pg0KPj4+IFJlbW92ZSB0aGUgZ2xvYmFsIGZsYWcgYW5kIGFkZCBpbmRp
dmlkdWFsIGZsYWdzIHRvIGFsbCBmbGFzaGVzDQo+Pj4gd2hpY2ggc3VwcG9ydHMgQlAgbG9ja2lu
Zy4gSW4gcGFydGljdWxhciB0aGUgZm9sbG93aW5nIGZsYXNoZXMNCj4+PiBkb24ndCBzdXBwb3J0
IHRoZSBCUCBzY2hlbWU6DQo+Pj4gwqAtIEFUMjZGMDA0DQo+Pj4gwqAtIEFUMjVTTDMyMQ0KPj4+
IMKgLSBBVDQ1REIwODFEDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFdhbGxlIDxt
aWNoYWVsQHdhbGxlLmNjPg0KPj4+IC0tLQ0KPj4+IMKgZHJpdmVycy9tdGQvc3BpLW5vci9hdG1l
bC5jIHwgMjggKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4+IMKgMSBmaWxlIGNoYW5n
ZWQsIDkgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9tdGQvc3BpLW5vci9hdG1lbC5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9hdG1l
bC5jDQo+Pj4gaW5kZXggM2Y1ZjIxYTQ3M2E2Li40OWQzOTJjNmM4YmMgMTAwNjQ0DQo+Pj4gLS0t
IGEvZHJpdmVycy9tdGQvc3BpLW5vci9hdG1lbC5jDQo+Pj4gKysrIGIvZHJpdmVycy9tdGQvc3Bp
LW5vci9hdG1lbC5jDQo+Pj4gQEAgLTEwLDM3ICsxMCwyNyBAQA0KPj4+DQo+Pj4gwqBzdGF0aWMg
Y29uc3Qgc3RydWN0IGZsYXNoX2luZm8gYXRtZWxfcGFydHNbXSA9IHsNCj4+PiDCoMKgwqDCoMKg
wqDCoCAvKiBBdG1lbCAtLSBzb21lIGFyZSAoY29uZnVzaW5nbHkpIG1hcmtldGVkIGFzICJEYXRh
Rmxhc2giICovDQo+Pj4gLcKgwqDCoMKgwqDCoCB7ICJhdDI1ZnMwMTAiLMKgIElORk8oMHgxZjY2
MDEsIDAsIDMyICogMTAyNCzCoMKgIDQsIFNFQ1RfNEspIH0sDQo+Pj4gLcKgwqDCoMKgwqDCoCB7
ICJhdDI1ZnMwNDAiLMKgIElORk8oMHgxZjY2MDQsIDAsIDY0ICogMTAyNCzCoMKgIDgsIFNFQ1Rf
NEspIH0sDQo+Pj4gK8KgwqDCoMKgwqDCoCB7ICJhdDI1ZnMwMTAiLMKgIElORk8oMHgxZjY2MDEs
IDAsIDMyICogMTAyNCzCoMKgIDQsIFNFQ1RfNEsgfA0KPj4+IFNQSV9OT1JfSEFTX0xPQ0spIH0s
DQo+Pj4gK8KgwqDCoMKgwqDCoCB7ICJhdDI1ZnMwNDAiLMKgIElORk8oMHgxZjY2MDQsIDAsIDY0
ICogMTAyNCzCoMKgIDgsIFNFQ1RfNEsgfA0KPj4+IFNQSV9OT1JfSEFTX0xPQ0spIH0sDQo+Pg0K
Pj4gYWZ0ZXIgYSBxdWljayBsb29rIGluIHRoZSBkYXRhc2hlZXRzIG9mIHRoZXNlIGZsYXNoZXMs
IEkgc3VzcGVjdCB0aGF0DQo+PiB3aGF0IHdlIGhhdmUgbm93IGluIHRoZSBTUEkgTk9SIGNvcmUg
Zm9yIFNSIGxvY2tpbmcgZG9lcyBub3Qgd29yayBmb3INCj4+IHRoZW0uIFRoZXkgcHJvYmFibHkg
c3VwcG9ydGVkIGp1c3QgInVubG9jayBhbGwiLCBjbGVhcmluZyBhbGwgdGhlDQo+PiBCUCBiaXRz
LiBBbnl3YXksIGRpZmZlcmVudCBwcm9ibGVtLg0KPj4+DQo+Pj4gLcKgwqDCoMKgwqDCoCB7ICJh
dDI1ZGYwNDFhIiwgSU5GTygweDFmNDQwMSwgMCwgNjQgKiAxMDI0LMKgwqAgOCwgU0VDVF80Sykg
fSwNCj4+PiAtwqDCoMKgwqDCoMKgIHsgImF0MjVkZjMyMSIswqAgSU5GTygweDFmNDcwMCwgMCwg
NjQgKiAxMDI0LMKgIDY0LCBTRUNUXzRLKSB9LA0KPj4+IC3CoMKgwqDCoMKgwqAgeyAiYXQyNWRm
MzIxYSIsIElORk8oMHgxZjQ3MDEsIDAsIDY0ICogMTAyNCzCoCA2NCwgU0VDVF80SykgfSwNCj4+
PiAtwqDCoMKgwqDCoMKgIHsgImF0MjVkZjY0MSIswqAgSU5GTygweDFmNDgwMCwgMCwgNjQgKiAx
MDI0LCAxMjgsIFNFQ1RfNEspIH0sDQo+Pj4gK8KgwqDCoMKgwqDCoCB7ICJhdDI1ZGYwNDFhIiwg
SU5GTygweDFmNDQwMSwgMCwgNjQgKiAxMDI0LMKgwqAgOCwgU0VDVF80SyB8DQo+Pj4gU1BJX05P
Ul9IQVNfTE9DSykgfSwNCj4+DQo+PiB0aGlzIG9uZSBkb2VzIG5vdCBzdXBwb3J0IEJQIGxvY2tp
bmc6DQo+PiBodHRwczovL3d3dy5hZGVzdG90ZWNoLmNvbS93cC1jb250ZW50L3VwbG9hZHMvZG9j
MzY2OC5wZGYNCj4+DQo+Pj4gK8KgwqDCoMKgwqDCoCB7ICJhdDI1ZGYzMjEiLMKgIElORk8oMHgx
ZjQ3MDAsIDAsIDY0ICogMTAyNCzCoCA2NCwgU0VDVF80SyB8DQo+Pj4gU1BJX05PUl9IQVNfTE9D
SykgfSwNCj4+DQo+PiBuZWl0aGVyIHRoaXMgb25lOg0KPj4gaHR0cHM6Ly9kYXRhc2hlZXQub2N0
b3BhcnQuY29tL0FUMjVERjMyMS1TM1UtQXRtZWwtZGF0YXNoZWV0LTg3MDA4OTYucGRmDQo+Pg0K
Pj4+ICvCoMKgwqDCoMKgwqAgeyAiYXQyNWRmMzIxYSIsIElORk8oMHgxZjQ3MDEsIDAsIDY0ICog
MTAyNCzCoCA2NCwgU0VDVF80SyB8DQo+Pj4gU1BJX05PUl9IQVNfTE9DSykgfSwNCj4+DQo+PiBu
b3IgdGhpcyBvbmU6IGh0dHBzOi8vd3d3LmFkZXN0b3RlY2guY29tL3dwLWNvbnRlbnQvdXBsb2Fk
cy9kb2MzNjg2LnBkZg0KPj4NCj4+PiArwqDCoMKgwqDCoMKgIHsgImF0MjVkZjY0MSIswqAgSU5G
TygweDFmNDgwMCwgMCwgNjQgKiAxMDI0LCAxMjgsIFNFQ1RfNEsgfA0KPj4+IFNQSV9OT1JfSEFT
X0xPQ0spIH0sDQo+Pg0KPj4gbm9yIHRoaXMgb25lOiBodHRwczovL3d3dy5hZGVzdG90ZWNoLmNv
bS93cC1jb250ZW50L3VwbG9hZHMvZG9jMzY4MC5wZGYNCj4+DQo+PiBJIHN0b3AgaGVyZS4NCj4g
DQo+IFRoZXNlIGFyZSBhbGwgdGhlIG9uZXMgd2hpY2ggdXNlIHRoZSBnbG9iYWwgdW5sb2NrLiBJ
IGNhbm5vdCBqdXN0IHNraXANCj4gdGhlIEhBU19MT0NLIGJpdCBoZXJlLCBiZWNhdXNlIG90aGVy
d2lzZSB0aGlzIHBhdGNoIHdvdWxkbid0IGJlDQo+IGJhY2t3YXJkcw0KPiBjb21wYXRpYmUuIFll
cyBJIG1pc3NlZCB0aGF0IGluIHRoZSBjb21taXQgbG9nLCBteSBiYWQuDQo+IA0KDQpObyB3b3Jy
aWVzLg0KDQoidW5sb2NrIGFsbCBhdCBib290IiBqdXN0IGNsZWFyZWQgdGhlIFNSIGJpdHMuIENs
ZWFyaW5nIHRoZSBTUiBiaXRzIHVubG9ja3MNCnRoZXNlIGZsYXNoZXM/DQoNCkNoZWVycywNCnRh
DQo=
