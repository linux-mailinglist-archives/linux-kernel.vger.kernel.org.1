Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B512A309F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbgKBQ4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:56:40 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:35699 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbgKBQ4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:56:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604336197; x=1635872197;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DEkNiMN0vaflb4rGg1Akpd9EkP0v1FUgNZDucP1BMiA=;
  b=o5x1aD7axiYHEkGeX+BCQpB4AvA6oBVzw4MRleatm8Es41ytKZyUcHUV
   peZcR6F4vJdixnRESpUPwVMIxeWPjopwFNKOx1odPGKnBROhjCMneWuZo
   2/G+zir+daois5h17CRYfO6dAbLhKqa0cKzKqAm4JSoOy0RInRLnEpGCM
   h7Foeqjp6YrP2Pf0GZ4AGMb3nQIGLWN05b0doRngNf3J/dlwpsw6uMCjd
   t4oxwWUKlKa7H++2x8GmSIVE+YQrVyGBf2OofKO8GPzV8isgcbbjw+4XF
   YAu6Ja6MYL3g1AbCS7II3RS30dxj3S3PLKms8BPb6oyWo7kQRLivWObCI
   A==;
IronPort-SDR: kEvh4pPqVHaMX8Ko8H3eIP+QjT07jc5Bco6PvSTiAA3ZbgXgZl9tHcslBlrKPLigaXsJ7thYLG
 cKzJ9J/+ZhIVKxQfgpSdB3+zbJQXZ9tPeeLZ8aO1zG+mG6GDB3/RwqyrckpXDp9yJMbr3JpLSu
 sSEsdLUbuWqqVqfVcyVTAI/LAy87YBZ/jTCpwRdXc77YlR/EeP//nNMD9bjQfVAgqzjs9TNg6M
 qu2n/RAVzMrZx6lro/BS/Xi46pWpDTgQkoGbwzOHVSt1WgjEJsO9Ek/msp5TfSJnIey0H41T+5
 +uk=
X-IronPort-AV: E=Sophos;i="5.77,445,1596524400"; 
   d="scan'208";a="94754893"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2020 09:56:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 2 Nov 2020 09:56:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Mon, 2 Nov 2020 09:56:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WITM5pURK8/G60lgnbtufqMsNc9gSuyOntQGmvqBobUjPTJQpy+GmNfTqmwCftTqO+Y2CbAqCKGvhy9GrJip9eiGe1UJWDZ2fnaHEXqwX+a5N7rnYgD6r91pgxa47gJXLjmZQnhIK6pK8NkdJKcohQnmk+NpnB5+Ku5oEZKUA0L2/TrDQfzGDktkWxwmH0PZwDPNDv7JxjfjA0qqGSZ2gGcIG1v8iwzuBwDvUIEZJM2/2FsGovANMDWYoQYBPKRUzORvWQTBAMmmTFeMPYIW1+4iq1OmdcGqG3DjoHxGQMyqPZDTP3mympSmVPYk+bVnaBiDCh46lNvo3+Bz44l6QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEkNiMN0vaflb4rGg1Akpd9EkP0v1FUgNZDucP1BMiA=;
 b=LCcGPSf8z+xibHRUliSrmqVnh4sdwrMt9JEXKlskG9jnGywsI+5F8xeYwOPfEt6GsWwUY3GKsjdkdtOrv8FKUxUmszEYOAa8MXLz0fmMi+7G01Vwsevh02YFsza4UjiFV1ALHQQ906+VZoTai/Tr7exwZzVGrAGuYKxpXWA2NK0jGXEYkCUNt4AN3F05ySVZuYJiOq4bKVLrIQa+31m/AqvI3YzNfC6UrikR8B7zU53xKoTcDoYGfW4EPq7PE9o0QH8+bZGIEG0ExYDhV9D7xL5o2g5nLBNyYgMRQWH0yf8TLwtYkOrf4uqie6xNgtONwXr8R8ezLFNO/G1aB3xGTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEkNiMN0vaflb4rGg1Akpd9EkP0v1FUgNZDucP1BMiA=;
 b=MOWrwsS93RP8/BJ5Oj9Bmmxz2UFaaGVxB5JaWipqKzwio+Rbvjcdv8koT/kPkJJAJ3YU2XQlIGTLkauj4uczANN7FIseV7EfW5GtBNJUl4lmuklNDtJrGPAuJZeu9lyI3CL2Pk7YZnPPeQab9CeFhp1HVaHoGfjxZe51p/Rd53s=
