Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65D42F8887
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 23:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbhAOWho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 17:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbhAOWhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 17:37:43 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79230C061796
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:36:27 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id g15so6914146pgu.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A3QHeBv0dD4s5gNfnmON1tlU9NgzLsj2NG7ehBQ00dQ=;
        b=mtSWsJyyn/E3m/bOxirC2eQylWPD/zEdB3jMcJo97C2FkFN1wnTVnPymt6cD365E/4
         rhccHDZS8Lmfxz6a16Hi+8LK8UYEspZfbQ3WwtjfaxRhQuKrY9z9Rl38ZoI7089PQ9Ub
         vVkqjTndk4IToHXeSSwzXQBuXXkSfBTkczRuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A3QHeBv0dD4s5gNfnmON1tlU9NgzLsj2NG7ehBQ00dQ=;
        b=pDJ1U3RFW52UaTH9AOLAe3mVKzLHl5b/QBlj09+7x6P3So2SkYYjH14QOJ1ervX2DV
         Mz32MvjpvGNwSApwLoh9zE6HRMnVPaacFEJF8ThG4B0sJ9vb3YqcuHkM/9XxdMUfvhbS
         KABUsUjl1z2/8/Cn/NkreGUp2M/rT4TeG6pyu1VuGuqaRlvtd+5A5O4Jb2g7GbMs4hJz
         ITpbHv+Gemo7eim5uuGgTK6h8gyTJTi/l+fi3UPoiZ1MPNWqLqSNL+dGjxHOWk5mvOwx
         NvkhUzaZrbFGjaY8kOoQzGLN8s9q34WPtwj/fGS9CraMTdif1spMIatFD9+qP8tvgJ0Z
         pZyQ==
X-Gm-Message-State: AOAM532wzvlII4yYThgcYl2z0mcDtVFbZL+5QPn2X+ySLNG4cdYU8vON
        inG/MuzyoE27YZfTxLvOR/BfKBZD1PKSaQ==
X-Google-Smtp-Source: ABdhPJwlwsNQq32Qc8tMrciESRZ9K2Hi+zYf71D6e1b++O6SYLlXBMaa2smWgYVhaUvtUoylYX21kg==
X-Received: by 2002:a63:b05:: with SMTP id 5mr15071946pgl.163.1610750186891;
        Fri, 15 Jan 2021 14:36:26 -0800 (PST)
Received: from philipchen.mtv.corp.google.com ([2620:15c:202:201:a6ae:11ff:fe11:fd59])
        by smtp.gmail.com with ESMTPSA id l3sm5208670pjz.27.2021.01.15.14.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 14:36:26 -0800 (PST)
From:   Philip Chen <philipchen@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>, dmitry.torokhov@gmail.com
Cc:     swboyd@chromium.org, dianders@chromium.org,
        Philip Chen <philipchen@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v6 3/3] dt-bindings: input: Fix the keymap for LOCK key
Date:   Fri, 15 Jan 2021 14:36:17 -0800
Message-Id: <20210115143555.v6.3.I96134907488f41f358d03f3c1b08194f9547e670@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210115143555.v6.1.Iaa8a60cf2ed4b7ad5e2fbb4ad76a1c600ee36113@changeid>
References: <20210115143555.v6.1.Iaa8a60cf2ed4b7ad5e2fbb4ad76a1c600ee36113@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decouple LOCK from F13 and directly map the LOCK key (KSI3/KSO9) to
KEY_SLEEP action key code.

Signed-off-by: Philip Chen <philipchen@chromium.org>
---

Changes in v6:
- New patch in v6

 include/dt-bindings/input/cros-ec-keyboard.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/dt-bindings/input/cros-ec-keyboard.h b/include/dt-bindings/input/cros-ec-keyboard.h
index a37a8c5701219..f0ae03634a966 100644
--- a/include/dt-bindings/input/cros-ec-keyboard.h
+++ b/include/dt-bindings/input/cros-ec-keyboard.h
@@ -19,8 +19,7 @@
 	MATRIX_KEY(0x01, 0x04, KEY_F7)	\
 	MATRIX_KEY(0x02, 0x09, KEY_F8)	\
 	MATRIX_KEY(0x01, 0x09, KEY_F9)	\
-	MATRIX_KEY(0x00, 0x04, KEY_F10)	\
-	MATRIX_KEY(0x03, 0x09, KEY_F13)
+	MATRIX_KEY(0x00, 0x04, KEY_F10)
 
 #define CROS_STD_MAIN_KEYMAP	\
 	MATRIX_KEY(0x00, 0x01, KEY_LEFTMETA)	\
@@ -50,6 +49,7 @@
 	MATRIX_KEY(0x03, 0x03, KEY_5)		\
 	MATRIX_KEY(0x03, 0x06, KEY_6)		\
 	MATRIX_KEY(0x03, 0x08, KEY_MINUS)	\
+	MATRIX_KEY(0x03, 0x09, KEY_SLEEP)	\
 	MATRIX_KEY(0x03, 0x0b, KEY_BACKSLASH)	\
 	MATRIX_KEY(0x03, 0x0c, KEY_MUHENKAN)	\
 						\
-- 
2.26.2

