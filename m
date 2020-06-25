Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF1E20A057
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 15:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405250AbgFYNwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 09:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404803AbgFYNwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 09:52:09 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3567C08C5C1;
        Thu, 25 Jun 2020 06:52:09 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id j12so3035219pfn.10;
        Thu, 25 Jun 2020 06:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VVgPOn7O5vygXaZOP7HGpuix5zgjHnM6UUWBPzwUJ4Y=;
        b=pP1WEOgH0SEEmJb/UaXkuHK8Ba1Lo+wY9744VI3i5PvvVw3f14edV98Su6rFk0TffM
         39QOnrE1vsNyNrCyaZu6hrVqpZWLrrmIhrbkLqPJHe9VWecJFY47fOiGjTotFobWEFpB
         7UR0tPFQ+BuEp0dSpMIiNiWReCQcqOue/O5TTcNULoVAzeWopoBhnwqRb42OfCuTJJ5/
         srmKTnltLi166dCLavXwivp/cK36NW6vWSHY0qdV0B1Y34wpkLtFKjXBEPpb5vl27Wrj
         uGAAY+sZVO/F8IMY36PmThIgUibhIXrbi7bLzID9+gaYf2zU5rSg0ZHbBq6bN3Uuneed
         5MKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VVgPOn7O5vygXaZOP7HGpuix5zgjHnM6UUWBPzwUJ4Y=;
        b=ORf5npVqTwsqnPLviyQNl8NxvnL0hAeCsGlJJIRJPbZjlhuN//ADX0JzYYCWcrG/q7
         ry/sFfv0WfOwNz7YUYD8CIoKB94m7l9EE//vU281aILlTRsRmaWriUYAWIJUtCcFQ7Bn
         icuL7xN+0PRRTIwgUKvmyes0yx4xUd1Omfsm35Eb2Q/e9ZKNMbJTmrPpHnc9s7M/wA6u
         rDFd03Dhk42knBHPd3oYxAA+SA6X9i9sk+XHv24EdCT9BNXz+iHIVuhLo/exZ0XXgIy9
         887Qbwl04cb6M4RXnDizJCKTVP41CyjdHoZ1EF2kkkuylWmUF/vJFxIuWbCioBLNKbeS
         Ezbw==
X-Gm-Message-State: AOAM531yVsFAjpYUsqRAg7rM9V7PJSUJ40nGSd/tLqcNuDoxNFknlDDJ
        mNKiOXTh1ezmJZWHxkM6vuqI9a8ySg4=
X-Google-Smtp-Source: ABdhPJzOP7qmFQ1KGxAuZ/+8XuJATbuzZcIQCdCTGN0QnWrO6svd6TuLiv567ICpzriO7hC9QGM98Q==
X-Received: by 2002:a63:9e02:: with SMTP id s2mr25764690pgd.170.1593093129146;
        Thu, 25 Jun 2020 06:52:09 -0700 (PDT)
Received: from localhost.localdomain ([1.240.193.107])
        by smtp.googlemail.com with ESMTPSA id f15sm4587309pfk.58.2020.06.25.06.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 06:52:08 -0700 (PDT)
From:   Kangmin Park <l4stpr0gr4m@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Michal Simek <michal.simek@xilinx.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mailbox: zynqmp_ipi: fix unit address
Date:   Thu, 25 Jun 2020 22:51:58 +0900
Message-Id: <20200625135158.5861-1-l4stpr0gr4m@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix unit address to match the first address specified in the reg
property of the node in example.

Signed-off-by: Kangmin Park <l4stpr0gr4m@gmail.com>
---
 .../devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt     | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
index 4438432bfe9b..ad76edccf881 100644
--- a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
+++ b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
@@ -87,7 +87,7 @@ Example:
 		ranges;
 
 		/* APU<->RPU0 IPI mailbox controller */
-		ipi_mailbox_rpu0: mailbox@ff90400 {
+		ipi_mailbox_rpu0: mailbox@ff990400 {
 			reg = <0xff990400 0x20>,
 			      <0xff990420 0x20>,
 			      <0xff990080 0x20>,
-- 
2.26.2

