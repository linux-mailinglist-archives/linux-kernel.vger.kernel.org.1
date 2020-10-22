Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B474295F1F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899150AbgJVM5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:57:22 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:51623 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2899020AbgJVM4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:56:11 -0400
X-UUID: a88b7edf3ac8499e8cc94a5e56d090d0-20201022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=JpP9G8B7XWdYj4DeKEXuUgHck3Kd7SmbxMhnFwU2By0=;
        b=INhXaUNCjOhtIcJxjj1PNcaCOsQJgpmvDIj/6k4GvehVO5op41ugeYeYtnx54l85h/xXu+Mbq4WWMaT4drBqa66CyN0f8kfhHSJYNz4KWd+D+1EjMkWEtfvsw7Gycj/KElT/tNQjKQGy9H4tbrU+YGTboO6ancbKf3IUMHhYNg4=;
X-UUID: a88b7edf3ac8499e8cc94a5e56d090d0-20201022
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1295960247; Thu, 22 Oct 2020 20:56:08 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 22 Oct 2020 20:56:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Oct 2020 20:56:07 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH 03/12] clk: mediatek: Clean up the pll_en_bit from en_mask on MT6765
Date:   Thu, 22 Oct 2020 20:55:56 +0800
Message-ID: <1603371365-30863-4-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1603371365-30863-1-git-send-email-weiyi.lu@mediatek.com>
References: <1603371365-30863-1-git-send-email-weiyi.lu@mediatek.com>
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
L21lZGlhdGVrL2Nsay1tdDY3NjUuYyB8IDIwICsrKysrKysrKystLS0tLS0tLS0tDQogMSBmaWxl
IGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10Njc2NS5jIGIvZHJpdmVycy9jbGsvbWVkaWF0
ZWsvY2xrLW10Njc2NS5jDQppbmRleCBkYjhkYjFiLi4wOTdiYmM0IDEwMDY0NA0KLS0tIGEvZHJp
dmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10Njc2NS5jDQorKysgYi9kcml2ZXJzL2Nsay9tZWRpYXRl
ay9jbGstbXQ2NzY1LmMNCkBAIC03NDcsMjYgKzc0NywyNiBAQA0KIAkJCV9wY3dfcmVnLCBfcGN3
X3NoaWZ0LCBOVUxMKQlcDQogDQogc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfcGxsX2RhdGEgcGxs
c1tdID0gew0KLQlQTEwoQ0xLX0FQTUlYRURfQVJNUExMX0wsICJhcm1wbGxfbCIsIDB4MDIxQywg
MHgwMjI4LCBCSVQoMCksDQorCVBMTChDTEtfQVBNSVhFRF9BUk1QTExfTCwgImFybXBsbF9sIiwg
MHgwMjFDLCAweDAyMjgsIDAsDQogCSAgICBQTExfQU8sIDIyLCA4LCAweDAyMjAsIDI0LCAwLCAw
LCAwLCAweDAyMjAsIDApLA0KLQlQTEwoQ0xLX0FQTUlYRURfQVJNUExMLCAiYXJtcGxsIiwgMHgw
MjBDLCAweDAyMTgsIEJJVCgwKSwNCisJUExMKENMS19BUE1JWEVEX0FSTVBMTCwgImFybXBsbCIs
IDB4MDIwQywgMHgwMjE4LCAwLA0KIAkgICAgUExMX0FPLCAyMiwgOCwgMHgwMjEwLCAyNCwgMCwg
MCwgMCwgMHgwMjEwLCAwKSwNCi0JUExMKENMS19BUE1JWEVEX0NDSVBMTCwgImNjaXBsbCIsIDB4
MDIyQywgMHgwMjM4LCBCSVQoMCksDQorCVBMTChDTEtfQVBNSVhFRF9DQ0lQTEwsICJjY2lwbGwi
LCAweDAyMkMsIDB4MDIzOCwgMCwNCiAJICAgIFBMTF9BTywgMjIsIDgsIDB4MDIzMCwgMjQsIDAs
IDAsIDAsIDB4MDIzMCwgMCksDQotCVBMTChDTEtfQVBNSVhFRF9NQUlOUExMLCAibWFpbnBsbCIs
IDB4MDIzQywgMHgwMjQ4LCBCSVQoMCksDQorCVBMTChDTEtfQVBNSVhFRF9NQUlOUExMLCAibWFp
bnBsbCIsIDB4MDIzQywgMHgwMjQ4LCAwLA0KIAkgICAgKEhBVkVfUlNUX0JBUiB8IFBMTF9BTyks
IDIyLCA4LCAweDAyNDAsIDI0LCAwLCAwLCAwLCAweDAyNDAsDQogCSAgICAwKSwNCi0JUExMKENM
S19BUE1JWEVEX01GR1BMTCwgIm1mZ3BsbCIsIDB4MDI0QywgMHgwMjU4LCBCSVQoMCksDQorCVBM
TChDTEtfQVBNSVhFRF9NRkdQTEwsICJtZmdwbGwiLCAweDAyNEMsIDB4MDI1OCwgMCwNCiAJICAg
IDAsIDIyLCA4LCAweDAyNTAsIDI0LCAwLCAwLCAwLCAweDAyNTAsIDApLA0KLQlQTEwoQ0xLX0FQ
TUlYRURfTU1QTEwsICJtbXBsbCIsIDB4MDI1QywgMHgwMjY4LCBCSVQoMCksDQorCVBMTChDTEtf
QVBNSVhFRF9NTVBMTCwgIm1tcGxsIiwgMHgwMjVDLCAweDAyNjgsIDAsDQogCSAgICAwLCAyMiwg
OCwgMHgwMjYwLCAyNCwgMCwgMCwgMCwgMHgwMjYwLCAwKSwNCi0JUExMKENMS19BUE1JWEVEX1VO
SVYyUExMLCAidW5pdjJwbGwiLCAweDAyNkMsIDB4MDI3OCwgQklUKDApLA0KKwlQTEwoQ0xLX0FQ
TUlYRURfVU5JVjJQTEwsICJ1bml2MnBsbCIsIDB4MDI2QywgMHgwMjc4LCAwLA0KIAkgICAgSEFW
RV9SU1RfQkFSLCAyMiwgOCwgMHgwMjcwLCAyNCwgMCwgMCwgMCwgMHgwMjcwLCAwKSwNCi0JUExM
KENMS19BUE1JWEVEX01TRENQTEwsICJtc2RjcGxsIiwgMHgwMjdDLCAweDAyODgsIEJJVCgwKSwN
CisJUExMKENMS19BUE1JWEVEX01TRENQTEwsICJtc2RjcGxsIiwgMHgwMjdDLCAweDAyODgsIDAs
DQogCSAgICAwLCAyMiwgOCwgMHgwMjgwLCAyNCwgMCwgMCwgMCwgMHgwMjgwLCAwKSwNCi0JUExM
KENMS19BUE1JWEVEX0FQTEwxLCAiYXBsbDEiLCAweDAyOEMsIDB4MDI5QywgQklUKDApLA0KKwlQ
TEwoQ0xLX0FQTUlYRURfQVBMTDEsICJhcGxsMSIsIDB4MDI4QywgMHgwMjlDLCAwLA0KIAkgICAg
MCwgMzIsIDgsIDB4MDI5MCwgMjQsIDB4MDA0MCwgMHgwMDBDLCAwLCAweDAyOTQsIDApLA0KLQlQ
TEwoQ0xLX0FQTUlYRURfTVBMTCwgIm1wbGwiLCAweDAyQTAsIDB4MDJBQywgQklUKDApLA0KKwlQ
TEwoQ0xLX0FQTUlYRURfTVBMTCwgIm1wbGwiLCAweDAyQTAsIDB4MDJBQywgMCwNCiAJICAgIFBM
TF9BTywgMjIsIDgsIDB4MDJBNCwgMjQsIDAsIDAsIDAsIDB4MDJBNCwgMCksDQogfTsNCiANCi0t
IA0KMS44LjEuMS5kaXJ0eQ0K

