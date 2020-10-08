Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF012287639
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 16:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbgJHOip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 10:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729770AbgJHOio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 10:38:44 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D26C061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 07:38:44 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e18so6873784wrw.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 07:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CnaYY18o2fUBSxrKOxr4IUz/CoikwNfBXHHG6rEGY+E=;
        b=zSN5/dFY3Pss71qJeL0BUGIjbsSNjXfA8EnhZObgHsbIGYe9uEqAG0D8Mt85u+JeUa
         rof4fEdSwxU3KGnZ4kZVhZMdNVxrtiwIsmUle4hHkpj9A/+YVT7QXj6jHfxIg8HTG79C
         4kTsbHGPNg4BK2LZ6hTPFGpDVXwkyAyFjMpradHBYcKhBFcteoJyR/OwFgEFGoF20Zw3
         mFVzbOKe3VxZ6370CKOoQwPHGz7/l7nzR4YauObVVhr578Em3+AY/R3McLx4xOlvDwAg
         Cj0/TVHN3rWPyIP1w2WX52S/rrsrcH/D3tB/mcPWFGMYgKRX9KH91damRNvQN83hM4mm
         IrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CnaYY18o2fUBSxrKOxr4IUz/CoikwNfBXHHG6rEGY+E=;
        b=AXzMCetBa2RIwE+6zKmFRs1Ss/BF4222NrMrA5KG2vYS67rF1pYBrHq59GK9JaHhIp
         ODN5IuyXHdvwPH6o5tsGY2bA0CwUf5sQgNscCB/rXyz9uSn3dtlb8yI+7Wpn30jRXCtd
         +zheHK/2AE/cIggp1wuuVrLhYhcQU6EivKUyS7OKpNqFdmR9RN5A2Hpl9jIVWsFaw5S6
         J3aLty7bmN+QrngI408xHkzAqUv/w9cTjEjKMzO5Sh93AmzBsq+NivA0RTdqR5YMabdE
         Cf4pWsPsA6SLTwTlYfDW4unCXKGI9tbe7++BpFs5pt/D1ZHOa1cR7hHWURug6ywBIljQ
         5VOA==
X-Gm-Message-State: AOAM532Neq1aYVAxsZvBdjH+GQam5AkPYfEAvXTKqKjhzRvAcapWepRK
        zpaHa/E9+p0wCU3vSE+WPmqUbp41Fe28jScf6Co=
X-Google-Smtp-Source: ABdhPJyx7CZ7tbTU69BULIH+0qH16YJhWmb6egZ/ijGM04WH4OKQaFlQj4KlXU5EMlA1w3n2NUX0nw==
X-Received: by 2002:adf:e38f:: with SMTP id e15mr9723978wrm.294.1602167923002;
        Thu, 08 Oct 2020 07:38:43 -0700 (PDT)
Received: from lmecxl0524.lme.st.com ([2a04:cec0:11c8:908d:6533:9100:d943:8b22])
        by smtp.gmail.com with ESMTPSA id y14sm6926942wma.48.2020.10.08.07.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 07:38:42 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [PATCH 3/5] firmware: arm_scmi: add config dependency for smc transport
Date:   Thu,  8 Oct 2020 16:37:20 +0200
Message-Id: <20201008143722.21888-3-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201008143722.21888-1-etienne.carriere@linaro.org>
References: <20201008143722.21888-1-etienne.carriere@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix dependencies for configuration switch ARM_SCMI_PROTOCOL that
is not exclusively dependent on MAILBOX since the alternate
smc transport that is depends on HAVE_ARM_SMCCC_DISCOVERY since [1].

Link: [1] d76428237784 ("firmware: arm_scmi: Use HAVE_ARM_SMCCC_DISCOVERY instead of ARM_PSCI_FW")
Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
 drivers/firmware/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 3315e3c21586..5bdd411206ff 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -9,7 +9,7 @@ menu "Firmware Drivers"
 config ARM_SCMI_PROTOCOL
 	tristate "ARM System Control and Management Interface (SCMI) Message Protocol"
 	depends on ARM || ARM64 || COMPILE_TEST
-	depends on MAILBOX
+	depends on MAILBOX || HAVE_ARM_SMCCC_DISCOVERY
 	help
 	  ARM System Control and Management Interface (SCMI) protocol is a
 	  set of operating system-independent software interfaces that are
-- 
2.17.1

