Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7648C23F610
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Aug 2020 04:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgHHCyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Aug 2020 22:54:52 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:31249 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726524AbgHHCyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 22:54:51 -0400
X-UUID: 4991f4db789642d0818e6d370a5b980f-20200808
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Grs5ZKo+Kb4nPk8FUoPPdvMh04ElZQ3N2JhQRc+vMC4=;
        b=p9+4C6+tJkbCm+JNcinwZfhFchqp9StP6mS7eNBqVl19NUYgWl+GHyPiq7u12udlDMTHfsmK4VBX3Rx+VysXkx5Ye4aOriwXwxh+5VXYYMocvf70XN82Lr1NkbHo/rDMHuFRw3OSxwk4nKYh3Ot4bKrVz+ie1vpwALDNrvtuttQ=;
X-UUID: 4991f4db789642d0818e6d370a5b980f-20200808
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2033817857; Sat, 08 Aug 2020 10:54:47 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 8 Aug 2020 10:54:45 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 8 Aug 2020 10:54:44 +0800
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
Subject: [RESEND v7, PATCH 7/7] arm64: dts: add display nodes for mt8183
Date:   Sat, 8 Aug 2020 10:53:51 +0800
Message-ID: <1596855231-5782-8-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1596855231-5782-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1596855231-5782-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBhZGQgZGlzcGxheSBub2RlcyBmb3IgbXQ4MTgzDQoNClNpZ25lZC1vZmYtYnk6
IFlvbmdxaWFuZyBOaXUgPHlvbmdxaWFuZy5uaXVAbWVkaWF0ZWsuY29tPg0KLS0tDQogYXJjaC9h
cm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaSB8IDk4ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDk4IGluc2VydGlvbnMoKykNCg0KZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kgYi9hcmNo
L2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4My5kdHNpDQppbmRleCA3Yjc4MWViLi40NDBj
ZjIyIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRz
aQ0KKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaQ0KQEAgLTMx
LDYgKzMxLDExIEBADQogCQlpMmM5ID0gJmkyYzk7DQogCQlpMmMxMCA9ICZpMmMxMDsNCiAJCWky
YzExID0gJmkyYzExOw0KKwkJb3ZsMCA9ICZvdmwwOw0KKwkJb3ZsXzJsMCA9ICZvdmxfMmwwOw0K
KwkJb3ZsXzJsMSA9ICZvdmxfMmwxOw0KKwkJcmRtYTAgPSAmcmRtYTA7DQorCQlyZG1hMSA9ICZy
ZG1hMTsNCiAJfTsNCiANCiAJY3B1cyB7DQpAQCAtNzA3LDkgKzcxMiwxMDIgQEANCiAJCW1tc3lz
OiBzeXNjb25AMTQwMDAwMDAgew0KIAkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTgzLW1t
c3lzIiwgInN5c2NvbiI7DQogCQkJcmVnID0gPDAgMHgxNDAwMDAwMCAwIDB4MTAwMD47DQorCQkJ
cG93ZXItZG9tYWlucyA9IDwmc2Nwc3lzIE1UODE4M19QT1dFUl9ET01BSU5fRElTUD47DQogCQkJ
I2Nsb2NrLWNlbGxzID0gPDE+Ow0KIAkJfTsNCiANCisJCW92bDA6IG92bEAxNDAwODAwMCB7DQor
CQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtZGlzcC1vdmwiOw0KKwkJCXJlZyA9IDww
IDB4MTQwMDgwMDAgMCAweDEwMDA+Ow0KKwkJCWludGVycnVwdHMgPSA8R0lDX1NQSSAyMjUgSVJR
X1RZUEVfTEVWRUxfTE9XPjsNCisJCQlwb3dlci1kb21haW5zID0gPCZzY3BzeXMgTVQ4MTgzX1BP
V0VSX0RPTUFJTl9ESVNQPjsNCisJCQljbG9ja3MgPSA8Jm1tc3lzIENMS19NTV9ESVNQX09WTDA+
Ow0KKwkJfTsNCisNCisJCW92bF8ybDA6IG92bEAxNDAwOTAwMCB7DQorCQkJY29tcGF0aWJsZSA9
ICJtZWRpYXRlayxtdDgxODMtZGlzcC1vdmwtMmwiOw0KKwkJCXJlZyA9IDwwIDB4MTQwMDkwMDAg
MCAweDEwMDA+Ow0KKwkJCWludGVycnVwdHMgPSA8R0lDX1NQSSAyMjYgSVJRX1RZUEVfTEVWRUxf
TE9XPjsNCisJCQlwb3dlci1kb21haW5zID0gPCZzY3BzeXMgTVQ4MTgzX1BPV0VSX0RPTUFJTl9E
SVNQPjsNCisJCQljbG9ja3MgPSA8Jm1tc3lzIENMS19NTV9ESVNQX09WTDBfMkw+Ow0KKwkJfTsN
CisNCisJCW92bF8ybDE6IG92bEAxNDAwYTAwMCB7DQorCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRl
ayxtdDgxODMtZGlzcC1vdmwtMmwiOw0KKwkJCXJlZyA9IDwwIDB4MTQwMGEwMDAgMCAweDEwMDA+
Ow0KKwkJCWludGVycnVwdHMgPSA8R0lDX1NQSSAyMjcgSVJRX1RZUEVfTEVWRUxfTE9XPjsNCisJ
CQlwb3dlci1kb21haW5zID0gPCZzY3BzeXMgTVQ4MTgzX1BPV0VSX0RPTUFJTl9ESVNQPjsNCisJ
CQljbG9ja3MgPSA8Jm1tc3lzIENMS19NTV9ESVNQX09WTDFfMkw+Ow0KKwkJfTsNCisNCisJCXJk
bWEwOiByZG1hQDE0MDBiMDAwIHsNCisJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My1k
aXNwLXJkbWEiOw0KKwkJCXJlZyA9IDwwIDB4MTQwMGIwMDAgMCAweDEwMDA+Ow0KKwkJCWludGVy
cnVwdHMgPSA8R0lDX1NQSSAyMjggSVJRX1RZUEVfTEVWRUxfTE9XPjsNCisJCQlwb3dlci1kb21h
aW5zID0gPCZzY3BzeXMgTVQ4MTgzX1BPV0VSX0RPTUFJTl9ESVNQPjsNCisJCQljbG9ja3MgPSA8
Jm1tc3lzIENMS19NTV9ESVNQX1JETUEwPjsNCisJCQltZWRpYXRlayxyZG1hX2ZpZm9fc2l6ZSA9
IDw1MTIwPjsNCisJCX07DQorDQorCQlyZG1hMTogcmRtYUAxNDAwYzAwMCB7DQorCQkJY29tcGF0
aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtZGlzcC1yZG1hIjsNCisJCQlyZWcgPSA8MCAweDE0MDBj
MDAwIDAgMHgxMDAwPjsNCisJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMjI5IElSUV9UWVBFX0xF
VkVMX0xPVz47DQorCQkJcG93ZXItZG9tYWlucyA9IDwmc2Nwc3lzIE1UODE4M19QT1dFUl9ET01B
SU5fRElTUD47DQorCQkJY2xvY2tzID0gPCZtbXN5cyBDTEtfTU1fRElTUF9SRE1BMT47DQorCQkJ
bWVkaWF0ZWsscmRtYV9maWZvX3NpemUgPSA8MjA0OD47DQorCQl9Ow0KKw0KKwkJY29sb3IwOiBj
b2xvckAxNDAwZTAwMCB7DQorCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtZGlzcC1j
b2xvciIsDQorCQkJCSAgICAgIm1lZGlhdGVrLG10ODE3My1kaXNwLWNvbG9yIjsNCisJCQlyZWcg
PSA8MCAweDE0MDBlMDAwIDAgMHgxMDAwPjsNCisJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMjMx
IElSUV9UWVBFX0xFVkVMX0xPVz47DQorCQkJcG93ZXItZG9tYWlucyA9IDwmc2Nwc3lzIE1UODE4
M19QT1dFUl9ET01BSU5fRElTUD47DQorCQkJY2xvY2tzID0gPCZtbXN5cyBDTEtfTU1fRElTUF9D
T0xPUjA+Ow0KKwkJfTsNCisNCisJCWNjb3JyMDogY2NvcnJAMTQwMGYwMDAgew0KKwkJCWNvbXBh
dGlibGUgPSAibWVkaWF0ZWssbXQ4MTgzLWRpc3AtY2NvcnIiOw0KKwkJCXJlZyA9IDwwIDB4MTQw
MGYwMDAgMCAweDEwMDA+Ow0KKwkJCWludGVycnVwdHMgPSA8R0lDX1NQSSAyMzIgSVJRX1RZUEVf
TEVWRUxfTE9XPjsNCisJCQlwb3dlci1kb21haW5zID0gPCZzY3BzeXMgTVQ4MTgzX1BPV0VSX0RP
TUFJTl9ESVNQPjsNCisJCQljbG9ja3MgPSA8Jm1tc3lzIENMS19NTV9ESVNQX0NDT1JSMD47DQor
CQl9Ow0KKw0KKwkJYWFsMDogYWFsQDE0MDEwMDAwIHsNCisJCQljb21wYXRpYmxlID0gIm1lZGlh
dGVrLG10ODE4My1kaXNwLWFhbCIsDQorCQkJCSAgICAgIm1lZGlhdGVrLG10ODE3My1kaXNwLWFh
bCI7DQorCQkJcmVnID0gPDAgMHgxNDAxMDAwMCAwIDB4MTAwMD47DQorCQkJaW50ZXJydXB0cyA9
IDxHSUNfU1BJIDIzMyBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KKwkJCXBvd2VyLWRvbWFpbnMgPSA8
JnNjcHN5cyBNVDgxODNfUE9XRVJfRE9NQUlOX0RJU1A+Ow0KKwkJCWNsb2NrcyA9IDwmbW1zeXMg
Q0xLX01NX0RJU1BfQUFMMD47DQorCQl9Ow0KKw0KKwkJZ2FtbWEwOiBnYW1tYUAxNDAxMTAwMCB7
DQorCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtZGlzcC1nYW1tYSIsDQorCQkJCSAg
ICAgIm1lZGlhdGVrLG10ODE3My1kaXNwLWdhbW1hIjsNCisJCQlyZWcgPSA8MCAweDE0MDExMDAw
IDAgMHgxMDAwPjsNCisJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMjM0IElSUV9UWVBFX0xFVkVM
X0xPVz47DQorCQkJcG93ZXItZG9tYWlucyA9IDwmc2Nwc3lzIE1UODE4M19QT1dFUl9ET01BSU5f
RElTUD47DQorCQkJY2xvY2tzID0gPCZtbXN5cyBDTEtfTU1fRElTUF9HQU1NQTA+Ow0KKwkJfTsN
CisNCisJCWRpdGhlcjA6IGRpdGhlckAxNDAxMjAwMCB7DQorCQkJY29tcGF0aWJsZSA9ICJtZWRp
YXRlayxtdDgxODMtZGlzcC1kaXRoZXIiOw0KKwkJCXJlZyA9IDwwIDB4MTQwMTIwMDAgMCAweDEw
MDA+Ow0KKwkJCWludGVycnVwdHMgPSA8R0lDX1NQSSAyMzUgSVJRX1RZUEVfTEVWRUxfTE9XPjsN
CisJCQlwb3dlci1kb21haW5zID0gPCZzY3BzeXMgTVQ4MTgzX1BPV0VSX0RPTUFJTl9ESVNQPjsN
CisJCQljbG9ja3MgPSA8Jm1tc3lzIENMS19NTV9ESVNQX0RJVEhFUjA+Ow0KKwkJfTsNCisNCisJ
CW11dGV4OiBtdXRleEAxNDAxNjAwMCB7DQorCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgx
ODMtZGlzcC1tdXRleCI7DQorCQkJcmVnID0gPDAgMHgxNDAxNjAwMCAwIDB4MTAwMD47DQorCQkJ
aW50ZXJydXB0cyA9IDxHSUNfU1BJIDIxNyBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KKwkJCXBvd2Vy
LWRvbWFpbnMgPSA8JnNjcHN5cyBNVDgxODNfUE9XRVJfRE9NQUlOX0RJU1A+Ow0KKwkJfTsNCisN
CiAJCXNtaV9jb21tb246IHNtaUAxNDAxOTAwMCB7DQogCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRl
ayxtdDgxODMtc21pLWNvbW1vbiIsICJzeXNjb24iOw0KIAkJCXJlZyA9IDwwIDB4MTQwMTkwMDAg
MCAweDEwMDA+Ow0KLS0gDQoxLjguMS4xLmRpcnR5DQo=

