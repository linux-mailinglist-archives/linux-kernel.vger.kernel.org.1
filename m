Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84A32E0C43
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 15:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgLVO5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 09:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbgLVO5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 09:57:09 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E61C061285;
        Tue, 22 Dec 2020 06:56:11 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id i5so429877pgo.1;
        Tue, 22 Dec 2020 06:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qYGBC9zMCBAhxRIfYfL2yra0LwNo/ANDyVaaTy3nkS0=;
        b=BmmyXlz6/KcNEo8rqZSNyZivFxGIo4J6QVw4jK0OpdutU8TYHe+dc8JbFMYr8GaT+m
         Ljzpm5hYMNo1Z2kYdeXQcnYvOn6D/NIJQlGTCnySi8btnlt84gS7r1HT4FRi3WJEAa5f
         EZ7uSGwbtqTwJuxv2cdDKCG40oa8i2lVw0YUn3QD/R3dWJ0nZUiyq3/C7s29W7+i4vD8
         AaKF9ru9qYpgIis1ivAWSQQ4DMPVbV4pJI2GX+e6OdPaVIDXcOSEbT3PawMopG7WXiYk
         X9Xkk3V+KesH/c3KCxkCNldRYqY7R1g0AFI6oWb/syAdsIOQXPJy2XycMy46/8REvzgy
         3vxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qYGBC9zMCBAhxRIfYfL2yra0LwNo/ANDyVaaTy3nkS0=;
        b=SyxeFIWmPks9B/a4Tfdh7UriybyUK7U/rdsFB3ejD1QC8a92ZwXbeSNicDNrgF987f
         hr/4HQ2r8gpPsIOPxYTRGqiyhkDkAFa29On+0aPC5TIKBTfaFeZdAFcMKvIul1gSxMb9
         l6bB6L8xXMPW00MUTw00i6aWN7/GNX052EIzXa9VOh4T374bcaHxI7zjBjxtBjNLqpX9
         OEmHfnszXTAqDDSnDu6KJsG8QoEsKQn0Mro1urtdX1wUZqWxK4kFnT41nIGBLkKQlbi8
         hc7c2wac/VQxY0/yuONF2WlgiLhCtNfZVY01VHplqU4Fp9T9IysqAEpO5OXGsvL/dFez
         glQA==
X-Gm-Message-State: AOAM533Nrl9hDk2++3CXo12LZkFTvaaMRtc/FZAbwySpaJhOsueutpOJ
        3JBqgHjLNvlzDdeuyRcemwE=
X-Google-Smtp-Source: ABdhPJxSxAh0+8dTxByYiL69Y441y0mrB6Fztl+KT+uYawlPEg2KT6aZxbdNJxrQ97fMg1g9FcvyEA==
X-Received: by 2002:a63:2347:: with SMTP id u7mr19888187pgm.189.1608648970940;
        Tue, 22 Dec 2020 06:56:10 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id k15sm21340349pfp.115.2020.12.22.06.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 06:56:10 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org (open list:SYSTEM CONTROL &
        POWER/MANAGEMENT INTERFACE Mes...),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 1/2] dt-bindings: arm: Add optional interrupt to smc/hvc SCMI transport
Date:   Tue, 22 Dec 2020 09:56:02 -0500
Message-Id: <20201222145603.40192-2-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201222145603.40192-1-jim2101024@gmail.com>
References: <20201222145603.40192-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In normal use of smc/hvc transport in SCMI the message completion is
indicated by the return of the SMC call.  This commit provides for an
optional interrupt named "a2p" which is used instead to
indicate the completion of a message.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 Documentation/devicetree/bindings/arm/arm,scmi.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documentation/devicetree/bindings/arm/arm,scmi.txt
index b5ce5b39bb9c..667d58e0a659 100644
--- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
+++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
@@ -31,6 +31,14 @@ Optional properties:
 
 - mbox-names: shall be "tx" or "rx" depending on mboxes entries.
 
+- interrupts : when using smc or hvc transports, this optional
+	 property indicates that msg completion by the platform is indicated
+	 by an interrupt rather than by the return of the smc call. This
+	 should not be used except when the platform requires such behavior.
+
+- interrupt-names : if "interrupts" is present, interrupt-names must also
+	 be present and have the value "a2p".
+
 See Documentation/devicetree/bindings/mailbox/mailbox.txt for more details
 about the generic mailbox controller and client driver bindings.
 
-- 
2.17.1

