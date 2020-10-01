Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C8827FAA1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 09:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731330AbgJAHwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 03:52:45 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:1602 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgJAHwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 03:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601538764; x=1633074764;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Oef8e5K54IIqocrvLaxrkxdCUAeslKALdDeaPoF4hG4=;
  b=Ol8AJUFUevnu/uVFYuWyBOo2UkTHG4FdhmdBaGk+hOR2BdX3kzyMd+J1
   lxaDEYZavnNZf32XVCfx33UCAkI3K8j2T1H3ANFk1r+ZqwWt1/Q123knL
   AC4RdJAHpGWV8tVBQ5Siz4JMmOX8nmapKrdIboCJiG5O7LRx5cDZogzQ3
   ZRMIbQq5lZK7vFM0nNfyB0CzKQ7yXR+SsqsZEJsMCMLY4g2VPkw1e1Zn6
   LxQD207+1fYfFZsfiIDw6FDFhoP4uwGfe3weNPvwBQmIUuy0dbT/C8o/q
   ykw5LZ+q0C8E66t77/A/p1VEQRNXlrf8SzSdhxqApiNqRZpLOC5qOsjTO
   g==;
IronPort-SDR: BX4P5xS8ngr3T2tgv/+AeH0Y1nkYAjzJm9+fDpim4PwJbUSwoaAEPJUP9bEv0ghlrMsl1FOxXw
 OczFYfZDscEnUuClepXQuFo/3T8NFrB/VHh3v3pwT/8B2YpYIr3en8uJeUlegKmlPvG3rdYH/k
 0HPlla3Ja76as2ez4YCUp5y6LLVblFYGm4FFHlHpkdFjb0K64y46lhUuGKjxSyKAEXAIIEgb4z
 ybnYpxaXUmyKSFQF5kdy0VJ7p3TaJxCIYKRB50xjGBbspVx4RCLAoBSmW9iMzznxVDk+2YXXtT
 8jU=
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="91051294"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Oct 2020 00:52:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 1 Oct 2020 00:52:13 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Thu, 1 Oct 2020 00:52:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzTe1WxyDcn29Yesj1K9pA3tOWnpKQw8FOwI5LZN26tgZBgDZYogroIvErXuMPJoPw9VnQbNA8B4uXsqmDPRSyFyUiaxulIkvZKg70AjtQNPeq1GxKVNNJ0Kp5ydxd2r0cNQYwrmWbHGvttlhJY1Y6GA50dCVFUXg84pV+uA6XQ9EViA2vl2PT1UmdFfe9NVX/egLQh5A9/oT0c7oD3/huIA9FaOHLasmbooSLejdic4XGC/CqbxvnkIU1IJ8PdUBFoFzlTqrMgMlw3ZEpgNVTXYtnah4u0xweByrBePjOrvKUSiptKaDIQexwvbEfrdhUEQ3fVcsIgjJPxMCSNnVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oef8e5K54IIqocrvLaxrkxdCUAeslKALdDeaPoF4hG4=;
 b=faNUNJee0CYNYpjJmJGNqpG7Wsb/LEUmtp1IvYWvP7zroNCsIm66lVxRg72KtwFh1pJw34hlH9LauQxlTzM85qQaPHj/LhjRYTI6YIifdQrRhucwfjkaLbs/lTmA8hj1936tTZz4AQr+KvmWKViPm241sVXBJkhu1+P3qiSuyA7pK3tHav+qW/wQWgyIwl81YSQFsuSo1zdl3SCg3lrsvpQgMBaC01kIiCNb0KYU+q6Mn2sdJVVqjPnAH7miNI9+b7Sp7A7+GBeF82GgiNSo1mlGahLmZCTFzBou8CY05lRdyRz3GzF5mSAKPcALoWEW+7NKql7URJl7Ba+vAeIyww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oef8e5K54IIqocrvLaxrkxdCUAeslKALdDeaPoF4hG4=;
 b=M7tf39Qf9XljqUXroNmuD9drg/IH4WP7ldihorqJSnZ1AYb16yENFIvQ5eIV8NE4NNqTlGTDx/Grvgug2RnRbUKVPkKeIqGCa4nXyOeuTl9l4npa8+Z+boccBLshwQbPlaD2yeFFPaligEX5oXjfcdaT52MtTzgteqMQxsikvbU=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (2603:10b6:3:112::12)
 by DM6PR11MB4691.namprd11.prod.outlook.com (2603:10b6:5:2a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Thu, 1 Oct
 2020 07:52:36 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a%4]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 07:52:36 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v14 07/15] mtd: spi-nor: core: do 2 byte reads for SR and
 FSR in DTR mode
