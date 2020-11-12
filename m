Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539F82B04E5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 13:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgKLMUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 07:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbgKLMUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 07:20:07 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD47C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 04:20:07 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id h6so1421303ilj.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 04:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=za7dGFRnG2wqlECVVKnE08UYeaqzR64RF/uHTVmfPiw=;
        b=C668CrY1de6Ifr8xbe4dcJaTJ8AojI3HzTemGQD+gegAMiMiyRUE8KlQ2tqgAJczHb
         zjsJnfG9n3PkTTAX8e20y6vahZ+EHuR3BRA1YEBvb4Ru57NNqjitIRYfnkn+csqtvYt5
         MYNZvPkaYxtcZRhEgX5uwbM6MB6JjYfG2f1f/d6i1TMCVqLjt83qE+kVFuvA6sVSSWrC
         1M12EC8B6lcaqDBlsNSSHEkbM7E1tsBEIssLmxnPUm/gabJwogXtOqS6sNzydh1GxLpc
         Gsv76gclozNDeBodzuLAa0aFIpPRBQN6NIOClr7uJ6yq0un1jcRr+pj/UjloY5PQmlRr
         e+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=za7dGFRnG2wqlECVVKnE08UYeaqzR64RF/uHTVmfPiw=;
        b=FMD5pmewkuTWlLk2TWC5fU/aXtDoEwNJkAbnzYeiYJMhVL0kHJvvRW+SP6zO4UWspP
         6DlNciWPa0WwKpyd6i2dDy1GtqtqutvmpyOzaIKXz5XPwwcENWzdooUBIuf93m6/ffPO
         7Gv+P6jAPhhjpLdM2ztsBQldQnfjBX8aJKCIkSxBNWMkimli3jMMoC1at1+YgOFabZCG
         Bie0kAoSuEwSXkMxvBqgxDQZmf75bPgy1hdVQHivvZvxfjEgB8aOwJMs4YIO8HXExQrV
         JZYJ25KqmYP3tz+i+i/txYadVTOqmGKyjQwUSjs4gUXDiCbrD2oeE79+hhQBOUtXnsws
         Bx4g==
X-Gm-Message-State: AOAM531QaMIMayC9EX40P+/hh9o1f+DBP2xDatcRrYxfMwHcT0HLQHOS
        hYEv6ahojHkDDE/EtMg0iM8ucA==
X-Google-Smtp-Source: ABdhPJyvxXY8RUImBDjNwF+2g3HhmjJVUanJtpgkfQcbk3YUDmjQ6+3RP9WfcJP2WEox+S2JyFNGwQ==
X-Received: by 2002:a05:6e02:2cc:: with SMTP id v12mr23629975ilr.115.1605183606897;
        Thu, 12 Nov 2020 04:20:06 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id k18sm2696996iow.4.2020.11.12.04.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 04:20:06 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] net: ipa: ignore the microcontroller log event
Date:   Thu, 12 Nov 2020 06:20:00 -0600
Message-Id: <20201112122000.20089-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201112121157.19784-1-elder@linaro.org>
References: <20201112121157.19784-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IPA-resident microcontroller has the ability to log various
activity in an area of IPA shared memory.  When the microcontroller
starts it generates an event to the AP to provide information about
the log.

We don't support reading this log, and we can safely ignore the
event.  So do that rather than treating the log info event we
receive as "unsupported."

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_uc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ipa/ipa_uc.c b/drivers/net/ipa/ipa_uc.c
index b382d47bc70d9..15bb357f3cfb1 100644
--- a/drivers/net/ipa/ipa_uc.c
+++ b/drivers/net/ipa/ipa_uc.c
@@ -129,9 +129,10 @@ static void ipa_uc_event_handler(struct ipa *ipa, enum ipa_irq_id irq_id)
 
 	if (shared->event == IPA_UC_EVENT_ERROR)
 		dev_err(dev, "microcontroller error event\n");
-	else
+	else if (shared->event != IPA_UC_EVENT_LOG_INFO)
 		dev_err(dev, "unsupported microcontroller event %hhu\n",
 			shared->event);
+	/* The LOG_INFO event can be safely ignored */
 }
 
 /* Microcontroller response IPA interrupt handler */
-- 
2.20.1

