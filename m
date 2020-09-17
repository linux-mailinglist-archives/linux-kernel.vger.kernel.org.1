Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5617926D406
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 08:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgIQG5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 02:57:19 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:39923 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726192AbgIQG5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 02:57:17 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 02:57:15 EDT
X-UUID: e55451a087fc42be8ef1c6b376087c54-20200917
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=fhSCGvsrIBFTU6Oe3bgRtFqtBj0ow+eXgKg9mZZzjAo=;
        b=mkXZApdw1q4Ada/u7mbaP0uKPociAuqFn4pQLb030fmPObNTH1GnLGrGnbCh5/PzKxJQAmrNMzT+nHUJRTAjkDyyO+mE27c4r/qu7CeZzHtF8U0SCNeP3dxXCVwAKKQLdFxYjN6gLWRcU5mjmfMvnDWk+1AKswd7G/7iBksMxrY=;
X-UUID: e55451a087fc42be8ef1c6b376087c54-20200917
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 659381008; Thu, 17 Sep 2020 14:52:05 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 17 Sep
 2020 14:52:03 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Sep 2020 14:52:02 +0800
Message-ID: <1600325394.20109.16.camel@mhfsdcap03>
Subject: Re: [PATCH] MAINTAINERS: Add entry for Broadcom BDC driver
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Florian Fainelli <f.fainelli@gmail.com>, <balbi@kernel.org>,
        <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>, <balbi@kernel.org>,
        <gregkh@linuxfoundation.org>, <matthias.bgg@gmail.com>,
        <swboyd@chromium.org>, <linux-arm-kernel@lists.infradead.org>,
        <alcooperx@gmail.com>
Date:   Thu, 17 Sep 2020 14:49:54 +0800
In-Reply-To: <830cd104-87de-4246-35ff-47a0ed5b05a9@gmail.com>
References: <20200710034806.15650-1-f.fainelli@gmail.com>
         <830cd104-87de-4246-35ff-47a0ed5b05a9@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 003D9F375333C4C19A1819A9282574292585033BFA22A87247ADF63049C69E1C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIwLTA5LTA2IGF0IDEyOjU1IC0wNzAwLCBGbG9yaWFuIEZhaW5lbGxpIHdyb3Rl
Og0KPiANCj4gT24gNy85LzIwMjAgODo0OCBQTSwgRmxvcmlhbiBGYWluZWxsaSB3cm90ZToNCj4g
PiBUaGUgQnJvYWRjb20gQkRDIGRyaXZlciBkaWQgbm90IGhhdmUgYSBNQUlOVEFJTkVSUyBlbnRy
eSB3aGljaCBtYWRlIGl0DQo+ID4gZXNjYXBlIHJldmlldyBmcm9tIEFsIGFuZCBteXNlbGYsIGFk
ZCBhbiBlbnRyeSBzbyB0aGUgcmVsZXZhbnQgbWFpbGluZw0KPiA+IGxpc3RzIGFuZCBwZW9wbGUg
YXJlIGNvcGllZC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBGbG9yaWFuIEZhaW5lbGxpIDxm
LmZhaW5lbGxpQGdtYWlsLmNvbT4NCj4gDQo+IFRoaXMgcGF0Y2ggc3RpbGwgZG9lcyBub3Qgc2Vl
bSB0byBoYXZlIGJlZW4gcGlja2VkIHVwIChub3Qgc2VlaW5nIGl0IGluIA0KPiBsaW51eC1uZXh0
KSwgY2FuIHRoaXMgYmUgYXBwbGllZCBzbyB3ZSBoYXZlIGFuIGFjY3VyYXRlIG1haW50YWluZXIg
DQo+IGluZm9ybWF0aW9uIGZvciB0aGlzIGRyaXZlcj8NClBpbmcNCg0KPiANCj4gVGhhbmtzDQo+
IA0KPiA+IC0tLQ0KPiA+ICAgTUFJTlRBSU5FUlMgfCA4ICsrKysrKysrDQo+ID4gICAxIGZpbGUg
Y2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL01BSU5UQUlO
RVJTIGIvTUFJTlRBSU5FUlMNCj4gPiBpbmRleCAxZDRhYTdmOTQyZGUuLjM2MGQwMDFiODFiOCAx
MDA2NDQNCj4gPiAtLS0gYS9NQUlOVEFJTkVSUw0KPiA+ICsrKyBiL01BSU5UQUlORVJTDQo+ID4g
QEAgLTM0MzQsNiArMzQzNCwxNCBAQCBGOglkcml2ZXJzL2J1cy9icmNtc3RiX2dpc2IuYw0KPiA+
ICAgRjoJZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLWJyY21zdGIuYw0KPiA+ICAgTjoJYnJj
bXN0Yg0KPiA+ICAgDQo+ID4gK0JST0FEQ09NIEJEQyBEUklWRVINCj4gPiArTToJQWwgQ29vcGVy
IDxhbGNvb3BlcnhAZ21haWwuY29tPg0KPiA+ICtMOglsaW51eC11c2JAdmdlci5rZXJuZWwub3Jn
DQo+ID4gK0w6CWJjbS1rZXJuZWwtZmVlZGJhY2stbGlzdEBicm9hZGNvbS5jb20NCj4gPiArUzoJ
TWFpbnRhaW5lZA0KPiA+ICtGOglEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNi
L2JyY20sYmRjLnR4dA0KPiA+ICtGOglkcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy8NCj4gPiAr
DQo+ID4gICBCUk9BRENPTSBCTUlQUyBDUFVGUkVRIERSSVZFUg0KPiA+ICAgTToJTWFya3VzIE1h
eWVyIDxtbWF5ZXJAYnJvYWRjb20uY29tPg0KPiA+ICAgTToJYmNtLWtlcm5lbC1mZWVkYmFjay1s
aXN0QGJyb2FkY29tLmNvbQ0KPiA+IA0KPiANCg0K

