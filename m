Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327B5302241
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 07:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbhAYGve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 01:51:34 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:62562 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726610AbhAYGur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 01:50:47 -0500
X-UUID: f9fd92f00151428f8fc1a03ad778b973-20210125
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=3sZdh7RRXxrc49QzROkGUluZgplDjz302X96USm+z90=;
        b=Z0qG9f2xZMR7M2KmGP08ZfOPOR1IamN8WAyd6HDThOBMf5ut41BVkXNCPslTTgXJD+KxreKqc5zTUWv9hdYJrPVKsoPX/EMz7wvjPcvZHxaOb3dpike6rwf9iIyIH+dmrrbaQKHbaPqO7NWzX8yHfTuyySV0vJc7+yXQl7O6wSs=;
X-UUID: f9fd92f00151428f8fc1a03ad778b973-20210125
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 296833013; Mon, 25 Jan 2021 14:49:52 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 25 Jan
 2021 14:49:45 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 Jan 2021 14:49:44 +0800
Message-ID: <1611557384.3184.22.camel@mhfsdcap03>
Subject: Re: [PATCH 3/3] memory: mtk-smi: Switch MTK_SMI to tristate
From:   Yong Wu <yong.wu@mediatek.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <yi.kuo@mediatek.com>
Date:   Mon, 25 Jan 2021 14:49:44 +0800
In-Reply-To: <20210122213558.qnboqc4obdmipxs4@kozik-lap>
References: <20210121062429.26504-1-yong.wu@mediatek.com>
         <20210121062429.26504-4-yong.wu@mediatek.com>
         <20210122213558.qnboqc4obdmipxs4@kozik-lap>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 1D28C57D2118177B6DC247476BBB989F212A870F3047A08E71A51B66345267EE2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTAxLTIyIGF0IDIyOjM1ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiBUaHUsIEphbiAyMSwgMjAyMSBhdCAwMjoyNDoyOVBNICswODAwLCBZb25nIFd1
