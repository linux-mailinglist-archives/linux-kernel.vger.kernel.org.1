Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7F92A2A71
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 13:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbgKBMLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 07:11:32 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:56347 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbgKBMLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 07:11:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604319092; x=1635855092;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QE8UoYhrISwnxCROEqCoTb3UGEtU9w6iHMfqG5Jbz9k=;
  b=zs3u4GMA+1WONa9LdsOElZA0DCB2/u16z2cb1Fc1XTcXdrhsWMje4bID
   y5ouU4VG1r9sCmjN36y8zPlV6A0ONtt2BV+i93z+/oNR8IQezgszDPSId
   2G3GCu22QrFQtQ2Qj2ng7iaQH2JrFoBXAgFu0KVY8/4JiW8gevp4WPYiN
   u7KRGYVfDJHOdI2LiUs816D/JBKpodo+EjlMAHVDyOXY1lm3HfETn+c0B
   KXObtyxbgs00wPTU9jTX637YlDkWynXTummFl6z8fjg+FxoAW6RXeg/xJ
   pqC9c2XMTq+YojJVeYpzBjqyxUnTuex4DwHMUlFbhHBHRsiWSVxnimu3t
   A==;
IronPort-SDR: KpqdWQY1UhczqdC4hkijz1JlzkKzssjox8ot8CydChyg5rcTzBaX+5daBB4RA/Ha+ve0Bwdlbq
 I+QZ5H3oWBPGCnWk7walCCMmHrnFPmnlq6LLzByigYrVqDGksVQoFAi864CMReAGWH0n/jr86/
 GVirS1Fr37FnCJuO70/FT6D6RYY75vFmIPnon6lltj7ylWRev/zk7UlTlAx7JwtRo+Mh7wDwqR
 FogW7b9eRp2VFJtN66EOOSJmHUCqgsyDPzLXTWhxuS1ovw2Hlo+KNpgITzc2wLO8DrY1GHx18V
 684=
X-IronPort-AV: E=Sophos;i="5.77,444,1596524400"; 
   d="scan'208";a="96811958"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2020 05:11:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 2 Nov 2020 05:11:30 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Mon, 2 Nov 2020 05:11:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnMLBJFVehTGbJBeM4MdPzUWzNYkhYrjs4XYbBhoqLaWNfvtEA0Om/VioSd02/ddY2wLvCflQe+J+PPcICrKZAbjemhsmpDQ2jyuvuvnhmxbuVMvEYiL+WEEO0PhGX1YZnEDdpbbQ1hW8EPnvEX5LA3qAke3AMoYaDTGPlFDxRpnsJ1r1I2CMTWfR16H70cP0CYhDiq0nAdtWL6sJu9u+ZSy5anT1Dp/nenCf+aZKVrFh8DxLQbJQRmcrLjLUq1xrk94BmoRYoPUxuCPwbuMhJH9vCAew6Aaa6DjUTECVPOK1Qq/9+37KVy6o0FIbeCfI3isT6oCnYuVP6kdEbrUsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QE8UoYhrISwnxCROEqCoTb3UGEtU9w6iHMfqG5Jbz9k=;
 b=lF77DgqxGiuiLC1zsdwtOtTMwRqITgqYEQGNhe1XBbMdh9j3DOy1xojimnwSn4l9SGcy2IfneAWBCQ8s+3PFej7qNbfm6W6tFAKKhr/0D0X7OP3S9AJCf0LzVZNXJv2IwnQBkh4gMsIV+ceu3UHIuqIeK+Nn5LeVyoBVIENVyC6VUALTEaN3BVwqcZq5/DOPSEzSEHv9FZQQ+Y70tx/RWyp+dfzjzTPAtoTiuCD8ARFAbYscLGMjrnmGcaHfUzZlgQtBpcIbTIBIwKpBwbjNSHDHaNKiypnXqPnkeSmJhxjkUbmqnPGVAzKXe7U5AtE2fKG1Fuls6U9ACY2F+zG39Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QE8UoYhrISwnxCROEqCoTb3UGEtU9w6iHMfqG5Jbz9k=;
 b=XnWs/LW3SRt3pAla0yMPF9lSQb+aK1j/LDvKYIRp6MqxYttSMS0nCuMzjVd5e7vv0Xi/NJE/ZAAK4uCJdVGIfk5u4lXF/HEKIvMk7fLnMqBMUGEImLU3f2vbNvkOA0rVKODN+XvjRd+RhiaxVQnA/n9GNqSdFc6vYoSeL6W0W1E=
