Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8971E24AEE3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 08:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgHTGFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 02:05:37 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:1222 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725768AbgHTGFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 02:05:37 -0400
X-UUID: fa639e406d5642449f4a9beced0c2978-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=T3fsiKzAfuDkPTZGpq2v7PuBxfB9dzJbAW9KikxKdO4=;
        b=M7TN0zI3dRlluag4g7IEiQO7vMY490hKEgFXTtrMeh7nR3xWmBsE45DTOMkTOMffyMbz4BeG7hnvfvOQZd9yu+0yXZpBl0XbqtXLoAicoQu88pBHy1YMGvMpGC992SfNKPliZyyh0h7AuVe50+3Kjul2Qy4X5p2mCmdvnGSMW/c=;
X-UUID: fa639e406d5642449f4a9beced0c2978-20200820
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1472691088; Thu, 20 Aug 2020 14:05:34 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Aug 2020 14:05:32 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 14:05:31 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v1 01/21] drm/mediatek: add component OVL_2L2
Date:   Thu, 20 Aug 2020 14:03:58 +0800
Message-ID: <1597903458-8055-2-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597903458-8055-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1597903458-8055-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBhZGQgY29tcG9uZW50IE9WTF8yTDINCg0KU2lnbmVkLW9mZi1ieTogWW9uZ3Fp
YW5nIE5pdSA8eW9uZ3FpYW5nLm5pdUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jIHwgMSArDQogaW5jbHVkZS9saW51eC9zb2Mv
bWVkaWF0ZWsvbXRrLW1tc3lzLmggICAgICB8IDEgKw0KIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Ry
bV9kZHBfY29tcC5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAu
Yw0KaW5kZXggNTdjODhkZS4uNWU5N2NhNSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHJtX2RkcF9jb21wLmMNCkBAIC00MDEsNiArNDAxLDcgQEAgc3RydWN0IG10a19kZHBf
Y29tcF9tYXRjaCB7DQogCVtERFBfQ09NUE9ORU5UX09WTDFdCT0geyBNVEtfRElTUF9PVkwsCTEs
IE5VTEwgfSwNCiAJW0REUF9DT01QT05FTlRfT1ZMXzJMMF0JPSB7IE1US19ESVNQX09WTF8yTCwJ
MCwgTlVMTCB9LA0KIAlbRERQX0NPTVBPTkVOVF9PVkxfMkwxXQk9IHsgTVRLX0RJU1BfT1ZMXzJM
LAkxLCBOVUxMIH0sDQorCVtERFBfQ09NUE9ORU5UX09WTF8yTDJdCT0geyBNVEtfRElTUF9PVkxf
MkwsCTIsIE5VTEwgfSwNCiAJW0REUF9DT01QT05FTlRfUFdNMF0JPSB7IE1US19ESVNQX1BXTSwJ
MCwgTlVMTCB9LA0KIAlbRERQX0NPTVBPTkVOVF9QV00xXQk9IHsgTVRLX0RJU1BfUFdNLAkxLCBO
VUxMIH0sDQogCVtERFBfQ09NUE9ORU5UX1BXTTJdCT0geyBNVEtfRElTUF9QV00sCTIsIE5VTEwg
fSwNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstbW1zeXMuaCBi
L2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1tbXN5cy5oDQppbmRleCA4OTE4NWM2Li4y
NjhkOTVhIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLW1tc3lz
LmgNCisrKyBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1tbXN5cy5oDQpAQCAtMjks
NiArMjksNyBAQCBlbnVtIG10a19kZHBfY29tcF9pZCB7DQogCUREUF9DT01QT05FTlRfT1ZMMCwN
CiAJRERQX0NPTVBPTkVOVF9PVkxfMkwwLA0KIAlERFBfQ09NUE9ORU5UX09WTF8yTDEsDQorCURE
UF9DT01QT05FTlRfT1ZMXzJMMiwNCiAJRERQX0NPTVBPTkVOVF9PVkwxLA0KIAlERFBfQ09NUE9O
RU5UX1BXTTAsDQogCUREUF9DT01QT05FTlRfUFdNMSwNCi0tIA0KMS44LjEuMS5kaXJ0eQ0K

