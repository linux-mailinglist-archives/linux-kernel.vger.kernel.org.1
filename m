Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1352846CD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 09:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbgJFHI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 03:08:27 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:54814 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726761AbgJFHI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 03:08:26 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09677k8P023201;
        Tue, 6 Oct 2020 09:07:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=Z88R9F775X/vx6uWOTTf1YpPD2/3YFVVHpJZnzBi2HA=;
 b=dDefOCjE16trFYivvjWWfsisB5Wg+QGde63dYCqQjQktdg7FaHsvqSF0jK9czJXOi3Xl
 39w5XIMPfr443IXbxjsXF0Y9EO79udP9Max/MytmuOQ3zLQYtkQd4656CsExjJlh9tv9
 0vjfdHXiab03A5wK5U2TahX3xUyOKS1ndCq5/7jHfjShn8fmWXvPffNHBeKGs6og72dU
 MYwTJQem5jVFY2TjJ+g6sojiEg7uSijg+wkfu5A0EKN6poreUNRdUqU0SsvrJK12hB6K
 DmKBVUplzgjLOo/qrCesb+4wNyatVgH1/rlyBu/65tt50dO9oNA5RNUABy1gumbDVKwW 8g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3402tjvvb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Oct 2020 09:07:56 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6282E10002A;
        Tue,  6 Oct 2020 09:07:55 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node1.st.com [10.75.127.4])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 469BB20FA4D;
        Tue,  6 Oct 2020 09:07:55 +0200 (CEST)
Received: from SFHDAG2NODE3.st.com (10.75.127.6) by SFHDAG2NODE1.st.com
 (10.75.127.4) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 6 Oct
 2020 09:07:17 +0200
Received: from SFHDAG2NODE3.st.com ([fe80::31b3:13bf:2dbe:f64c]) by
 SFHDAG2NODE3.st.com ([fe80::31b3:13bf:2dbe:f64c%20]) with mapi id
 15.00.1473.003; Tue, 6 Oct 2020 09:07:17 +0200
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     Alain Volmat <avolmat@me.com>,
        Russell King <linux@armlinux.org.uk>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Olof Johansson" <olof@lixom.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Enrico Weigelt <info@metux.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Kate Stewart" <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] arm: sti LL_UART: add STiH418 SBC UART0 support
Thread-Topic: [PATCH v2 2/2] arm: sti LL_UART: add STiH418 SBC UART0 support
Thread-Index: AQHWfwf0QXzHAjzt8keI+ryiHMNuy6mKPw4A
Date:   Tue, 6 Oct 2020 07:07:17 +0000
Message-ID: <0061645e-25ae-9eef-d9aa-df9b9b27aec7@st.com>
References: <20200830195748.30221-1-avolmat@me.com>
 <20200830195748.30221-3-avolmat@me.com>
