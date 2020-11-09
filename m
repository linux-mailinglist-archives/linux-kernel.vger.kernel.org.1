Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1C12AAF25
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 03:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbgKICNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 21:13:45 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:38108 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727979AbgKICNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 21:13:42 -0500
X-UUID: ee7e091f9100480f817d75b1cb6d0b12-20201109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=FKhZuwpPHP3D4MgABPAntEpB83EFCx5rbahAxeXDleI=;
        b=tZr/46NozoS/5gzw68mkGlCgpiScF4msnYbQI5JMFru4hjeIKjxrk+MczG6Q9ETyug41I04yPavWsM7nKzRBT6pa7KbnO5QFf0bc+nivzuOfnP6TShrRUvULGApa+TZVP2yCUYSHCDNrEusI5zPABptnSO9NcIzG+Wha5RmdVJI=;
X-UUID: ee7e091f9100480f817d75b1cb6d0b12-20201109
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 617512412; Mon, 09 Nov 2020 10:13:37 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 9 Nov 2020 10:13:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 9 Nov 2020 10:13:37 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v2 04/13] clk: mediatek: Clean up the pll_en_bit from en_mask on MT6779
Date:   Mon, 9 Nov 2020 10:13:19 +0800
Message-ID: <1604888008-30555-5-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1604888008-30555-1-git-send-email-weiyi.lu@mediatek.com>
References: <1604888008-30555-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cmVtb3ZlIHBsbF9lbl9iaXQoYml0MCkgZnJvbSBlbl9tYXNrIHRvIG1ha2UgZW5fbWFzayBhIHB1
cmUgZW5fbWFzaw0KdGhhdCBvbmx5IHVzZWQgZm9yIHBsbCBkaXZpZGVycy4NCg0KU2lnbmVkLW9m
Zi1ieTogV2VpeWkgTHUgPHdlaXlpLmx1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvY2xr
L21lZGlhdGVrL2Nsay1tdDY3NzkuYyB8IDI0ICsrKysrKysrKysrKy0tLS0tLS0tLS0tLQ0KIDEg
ZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDY3NzkuYyBiL2RyaXZlcnMvY2xrL21l
ZGlhdGVrL2Nsay1tdDY3NzkuYw0KaW5kZXggNmUwZDNhMS4uODllMWJkNCAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDY3NzkuYw0KKysrIGIvZHJpdmVycy9jbGsvbWVk
aWF0ZWsvY2xrLW10Njc3OS5jDQpAQCAtMTE4MCwzMyArMTE4MCwzMyBAQA0KIAkJCV9wY3dfY2hn
X3JlZywgTlVMTCkNCiANCiBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19wbGxfZGF0YSBwbGxzW10g
PSB7DQotCVBMTChDTEtfQVBNSVhFRF9BUk1QTExfTEwsICJhcm1wbGxfbGwiLCAweDAyMDAsIDB4
MDIwQywgQklUKDApLA0KKwlQTEwoQ0xLX0FQTUlYRURfQVJNUExMX0xMLCAiYXJtcGxsX2xsIiwg
MHgwMjAwLCAweDAyMEMsIDAsDQogCSAgICBQTExfQU8sIDAsIDIyLCA4LCAweDAyMDQsIDI0LCAw
LCAwLCAwLCAweDAyMDQsIDAsIDApLA0KLQlQTEwoQ0xLX0FQTUlYRURfQVJNUExMX0JMLCAiYXJt
cGxsX2JsIiwgMHgwMjEwLCAweDAyMUMsIEJJVCgwKSwNCisJUExMKENMS19BUE1JWEVEX0FSTVBM
TF9CTCwgImFybXBsbF9ibCIsIDB4MDIxMCwgMHgwMjFDLCAwLA0KIAkgICAgUExMX0FPLCAwLCAy
MiwgOCwgMHgwMjE0LCAyNCwgMCwgMCwgMCwgMHgwMjE0LCAwLCAwKSwNCi0JUExMKENMS19BUE1J
WEVEX0NDSVBMTCwgImNjaXBsbCIsIDB4MDJBMCwgMHgwMkFDLCBCSVQoMCksDQorCVBMTChDTEtf
QVBNSVhFRF9DQ0lQTEwsICJjY2lwbGwiLCAweDAyQTAsIDB4MDJBQywgMCwNCiAJICAgIFBMTF9B
TywgMCwgMjIsIDgsIDB4MDJBNCwgMjQsIDAsIDAsIDAsIDB4MDJBNCwgMCwgMCksDQotCVBMTChD
TEtfQVBNSVhFRF9NQUlOUExMLCAibWFpbnBsbCIsIDB4MDIzMCwgMHgwMjNDLCBCSVQoMCksDQor
CVBMTChDTEtfQVBNSVhFRF9NQUlOUExMLCAibWFpbnBsbCIsIDB4MDIzMCwgMHgwMjNDLCAwLA0K
IAkgICAgKEhBVkVfUlNUX0JBUiksIEJJVCgyNCksIDIyLCA4LCAweDAyMzQsIDI0LCAwLCAwLCAw
LA0KIAkgICAgMHgwMjM0LCAwLCAwKSwNCi0JUExMKENMS19BUE1JWEVEX1VOSVYyUExMLCAidW5p
djJwbGwiLCAweDAyNDAsIDB4MDI0QywgQklUKDApLA0KKwlQTEwoQ0xLX0FQTUlYRURfVU5JVjJQ
TEwsICJ1bml2MnBsbCIsIDB4MDI0MCwgMHgwMjRDLCAwLA0KIAkgICAgKEhBVkVfUlNUX0JBUiks
IEJJVCgyNCksIDIyLCA4LCAweDAyNDQsIDI0LA0KIAkgICAgMCwgMCwgMCwgMHgwMjQ0LCAwLCAw
KSwNCi0JUExMKENMS19BUE1JWEVEX01GR1BMTCwgIm1mZ3BsbCIsIDB4MDI1MCwgMHgwMjVDLCBC
SVQoMCksDQorCVBMTChDTEtfQVBNSVhFRF9NRkdQTEwsICJtZmdwbGwiLCAweDAyNTAsIDB4MDI1
QywgMCwNCiAJICAgIDAsIDAsIDIyLCA4LCAweDAyNTQsIDI0LCAwLCAwLCAwLCAweDAyNTQsIDAs
IDApLA0KLQlQTEwoQ0xLX0FQTUlYRURfTVNEQ1BMTCwgIm1zZGNwbGwiLCAweDAyNjAsIDB4MDI2
QywgQklUKDApLA0KKwlQTEwoQ0xLX0FQTUlYRURfTVNEQ1BMTCwgIm1zZGNwbGwiLCAweDAyNjAs
IDB4MDI2QywgMCwNCiAJICAgIDAsIDAsIDIyLCA4LCAweDAyNjQsIDI0LCAwLCAwLCAwLCAweDAy
NjQsIDAsIDApLA0KLQlQTEwoQ0xLX0FQTUlYRURfVFZEUExMLCAidHZkcGxsIiwgMHgwMjcwLCAw
eDAyN0MsIEJJVCgwKSwNCisJUExMKENMS19BUE1JWEVEX1RWRFBMTCwgInR2ZHBsbCIsIDB4MDI3
MCwgMHgwMjdDLCAwLA0KIAkgICAgMCwgMCwgMjIsIDgsIDB4MDI3NCwgMjQsIDAsIDAsIDAsIDB4
MDI3NCwgMCwgMCksDQotCVBMTChDTEtfQVBNSVhFRF9BRFNQUExMLCAiYWRzcHBsbCIsIDB4MDJi
MCwgMHgwMmJDLCBCSVQoMCksDQorCVBMTChDTEtfQVBNSVhFRF9BRFNQUExMLCAiYWRzcHBsbCIs
IDB4MDJiMCwgMHgwMmJDLCAwLA0KIAkgICAgKEhBVkVfUlNUX0JBUiksIEJJVCgyMyksIDIyLCA4
LCAweDAyYjQsIDI0LA0KIAkgICAgMCwgMCwgMCwgMHgwMmI0LCAwLCAwKSwNCi0JUExMKENMS19B
UE1JWEVEX01NUExMLCAibW1wbGwiLCAweDAyODAsIDB4MDI4QywgQklUKDApLA0KKwlQTEwoQ0xL
X0FQTUlYRURfTU1QTEwsICJtbXBsbCIsIDB4MDI4MCwgMHgwMjhDLCAwLA0KIAkgICAgKEhBVkVf
UlNUX0JBUiksIEJJVCgyMyksIDIyLCA4LCAweDAyODQsIDI0LA0KIAkgICAgMCwgMCwgMCwgMHgw
Mjg0LCAwLCAwKSwNCi0JUExMKENMS19BUE1JWEVEX0FQTEwxLCAiYXBsbDEiLCAweDAyQzAsIDB4
MDJEMCwgQklUKDApLA0KKwlQTEwoQ0xLX0FQTUlYRURfQVBMTDEsICJhcGxsMSIsIDB4MDJDMCwg
MHgwMkQwLCAwLA0KIAkgICAgMCwgMCwgMzIsIDgsIDB4MDJDMCwgMSwgMCwgMHgxNCwgMCwgMHgw
MkM0LCAwLCAweDJDMCksDQotCVBMTChDTEtfQVBNSVhFRF9BUExMMiwgImFwbGwyIiwgMHgwMkQ0
LCAweDAyRTQsIEJJVCgwKSwNCisJUExMKENMS19BUE1JWEVEX0FQTEwyLCAiYXBsbDIiLCAweDAy
RDQsIDB4MDJFNCwgMCwNCiAJICAgIDAsIDAsIDMyLCA4LCAweDAyRDQsIDEsIDAsIDB4MTQsIDEs
IDB4MDJEOCwgMCwgMHgwMkQ0KSwNCiB9Ow0KIA0KLS0gDQoxLjguMS4xLmRpcnR5DQo=

