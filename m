Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA392E8C21
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 13:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbhACM1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 07:27:51 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:38905 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbhACM1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 07:27:50 -0500
Received: from localhost.localdomain ([37.4.249.194]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N4eOd-1jxhql0xzr-011lxO; Sun, 03 Jan 2021 13:25:16 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH] MAINTAINERS: Include bcm2835 subsequents into search
Date:   Sun,  3 Jan 2021 13:24:35 +0100
Message-Id: <1609676675-5361-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:arz7TrPc5/RznTkCcd74QqBGE/i0Kc/U97cMuuxRMplMtPcG72T
 nGI+gWazjDZnI23xYaPQAP69sD18xxXM9nptB4I25im6vn6nQsMRF7fzsWLT16Cp8m+W0tH
 sNoPJZXySuOm7ElVLlTl0g3H8IHga8BylGZ1WJpuhXRQFgmw8dWRxR/XE9PTcbHowy6DRk4
 1QCZHMMYv7LZCS/6lD7tg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EAnL9Oa2P50=:/dLitfEGyZH2wAHs5p2qYh
 TEpbwKOrsdn5QfbYlcdWq82qmPP4oEV+4gaU8yYx4ZCU1jTm47KPwb/Ma4dPe43t3MpKZ7dyI
 SKrIuSiuk2qYgddx58T/fDxu2b16PrMioI0bnhT16l/bJ/WrWAZiyRT8C1dABCGzNLAiKSnul
 JAYE1yTnqICrdqLmidK/Rbsg7CyiPGEBtNFrwoGvk4VvV62mfGa5VC3+C1Ri4usX1VSjvJQ2c
 fbz0Js0hqlG3mC/xTIRSGOAHLB6aMO5GfroZiCSAV4Ock3BUAZWwgN/PwptxSWyV+95uiYSJU
 884JmDaG94vFiZFsy09M0MUjfn1EFO7cjk1Zf9GPwla2Z0QZzhy1FXyMsriDke2zb1eciO2wc
 mpE53+bfJMaTIuQOMNocZYGlisEyqJqtJS4u9M0ttWGR7cvZ2vTtWHBBIi8K3D5Km1kXWOu7Q
 7TlsfsNLYw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the bcm2835 maintainer info in order to handle subsequent SoCs.
After this get_maintainers.pl provides the proper maintainers for
irqchip-bcm2836.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 546aa66..ecfe78f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3413,7 +3413,7 @@ F:	Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
 F:	drivers/pci/controller/pcie-brcmstb.c
 F:	drivers/staging/vc04_services
 N:	bcm2711
-N:	bcm2835
+N:	bcm283*
 
 BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITECTURE
 M:	Florian Fainelli <f.fainelli@gmail.com>
-- 
2.7.4