In-Reply-To: <20200830195748.30221-3-avolmat@me.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FAB3CB18DEEC04FAD55FA16D2716FD1@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-06_02:2020-10-06,2020-10-06 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxhaW4NCg0KT24gOC8zMC8yMCA5OjU3IFBNLCBBbGFpbiBWb2xtYXQgd3JvdGU6DQo+IEFk
ZCB0aGUgZW50cnkgZm9yIHRoZSBTVGlINDE4IFNCQyBVQVJUMCBsb3cgbGV2ZWwgdWFydC4NCj4N
Cj4gU2lnbmVkLW9mZi1ieTogQWxhaW4gVm9sbWF0IDxhdm9sbWF0QG1lLmNvbT4NCj4gLS0tDQo+
ICBhcmNoL2FybS9LY29uZmlnLmRlYnVnIHwgMTkgKysrKysrKysrKysrKysrKystLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYg
LS1naXQgYS9hcmNoL2FybS9LY29uZmlnLmRlYnVnIGIvYXJjaC9hcm0vS2NvbmZpZy5kZWJ1Zw0K
PiBpbmRleCBlOTdkNmU1Yzg4OTguLjQ0N2QxNzdmY2Y4ZCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9h
cm0vS2NvbmZpZy5kZWJ1Zw0KPiArKysgYi9hcmNoL2FybS9LY29uZmlnLmRlYnVnDQo+IEBAIC0x
MjA0LDYgKzEyMDQsMTYgQEAgY2hvaWNlDQo+ICANCj4gIAkJICBJZiB1bnN1cmUsIHNheSBOLg0K
PiAgDQo+ICsJY29uZmlnIERFQlVHX1NUSUg0MThfU0JDX0FTQzANCj4gKwkJYm9vbCAiVXNlIFN0
aUg0MTggU0JDIEFTQzAgVUFSVCBmb3IgbG93LWxldmVsIGRlYnVnIg0KPiArCQlkZXBlbmRzIG9u
IEFSQ0hfU1RJDQo+ICsJCWhlbHANCj4gKwkJICBTYXkgWSBoZXJlIGlmIHlvdSB3YW50IGtlcm5l
bCBsb3ctbGV2ZWwgZGVidWdnaW5nIHN1cHBvcnQNCj4gKwkJICBvbiBTVGlINDE4IGJhc2VkIHBs
YXRmb3JtcyB3aGljaCBoYXMgZGVmYXVsdCBVQVJUIHdpcmVkDQo+ICsJCSAgdXAgdG8gU0JDIEFT
QzAuDQo+ICsNCj4gKwkJICBJZiB1bnN1cmUsIHNheSBOLg0KPiArDQo+ICAJY29uZmlnIFNUTTMy
RjRfREVCVUdfVUFSVA0KPiAgCQlib29sICJVc2UgU1RNMzJGNCBVQVJUIGZvciBsb3ctbGV2ZWwg
ZGVidWciDQo+ICAJCWRlcGVuZHMgb24gTUFDSF9TVE0zMkY0MjkgfHwgTUFDSF9TVE0zMkY0NjkN
Cj4gQEAgLTE1ODcsNiArMTU5Nyw3IEBAIGNvbmZpZyBERUJVR19MTF9JTkNMVURFDQo+ICAJZGVm
YXVsdCAiZGVidWcvc2lyZi5TIiBpZiBERUJVR19TSVJGU09DX1VBUlQNCj4gIAlkZWZhdWx0ICJk
ZWJ1Zy9zdGkuUyIgaWYgREVCVUdfU1RJSDQxWF9BU0MyDQo+ICAJZGVmYXVsdCAiZGVidWcvc3Rp
LlMiIGlmIERFQlVHX1NUSUg0MVhfU0JDX0FTQzENCj4gKwlkZWZhdWx0ICJkZWJ1Zy9zdGkuUyIg
aWYgREVCVUdfU1RJSDQxOF9TQkNfQVNDMA0KPiAgCWRlZmF1bHQgImRlYnVnL3N0bTMyLlMiIGlm
IERFQlVHX1NUTTMyX1VBUlQNCj4gIAlkZWZhdWx0ICJkZWJ1Zy90ZWdyYS5TIiBpZiBERUJVR19U
RUdSQV9VQVJUDQo+ICAJZGVmYXVsdCAiZGVidWcvdXg1MDAuUyIgaWYgREVCVUdfVVg1MDBfVUFS
VA0KPiBAQCAtMTYyMCw2ICsxNjMxLDcgQEAgY29uZmlnIERFQlVHX1VBUlRfUEhZUw0KPiAgCWRl
ZmF1bHQgMHgwMzAxMGZlMCBpZiBBUkNIX1JQQw0KPiAgCWRlZmF1bHQgMHgwNzAwMDAwMCBpZiBE
RUJVR19TVU45SV9VQVJUMA0KPiAgCWRlZmF1bHQgMHgwOTQwNTAwMCBpZiBERUJVR19aVEVfWlgN
Cj4gKwlkZWZhdWx0IDB4MDk1MzAwMDAgaWYgREVCVUdfU1RJSDQxOF9TQkNfQVNDMA0KPiAgCWRl
ZmF1bHQgMHgxMDAwOTAwMCBpZiBERUJVR19SRUFMVklFV19TVERfUE9SVCB8fCBcDQo+ICAJCQkJ
REVCVUdfVkVYUFJFU1NfVUFSVDBfQ0E5DQo+ICAJZGVmYXVsdCAweDEwMTBjMDAwIGlmIERFQlVH
X1JFQUxWSUVXX1BCMTE3Nl9QT1JUDQo+IEBAIC0xNzUwLDcgKzE3NjIsOCBAQCBjb25maWcgREVC
VUdfVUFSVF9QSFlTDQo+ICAJCURFQlVHX0JDTTYzWFhfVUFSVCB8fCBERUJVR19BU005MjYwX1VB
UlQgfHwgXA0KPiAgCQlERUJVR19TSVJGU09DX1VBUlQgfHwgREVCVUdfRElHSUNPTE9SX1VBMCB8
fCBcDQo+ICAJCURFQlVHX0FUOTFfVUFSVCB8fCBERUJVR19TVE0zMl9VQVJUIHx8IFwNCj4gLQkJ
REVCVUdfU1RJSDQxWF9BU0MyIHx8IERFQlVHX1NUSUg0MVhfU0JDX0FTQzENCj4gKwkJREVCVUdf
U1RJSDQxWF9BU0MyIHx8IERFQlVHX1NUSUg0MVhfU0JDX0FTQzEgfHwgXA0KPiArCQlERUJVR19T
VElINDE4X1NCQ19BU0MwDQo+ICANCj4gIGNvbmZpZyBERUJVR19VQVJUX1ZJUlQNCj4gIAloZXgg
IlZpcnR1YWwgYmFzZSBhZGRyZXNzIG9mIGRlYnVnIFVBUlQiDQo+IEBAIC0xNzk2LDYgKzE4MDks
NyBAQCBjb25maWcgREVCVUdfVUFSVF9WSVJUDQo+ICAJZGVmYXVsdCAweGY4MDkwMDAwIGlmIERF
QlVHX1ZFWFBSRVNTX1VBUlQwX1JTMQ0KPiAgCWRlZmF1bHQgMHhmOGZmZWUwMCBpZiBERUJVR19B
VDkxX1NBTTkyNjNfREJHVQ0KPiAgCWRlZmF1bHQgMHhmOGZmZjIwMCBpZiBERUJVR19BVDkxX1JN
OTIwMF9EQkdVDQo+ICsJZGVmYXVsdCAweGY5NTMwMDAwIGlmIERFQlVHX1NUSUg0MThfU0JDX0FT
QzANCj4gIAlkZWZhdWx0IDB4ZjllMDkwMDAgaWYgREVCVUdfQU0zM1hYVUFSVDENCj4gIAlkZWZh
dWx0IDB4ZmEwMjAwMDAgaWYgREVCVUdfT01BUDRVQVJUMyB8fCBERUJVR19USTgxWFhVQVJUMQ0K
PiAgCWRlZmF1bHQgMHhmYTAyMjAwMCBpZiBERUJVR19USTgxWFhVQVJUMg0KPiBAQCAtMTg2NCw3
ICsxODc4LDggQEAgY29uZmlnIERFQlVHX1VBUlRfVklSVA0KPiAgCQlERUJVR19CQ002M1hYX1VB
UlQgfHwgREVCVUdfQVNNOTI2MF9VQVJUIHx8IFwNCj4gIAkJREVCVUdfU0lSRlNPQ19VQVJUIHx8
IERFQlVHX0RJR0lDT0xPUl9VQTAgfHwgXA0KPiAgCQlERUJVR19BVDkxX1VBUlQgfHwgREVCVUdf
U1RNMzJfVUFSVCB8fCBcDQo+IC0JCURFQlVHX1NUSUg0MVhfQVNDMiB8fCBERUJVR19TVElINDFY
X1NCQ19BU0MxDQo+ICsgIAkJREVCVUdfU1RJSDQxWF9BU0MyIHx8IERFQlVHX1NUSUg0MVhfU0JD
X0FTQzEgfHwgXA0KPiArCQlERUJVR19TVElINDE4X1NCQ19BU0MwDQo+ICANCj4gIGNvbmZpZyBE
RUJVR19VQVJUXzgyNTBfU0hJRlQNCj4gIAlpbnQgIlJlZ2lzdGVyIG9mZnNldCBzaGlmdCBmb3Ig
dGhlIDgyNTAgZGVidWcgVUFSVCINCg0KUmV2aWV3ZWQtYnk6IFBhdHJpY2UgQ2hvdGFyZCA8cGF0
cmljZS5jaG90YXJkQHN0LmNvbT4NCg0KVGhhbmtzDQoNClBhdHJpY2UNCg==
