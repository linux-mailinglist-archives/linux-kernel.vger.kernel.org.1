Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE5029FC75
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 05:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbgJ3EEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 00:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgJ3EEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 00:04:07 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3544EC0613D5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 21:04:06 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 15so4078162pgd.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 21:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=omeX/7USjZZ0bCTBjHGOVLTjZl1oqWJzp7gUz7b6h8o=;
        b=nDvPvTn9phgjic1rYziuxJbM/OAHLhdXJG7ZM3/oaHXZLLEojGVPRr0/dOJEMOX2ZV
         0y48gTkP0J6wfHakJaZv98m/RyzH64FNDGl4ALrV2KM0/WaO9GWXgd60CUeWwwTgZd9x
         OwQYnx4Jv+QedwVrqKomnqgBSkiMcVlKi+DDXHX4aEeYmacKedUyw4sfEn2NK2gooOAW
         UUng2XwfDd6pkqZjUw9pOpsV8BXzcYBMYGqGFu+80jE1qe25+6V+wsPRSdQkpdAXnQQN
         9ksbWoIOgpNjOQYJQIpN/EEZBgTd8eMZ5xqHhYPSPdH0UiU2VOZ5eOZ6WszqRidIbY3A
         /BOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=omeX/7USjZZ0bCTBjHGOVLTjZl1oqWJzp7gUz7b6h8o=;
        b=p8Gd2yPOgst0cn6IVaQhG+pR9jlpwluFc4V45xtjp3LCiuEW2O7AIzAXtiVBJiTSzG
         DaTCwxtGCkf45ldE1Xi5dxLPt3nUcQVBK6OyG0wH65ShAGGh7+NPR3AaAQ32LC3YQvtI
         Ne2vKDSQ6bB8tEoH4VDS51p5/uSmToH3zo/UrhgUkBRlNUVW1/Nw+lnARqfy4AKSToKx
         1hJilQsaM5nr95YMJxFWqqNJLXlLFgIFXsMz2qce7jfWy8tgQGWC74STQqVKMUAjFjFd
         S273ApSuNpaxAPkFNFuHJ441IPjPoQp5ruYsjohXaMneVtEkzxBY8X7bv4P2cvjl+XX0
         EBRw==
X-Gm-Message-State: AOAM533aSO8hRpqR0Z+dUg3q/cW0SjAHOkiTTtHNdDacjQqYfWpiJPCi
        69awsuKIBVUprGo2XSpZ/tI=
X-Google-Smtp-Source: ABdhPJwln0YHLlt3cQgyT3IiP+FDpP1bJ7gzY5729HwxsrRS9rA7GRyYw5IR8mCvUPP0U5gk7iKY8g==
X-Received: by 2002:a63:5152:: with SMTP id r18mr458807pgl.381.1604030645846;
        Thu, 29 Oct 2020 21:04:05 -0700 (PDT)
Received: from my--box ([103.98.79.70])
        by smtp.gmail.com with ESMTPSA id j2sm4048182pgi.48.2020.10.29.21.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 21:04:05 -0700 (PDT)
Date:   Fri, 30 Oct 2020 09:33:59 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     mh12gx2825@gmail.com, melissa.srw@gmail.com, daniel.vetter@ffwll.ch
Subject: [PATCH v2] drm/amd/pm: replace kmalloc+memcpy by kmemdup
Message-ID: <20201030040359.GA276414@my--box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kmemdup() for instructions using kmalloc() + memcpy(). More
information here: https://lwn.net/Articles/198928/
Issue reported by coccinelle script: scripts/coccinelle/api/memdup.cocci

Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
---
Changes since v1:
   - Update patch subject and log message to match proposed change.
   
Please Note: This is a Outreachy project task patch.

 .../gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c  | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c
index 740e2fc7a034..1e79baab753e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c
@@ -252,12 +252,11 @@ static int init_powerplay_table_information(
 	phm_copy_clock_limits_array(hwmgr, &pptable_information->power_saving_clock_max, powerplay_table->PowerSavingClockMax, ATOM_VEGA12_PPCLOCK_COUNT);
 	phm_copy_clock_limits_array(hwmgr, &pptable_information->power_saving_clock_min, powerplay_table->PowerSavingClockMin, ATOM_VEGA12_PPCLOCK_COUNT);
 
-	pptable_information->smc_pptable = kmalloc(sizeof(PPTable_t), GFP_KERNEL);
+	pptable_information->smc_pptable = kmemdup(&(powerplay_table->smcPPTable),
+						   sizeof(PPTable_t), GFP_KERNEL);
 	if (pptable_information->smc_pptable == NULL)
 		return -ENOMEM;
 
-	memcpy(pptable_information->smc_pptable, &(powerplay_table->smcPPTable), sizeof(PPTable_t));
-
 	result = append_vbios_pptable(hwmgr, (pptable_information->smc_pptable));
 
 	return result;
-- 
2.25.1

