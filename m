Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5089B296A89
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 09:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375819AbgJWHrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 03:47:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:59584 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S374596AbgJWHrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 03:47:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5ECCEAC43;
        Fri, 23 Oct 2020 07:47:13 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     dri-devel@lists.freedesktop.org
Cc:     amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] drm/amd/display: Fix kernel panic by dal_gpio_open() error
Date:   Fri, 23 Oct 2020 09:46:54 +0200
Message-Id: <20201023074656.11855-2-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201023074656.11855-1-tiwai@suse.de>
References: <20201023074656.11855-1-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently both error code paths handled in dal_gpio_open_ex() issues
ASSERT_CRITICAL(), and this leads to a kernel panic unnecessarily if
CONFIG_KGDB is enabled.  Since basically both are non-critical errors
and can be recovered, drop those assert calls and use a safer one,
BREAK_TO_DEBUGGER(), for allowing the debugging, instead.

BugLink: https://bugzilla.opensuse.org/show_bug.cgi?id=1177973
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/gpu/drm/amd/display/dc/gpio/gpio_base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/gpio_base.c b/drivers/gpu/drm/amd/display/dc/gpio/gpio_base.c
index f67c18375bfd..dac427b68fd7 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/gpio_base.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/gpio_base.c
@@ -63,13 +63,13 @@ enum gpio_result dal_gpio_open_ex(
 	enum gpio_mode mode)
 {
 	if (gpio->pin) {
-		ASSERT_CRITICAL(false);
+		BREAK_TO_DEBUGGER();
 		return GPIO_RESULT_ALREADY_OPENED;
 	}
 
 	// No action if allocation failed during gpio construct
 	if (!gpio->hw_container.ddc) {
-		ASSERT_CRITICAL(false);
+		BREAK_TO_DEBUGGER();
 		return GPIO_RESULT_NON_SPECIFIC_ERROR;
 	}
 	gpio->mode = mode;
-- 
2.16.4

