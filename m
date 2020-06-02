Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3341EC126
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 19:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgFBRiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 13:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgFBRiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 13:38:12 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21DCC05BD1E;
        Tue,  2 Jun 2020 10:38:12 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 64so5366269pfg.8;
        Tue, 02 Jun 2020 10:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dGaeeYOWz56yaJIcCY7o0HTuksFYq7poxtIG8aT/rvQ=;
        b=NdaPw4qPnww6iAIksXtR7ayxz8AMitlGypq2Hdgco5FHSD1OkEKscjvYt2UoST4On0
         P0Ii6Bnbr8ze/fXQJbKyqLE4U4pNJh8Daz0vQLIwXrUbFvnYH/xc0EkMDB8eepOI0mOQ
         0a7KqgwR97hphCoicsY2XhpKDlxXtFjIHtXabAcrOtYirHXZUdYYw7DHCbsC2t5ud9jO
         SPvvL+ybISZjkryMeQIwKx8YEhX7jTCkUU777Sh7X+FUYo3JkckbW6Kl9mpsThktxLae
         FzL1jgAMCLc1IpFvXprHNA6dgmTnjoxcDxcs8vQlI+yipWGMlOm66Zr7rYmPKpjmQLOQ
         OHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dGaeeYOWz56yaJIcCY7o0HTuksFYq7poxtIG8aT/rvQ=;
        b=g11U5/wCCIP8zGeQ2LAmBtie2dkc5m2PQFxP5hTQU2E41yqferIxUtIlkjeIgyN81Q
         rcTkpKpeSEIhSgCjdl63oJ1/ZxznLpP+zb1rKvlaOAommRAQvozFY85ClwN/oGWu71Dy
         g14D/v1g82Sgo8HhUREIGig1si45XSYxAv+kSWYvX8b3MdqneoIOBrel2Nk02pi6flcU
         KeL+NcrxNuHfkWaHJCJYjiYe0h8y4HzMH96ztRROGMf6GIlRodPEiOWZBtb6noQDmwc+
         R9OH4SgGGakSY86rOoFfOfiZRhtpwRLcKB89MogVo8l0y4pCY0mXBNSW2/EDgS6gaGfE
         XqXQ==
X-Gm-Message-State: AOAM533L11Rc9JE/As3rOdCEe2bT77GOcj7iaVnkqkYTlCcC3rab+Hqm
        ZM9uWB1+7cn6VlDEUNPngsI=
X-Google-Smtp-Source: ABdhPJw1rMRh9pZJav+jPZjKWaumMz1w+TAn7Jmni189X/Ii3iIsRtSvcPhq7wsM0IC2/h9NWNCt9g==
X-Received: by 2002:a62:640b:: with SMTP id y11mr1623388pfb.195.1591119492269;
        Tue, 02 Jun 2020 10:38:12 -0700 (PDT)
Received: from localhost.localdomain ([223.235.152.125])
        by smtp.gmail.com with ESMTPSA id i22sm2864382pfo.92.2020.06.02.10.37.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jun 2020 10:38:11 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v3 07/10] dt-bindings: reset: s700: Add binding constants for mmc
Date:   Tue,  2 Jun 2020 23:03:09 +0530
Message-Id: <1591119192-18538-8-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591119192-18538-1-git-send-email-amittomer25@gmail.com>
References: <1591119192-18538-1-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds device tree binding reset constants for mmc controller
present on Actions S700 Soc.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
Changes since v2:
	* No change.
Changes since v1:
        * No change.
Changes since RFC:
        * added Rob's acked-by tag
---
 include/dt-bindings/reset/actions,s700-reset.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/reset/actions,s700-reset.h b/include/dt-bindings/reset/actions,s700-reset.h
index 5e3b16b8ef53..a3118de6d7aa 100644
--- a/include/dt-bindings/reset/actions,s700-reset.h
+++ b/include/dt-bindings/reset/actions,s700-reset.h
@@ -30,5 +30,8 @@
 #define RESET_UART4				20
 #define RESET_UART5				21
 #define RESET_UART6				22
+#define RESET_SD0				23
+#define RESET_SD1				24
+#define RESET_SD2				25
 
 #endif /* __DT_BINDINGS_ACTIONS_S700_RESET_H */
-- 
2.7.4

