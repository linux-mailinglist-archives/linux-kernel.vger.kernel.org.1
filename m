Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70512E0C41
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 15:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgLVO5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 09:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbgLVO5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 09:57:08 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F500C061282;
        Tue, 22 Dec 2020 06:56:09 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id m5so1465642pjv.5;
        Tue, 22 Dec 2020 06:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0u3LFUxRxnvgI6Cwduh1xnt56XbSCCLQm5gV2qKSomc=;
        b=r24Vo/AngNenXskU7k5TrYgGkv9fiYqiIeAMnmxWgWvp+SRtFMNjDjOVrx1Rx7eFq/
         jBaLk1iokDeZG3hiDnwGinZnhkhNB9HniszbhArNsG98SspNFcYPq3mzJSzmbPGOXJDn
         dmhiRfqA+eeuB3h/Qj0G4k/cU6bD1IuBHRddI1TYfRTEsL1hybl+bWIOGTn7kZO+5HSR
         XF1C/XU5KIyaUvLbWqcg4I3iXlymyIqGDQK0f2AbpxQiNV7efELkmUlXcr4GiL7Z2CyZ
         eotCcZl0d0MJ76OH+lEFuHyh23+wqSuSiIItW9Dow2unE0SHvtqf81CVO/zZhpbVtfhz
         hneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0u3LFUxRxnvgI6Cwduh1xnt56XbSCCLQm5gV2qKSomc=;
        b=T6W0H6oXKtpGP2rg00sTSu/Kisu6oNHvVbDvpMhOTrBVDva/ewkR1OYNbeC4w8qc3H
         oxnNm6SXnC2fh0zBl8rUOmvHv/LwUD+XOX+tnrxwZZMFp9wa2uFAzehFQEtaExmNk2LB
         tgob20SVnP7wAZkXRDRwWxZjZ3eEFcAZr/VNLIWsFmnPZn8/EQYfp3PUgfKzcDTkr8NI
         wuM8O4zaaNLNanMBGJXZbsCWYuTYRT9lv1tuUsGsXzHfNx8NTGXJWK9VOH7sl+lG6rzJ
         tUOZtlmk1LlaLAWvOApYZuHV6lZj0QZYBjTGLAT6tpmUxZ5p+EGel46VVuLHd48lJpdw
         wLHA==
X-Gm-Message-State: AOAM53381dE0bB7xUwBPchpEuDwd7g65D6+/Da2cn/oXv+57aKE1D24x
        78PY5nS4bKPwXvO1K5y9C8U=
X-Google-Smtp-Source: ABdhPJw6uOIsfe+mbN9XAWG4UCoYS8M4YEasV7yy6zAECUHHDuE5JGy63f/5D07UverviyqhKezSxA==
X-Received: by 2002:a17:90a:b38d:: with SMTP id e13mr22995333pjr.214.1608648968695;
        Tue, 22 Dec 2020 06:56:08 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id k15sm21340349pfp.115.2020.12.22.06.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 06:56:08 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (open list:SYSTEM CONTROL &
        POWER/MANAGEMENT INTERFACE Mes...),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 0/2] firmware: arm_scmi: Augment SMC/HVC to allow optional interrupt
Date:   Tue, 22 Dec 2020 09:56:01 -0500
Message-Id: <20201222145603.40192-1-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4 -- s/message-serviced/a2p/ in the bindings commit message.
   -- Changed author/s-o-b/committer email address as my company is now
      appending boilerplate text to all outgoing emails.

v3 -- Changed interrupt name from "message-serviced" to "a2p" (RobH)

v2 -- Correct commit message, s/msg/message/, and remove extra WS on
      "dt-bindings" commit (Sudeep)
   -- Change interrupt name to "message-serviced", move irq assignent to end
      of function. (Sudeep)

v1 -- original.

Jim Quinlan (2):
  dt-bindings: arm: Add optional interrupt to smc/hvc SCMI transport
  firmware: arm_scmi: Augment SMC/HVC to allow optional interrupt

 .../devicetree/bindings/arm/arm,scmi.txt      |  8 ++++
 drivers/firmware/arm_scmi/smc.c               | 38 ++++++++++++++++++-
 2 files changed, 45 insertions(+), 1 deletion(-)

-- 
2.17.1

