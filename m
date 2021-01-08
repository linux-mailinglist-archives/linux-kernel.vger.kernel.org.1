Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB272EF8D5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbhAHURG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729357AbhAHURB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:17:01 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C358CC0612AD
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:15:30 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id v14so8750542wml.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w+rKqjsgsMRrWlbR0mS6qqZSklymAWueG82I2hOJ6Ds=;
        b=UjObcNpLmHgcVOeAiK1W8DH7qr/VTvKYYZvqwqgnSssxmyVRRzsJZmTvoKlwdQs01J
         NH7S9Mex2LrJ2/AaEUzm3rNqG8I12C/Xpj1PsvDO1wyi8oGualF6qkSrVPunrDULTTom
         xWhM/2mwjk08/4+J6spoCMxRTl9G0Gw/r0h4588xd8hz4X9VkBA/dx45Yd8tNUUewq6e
         zPICIlZTExobP1md8Ivtbr/c55KpzqTHL5gUtGhOv3CbcwSOfFoXTfvsHz6wLvTGD+4T
         4JJku0UmibFovBql4Ll+pwP24pQJS2iS/Ra4slhfru8dhDevYzSAhuUjzHo1VmJinivG
         6x0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w+rKqjsgsMRrWlbR0mS6qqZSklymAWueG82I2hOJ6Ds=;
        b=DD4hMGFHaZGJ9HN9zpfXHDqA5koRxeo9Ja2g9tRHT8rRMOY1y9PGfV/wGGQ3srTj24
         qxKgI9B9mbCQHg0Xn/glTFd+Z7TyWfSDdnXNYIHNJoY66cvmhg2Crjww6GnfCHkUL36t
         SyuKenlQw4H9jgKv0kQCkXLw2ae1YxlpHpVTfBWCFzPLh7M5NsZ7I3aeRU2iairgLsEL
         N1XBRK3l7h7xEiuW7OOZDErTnb29mmQ+JnNMzQGfNfXgCX8Q3wRStDxghGdeRmBzrtPD
         HeE589K6FvhdNxw/bqsessnxU9uE+bWzuKu2kscppDVZDgzJDcpUqLoUE6DF2aMzd60E
         SiTg==
X-Gm-Message-State: AOAM531p/IMtHwMKsjGpzP5BopWVQ4ZxBywrG4cyd89LA6Mm+14TkNeK
        JKYhaBclr5W+fiWkmdmhcOtnSg==
X-Google-Smtp-Source: ABdhPJzB7xilZqzkaJwNBTqYl/8XOYXzJhHqfV3T6uGCy6KkEdJfdWEONiV4H4I/V6KCmnexrpAfPw==
X-Received: by 2002:a1c:7218:: with SMTP id n24mr4508553wmc.186.1610136929497;
        Fri, 08 Jan 2021 12:15:29 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:15:28 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Igor Kravchenko <Igor.Kravchenko@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 17/40] drm/amd/display/dc/bios/bios_parser: Make local functions static
Date:   Fri,  8 Jan 2021 20:14:34 +0000
Message-Id: <20210108201457.3078600-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108201457.3078600-1-lee.jones@linaro.org>
References: <20210108201457.3078600-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:2588:16: warning: no previous prototype for ‘update_slot_layout_info’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:2692:16: warning: no previous prototype for ‘get_bracket_layout_record’ [-Wmissing-prototypes]

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Igor Kravchenko <Igor.Kravchenko@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index 23a373ca94b5c..f054c5872c619 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -2585,7 +2585,7 @@ static struct integrated_info *bios_parser_create_integrated_info(
 	return NULL;
 }
 
-enum bp_result update_slot_layout_info(
+static enum bp_result update_slot_layout_info(
 	struct dc_bios *dcb,
 	unsigned int i,
 	struct slot_layout_info *slot_layout_info,
@@ -2689,7 +2689,7 @@ enum bp_result update_slot_layout_info(
 }
 
 
-enum bp_result get_bracket_layout_record(
+static enum bp_result get_bracket_layout_record(
 	struct dc_bios *dcb,
 	unsigned int bracket_layout_id,
 	struct slot_layout_info *slot_layout_info)
-- 
2.25.1

