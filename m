Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F302B1C88
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbgKMNv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgKMNuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:50:25 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9399DC061A48
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:50:25 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id h62so8560289wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OFGPsQBWaqIstUovZEQuV7ZoQw1xUxoIPu10HqknCTI=;
        b=hDDNRtwmjy7UzVPZNCJaQ+bu+PRm7kW3v0HnLqD/oaFNjNOldbhgb4hKirvW7RQ3XG
         txtByjBe8inFiRzGvNE+0ZhuM7fV8Syu7RL2PxTSw2iQ4LD1FFAVBa7/GJ93TuAgl0XA
         ACpV0/PDpouzHfBWTiLt7rJyhWBmcfvQ9qFIvNY4YbDDotBVfQmZZoxQ8vEKkrAwZ3DS
         i3XKYmnsRMMZb3YU7tGhZTUDY4RrTNSSIqPhVlTAfqW/ZFop7DarUDsHz7+LSVLhD4vD
         hnfZR+RX+VS+Bxjl5AVbcbeSDW5bYjOBDFd4HsO95GvFkJNQ/mV9Ogq4rZyjmic5vcYi
         FTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OFGPsQBWaqIstUovZEQuV7ZoQw1xUxoIPu10HqknCTI=;
        b=poc5B6MEbqbDvd1g2C1KHROYVKbIbOvmub3A47kVg4K7uKXluZANsEbWs80ub6h07I
         gFNUlfK6emaSrQVYUluHZV0fYA9xNK0hVrIJaC8mU/i+3uY3/wTXVgH919+Fcg7dXxwc
         kHJUHRkBaHtCjcWQNIO9vaqZVKWWM39klWU7dEHGRg/rDGNJur/bbxqxZtLcETY1ATad
         6yP4W83Y6iSqC74t34TFKlTECUVU3pLsUk67EVCaBbqqoKs19n2nmEYcFYrSrdtRCV+9
         i4IVgweoc8X7cM0TRIE6jcejVJe031ht95xIYqi8Rto/NdfKKpFfu/gVBAGTpzsFDDbX
         hyxA==
X-Gm-Message-State: AOAM530iNOSLJNlMkyeUTNzf6HQxAQ8MmtoV6rlY+lO/SAvhhvjneAJ8
        c/V4X1GxHAOfd/OhldzB6DLhjg==
X-Google-Smtp-Source: ABdhPJyRl6lkCY0QwpZX7ubai9WllsidpusPMAw7vEARujcTCQ0A8ompo9Cv1/xtXRSuPmAwCaT85w==
X-Received: by 2002:a1c:2cd7:: with SMTP id s206mr2533032wms.182.1605275424372;
        Fri, 13 Nov 2020 05:50:24 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 05:50:23 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH 34/40] drm/msm/disp/mdp5/mdp5_ctl: Demote non-conformant kernel-doc headers
Date:   Fri, 13 Nov 2020 13:49:32 +0000
Message-Id: <20201113134938.4004947-35-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113134938.4004947-1-lee.jones@linaro.org>
References: <20201113134938.4004947-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Very little attempt has been made to document these functions.

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.c:227: warning: Function parameter or member 'ctl' not described in 'mdp5_ctl_set_encoder_state'
 drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.c:227: warning: Function parameter or member 'pipeline' not described in 'mdp5_ctl_set_encoder_state'
 drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.c:227: warning: Function parameter or member 'enabled' not described in 'mdp5_ctl_set_encoder_state'
 drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.c:227: warning: Excess function parameter 'enable' description in 'mdp5_ctl_set_encoder_state'
 drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.c:529: warning: Function parameter or member 'ctl' not described in 'mdp5_ctl_commit'
 drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.c:529: warning: Function parameter or member 'pipeline' not described in 'mdp5_ctl_commit'
 drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.c:529: warning: Function parameter or member 'flush_mask' not described in 'mdp5_ctl_commit'
 drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.c:529: warning: Function parameter or member 'start' not described in 'mdp5_ctl_commit'

Cc: Rob Clark <robdclark@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.c
index 030279d7b64b7..b5c40f9773629 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.c
@@ -213,10 +213,10 @@ static void send_start_signal(struct mdp5_ctl *ctl)
 	spin_unlock_irqrestore(&ctl->hw_lock, flags);
 }
 
-/**
+/*
  * mdp5_ctl_set_encoder_state() - set the encoder state
  *
- * @enable: true, when encoder is ready for data streaming; false, otherwise.
+ * @enabled: true, when encoder is ready for data streaming; false, otherwise.
  *
  * Note:
  * This encoder state is needed to trigger START signal (data path kickoff).
@@ -507,7 +507,7 @@ static void fix_for_single_flush(struct mdp5_ctl *ctl, u32 *flush_mask,
 	}
 }
 
-/**
+/*
  * mdp5_ctl_commit() - Register Flush
  *
  * The flush register is used to indicate several registers are all
-- 
2.25.1

