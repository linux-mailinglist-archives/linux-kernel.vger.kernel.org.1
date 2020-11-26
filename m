Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E552C560D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390783AbgKZNm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390767AbgKZNmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:42:55 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE06C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:42:55 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id u12so2218670wrt.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JRGzsr7E+IJLlqxa5D+IrFAdZhiFdGYpEedhVyk6GiY=;
        b=npJUR/DbxvX22PhhvsddHD3XwoyyDVf+g0XRN8KgbhT11qHmB4zphgQBWSBHNqNjr/
         8Vo0vv65NfZ9JCW8L/2SMi1OI6FMPbNOzBTW/o/VfmojKflzjEGWCqSYTC7rPf98wwMv
         mSK7VJ0LcB9+AQPMEzZtIq1VLY8QK6X9GkV8LJGK+XMVPn3+lE2rsA/0S10wsQww0dax
         gOzL2JHYgBqZPD72m+1EvomBH7ybMYA10Bci7AkXEShO9cuvmxBL+VMQn7rB6Nholahm
         0H7D+pNpH/VIKwt5Lzsklllify4PiA1rjNC+VV0Q6JzUxkKrm3UyRNkoGvpwqigXwObt
         QsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JRGzsr7E+IJLlqxa5D+IrFAdZhiFdGYpEedhVyk6GiY=;
        b=Rbrs3PzuI/HjwVQ0GOElZDN3u77pvZOtO3ZNUskjA9grFpie9DsGWqb+1dig5No8t7
         4I/nCyxc14NGqfe0GcThMDExPL83s8B/ilQRGAXGinC6JN21FLpyPASikZh3usimTozz
         jTvPorvd98Y063mv4ZizkXNg93EGpKP2FSz4LrqS1nUJBuRXCinWmFlKk7GiulEv2KUS
         qf+EssbveNEOHm2cYGc4JJ4ZyxZosXUYdLjZtz75eH54+PvDHN9I5kHJWUzN4W1DoDq8
         owK4n1bz0lcfSWdwJzB3Y3xFImEJF+aa/2HPNqgwOHVd1kGeX3Bsks56/cy1D0niT8Xw
         thsQ==
X-Gm-Message-State: AOAM533+fLGG/6jnZEEJcc9Yycwh90+M7PnDq4Ws3r5yFh8Xng6zzSTp
        osaB7T6FG/Ah7cntaJKULnDo8A==
X-Google-Smtp-Source: ABdhPJwo3+FQc6tpgfzfYae15R5ZY9ynnRvbHNRXmcN7/sg1nZfCyc5IUVsESXdGkNqsUW9sg2Vo8g==
X-Received: by 2002:a5d:4408:: with SMTP id z8mr4111560wrq.204.1606398174228;
        Thu, 26 Nov 2020 05:42:54 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:42:53 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 06/40] drm/amd/pm/powerplay/smumgr/smu9_smumgr: Include our own header containing our prototypes
Date:   Thu, 26 Nov 2020 13:42:06 +0000
Message-Id: <20201126134240.3214176-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126134240.3214176-1-lee.jones@linaro.org>
References: <20201126134240.3214176-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/smu9_smumgr.c:38:6: warning: no previous prototype for ‘smu9_is_smc_ram_running’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/smu9_smumgr.c:112:5: warning: no previous prototype for ‘smu9_send_msg_to_smc’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/smu9_smumgr.c:140:5: warning: no previous prototype for ‘smu9_send_msg_to_smc_with_parameter’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/smu9_smumgr.c:165:10: warning: no previous prototype for ‘smu9_get_argument’ [-Wmissing-prototypes]

Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c
index 8a9aee85043ec..23e5de3c4ec16 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c
@@ -22,6 +22,7 @@
  */
 
 #include "smumgr.h"
+#include "smu9_smumgr.h"
 #include "vega10_inc.h"
 #include "soc15_common.h"
 #include "pp_debug.h"
-- 
2.25.1