Received: from CY4PR1101MB2341.namprd11.prod.outlook.com
 (2603:10b6:903:b1::22) by CY4PR11MB2040.namprd11.prod.outlook.com
 (2603:10b6:903:29::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Mon, 2 Nov
 2020 12:11:28 +0000
Received: from CY4PR1101MB2341.namprd11.prod.outlook.com
 ([fe80::908:a628:69ca:d62e]) by CY4PR1101MB2341.namprd11.prod.outlook.com
 ([fe80::908:a628:69ca:d62e%7]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 12:11:28 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <lee.jones@linaro.org>, <Nicolas.Ferre@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <richard.genoud@gmail.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
Subject: Re: [PATCH] ARM: dts: at91: add serial MFD sub-node for usart
Thread-Topic: [PATCH] ARM: dts: at91: add serial MFD sub-node for usart
Thread-Index: AQHWrq0BNGYIfVuhjkKKUxhuAsgrHKmwJpcAgARphwCAADUdAA==
Date:   Mon, 2 Nov 2020 12:11:28 +0000
Message-ID: <780303c7-2c32-f2e1-c9ce-1e2ee6bf0533@microchip.com>
References: <20201030110702.886638-1-codrin.ciubotariu@microchip.com>
 <b054ce5c-58fd-dd86-2cb6-1e1f06a0899e@microchip.com>
 <20201102090122.GF4127@dell>
In-Reply-To: <20201102090122.GF4127@dell>
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
x-ms-office365-filtering-correlation-id: 5b1fa053-93a3-47d2-c6ce-08d87f286da7
x-ms-traffictypediagnostic: CY4PR11MB2040:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB204097604EE63CCB54D27878E7100@CY4PR11MB2040.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6e/Hq5AjdF0RXZTLUjwijvKHnCBAJ1dsGaBzSLAMPXmDn7IX2MIaAQoRh0OoKqUGz123bucUeQXy0uyuxaH9As+8jfelJpEVyYtgvRApRmte0WQvciq1TECC9CE0EMtVSKhGxGYZY/ftwxs+c/CFaX8ObedsvjSGU26UoHed9jiqIznoVd8eJODcE5ovIp3UPM/3aOPXj84qLLx32MpHpoqItrV9R2k7/qSrGBx+K7wzZsOFoE4op1Kt46UkvQIfPcSaX0Lj5+E1j+jOrE8tEcITwFzhqstJM8jvrc99VNPoW2djKAXo0NQzT5Xi+fadoDYtXF7orDeeJrOl3ZnfsgpRCf1XGVJYLgD5b8PxK+2X/7ivSTTPsWACCWMirWCY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1101MB2341.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(346002)(366004)(396003)(376002)(8936002)(64756008)(6512007)(31696002)(186003)(5660300002)(91956017)(4326008)(6506007)(66476007)(66556008)(6486002)(66946007)(2616005)(36756003)(107886003)(8676002)(316002)(26005)(83380400001)(478600001)(6636002)(54906003)(86362001)(71200400001)(2906002)(76116006)(53546011)(110136005)(31686004)(66446008)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: nI6lNjLFoUqeAQd79GEZNzcPJ+g5cGW/4D20wZ87gwp23ZbAe2R5XuxRW8o4/3MTcdVEHgEU98fMjS0L2bntdrMMRo/0SybmlrRSrLMjhfG4J27Nlg3HkUTug3tdzNMO0IomUsI6k9JRu0+JA9t/JmrF4legB3oDfiHdKHu5pp5yHTBLFVGe08bxO5w9Qo/4Jdx0mILwHpJhRmjZQy53nj1NwSOZk0ZtBgGekI/djI57w4VvhGWep5Bo5m41KcNen7AP/SUwQi3N1/yTMHWVwhCNQ2+im2N0w55k1E4rvH5aFjhkjEplMRF15ZteFIdJ4IQcEkO9b2RDb7ALpyB6BBIoLHJCNPzRvt9Ch9Ntu2qZtE7frQuKFRckMWeBECDniAt72/VvwQ1nUDj0aEtyOA1Bbv6q3evyAopuwtivEMRdJKPWeOG3WBSEeG5uhWqPn7yoNw8w6xNXwkYySvwXGe1ZxIRcn6SGxOjJqXiQ8MyzkbqKiphtG33oW6Cyi+ufsb6pfX0A3rCgWGoME9dI9j8GXI6k8XHPGCEpirugiHUsmmk8+NILeF7Dp7r3MUhITzLnzLNfbv4qHimaRcD31mfbY9h8DgYLAumHSQbmRjiS1YjUUF6x8vLoVHKyLRVi/OCMY/vYfOZIjD4VuGkodg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A66CB6DED5B834CADC8D899D9BA0198@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1101MB2341.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b1fa053-93a3-47d2-c6ce-08d87f286da7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 12:11:28.7136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yfYllLi01niDCm86Vaofz7xoXEb0/FUunnUtoxAKVgEu65j25VixwMHIHaU3/l5RKQ7V0tq1Ojf6aIm/hpncKL8/43IJoslyeHRVt8kZ5T8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB2040
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDIuMTEuMjAyMCAxMTowMSwgTGVlIEpvbmVzIHdyb3RlOg0KPiBPbiBGcmksIDMwIE9jdCAy
MDIwLCBOaWNvbGFzIEZlcnJlIHdyb3RlOg0KPiANCj4+IE9uIDMwLzEwLzIwMjAgYXQgMTI6MDcs
IENvZHJpbiBDaXVib3Rhcml1IHdyb3RlOg0KPj4+IFRoZSAiYXRtZWwsYXQ5MXNhbTkyNjAtdXNh
cnQiIGRyaXZlciBpcyBhIE1GRCBkcml2ZXIsIHNvIGl0IG5lZWRzIHN1Yi1ub2Rlcw0KPj4+IHRv
IG1hdGNoIHRoZSByZWdpc3RlcmVkIHBsYXRmb3JtIGRldmljZS4gRm9yIHRoaXMgcmVhc29uLCB3
ZSBhZGQgYSBzZXJpYWwNCj4+PiBzdWJub2RlIHRvIGFsbCB0aGUgImF0bWVsLGF0OTFzYW05MjYw
LXVzYXJ0IiBzZXJpYWwgY29tcGF0aWJsZSBub2RzLiBUaGlzDQo+Pj4gd2lsbCBhbHNvIHJlbW92
ZSB0aGUgYm9vdCB3YXJuaW5nOg0KPj4+ICJhdG1lbF91c2FydF9zZXJpYWw6IEZhaWxlZCB0byBs
b2NhdGUgb2Zfbm9kZSBbaWQ6IC0yXSINCj4+DQo+PiBJIGRvbid0IHJlbWVtYmVyIHRoaXMgd2Fy
bmluZyB3YXMgcmFpc2VkIHByZXZpb3VzbHkgZXZlbiBpZiB0aGUgTUZEIGRyaXZlcg0KPj4gd2Fz
IGFkZGVkIGEgd2hpbGUgYWdvIChTZXB0LiAyMDE4KS4NCj4+DQo+PiBJIHdvdWxkIHNheSBpdCdz
IGR1ZSB0byA0NjZhNjJkNzY0MmYgKCJtZmQ6IGNvcmU6IE1ha2UgYSBiZXN0IGVmZm9ydCBhdHRl
bXB0DQo+PiB0byBtYXRjaCBkZXZpY2VzIHdpdGggdGhlIGNvcnJlY3Qgb2Zfbm9kZXMiKSB3aGlj
aCB3YXMgYWRkZWQgb24gbWlkIEF1Z3VzdA0KPj4gYW5kIGNvcnJlY3RlZCB3aXRoIDIyMzgwYjY1
ZGM3MCAoIm1mZDogbWZkLWNvcmU6IEVuc3VyZSBkaXNhYmxlZCBkZXZpY2VzIGFyZQ0KPj4gaWdu
b3JlZCB3aXRob3V0IGVycm9yIikgYnV0IG1heWJlIG5vdCBjb3ZlcmluZyBvdXIgY2FzZS4NCj4+
DQo+PiBTbywgd2VsbCwgSSBkb24ndCBrbm93IHdoYXQncyB0aGUgYmVzdCBvcHRpb24gdG8gdGhp
cyBjaGFuZ2UuIE1vcmVvdmVyLCBJDQo+PiB3b3VsZCBzYXkgdGhhdCBhbGwgb3RoZXIgVVNBUlQg
cmVsYXRlZCBwcm9wZXJ0aWVzIGdvIGludG8gdGhlIGNoaWxkIG5vdCBpZg0KPj4gdGhlcmUgaXMg
YSBuZWVkIGZvciBvbmUuDQo+Pg0KPj4gTGVlLCBJIHN1c3BlY3QgdGhhdCB3ZSdyZSBub3QgdGhl
IG9ubHkgb25lcyBleHBlcmllbmNpbmcgdGhpcyB1Z2x5IHdhcm5pbmcNCj4+IGR1cmluZyB0aGUg
Ym9vdCBsb2c6IGNhbiB5b3UgcG9pbnQgdXMgb3V0IGhvdyB0byBkZWFsIHdpdGggaXQgZm9yIG91
cg0KPj4gZXhpc3RpbmcgYXRtZWxfc2VyaWFsLmMgdXNlcnM/DQo+IA0KPiBZb3Ugc2hvdWxkIG5v
dCBiZSBpbnN0YW50aWF0aW5nIGRyaXZlcnMgdGhyb3VnaCBEZXZpY2UgVHJlZSB3aGljaCBhcmUN
Cj4gbm90IGRlc2NyaWJlZCB0aGVyZS4gIElmIHRoZSBjb3JyZWN0IHJlcHJlc2VudGF0aW9uIG9m
IHRoZSBIL1cgYWxyZWFkeQ0KPiBleGlzdHMgaW4gRGV2aWNlIFRyZWUgaS5lLiBubyBTUEkgYW5k
IFVBUlQgSVAgcmVhbGx5IGV4aXN0cywgdXNlIHRoZQ0KPiBNRkQgY29yZSBBUEkgdG8gcmVnaXN0
ZXIgdGhlbSB1dGlsaXNpbmcgdGhlIHBsYXRmb3JtIEFQSSBpbnN0ZWFkLg0KPiANCj4gVGhpcyBz
aG91bGQgZG8gaXQ6DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZmQvYXQ5MS11c2FydC5j
IGIvZHJpdmVycy9tZmQvYXQ5MS11c2FydC5jDQo+IGluZGV4IDZhODM1MWE0NTg4ZTIuLjkzOWJk
MjMzMmE0ZjYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWZkL2F0OTEtdXNhcnQuYw0KPiArKysg
Yi9kcml2ZXJzL21mZC9hdDkxLXVzYXJ0LmMNCj4gQEAgLTE3LDEyICsxNywxMCBAQA0KPiANCj4g
ICBzdGF0aWMgY29uc3Qgc3RydWN0IG1mZF9jZWxsIGF0OTFfdXNhcnRfc3BpX3N1YmRldiA9IHsN
Cj4gICAgICAgICAgLm5hbWUgPSAiYXQ5MV91c2FydF9zcGkiLA0KPiAtICAgICAgIC5vZl9jb21w
YXRpYmxlID0gIm1pY3JvY2hpcCxhdDkxc2FtOWc0NS11c2FydC1zcGkiLA0KPiAgIH07DQo+IA0K
PiAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbWZkX2NlbGwgYXQ5MV91c2FydF9zZXJpYWxfc3ViZGV2
ID0gew0KPiAgICAgICAgICAubmFtZSA9ICJhdG1lbF91c2FydF9zZXJpYWwiLA0KPiAtICAgICAg
IC5vZl9jb21wYXRpYmxlID0gImF0bWVsLGF0OTFybTkyMDAtdXNhcnQtc2VyaWFsIiwNCj4gICB9
Ow0KPiANCj4gICBzdGF0aWMgaW50IGF0OTFfdXNhcnRfbW9kZV9wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQ0KDQpbc25pcF0NCg0KSGkgTGVlLCB0aGFuayB5b3UgZm9yIGxvb2tp
bmcgdGhyb3VnaCBvdXIgdXNhcnQgZHJpdmVyIGFuZCBmb3Igc2hhcmluZyANCnlvdXIgdGhvdWdo
dHMuIFJlbW92aW5nIHRoZSB1c2FnZSBvZiBjb21wYXRpYmxlIHN0cmluZyBtZWFucyB0aGF0IGZv
ciANCnNpbWlsYXIgc2VyaWFsL1NQSSBJUHMgd2Ugd291bGQgbmVlZCB0byBjcmVhdGUgbmV3IHBs
YXRmb3JtIGRyaXZlcnMuIA0KVGhpcyBpcyBub3QgaWRlYWwsIGJ1dCBpdCdzIGEgc29sdXRpb24u
IFdoYXQgSSBwcm9wb3NlZCBpcyBtb3JlIA0KZmxleGlibGUsIGJ1dCwgYXMgeW91IHBvaW50ZWQg
b3V0LCBJIGFtIG5vdCBzdXJlIGl0IGNvcnJlY3RseSBkZXNjcmliZXMgDQp0aGUgSFcsIGJlY2F1
c2UgdGhlIGRlY2lzaW9uIG9mIHdoZXRoZXIgdG8gdXNlIHRoaXMgSVAgYXMgYSBzZXJpYWwgb3Ig
YSANClNQSSBpcyBhIGNvbmZpZ3VyYWJsZSBvbmUuDQoNClRoYW5rcyBhbmQgYmVzdCByZWdhcmRz
LA0KQ29kcmluDQo=
