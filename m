Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F98E2A930B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgKFJqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:46:24 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:37671 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725868AbgKFJqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:46:24 -0500
X-UUID: 66107521c869482c9656fccadfaeac7f-20201106
X-UUID: 66107521c869482c9656fccadfaeac7f-20201106
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1245991233; Fri, 06 Nov 2020 17:46:21 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 6 Nov 2020 17:46:18 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 6 Nov 2020 17:46:18 +0800
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
CC:     Ainge Hsu <ainge.hsu@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 1/2] dt-bindings: usb: mediatek,mtk-xhci: add str-clock-on
Date:   Fri, 6 Nov 2020 17:46:04 +0800
Message-ID: <1604655965-22418-1-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1604301530-31546-1-git-send-email-macpaul.lin@mediatek.com>
References: <1604301530-31546-1-git-send-email-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Option "mediatek,str-clock-on" means to keep clock on during system
suspend and resume. Some platform will flush register settings if clock has
been disabled when system is suspended. Set this option to avoid clock off.

Change-Id: Id841f58e9d7fb3656511072b3eb14d0d355e2dd5
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
Changes for v2:
  - Rename "mediatek,keep-clock-on" to "mediatek,str-clock-on" which implies
    this option related to STR functions.
  - After discussion with Chunfeng, resend dt-bindings descritption based on
    mediatek,mtk-xhci.txt instead of yaml format.

 .../devicetree/bindings/usb/mediatek,mtk-xhci.txt  |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
index 42d8814..fc93bcf 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
@@ -37,6 +37,9 @@ Required properties:
 
 Optional properties:
  - wakeup-source : enable USB remote wakeup;
+ - mediatek,str-clock-on: Keep clock on during system suspend and resume.
+	Some platform will flush register settings if clock has been disabled
+	when system is suspended.
  - mediatek,syscon-wakeup : phandle to syscon used to access the register
 	of the USB wakeup glue layer between xHCI and SPM; it depends on
 	"wakeup-source", and has two arguments:
-- 
1.7.9.5

