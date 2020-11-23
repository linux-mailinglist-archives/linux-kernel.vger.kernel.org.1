Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A142C0468
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgKWLUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729041AbgKWLUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:20:07 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C611C061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:20:07 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id e7so674426wrv.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L1A6ShzSRHULt3G6Ke9LreeZL2K1GMKHsXViRU+yWaI=;
        b=XC1icHQxTB5jacAoVkI3gjV1OSiGC+//Jf3F6glek/2GBxRYgE2yNAyO4F44L015/I
         iQHkbcSVXSbFSfexxKIK3Uly4nKoNbPPjwtUhqkNP07ZCQxVKwNnbxla1nfhBKX00Yoe
         SGnzZi03THb4xnvkePPGXeZ08ztRIwO2g3wa2CeiG1TfwNkznCf1gvCslTWp5EsyzASG
         w7VDIMcwwG9kT8LIMDbEcJleoR3qSsEeJa8hDC1PddPNJ4BexzOdjGBTIb3dvJPu8mmD
         GOKmAX3AolXdraBrtUXBskn8KYdgdFLoXD+peVxJfwqHfTydMh8v4BvcoyAzKN1719lb
         TpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L1A6ShzSRHULt3G6Ke9LreeZL2K1GMKHsXViRU+yWaI=;
        b=gZGpHqa1m76JaSl0rQtzqh+eY1+zHqTgPQtDYgXjGRJT2Ky0BMeBuAtTNnTGfRpY+9
         w66J2qkEOZNhNb3U38du1LyaL3JRsP0bQVe9fkEnheoyw1YGOlcl31YgTHeiYmifKtCd
         SX2axHwshZ2sSwySv/24OIEsdypqdwmkf83nCBHqqOIS/EO3IOTsTb4M6s30mE4zSelB
         QBMAhi7EIlb8EWHGZFiCFV876O6YYytFktxKO2QWbTb9DW+n9EQV8zbGh6OtaDndYH/2
         A4vJMlogNZcoqdCzhbQNVrS1rv4D7bzNPBSJ2CBdc1NN+e+Iub5GNu06v0HXzH0UJdZG
         HFLQ==
X-Gm-Message-State: AOAM530/0YsiJqW/AaYn/Ldk22nBxXNQDVhwLShJX+vdNiZiTVOk8yyF
        d4Y5SDOrSDMdjDbt3m1NX0/eng==
X-Google-Smtp-Source: ABdhPJz0+ceQe/Y2+pvKBwkjE9xITEVzXG9ujBWW3we5tH8y1dyudIKejmJLw6kMKEizjicMAXgLUA==
X-Received: by 2002:a5d:6548:: with SMTP id z8mr11259177wrv.399.1606130406387;
        Mon, 23 Nov 2020 03:20:06 -0800 (PST)
Received: from dell.default ([91.110.221.218])
        by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 03:20:05 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Drew Davenport <ddavenport@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: [PATCH 31/40] drm/msm/disp/dpu1/dpu_rm: Fix formatting issues and supply 'global_state' description
Date:   Mon, 23 Nov 2020 11:19:10 +0000
Message-Id: <20201123111919.233376-32-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201123111919.233376-1-lee.jones@linaro.org>
References: <20201123111919.233376-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c:247: warning: Excess function parameter 'Return' description in '_dpu_rm_check_lm_peer'
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c:283: warning: Function parameter or member 'global_state' not described in '_dpu_rm_check_lm_and_get_connected_blks'
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c:283: warning: Excess function parameter 'Return' description in '_dpu_rm_check_lm_and_get_connected_blks'

Cc: Rob Clark <robdclark@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Drew Davenport <ddavenport@chromium.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
index 0ae8a36ffcff3..fd2d104f0a91d 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
@@ -239,7 +239,7 @@ static bool _dpu_rm_needs_split_display(const struct msm_display_topology *top)
  * @rm: dpu resource manager handle
  * @primary_idx: index of primary mixer in rm->mixer_blks[]
  * @peer_idx: index of other mixer in rm->mixer_blks[]
- * @Return: true if rm->mixer_blks[peer_idx] is a peer of
+ * Return: true if rm->mixer_blks[peer_idx] is a peer of
  *          rm->mixer_blks[primary_idx]
  */
 static bool _dpu_rm_check_lm_peer(struct dpu_rm *rm, int primary_idx,
@@ -264,6 +264,7 @@ static bool _dpu_rm_check_lm_peer(struct dpu_rm *rm, int primary_idx,
  *	proposed use case requirements, incl. hardwired dependent blocks like
  *	pingpong
  * @rm: dpu resource manager handle
+ * @global_state: resources shared across multiple kms objects
  * @enc_id: encoder id requesting for allocation
  * @lm_idx: index of proposed layer mixer in rm->mixer_blks[], function checks
  *      if lm, and all other hardwired blocks connected to the lm (pp) is
@@ -274,7 +275,7 @@ static bool _dpu_rm_check_lm_peer(struct dpu_rm *rm, int primary_idx,
  *      mixer in rm->dspp_blks[].
  * @reqs: input parameter, rm requirements for HW blocks needed in the
  *      datapath.
- * @Return: true if lm matches all requirements, false otherwise
+ * Return: true if lm matches all requirements, false otherwise
  */
 static bool _dpu_rm_check_lm_and_get_connected_blks(struct dpu_rm *rm,
 		struct dpu_global_state *global_state,
-- 
2.25.1