IHdyb3RlOg0KPiA+IFRoaXMgcGF0Y2ggc3dpdGNoZXMgTVRLX1NNSSB0byB0cmlzdGF0ZS4gU3Vw
cG9ydCBpdCBjb3VsZCBiZSAnbScuDQo+ID4gDQo+ID4gTWVhbndoaWxlLCBGaXggYSBidWlsZCBp
c3N1ZSB3aGlsZSBNVEtfU01JIGlzIGJ1aWx0IGFzIG1vZHVsZS4NCj4gDQo+IHMvRml4L2ZpeC4N
Cj4gDQo+IFdoYXQgZXJyb3IgaXMgYmVpbmcgZml4ZWQgaGVyZT8gSG93IGNhbiBJIHJlcHJvZHVj
ZSBpdD8gQXJlbid0IHlvdSBqdXN0DQo+IGFkanVzdGluZyBpdCB0byBiZWluZyBidWlsZGFibGUg
YnkgbW9kdWxlPw0KDQpTb3JyeSwgSSBkaWRuJ3QgY29weSB0aGUgZmFpbCBsb2cgaGVyZS4gVGhp
cyBpcyB0aGUgYnVpbGQgbG9nOg0KDQpJbiBmaWxlIGluY2x1ZGVkIGZyb20gLi4uL2RyaXZlcnMv
aW9tbXUvbXRrX2lvbW11LmM6MzQ6MDoNCi4uLi9kcml2ZXJzL2lvbW11L210a19pb21tdS5oOjg0
OjI4OiBlcnJvcjogYXJyYXkgdHlwZSBoYXMgaW5jb21wbGV0ZQ0KZWxlbWVudCB0eXBlICdzdHJ1
Y3QgbXRrX3NtaV9sYXJiX2lvbW11Jw0KICBzdHJ1Y3QgbXRrX3NtaV9sYXJiX2lvbW11IGxhcmJf
aW11W01US19MQVJCX05SX01BWF07DQoNCk91ciBpb21tdSBkcml2ZXIgd2lsbCB1c2UgdGhpcyBz
dHJ1Y3R1cmUuIGJ1dCBpdCB3YXMgY29udGFpbmVkIGJ5DQoiI2lmZGVmIENPTkZJR19NVEtfU01J
Ii4gdGh1cyBJIGNoYW5nZSBpdCB0byAiI2lmDQpJU19FTkFCTEVEKENPTkZJR19NVEtfU01JKSIN
Cg0KSWYgcmVwcm9kdWNpbmcgaXQsIHdlIHNob3VsZCBjaGFuZ2UgbXRrLWlvbW11IHRvIG1vZHVs
ZV9pbml0WzFdLiBhbmQNCnN3aXRjaCBrY29uZmlnIE1US19JT01NVSB0byB0cmlzdGF0ZSwgdGhl
biBjaGFuZ2UgdGhlIENPTkZJR19NVEtfSU9NTVUNCnRvIG0uIHdlIGNvdWxkIGdldCB0aGUgZmFp
bCBsb2cuDQoNCkluIHRoaXMgY2FzZSwgU2hvdWxkIEkgc3F1YXNoIHRoaXMgY2hhbmdlIGludG8g
dGhpcyBwYXRjaD8gSSB0aG91Z2ggdGhpcw0KaXMgYSBwcmVwYXJpbmcgcGF0Y2ggYW5kIHRoZSBm
YWlsIGlzIGNhdXNlZCBieSBNVEtfU01JLiB0aHVzIEkgc3F1YXNoDQp0aGF0IGludG8gdGhpcyBw
YXRjaC4gb3IgY2hhbmdlIGl0IGFzIGEgaW5kZXBlbmRlbnQgcGF0Y2ggYW5kIHNlbmQgd2hlbg0K
SSBjaGFuZ2UgTVRLX0lPTU1VIHRvIHRyaXN0YXRlPw0KDQpbMV0NCmh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xpbnV4LW1lZGlhdGVrLzE1OTA4MjYyMTgtMjM2NTMtMTQtZ2l0LXNlbmQtZW1haWwt
eW9uZy53dUBtZWRpYXRlay5jb20vDQoNCg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0
b2YNCj4gDQo+IA0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVk
aWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+IFRoaXMgcGF0Y2ggaGFzIGEgbGl0dGxlIGNvbmZsaWN0
IHdpdGggdGhlIG10ODE5MiBpb21tdSBwYXRjaCB3aGljaA0KPiA+IGRlbGV0ZSB0aGUgTVRLX0xB
UkJfTlJfTUFYIGluIHNtaS5oKEl0J3Mgc3RpbGwgcmV2aWV3aW5nKS4NCj4gPiBUaGlzIHBhdGNo
IHJlYmFzZSBvbiB0aGUgY2xlYW4gdjUuMTEtcmMxLg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21l
bW9yeS9LY29uZmlnICAgICB8IDIgKy0NCj4gPiAgaW5jbHVkZS9zb2MvbWVkaWF0ZWsvc21pLmgg
fCAyICstDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21lbW9yeS9LY29uZmlnIGIvZHJp
dmVycy9tZW1vcnkvS2NvbmZpZw0KPiA+IGluZGV4IDNlYTY5MTNkZjE3Ni4uZDVmMGY0NjgwODgw
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbWVtb3J5L0tjb25maWcNCj4gPiArKysgYi9kcml2
ZXJzL21lbW9yeS9LY29uZmlnDQo+ID4gQEAgLTE3Myw3ICsxNzMsNyBAQCBjb25maWcgSlo0Nzgw
X05FTUMNCj4gPiAgCSAgbWVtb3J5IGRldmljZXMgc3VjaCBhcyBOQU5EIGFuZCBTUkFNLg0KPiA+
ICANCj4gPiAgY29uZmlnIE1US19TTUkNCj4gPiAtCWJvb2wgIk1lZGlhdGVrIFNvQyBNZW1vcnkg
Q29udHJvbGxlciBkcml2ZXIiIGlmIENPTVBJTEVfVEVTVA0KPiA+ICsJdHJpc3RhdGUgIk1lZGlh
dGVrIFNvQyBNZW1vcnkgQ29udHJvbGxlciBkcml2ZXIiIGlmIENPTVBJTEVfVEVTVA0KPiA+ICAJ
ZGVwZW5kcyBvbiBBUkNIX01FRElBVEVLIHx8IENPTVBJTEVfVEVTVA0KPiA+ICAJaGVscA0KPiA+
ICAJICBUaGlzIGRyaXZlciBpcyBmb3IgdGhlIE1lbW9yeSBDb250cm9sbGVyIG1vZHVsZSBpbiBN
ZWRpYVRlayBTb0NzLA0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3NvYy9tZWRpYXRlay9zbWku
aCBiL2luY2x1ZGUvc29jL21lZGlhdGVrL3NtaS5oDQo+ID4gaW5kZXggNWEzNGI4N2Q4OWUzLi4y
OWUyZmI4ZjMzZDYgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9zb2MvbWVkaWF0ZWsvc21pLmgN
Cj4gPiArKysgYi9pbmNsdWRlL3NvYy9tZWRpYXRlay9zbWkuaA0KPiA+IEBAIC05LDcgKzksNyBA
QA0KPiA+ICAjaW5jbHVkZSA8bGludXgvYml0b3BzLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9k
ZXZpY2UuaD4NCj4gPiAgDQo+ID4gLSNpZmRlZiBDT05GSUdfTVRLX1NNSQ0KPiA+ICsjaWYgSVNf
RU5BQkxFRChDT05GSUdfTVRLX1NNSSkNCg0K

