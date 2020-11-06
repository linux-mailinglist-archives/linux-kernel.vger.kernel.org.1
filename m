Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A90B2A9384
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgKFJ6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:58:46 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:48779 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726075AbgKFJ6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:58:46 -0500
X-UUID: 8529835258ca4689bd97b26971337d07-20201106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=4s+L7wob1CsZbTthU7rAq7FTbLUsWXrb2OgOu2nJ7fo=;
        b=d7kmhsuQvTimtfvpgc0k+T1KEaoBxx9Dm/kyM7x2X3xbfIiFb5SmDUmi5UKfI0q7GNIiZW7dBGJCYQxvLWSIjrNzCVYYVniVY8/omtlGctyMIUqBT+njrGedsYvPAGxej1gsutGGi2iSsLT8VVJ6dymWfV1t2+c0CmqZ/CM9mkg=;
X-UUID: 8529835258ca4689bd97b26971337d07-20201106
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1293617369; Fri, 06 Nov 2020 17:58:42 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 6 Nov 2020 17:58:39 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 6 Nov 2020 17:58:39 +0800
Message-ID: <1604656720.24301.24.camel@mtkswgap22>
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: mediatek,mtk-xhci: add
 str-clock-on
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        "Chunfeng Yun =?UTF-8?Q?=28=E4=BA=91=E6=98=A5=E5=B3=B0=29?=" 
        <Chunfeng.Yun@mediatek.com>,
        Ainge Hsu =?UTF-8?Q?=28=E5=BE=90=E5=B7=A7=E5=AE=9C=29?= 
        <ainge.hsu@mediatek.com>,
        Eddie Hung =?UTF-8?Q?=28=E6=B4=AA=E6=AD=A3=E9=91=AB=29?= 
        <Eddie.Hung@mediatek.com>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 6 Nov 2020 17:58:40 +0800
In-Reply-To: <1604655965-22418-1-git-send-email-macpaul.lin@mediatek.com>
References: <1604301530-31546-1-git-send-email-macpaul.lin@mediatek.com>
         <1604655965-22418-1-git-send-email-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTExLTA2IGF0IDE3OjQ2ICswODAwLCBNYWNwYXVsIExpbiB3cm90ZToNCj4g
T3B0aW9uICJtZWRpYXRlayxzdHItY2xvY2stb24iIG1lYW5zIHRvIGtlZXAgY2xvY2sgb24gZHVy
aW5nIHN5c3RlbQ0KPiBzdXNwZW5kIGFuZCByZXN1bWUuIFNvbWUgcGxhdGZvcm0gd2lsbCBmbHVz
aCByZWdpc3RlciBzZXR0aW5ncyBpZiBjbG9jayBoYXMNCj4gYmVlbiBkaXNhYmxlZCB3aGVuIHN5
c3RlbSBpcyBzdXNwZW5kZWQuIFNldCB0aGlzIG9wdGlvbiB0byBhdm9pZCBjbG9jayBvZmYuDQo+
IA0KPiBDaGFuZ2UtSWQ6IElkODQxZjU4ZTlkN2ZiMzY1NjUxMTA3MmIzZWIxNGQwZDM1NWUyZGQ1
DQoNClNvcnJ5IEkndmUgZm91bmQgYSBDaGFuZ2UtSUQgdGFnIGhlcmUsDQpJJ2xsIHNlbmQgcGF0
Y2ggdjMuDQoNCj4gU2lnbmVkLW9mZi1ieTogTWFjcGF1bCBMaW4gPG1hY3BhdWwubGluQG1lZGlh
dGVrLmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgZm9yIHYyOg0KPiAgIC0gUmVuYW1lICJtZWRpYXRl
ayxrZWVwLWNsb2NrLW9uIiB0byAibWVkaWF0ZWssc3RyLWNsb2NrLW9uIiB3aGljaCBpbXBsaWVz
DQo+ICAgICB0aGlzIG9wdGlvbiByZWxhdGVkIHRvIFNUUiBmdW5jdGlvbnMuDQo+ICAgLSBBZnRl
ciBkaXNjdXNzaW9uIHdpdGggQ2h1bmZlbmcsIHJlc2VuZCBkdC1iaW5kaW5ncyBkZXNjcml0cHRp
b24gYmFzZWQgb24NCj4gICAgIG1lZGlhdGVrLG10ay14aGNpLnR4dCBpbnN0ZWFkIG9mIHlhbWwg
Zm9ybWF0Lg0KPiANCj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9tZWRpYXRlayxtdGst
eGhjaS50eHQgIHwgICAgMyArKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykN
Cj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNi
L21lZGlhdGVrLG10ay14aGNpLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy91c2IvbWVkaWF0ZWssbXRrLXhoY2kudHh0DQo+IGluZGV4IDQyZDg4MTQuLmZjOTNiY2YgMTAw
NjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0
ZWssbXRrLXhoY2kudHh0DQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy91c2IvbWVkaWF0ZWssbXRrLXhoY2kudHh0DQo+IEBAIC0zNyw2ICszNyw5IEBAIFJlcXVpcmVk
IHByb3BlcnRpZXM6DQo+ICANCj4gIE9wdGlvbmFsIHByb3BlcnRpZXM6DQo+ICAgLSB3YWtldXAt
c291cmNlIDogZW5hYmxlIFVTQiByZW1vdGUgd2FrZXVwOw0KPiArIC0gbWVkaWF0ZWssc3RyLWNs
b2NrLW9uOiBLZWVwIGNsb2NrIG9uIGR1cmluZyBzeXN0ZW0gc3VzcGVuZCBhbmQgcmVzdW1lLg0K
PiArCVNvbWUgcGxhdGZvcm0gd2lsbCBmbHVzaCByZWdpc3RlciBzZXR0aW5ncyBpZiBjbG9jayBo
YXMgYmVlbiBkaXNhYmxlZA0KPiArCXdoZW4gc3lzdGVtIGlzIHN1c3BlbmRlZC4NCj4gICAtIG1l
ZGlhdGVrLHN5c2Nvbi13YWtldXAgOiBwaGFuZGxlIHRvIHN5c2NvbiB1c2VkIHRvIGFjY2VzcyB0
aGUgcmVnaXN0ZXINCj4gIAlvZiB0aGUgVVNCIHdha2V1cCBnbHVlIGxheWVyIGJldHdlZW4geEhD
SSBhbmQgU1BNOyBpdCBkZXBlbmRzIG9uDQo+ICAJIndha2V1cC1zb3VyY2UiLCBhbmQgaGFzIHR3
byBhcmd1bWVudHM6DQoNClRoYW5rcw0KTWFjcGF1bCBMaW4NCg==