Thread-Topic: [PATCH v14 07/15] mtd: spi-nor: core: do 2 byte reads for SR and
 FSR in DTR mode
Thread-Index: AQHWl8fTc0NzaLTqvk2yuALqCAPR9w==
Date:   Thu, 1 Oct 2020 07:52:36 +0000
Message-ID: <07af5100-55b5-4f51-ef5b-1e7a69b3607b@microchip.com>
References: <20200930185732.6201-1-p.yadav@ti.com>
 <20200930185732.6201-8-p.yadav@ti.com>
In-Reply-To: <20200930185732.6201-8-p.yadav@ti.com>
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
x-ms-office365-filtering-correlation-id: 66e10c92-429b-42ce-65d2-08d865def680
x-ms-traffictypediagnostic: DM6PR11MB4691:
x-microsoft-antispam-prvs: <DM6PR11MB4691F60879AD96F5415F0FD7F0300@DM6PR11MB4691.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OyPI/BhCnp6/TokErNz2A0AGy7PEW3nB6ojtAw/BE6+qMPlkoA0RFbDqeZ1DDMwxMZjoaGLm4CNMSiXylvzIFl9E6XBzRQ1+yOug/4tqFGkR4NWiufG+hnZ5OD3o+0IXUVeNs6g7U8YPfpgHucqvP9nOF9wcYYlsaAlMgDAfk5SU3kwyDNo8l4S3w3raQ1V7Dtle/mB/wr1qZtB8wqPWlbgd0J7qcWSzhvH0nrha/3FiFbL+6e3wgzK7fpPSqON7jppPQ5nZi1QuB51kaqsN99LbDl+r0+hglYR6nLJpEhM2CpEG16NFb4/YMD9jybPrINLhonyaNUdCgI/pFX/JwnSQxU/V9/g57aXueY+BNDYloyBFyouV2P6kc947YQ2A9EbH7heH3tWevAOAqmB2SiLSV+m9cKfA9ERFMb8ezMH1aiyNLpFxkUUmyFMeFlYs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(366004)(396003)(39860400002)(2906002)(316002)(91956017)(8676002)(186003)(110136005)(54906003)(66946007)(2616005)(53546011)(6512007)(26005)(6506007)(31686004)(83380400001)(8936002)(31696002)(36756003)(64756008)(6486002)(4326008)(71200400001)(66476007)(86362001)(5660300002)(66556008)(66446008)(478600001)(76116006)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 8h0lHOVROtCSrLwhLTvNesKtMk4ssTtBx2EM38kKukMJdRv0XS3OR7AoOfcgqIfbmvD1Eax9zomyI4gUE+BlohCbKYPblKt5rJA/aEe+Gwu6y6hflz3QJ3Z9ABjfjcsxw/vldE16+pDJzb9Am7GyhfCWxrUVAEFiNmxzn6m+J5Rcdsdl2p2enbh2BXOHvEc/FSyR65F2h67aJ89cb4Xl7d4DnXts6pyJldzGPRt6gM41Vk74MF/qcXXloDaAwHrN4iS7A+l9V62wljHg6FfRD6XFrvTs+FYIQr24LboTrkDYuVIV/+rPiaw4jFr8Mip0rnu9X6sOh0u//osPbnPFec6ffMGxIzrrlafg1JLnHJviron61MdqnCEaQxe8Lyjlh7h4bjSG7+PFSHGKg5neiqpovUHOWWLkqUmsXTMlnalybqo+e2jVGwAHpvbebZVJX1bn6TdY5gK7/O/bYQ1ti8P5peG2UC6CublOzDw2bOyBPLwD3jatYkYYHSLxySr9o3/UCBerkK9pFVzc3EFBdyg7nQbfOUndZt9zHtmeT/1+H1+qdMPbfWB5WuyFbVMwVI7Jbk6LyvAPISUPoXE32o3NP5k/En2SGFbkTcIEiTe4t8HPCkniJqyLe1CMfLCvOm3tj6QTLGNf9CY6UqAqbQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <239D18AA5719D14CAE0A8CDAE78413D4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e10c92-429b-42ce-65d2-08d865def680
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 07:52:36.4620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LnbPPGibMA66zleC9jgZG5uFAfAybHL3lV8nWOGX3NT2CKQGhiLaw7qtbvy+3sEpPa/ZOD1rl6h+DtV7F53qX3x6FvxPMyG6jKdKz+rbuUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4691
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8zMC8yMCA5OjU3IFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBTb21lIGNvbnRyb2xsZXJzLCBsaWtlIHRoZSBj
YWRlbmNlIHFzcGkgY29udHJvbGxlciwgaGF2ZSB0cm91YmxlIHJlYWRpbmcNCj4gb25seSAxIGJ5
dGUgaW4gRFRSIG1vZGUuIFNvLCBkbyAyIGJ5dGUgcmVhZHMgZm9yIFNSIGFuZCBGU1IgY29tbWFu
ZHMgaW4NCj4gRFRSIG1vZGUsIGFuZCB0aGVuIGRpc2NhcmQgdGhlIHNlY29uZCBieXRlLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogUHJhdHl1c2ggWWFkYXYgPHAueWFkYXZAdGkuY29tPg0KDQpSZXZp
ZXdlZC1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KDQo+
IC0tLQ0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMgfCAxNSArKysrKysrKysrKysrLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jIGIvZHJpdmVycy9tdGQv
c3BpLW5vci9jb3JlLmMNCj4gaW5kZXggMTQ2NWNmODBmOTc4Li43M2EyNmU3ZTMyYzIgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvbXRk
L3NwaS1ub3IvY29yZS5jDQo+IEBAIC0zNzAsNyArMzcwLDcgQEAgaW50IHNwaV9ub3Jfd3JpdGVf
ZGlzYWJsZShzdHJ1Y3Qgc3BpX25vciAqbm9yKQ0KPiAgICogc3BpX25vcl9yZWFkX3NyKCkgLSBS
ZWFkIHRoZSBTdGF0dXMgUmVnaXN0ZXIuDQo+ICAgKiBAbm9yOiAgICAgICBwb2ludGVyIHRvICdz
dHJ1Y3Qgc3BpX25vcicuDQo+ICAgKiBAc3I6ICAgICAgICAgICAgICAgIHBvaW50ZXIgdG8gYSBE
TUEtYWJsZSBidWZmZXIgd2hlcmUgdGhlIHZhbHVlIG9mIHRoZQ0KPiAtICogICAgICAgICAgICAg
IFN0YXR1cyBSZWdpc3RlciB3aWxsIGJlIHdyaXR0ZW4uDQo+ICsgKiAgICAgICAgICAgICAgU3Rh
dHVzIFJlZ2lzdGVyIHdpbGwgYmUgd3JpdHRlbi4gU2hvdWxkIGJlIGF0IGxlYXN0IDIgYnl0ZXMu
DQo+ICAgKg0KPiAgICogUmV0dXJuOiAwIG9uIHN1Y2Nlc3MsIC1lcnJubyBvdGhlcndpc2UuDQo+
ICAgKi8NCj4gQEAgLTM4OCw2ICszODgsMTEgQEAgc3RhdGljIGludCBzcGlfbm9yX3JlYWRfc3Io
c3RydWN0IHNwaV9ub3IgKm5vciwgdTggKnNyKQ0KPiAgICAgICAgICAgICAgICAgaWYgKG5vci0+
cmVnX3Byb3RvID09IFNOT1JfUFJPVE9fOF84XzhfRFRSKSB7DQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgIG9wLmFkZHIubmJ5dGVzID0gbm9yLT5wYXJhbXMtPnJkc3JfYWRkcl9uYnl0ZXM7DQo+
ICAgICAgICAgICAgICAgICAgICAgICAgIG9wLmR1bW15Lm5ieXRlcyA9IG5vci0+cGFyYW1zLT5y
ZHNyX2R1bW15Ow0KPiArICAgICAgICAgICAgICAgICAgICAgICAvKg0KPiArICAgICAgICAgICAg
ICAgICAgICAgICAgKiBXZSBkb24ndCB3YW50IHRvIHJlYWQgb25seSBvbmUgYnl0ZSBpbiBEVFIg
bW9kZS4gU28sDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAqIHJlYWQgMiBhbmQgdGhlbiBk
aXNjYXJkIHRoZSBzZWNvbmQgYnl0ZS4NCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICovDQo+
ICsgICAgICAgICAgICAgICAgICAgICAgIG9wLmRhdGEubmJ5dGVzID0gMjsNCj4gICAgICAgICAg
ICAgICAgIH0NCj4gDQo+ICAgICAgICAgICAgICAgICBzcGlfbm9yX3NwaW1lbV9zZXR1cF9vcChu
b3IsICZvcCwgbm9yLT5yZWdfcHJvdG8pOw0KPiBAQCAtNDA4LDcgKzQxMyw4IEBAIHN0YXRpYyBp
bnQgc3BpX25vcl9yZWFkX3NyKHN0cnVjdCBzcGlfbm9yICpub3IsIHU4ICpzcikNCj4gICAqIHNw
aV9ub3JfcmVhZF9mc3IoKSAtIFJlYWQgdGhlIEZsYWcgU3RhdHVzIFJlZ2lzdGVyLg0KPiAgICog
QG5vcjogICAgICAgcG9pbnRlciB0byAnc3RydWN0IHNwaV9ub3InDQo+ICAgKiBAZnNyOiAgICAg
ICBwb2ludGVyIHRvIGEgRE1BLWFibGUgYnVmZmVyIHdoZXJlIHRoZSB2YWx1ZSBvZiB0aGUNCj4g
LSAqICAgICAgICAgICAgICBGbGFnIFN0YXR1cyBSZWdpc3RlciB3aWxsIGJlIHdyaXR0ZW4uDQo+
ICsgKiAgICAgICAgICAgICAgRmxhZyBTdGF0dXMgUmVnaXN0ZXIgd2lsbCBiZSB3cml0dGVuLiBT
aG91bGQgYmUgYXQgbGVhc3QgMg0KPiArICogICAgICAgICAgICAgIGJ5dGVzLg0KPiAgICoNCj4g
ICAqIFJldHVybjogMCBvbiBzdWNjZXNzLCAtZXJybm8gb3RoZXJ3aXNlLg0KPiAgICovDQo+IEBA
IC00MjYsNiArNDMyLDExIEBAIHN0YXRpYyBpbnQgc3BpX25vcl9yZWFkX2ZzcihzdHJ1Y3Qgc3Bp
X25vciAqbm9yLCB1OCAqZnNyKQ0KPiAgICAgICAgICAgICAgICAgaWYgKG5vci0+cmVnX3Byb3Rv
ID09IFNOT1JfUFJPVE9fOF84XzhfRFRSKSB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIG9w
LmFkZHIubmJ5dGVzID0gbm9yLT5wYXJhbXMtPnJkc3JfYWRkcl9uYnl0ZXM7DQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgIG9wLmR1bW15Lm5ieXRlcyA9IG5vci0+cGFyYW1zLT5yZHNyX2R1bW15
Ow0KPiArICAgICAgICAgICAgICAgICAgICAgICAvKg0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgKiBXZSBkb24ndCB3YW50IHRvIHJlYWQgb25seSBvbmUgYnl0ZSBpbiBEVFIgbW9kZS4gU28s
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAqIHJlYWQgMiBhbmQgdGhlbiBkaXNjYXJkIHRo
ZSBzZWNvbmQgYnl0ZS4NCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICovDQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgIG9wLmRhdGEubmJ5dGVzID0gMjsNCj4gICAgICAgICAgICAgICAgIH0N
Cj4gDQo+ICAgICAgICAgICAgICAgICBzcGlfbm9yX3NwaW1lbV9zZXR1cF9vcChub3IsICZvcCwg
bm9yLT5yZWdfcHJvdG8pOw0KPiAtLQ0KPiAyLjI4LjANCj4gDQoNCg==
