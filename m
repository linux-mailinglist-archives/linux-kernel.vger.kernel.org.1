Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECDD1A4201
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 06:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgDJEdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 00:33:10 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:12559 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725838AbgDJEdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 00:33:09 -0400
X-UUID: 9db3cee123b740be8d279eb6d953d59f-20200410
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=iR0rPL64FU19qOW727A31bTZVI8PeoEj1NeCit81CAU=;
        b=SBZswVGNcllg+KcVmyuu2bB+f0nIzMhbQp/laMeMPonQfruUJ6p5WXHk0xUoAdikZzvAP3RhB3sS8+zgZq0k2ElST2+3VMJzEVl7os+24yLO6qlke5slo3RPhCnQ4Vi0FdqRXUiSts9/ImNu3AAv/O3ja6JssK2zTTo8KPc7vZo=;
X-UUID: 9db3cee123b740be8d279eb6d953d59f-20200410
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 756251616; Fri, 10 Apr 2020 12:32:58 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 10 Apr
 2020 12:32:54 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Fri, 10 Apr 2020 12:32:52 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, <huijuan.xie@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 2/4] dt-bindings: display: mediatek: get mipitx calibration data from nvmem
Date:   Fri, 10 Apr 2020 12:32:46 +0800
Message-ID: <20200410043248.114384-3-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200410043248.114384-1-jitao.shi@mediatek.com>
References: <20200410043248.114384-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 49539A6026651F122A21719B8F06698786679A4F77C845552F78FCE2108AC9B02000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHByb3BlcnRpZXMgdG8gZ2V0IGdldCBtaXBpdHggY2FsaWJyYXRpb24gZGF0YS4NCg0KUmV2
aWV3ZWQtYnk6IENodW4tS3VhbmcgSHUgPGNodW5rdWFuZy5odUBrZXJuZWwub3JnPg0KUmV2aWV3
ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQpTaWduZWQtb2ZmLWJ5OiBKaXRh
byBTaGkgPGppdGFvLnNoaUBtZWRpYXRlay5jb20+DQotLS0NCiAuLi4vZGV2aWNldHJlZS9iaW5k
aW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRzaS50eHQgICAgfCA1ICsrKysrDQogMSBm
aWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHNpLnR4dCBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlh
dGVrLGRzaS50eHQNCmluZGV4IGQ3OGI2ZDZkOGZhYi4uOGU0NzI5ZGU4Yzg1IDEwMDY0NA0KLS0t
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVk
aWF0ZWssZHNpLnR4dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rp
c3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHNpLnR4dA0KQEAgLTM2LDYgKzM2LDkgQEAgUmVxdWly
ZWQgcHJvcGVydGllczoNCiBPcHRpb25hbCBwcm9wZXJ0aWVzOg0KIC0gZHJpdmUtc3RyZW5ndGgt
bWljcm9hbXA6IGFkanVzdCBkcml2aW5nIGN1cnJlbnQsIHNob3VsZCBiZSAzMDAwIH4gNjAwMC4g
QW5kDQogCQkJCQkJICAgdGhlIHN0ZXAgaXMgMjAwLg0KKy0gbnZtZW0tY2VsbHM6IEEgcGhhbmRs
ZSB0byB0aGUgY2FsaWJyYXRpb24gZGF0YSBwcm92aWRlZCBieSBhIG52bWVtIGRldmljZS4gSWYN
CisgICAgICAgICAgICAgICB1bnNwZWNpZmllZCBkZWZhdWx0IHZhbHVlcyBzaGFsbCBiZSB1c2Vk
Lg0KKy0gbnZtZW0tY2VsbC1uYW1lczogU2hvdWxkIGJlICJjYWxpYnJhdGlvbi1kYXRhIg0KIA0K
IEV4YW1wbGU6DQogDQpAQCAtNDcsNiArNTAsOCBAQCBtaXBpX3R4MDogbWlwaS1kcGh5QDEwMjE1
MDAwIHsNCiAJI2Nsb2NrLWNlbGxzID0gPDA+Ow0KIAkjcGh5LWNlbGxzID0gPDA+Ow0KIAlkcml2
ZS1zdHJlbmd0aC1taWNyb2FtcCA9IDw0NjAwPjsNCisJbnZtZW0tY2VsbHM9IDwmbWlwaV90eF9j
YWxpYnJhdGlvbj47DQorCW52bWVtLWNlbGwtbmFtZXMgPSAiY2FsaWJyYXRpb24tZGF0YSI7DQog
fTsNCiANCiBkc2kwOiBkc2lAMTQwMWIwMDAgew0KLS0gDQoyLjIxLjANCg==

