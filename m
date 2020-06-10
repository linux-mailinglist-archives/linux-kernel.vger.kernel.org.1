Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418FE1F5401
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 13:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgFJL6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 07:58:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33518 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728562AbgFJL6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 07:58:09 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jizMq-0000Nb-Ho; Wed, 10 Jun 2020 11:58:04 +0000
From:   Colin King <colin.king@canonical.com>
To:     Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/ast: fix missing break in switch statement for format->cpp[0] case 4
Date:   Wed, 10 Jun 2020 12:58:04 +0100
Message-Id: <20200610115804.1132338-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0.rc0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the switch statement for format->cpp[0] value 4 assigns
color_index which is never read again and then falls through to the
default case and returns. This looks like a missing break statement
bug. Fix this by adding a break statement.

Addresses-Coverity: ("Unused value")
Fixes: 259d14a76a27 ("drm/ast: Split ast_set_vbios_mode_info()")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/ast/ast_mode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index 7d39b858c9f1..3a3a511670c9 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -226,6 +226,7 @@ static void ast_set_vbios_color_reg(struct ast_private *ast,
 	case 3:
 	case 4:
 		color_index = TrueCModeIndex;
+		break;
 	default:
 		return;
 	}
-- 
2.27.0.rc0

