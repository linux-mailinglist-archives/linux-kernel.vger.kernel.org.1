Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C64E2E0E0E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 19:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgLVSA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 13:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgLVSA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 13:00:56 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0F8C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 10:00:16 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id z136so12766147iof.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 10:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lzbNETM/VQ0CF6UoqqNA9CDEiZmVI79DsLSU1ICVIv0=;
        b=BYipllSzhxkdhGE/W+0NoBr/XmDKFCO07Zlxles9TAUWpznadJrUXHAQEez69aTb0U
         JItlAujNywUKOb0Z6e1/BfBWI3kJlyr6O7zT79j2CqT0HRVrgtg6Y7vIP0Ye68J06Xj9
         aS2Qe6nUy+zI5hXr7OFQGx4L9Gp7Bjwmui8R1kwaYn0dOI399HH11UY7GMPOW8/uSm2u
         91HEziwTEAFxZGKOcn5Y9tu5kNtSWu7gu+eYIWkJqAF723PrA8bbYaxEzFlV0on8nDfx
         L74stBC+/I9/quPOMfDFjpxi2mdpF603r78frjcOt6BZaSeRia6umcka8GF4XCCyvKyE
         wOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lzbNETM/VQ0CF6UoqqNA9CDEiZmVI79DsLSU1ICVIv0=;
        b=pqiXhhOlR0UyuK+K3m7BdlvtiuWAH/dm0qvXOTd6hNqRN2m7z92XYmys/ZnCAHDQmJ
         e1Xn1jD1v1hU9YAIw70ef+Z1zf6cTMUdB10Dq6uza+ODwzj+WINKb26KINzldvylhAak
         XMEsGYRUUELRFQ8CzMJjDCLUH+S6CoCyO+M2LVKDAnXEwnnX29bEwgLdsRYkzudziyD7
         H+TkW/D3zuK4LEDefX6LOAP9GxcBIFEdZg/6dV2RUAd6dMxsGxuiGhCRG3KHNWTAzhVy
         ag0/ITEpnGH+5Pd9ul1vYQAfTEVSJAz4KQeRvfsDwziM2P7YG6i2ff8yLOlbEYyoSuQF
         Fkjg==
X-Gm-Message-State: AOAM530iECI+HLcxgBjSGtH66W/LJjEDoYEc8tltSM3LTiaVwJs8AZKp
        24/LPO0JHDcMZS1YamfbTdYSdWanx7uBQw==
X-Google-Smtp-Source: ABdhPJxCwCT+337xsgtQzriREKmGL1xkST3e+zgjk0XP9aBBWEjfwqO5w5BeYU9lFeuNJ2q9ozZKew==
X-Received: by 2002:a05:6602:152:: with SMTP id v18mr18904967iot.187.1608660015989;
        Tue, 22 Dec 2020 10:00:15 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id f29sm16328385ilg.3.2020.12.22.10.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 10:00:15 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, cpratapa@codeaurora.org,
        bjorn.andersson@linaro.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 0/3] net: ipa: GSI interrupt handling fixes
Date:   Tue, 22 Dec 2020 12:00:09 -0600
Message-Id: <20201222180012.22489-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements fixes for some issues related to handling
interrupts when GSI channel and event ring commands complete.

The first issue is that the completion condition for an event ring
or channel command could occur while the associated interrupt is
disabled.  This would cause the interrupt to fire when it is
subsequently enabled, even if the condition it signals had already
been handled.  The fix is to clear any pending interrupt conditions
before re-enabling the interrupt.

The second and third patches change how the success of an event ring
or channel command is determined.  These commands change the state
of an event ring or channel.  Previously the receipt of a completion
interrupt was required to consider a command successful.  Instead, a
command is successful if it changes the state of the target event
ring or channel in the way expected.  This way the command can
succeed even if the completion interrupt did not arrive while it was
enabled.

					-Alex

Alex Elder (3):
  net: ipa: clear pending interrupts before enabling
  net: ipa: use state to determine channel command success
  net: ipa: use state to determine event ring command success

 drivers/net/ipa/gsi.c | 89 +++++++++++++++++++++++++++----------------
 1 file changed, 56 insertions(+), 33 deletions(-)

-- 
2.20.1