Received: from CY4PR1101MB2341.namprd11.prod.outlook.com
 (2603:10b6:903:b1::22) by CY4PR1101MB2101.namprd11.prod.outlook.com
 (2603:10b6:910:24::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 2 Nov
 2020 16:56:35 +0000
Received: from CY4PR1101MB2341.namprd11.prod.outlook.com
 ([fe80::908:a628:69ca:d62e]) by CY4PR1101MB2341.namprd11.prod.outlook.com
 ([fe80::908:a628:69ca:d62e%7]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 16:56:35 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <lee.jones@linaro.org>
CC:     <Nicolas.Ferre@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <richard.genoud@gmail.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
Subject: Re: [PATCH] ARM: dts: at91: add serial MFD sub-node for usart
Thread-Topic: [PATCH] ARM: dts: at91: add serial MFD sub-node for usart
Thread-Index: AQHWrq0BNGYIfVuhjkKKUxhuAsgrHKmwJpcAgARphwCAADUdAIAABSQAgAAHOACAAENMAA==
Date:   Mon, 2 Nov 2020 16:56:35 +0000
Message-ID: <9f99dcf1-239d-b3b3-4b7d-e6d628bb3fed@microchip.com>
References: <20201030110702.886638-1-codrin.ciubotariu@microchip.com>
 <b054ce5c-58fd-dd86-2cb6-1e1f06a0899e@microchip.com>
 <20201102090122.GF4127@dell>
 <780303c7-2c32-f2e1-c9ce-1e2ee6bf0533@microchip.com>
 <20201102122952.GB4488@dell>
 <e2b038f0-81ea-3d2f-cb06-dd02f0b84860@microchip.com>
In-Reply-To: <e2b038f0-81ea-3d2f-cb06-dd02f0b84860@microchip.com>
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
x-ms-office365-filtering-correlation-id: 05877364-b2e0-4fc0-3864-08d87f5041e0
x-ms-traffictypediagnostic: CY4PR1101MB2101:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1101MB2101C8E7AAA96C25DC027467E7100@CY4PR1101MB2101.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1+OAL4m9IJqjFUUket4r/GTEZUgjdVfF1VX0g8f0VWCaQQ1DKVrTx9jEk02YCgLpbKyA0brNMEVLbgf2OdCx23K46Y7VZcE+xVf2NTN1buMDyRoswMc3PQEQpvl7zDsZlYZFp4UoZMWJxXxV8YZrkRSRno+a6A1PRpQrmKsdPwHzUgDW6CRuDQMjuGqwcsgJ39Jt60B59wAIPzTdafPzb/fF95iXufXlbzCun/DWsGHZLZ11xPhSpCUwFokjQZp0XYFieo+6p0ycY3LvUwhzPl6dJXJsI8L0000Cb3oAKU1FjMMAbcaqZspM3vq3F+NI0+8YZeKQcSVGzAcUCwlxYysl5Q8mFmqFlVCDSVaEgzBUitCXBs1gh/0pSLBWALQF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1101MB2341.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(376002)(346002)(136003)(83380400001)(2906002)(31696002)(91956017)(8936002)(64756008)(66476007)(66446008)(66556008)(66946007)(6512007)(86362001)(36756003)(76116006)(31686004)(8676002)(5660300002)(107886003)(53546011)(4326008)(6486002)(478600001)(71200400001)(6506007)(26005)(186003)(316002)(2616005)(54906003)(6916009)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: xOotU8UKuYih/UH8iFacD3F1I13HvLISRDVmWGXwUKSIvCLNnou0n+RXcr9HPs1UMcXGzYTCu524L2WfWWQ3fL/EI3gvGzvrN86J1FvAoHzgXmYobrF3UYFsrDIKkmoGdYdadKChimnQQHXkLjJlqu8eQlXyWCkEy3UxLQoC+9A5cv2R8OhuA7UNMkK88h8sXBQcL8rf/rdMu0zAnsp03RdxrfaQrqDN4TTipFr4c/+EcXT2wL1KIjxhcv3U/E1+75syDBJonTx1Z0MdON5e/sYnW5iYrouFjEVhyURXdy3Z8pMfLxqSAQZTIKO1iE47nbrex6ggOHOL+JqLvfVh1N3X6Pmt9aFJpI15k9dUo8k1eeA0472RNxoLaiGtGRX2crGuaqZIC0PnuLcs6hY7XifHvf4XSqoxtECr2owLu18PpQE5xL9pwWrYy8VOBl4YkDDJwxSC5uukRqqOFFNeF3SIPFAZAqyN/csSXF5Osi1vIT0cHJX5UkahDB/lhlnxmnibK+aYdon9n+GZuAzkr823nS5/P0NkQAWBIlxAUvOKO5CjBmiEcPzZ8i9thJPegf3ETJF+24knMkL6kFI8K3tJZgZfxr+YlWUvRClcyT099jCEtm59ALdgO10EfudzhZ09vLfMZg1X/00Rwn5Uwg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D87F0A2343F3F4BBD069CE8F81C53F8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1101MB2341.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05877364-b2e0-4fc0-3864-08d87f5041e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 16:56:35.0500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0PD67rBLiZvL8SD2zHmzoJm7zSLnlM4pJkMRSWU8p3nH+AJcCAipBzaCfSWX+a1uJMoVR7R6zw7QITjrfQK/HSuBIFWEWshNwfaCI3OFj2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2101
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDIuMTEuMjAyMCAxNDo1NSwgQ29kcmluLkNpdWJvdGFyaXVAbWljcm9jaGlwLmNvbSB3cm90
ZToNCj4gT24gMDIuMTEuMjAyMCAxNDoyOSwgTGVlIEpvbmVzIHdyb3RlOg0KPj4gRVhURVJOQUwg
RU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+Pg0KPj4gT24gTW9uLCAwMiBOb3YgMjAyMCwgQ29k
cmluLkNpdWJvdGFyaXVAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+DQo+Pj4gT24gMDIuMTEuMjAy
MCAxMTowMSwgTGVlIEpvbmVzIHdyb3RlOg0KPj4+PiBPbiBGcmksIDMwIE9jdCAyMDIwLCBOaWNv
bGFzIEZlcnJlIHdyb3RlOg0KPj4+Pg0KPj4+Pj4gT24gMzAvMTAvMjAyMCBhdCAxMjowNywgQ29k
cmluIENpdWJvdGFyaXUgd3JvdGU6DQo+Pj4+Pj4gVGhlICJhdG1lbCxhdDkxc2FtOTI2MC11c2Fy
dCIgZHJpdmVyIGlzIGEgTUZEIGRyaXZlciwgc28gaXQgbmVlZHMgc3ViLW5vZGVzDQo+Pj4+Pj4g
dG8gbWF0Y2ggdGhlIHJlZ2lzdGVyZWQgcGxhdGZvcm0gZGV2aWNlLiBGb3IgdGhpcyByZWFzb24s
IHdlIGFkZCBhIHNlcmlhbA0KPj4+Pj4+IHN1Ym5vZGUgdG8gYWxsIHRoZSAiYXRtZWwsYXQ5MXNh
bTkyNjAtdXNhcnQiIHNlcmlhbCBjb21wYXRpYmxlIG5vZHMuIFRoaXMNCj4+Pj4+PiB3aWxsIGFs
c28gcmVtb3ZlIHRoZSBib290IHdhcm5pbmc6DQo+Pj4+Pj4gImF0bWVsX3VzYXJ0X3NlcmlhbDog
RmFpbGVkIHRvIGxvY2F0ZSBvZl9ub2RlIFtpZDogLTJdIg0KPj4+Pj4NCj4+Pj4+IEkgZG9uJ3Qg
cmVtZW1iZXIgdGhpcyB3YXJuaW5nIHdhcyByYWlzZWQgcHJldmlvdXNseSBldmVuIGlmIHRoZSBN
RkQgZHJpdmVyDQo+Pj4+PiB3YXMgYWRkZWQgYSB3aGlsZSBhZ28gKFNlcHQuIDIwMTgpLg0KPj4+
Pj4NCj4+Pj4+IEkgd291bGQgc2F5IGl0J3MgZHVlIHRvIDQ2NmE2MmQ3NjQyZiAoIm1mZDogY29y
ZTogTWFrZSBhIGJlc3QgZWZmb3J0IGF0dGVtcHQNCj4+Pj4+IHRvIG1hdGNoIGRldmljZXMgd2l0
aCB0aGUgY29ycmVjdCBvZl9ub2RlcyIpIHdoaWNoIHdhcyBhZGRlZCBvbiBtaWQgQXVndXN0DQo+
Pj4+PiBhbmQgY29ycmVjdGVkIHdpdGggMjIzODBiNjVkYzcwICgibWZkOiBtZmQtY29yZTogRW5z
dXJlIGRpc2FibGVkIGRldmljZXMgYXJlDQo+Pj4+PiBpZ25vcmVkIHdpdGhvdXQgZXJyb3IiKSBi
dXQgbWF5YmUgbm90IGNvdmVyaW5nIG91ciBjYXNlLg0KPj4+Pj4NCj4+Pj4+IFNvLCB3ZWxsLCBJ
IGRvbid0IGtub3cgd2hhdCdzIHRoZSBiZXN0IG9wdGlvbiB0byB0aGlzIGNoYW5nZS4gTW9yZW92
ZXIsIEkNCj4+Pj4+IHdvdWxkIHNheSB0aGF0IGFsbCBvdGhlciBVU0FSVCByZWxhdGVkIHByb3Bl
cnRpZXMgZ28gaW50byB0aGUgY2hpbGQgbm90IGlmDQo+Pj4+PiB0aGVyZSBpcyBhIG5lZWQgZm9y
IG9uZS4NCj4+Pj4+DQo+Pj4+PiBMZWUsIEkgc3VzcGVjdCB0aGF0IHdlJ3JlIG5vdCB0aGUgb25s
eSBvbmVzIGV4cGVyaWVuY2luZyB0aGlzIHVnbHkgd2FybmluZw0KPj4+Pj4gZHVyaW5nIHRoZSBi
b290IGxvZzogY2FuIHlvdSBwb2ludCB1cyBvdXQgaG93IHRvIGRlYWwgd2l0aCBpdCBmb3Igb3Vy
DQo+Pj4+PiBleGlzdGluZyBhdG1lbF9zZXJpYWwuYyB1c2Vycz8NCj4+Pj4NCj4+Pj4gWW91IHNo
b3VsZCBub3QgYmUgaW5zdGFudGlhdGluZyBkcml2ZXJzIHRocm91Z2ggRGV2aWNlIFRyZWUgd2hp
Y2ggYXJlDQo+Pj4+IG5vdCBkZXNjcmliZWQgdGhlcmUuICBJZiB0aGUgY29ycmVjdCByZXByZXNl
bnRhdGlvbiBvZiB0aGUgSC9XIGFscmVhZHkNCj4+Pj4gZXhpc3RzIGluIERldmljZSBUcmVlIGku
ZS4gbm8gU1BJIGFuZCBVQVJUIElQIHJlYWxseSBleGlzdHMsIHVzZSB0aGUNCj4+Pj4gTUZEIGNv
cmUgQVBJIHRvIHJlZ2lzdGVyIHRoZW0gdXRpbGlzaW5nIHRoZSBwbGF0Zm9ybSBBUEkgaW5zdGVh
ZC4NCj4+Pj4NCj4+Pj4gVGhpcyBzaG91bGQgZG8gaXQ6DQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL21mZC9hdDkxLXVzYXJ0LmMgYi9kcml2ZXJzL21mZC9hdDkxLXVzYXJ0LmMNCj4+
Pj4gaW5kZXggNmE4MzUxYTQ1ODhlMi4uOTM5YmQyMzMyYTRmNiAxMDA2NDQNCj4+Pj4gLS0tIGEv
ZHJpdmVycy9tZmQvYXQ5MS11c2FydC5jDQo+Pj4+ICsrKyBiL2RyaXZlcnMvbWZkL2F0OTEtdXNh
cnQuYw0KPj4+PiBAQCAtMTcsMTIgKzE3LDEwIEBADQo+Pj4+DQo+Pj4+ICAgICBzdGF0aWMgY29u
c3Qgc3RydWN0IG1mZF9jZWxsIGF0OTFfdXNhcnRfc3BpX3N1YmRldiA9IHsNCj4+Pj4gICAgICAg
ICAgICAubmFtZSA9ICJhdDkxX3VzYXJ0X3NwaSIsDQo+Pj4+IC0gICAgICAgLm9mX2NvbXBhdGli
bGUgPSAibWljcm9jaGlwLGF0OTFzYW05ZzQ1LXVzYXJ0LXNwaSIsDQo+Pj4+ICAgICB9Ow0KPj4+
Pg0KPj4+PiAgICAgc3RhdGljIGNvbnN0IHN0cnVjdCBtZmRfY2VsbCBhdDkxX3VzYXJ0X3Nlcmlh
bF9zdWJkZXYgPSB7DQo+Pj4+ICAgICAgICAgICAgLm5hbWUgPSAiYXRtZWxfdXNhcnRfc2VyaWFs
IiwNCj4+Pj4gLSAgICAgICAub2ZfY29tcGF0aWJsZSA9ICJhdG1lbCxhdDkxcm05MjAwLXVzYXJ0
LXNlcmlhbCIsDQo+Pj4+ICAgICB9Ow0KPj4+Pg0KPj4+PiAgICAgc3RhdGljIGludCBhdDkxX3Vz
YXJ0X21vZGVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4+Pg0KPj4+IFtz
bmlwXQ0KPj4+DQo+Pj4gSGkgTGVlLCB0aGFuayB5b3UgZm9yIGxvb2tpbmcgdGhyb3VnaCBvdXIg
dXNhcnQgZHJpdmVyIGFuZCBmb3Igc2hhcmluZw0KPj4+IHlvdXIgdGhvdWdodHMuIFJlbW92aW5n
IHRoZSB1c2FnZSBvZiBjb21wYXRpYmxlIHN0cmluZyBtZWFucyB0aGF0IGZvcg0KPj4+IHNpbWls
YXIgc2VyaWFsL1NQSSBJUHMgd2Ugd291bGQgbmVlZCB0byBjcmVhdGUgbmV3IHBsYXRmb3JtIGRy
aXZlcnMuDQo+Pg0KPj4gV2h5IHdvdWxkIHlvdSBuZWVkIHRvIGRvIHRoYXQ/DQo+IA0KPiBJbiB0
aGUgY2FzZSB3ZSB3aWxsIGhhdmUgdG8gc3VwcG9ydCBhbm90aGVyIHNpbWlsYXIgSVAsIGJ1dCB3
aXRoIGENCj4gZGlmZmVyZW50IHNldCBvZiBmZWF0dXJlcy4gTm90IGEgbmV3IHBsYXRmb3JtIGRy
aXZlciBmcm9tIHNjcmF0Y2gsIGJ1dA0KPiBhdCBsZWFzdCBhIG5ldyBzdHJ1Y3QgcGxhdGZvcm1f
ZHJpdmVyIGZvciBlYWNoIHZhcmlhbnQuDQoNCkkgZ3Vlc3Mgd2UgY291bGQgdXNlIHN0cnVjdCBt
ZmRfY2VsbC5wbGF0Zm9ybV9kYXRhIHRvIHNlbGVjdCB0aGUgDQpmZWF0dXJlcyBmb3IgdGhlIHNl
cmlhbC9TUEkuIFRoaXMgcGxhdGZvcm0gZGF0YSBjYW4gYmUgcGVyIGNvbXBhdGlibGUgb2YgDQpv
dXIgTUZEIGRyaXZlci4gSSB3aWxsIHNlbmQgYSBwYXRjaCB3aXRoIHRoZSBjaGFuZ2VzIHlvdSBz
dWdnZXN0ZWQuIA0KVGhhbmsgeW91IQ0KDQpCZXN0IHJlZ2FyZHMsDQpDb2RyaW4NCg0KPiANCj4+
DQo+Pj4gVGhpcyBpcyBub3QgaWRlYWwsIGJ1dCBpdCdzIGEgc29sdXRpb24uIFdoYXQgSSBwcm9w
b3NlZCBpcyBtb3JlDQo+Pj4gZmxleGlibGUsIGJ1dCwgYXMgeW91IHBvaW50ZWQgb3V0LCBJIGFt
IG5vdCBzdXJlIGl0IGNvcnJlY3RseSBkZXNjcmliZXMNCj4+PiB0aGUgSFcsIGJlY2F1c2UgdGhl
IGRlY2lzaW9uIG9mIHdoZXRoZXIgdG8gdXNlIHRoaXMgSVAgYXMgYSBzZXJpYWwgb3IgYQ0KPj4+
IFNQSSBpcyBhIGNvbmZpZ3VyYWJsZSBvbmUuDQo+Pj4NCj4+PiBUaGFua3MgYW5kIGJlc3QgcmVn
YXJkcywNCj4+PiBDb2RyaW4NCj4+DQo+PiAtLQ0KPj4gTGVlIEpvbmVzIFvmnY7nkLzmlq9dDQo+
PiBTZW5pb3IgVGVjaG5pY2FsIExlYWQgLSBEZXZlbG9wZXIgU2VydmljZXMNCj4+IExpbmFyby5v
cmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBcm0gU29Dcw0KPj4gRm9sbG93IExpbmFy
bzogRmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZw0KPj4NCj4gDQoNCg==
