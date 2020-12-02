Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27572CC93A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 22:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgLBV4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 16:56:34 -0500
Received: from hex.unseen.dk ([212.237.101.44]:36754 "EHLO hex.unseen.dk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbgLBV4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 16:56:33 -0500
X-Greylist: delayed 556 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Dec 2020 16:56:32 EST
Received: from localhost (localhost [127.0.0.1])
        by hex.unseen.dk (Postfix) with ESMTP id 990DB11DA3FB;
        Wed,  2 Dec 2020 22:46:35 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at unseen.dk
Received: from hex.unseen.dk ([127.0.0.1])
        by localhost (hex.unseen [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6qEBB2FyEDon; Wed,  2 Dec 2020 22:46:35 +0100 (CET)
Received: from bsjohnson.unseen (unknown [10.0.0.72])
        by hex.unseen.dk (Postfix) with ESMTPSA id C6CAB11DA3FA;
        Wed,  2 Dec 2020 22:46:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=unseen.dk; s=hex;
        t=1606945594; bh=T/UwXSueSuSau4pzwxws5vR3ydYacy3jwNWkonR3tgs=;
        h=From:To:Cc:Subject:Date:From;
        b=O2c/oWEE+T7M6AXFOgHq9hZh3aQ4kYAU8lbaVFC8rMZBvSYqdcMBd+2736JX9ckIC
         U7k2KJzlsfmsC/SN0mus4oAWVcvBoCkH+fEII008a7XslTtFYtgk9bRm23u+OIbbwi
         iSv/Kjra5/iIDMnUhaWvZJf0rrdsgBy6q6YwoHNo=
From:   =?UTF-8?q?Dennis=20Skovborg=20J=C3=B8rgensen?= <dennis@unseen.dk>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devel@driverdev.osuosl.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging/vc04_services/bcm2835-audio: Parenthesize alsa2chip macro
Date:   Wed,  2 Dec 2020 22:46:31 +0100
Message-Id: <20201202214634.186858-1-dennis@unseen.dk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add parenthesis around the alsa2chip macro to remove a checkpatch error.

Signed-off-by: Dennis Skovborg Jørgensen <dennis@unseen.dk>
---
 drivers/staging/vc04_services/bcm2835-audio/bcm2835.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
index 1b36475872d6..51066ac8eea5 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
@@ -22,7 +22,7 @@ enum {
 /* macros for alsa2chip and chip2alsa, instead of functions */
 
 // convert alsa to chip volume (defined as macro rather than function call)
-#define alsa2chip(vol) (uint)(-(((vol) << 8) / 100))
+#define alsa2chip(vol) ((uint)(-(((vol) << 8) / 100)))
 
 // convert chip to alsa volume
 #define chip2alsa(vol) -(((vol) * 100) >> 8)
-- 
2.29.2

