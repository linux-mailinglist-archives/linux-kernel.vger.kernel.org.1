Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A1B2B4E1E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387868AbgKPRmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387527AbgKPRmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:42:15 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9309C0617A7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:42:13 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 23so19633374wrc.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z9hqlcpW7hereULOoI8627Xoa15VHuxF/Ol1jNzvX80=;
        b=VzWzCJBPPmyM3LpM7la4ilnDI68trSv7JH2kfu2f+DU0i4SMuZmeKKXiNLD1Hu4Etc
         wIhTyantuHh0S7h+NwM9t/QpaHtrBiT/mhLmz2It8yTttVcJAvk3V+u2b40CnNADXgKR
         HA6ChwT3TtKgoqlfuS732ua9sE7/x3Av0/dDNvBe+qbOU7Qkb4DYV+WabOT4A/++AZgY
         urAa0e+d4vnAcXCsaIw3qiDif6pZknYz13s9Xt2VaOHpca1hEYKNdjSMuim15K33YJXr
         wcsFYRRcZBKmBLiqjcaZk+SZrNmLGMiuVVoTO+Hja3MJLGnOx6GDJUgm/SZVzDrPyaAJ
         pwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z9hqlcpW7hereULOoI8627Xoa15VHuxF/Ol1jNzvX80=;
        b=HuRlaxNQSIe352garx0UN7oONf8eKlaw5XesjGppbsTUu8zB8XTE2SmTeXRvVECNuR
         X9YdwvMbRAC++ISoH6iWtmyCoIsmNw9a4LvTIrTE/Y+ZQauSSg3qmteRdJrQY2mBsk7x
         XS93Mvus1jV7mkbX2HUM8uYUVRzvvRkxiXhqoF/pOZyI+D5ltouda/LRh8+1+0cUrXI5
         WIOwl32qOt95oOLuZ5RFS6hEoduv3pjRV0M++mAhwh2ITjylhMfNzfF+1g5Lj3x4q7AC
         3tMH/WKWmdPIsbZqlEMFgksA//ZMxzgJ7JR3JubpLEKmUaa8KYQ+whIJAP2SwrWgedNy
         WzfQ==
X-Gm-Message-State: AOAM533UO5V0hvqE2SXNPuq+7RNtn3oG7D5FIAFEFsrrhxJPEkSXuNw+
        u2QY1+5BLstonBcwybvV0qBNYg==
X-Google-Smtp-Source: ABdhPJwe4OeSF0fUEzmtQPCyVZBNL4CH7EopB3/QGF4xEgcwY0RS9lBoS1zjZjxDp+VwWScJhmJ/Ww==
X-Received: by 2002:a05:6000:110c:: with SMTP id z12mr20268702wrw.214.1605548532636;
        Mon, 16 Nov 2020 09:42:12 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n10sm24667224wrx.9.2020.11.16.09.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:42:12 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 37/42] drm/vc4/vc4_hdmi_regs: Mark some data sets as __maybe_unused
Date:   Mon, 16 Nov 2020 17:41:07 +0000
Message-Id: <20201116174112.1833368-38-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116174112.1833368-1-lee.jones@linaro.org>
References: <20201116174112.1833368-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The alternative is to move them into the source file that uses then,
but they are large and intrusive, so that strategy is being avoided.

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vc4/vc4_hdmi_regs.h:282:39: warning: ‘vc5_hdmi_hdmi1_fields’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/vc4/vc4_hdmi_regs.h:206:39: warning: ‘vc5_hdmi_hdmi0_fields’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/vc4/vc4_hdmi_regs.h:145:39: warning: ‘vc4_hdmi_fields’ defined but not used [-Wunused-const-variable=]

Cc: Eric Anholt <eric@anholt.net>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/vc4/vc4_hdmi_regs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi_regs.h b/drivers/gpu/drm/vc4/vc4_hdmi_regs.h
index 7c6b4818f2455..96d764ebfe675 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi_regs.h
+++ b/drivers/gpu/drm/vc4/vc4_hdmi_regs.h
@@ -142,7 +142,7 @@ struct vc4_hdmi_register {
 #define VC5_RAM_REG(reg, offset)	_VC4_REG(VC5_RAM, reg, offset)
 #define VC5_RM_REG(reg, offset)		_VC4_REG(VC5_RM, reg, offset)
 
-static const struct vc4_hdmi_register vc4_hdmi_fields[] = {
+static const struct vc4_hdmi_register __maybe_unused vc4_hdmi_fields[] = {
 	VC4_HD_REG(HDMI_M_CTL, 0x000c),
 	VC4_HD_REG(HDMI_MAI_CTL, 0x0014),
 	VC4_HD_REG(HDMI_MAI_THR, 0x0018),
@@ -203,7 +203,7 @@ static const struct vc4_hdmi_register vc4_hdmi_fields[] = {
 	VC4_HDMI_REG(HDMI_RAM_PACKET_START, 0x0400),
 };
 
-static const struct vc4_hdmi_register vc5_hdmi_hdmi0_fields[] = {
+static const struct vc4_hdmi_register __maybe_unused vc5_hdmi_hdmi0_fields[] = {
 	VC4_HD_REG(HDMI_DVP_CTL, 0x0000),
 	VC4_HD_REG(HDMI_MAI_CTL, 0x0010),
 	VC4_HD_REG(HDMI_MAI_THR, 0x0014),
@@ -279,7 +279,7 @@ static const struct vc4_hdmi_register vc5_hdmi_hdmi0_fields[] = {
 	VC5_CSC_REG(HDMI_CSC_34_33, 0x018),
 };
 
-static const struct vc4_hdmi_register vc5_hdmi_hdmi1_fields[] = {
+static const struct vc4_hdmi_register __maybe_unused vc5_hdmi_hdmi1_fields[] = {
 	VC4_HD_REG(HDMI_DVP_CTL, 0x0000),
 	VC4_HD_REG(HDMI_MAI_CTL, 0x0030),
 	VC4_HD_REG(HDMI_MAI_THR, 0x0034),
-- 
2.25.1

