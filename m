Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F357296A02
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 09:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375497AbgJWHAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 03:00:14 -0400
Received: from mail-m17613.qiye.163.com ([59.111.176.13]:2746 "EHLO
        mail-m17613.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S373639AbgJWHAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 03:00:14 -0400
Received: from ubuntu.localdomain (unknown [157.0.31.124])
        by mail-m17613.qiye.163.com (Hmail) with ESMTPA id 64AFD482BB8;
        Fri, 23 Oct 2020 15:00:10 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Dave Airlie <airlied@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] gpu/drm/mgag200:remove break after return
Date:   Fri, 23 Oct 2020 00:00:03 -0700
Message-Id: <20201023070004.55105-1-bernard@vivo.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZHx1NGUsdSR5JGB0eVkpNS0hPSE1PSktNSk5VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS09ISVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NDo6MDo*ED8fQjRWQ0keIj1P
        EgNPCwlVSlVKTUtIT0hNT0pKS0hMVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSU9ZV1kIAVlBSUpLSTcG
X-HM-Tid: 0a755441f6d193bakuws64afd482bb8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function mgag200_set_pci_regs, there are some switch cases
returned, then break. These break will never run.
This patch is to make the code a bit readable.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/mgag200/mgag200_mode.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
index 38672f9e5c4f..de873a5d276e 100644
--- a/drivers/gpu/drm/mgag200/mgag200_mode.c
+++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
@@ -794,20 +794,17 @@ static int mgag200_crtc_set_plls(struct mga_device *mdev, long clock)
 	case G200_SE_A:
 	case G200_SE_B:
 		return mga_g200se_set_plls(mdev, clock);
-		break;
 	case G200_WB:
 	case G200_EW3:
 		return mga_g200wb_set_plls(mdev, clock);
-		break;
 	case G200_EV:
 		return mga_g200ev_set_plls(mdev, clock);
-		break;
 	case G200_EH:
 	case G200_EH3:
 		return mga_g200eh_set_plls(mdev, clock);
-		break;
 	case G200_ER:
 		return mga_g200er_set_plls(mdev, clock);
+	default:
 		break;
 	}
 
-- 
2.28.0

