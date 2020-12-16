Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 791262DC80E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 21:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgLPU7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 15:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbgLPU7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 15:59:09 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DB0C061794;
        Wed, 16 Dec 2020 12:58:29 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id b5so2397692pjl.0;
        Wed, 16 Dec 2020 12:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fuyhH48HeEthOAICCtVGagOKS1EwHUmYBYVgW+mdhRc=;
        b=KAd8S57S9Xcq/jilEClsBCcaM0XE1X6wU+J3MlXuEt/tpl5zTuNjzjX7DIERSogXSI
         UvB+pnpJwxmhQpJjQBSCnhuJN4+n7YZ4JaTSd0whhYsjkQgcn6ITYO/Vy96GyoCn1Ka/
         0FIuJs2RIwnXNckY900NeR0cWFpHztYM6RFaYxphGn59zEojwqTThJosISPJhMis50Of
         w27vrsGAg0i2x9R8psKDQZyv4YLfMuCy5cpHDg43YJfrwKdQMBvefv+++fdInPQ7TMF2
         CPnp6/ah7SWg6VM94x0evudvHC/VerSrrscD1zMAv9INcM/FKzbgKoe7O05npXL9Sawu
         LBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fuyhH48HeEthOAICCtVGagOKS1EwHUmYBYVgW+mdhRc=;
        b=efUZg5g7Tvjev5IPxegTBd33bAaGlVY0pN330EIWpAycYwLYFIfRLAncq0y3w9AD0u
         cRfv/DAsXGFaUIAVuu4rqgFrbzYaFgU4l8IB3z8ce6r6HZM0bO/8A9+r5lKrlUX6qAhr
         S4P5gtCQfQTnbVsRVeKyRjstbBtLkaZA3OAxd5pu0y9M5WcNoVL3Y2UFFYeoqYKATDz5
         fMjvSiRmIMVLRa1dyiSXaNjiAcb/0ZtwYOmZgbcluijPUBuvjbujsDSHGQFpOQG86Acf
         xxL02wTCPoBPxLMZnSRbhC5pso5BGj/ZOHbMXYzBr7SI+Aug+lODN+ttrnaGIvi7xH4D
         ggNg==
X-Gm-Message-State: AOAM532CVZnPvX/oYOeZFstyGHYGJ9qZNnMdSMaNTm7VYwdwcNK6l3KK
        wir/RlVlwdpCYJFLiT8E/jE=
X-Google-Smtp-Source: ABdhPJwHFcGEHO48hJq9w/DTSdCXtcplKHfc2lePySEkyxiNf8fK0bVrP4xFiYMy9ddsqte6Mv3SSA==
X-Received: by 2002:a17:902:7489:b029:da:5aed:8ebf with SMTP id h9-20020a1709027489b02900da5aed8ebfmr4171737pll.35.1608152309159;
        Wed, 16 Dec 2020 12:58:29 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id fs12sm2866598pjb.49.2020.12.16.12.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 12:58:28 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
X-Google-Original-From: Jim Quinlan <james.quinlan@broadcom.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/2] dt-bindings: arm: Add optional interrupt to smc/hvc SCMI transport
Date:   Wed, 16 Dec 2020 15:58:01 -0500
Message-Id: <20201216205805.4221-2-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201216205805.4221-1-james.quinlan@broadcom.com>
References: <20201216205805.4221-1-james.quinlan@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In normal use of smc/hvc transport in SCMI the message completion is
indicated by the return of the SMC call.  This commit provides for an
optional interrupt named "message-serviced" which is used instead to
indicate the completion of a message.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
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

