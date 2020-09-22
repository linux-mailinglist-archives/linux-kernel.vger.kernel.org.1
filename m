Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6755527385D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 04:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbgIVCLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 22:11:17 -0400
Received: from mail-m17613.qiye.163.com ([59.111.176.13]:41825 "EHLO
        mail-m17613.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728776AbgIVCLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 22:11:17 -0400
Received: from ubuntu.localdomain (unknown [157.0.31.124])
        by mail-m17613.qiye.163.com (Hmail) with ESMTPA id A31534827CA;
        Tue, 22 Sep 2020 10:11:13 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Jun Lei <Jun.Lei@amd.com>, Aric Cyr <aric.cyr@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>,
        Brandon Syu <Brandon.Syu@amd.com>,
        Michael Strauss <michael.strauss@amd.com>,
        abdoulaye berthe <abdoulaye.berthe@amd.com>,
        Martin Leung <martin.leung@amd.com>,
        Bernard Zhao <bernard@vivo.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v2] drm/amd/display: optimize code runtime a bit
Date:   Mon, 21 Sep 2020 19:11:03 -0700
Message-Id: <20200922021106.24733-1-bernard@vivo.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSh5ISRhJSB5CQ0kaVkpNS0tMT0tNTE9LTEhVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pkk6EQw*Qj8hPA8PMEkONSJJ
        GQNPCxdVSlVKTUtLTE9LTUxPTk1PVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSU9ZV1kIAVlBSElNQzcG
X-HM-Tid: 0a74b3944a0993bakuwsa31534827ca
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function dal_ddc_service_query_ddc_data,
get rid of dal_ddc_i2c_payloads_destroy, call
dal_vector_destruct() directly.
This change is to make the code run a bit fast.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
Changes since V1:
*get rid of dal_ddc_i2c_payloads_destroy, call
dal_vector_destruct() directly.

Link for V1:
*https://lore.kernel.org/patchwork/patch/1309014/
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
index b984eecca58b..dec12de37642 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
@@ -148,14 +148,6 @@ static uint32_t dal_ddc_i2c_payloads_get_count(struct i2c_payloads *p)
 	return p->payloads.count;
 }
 
-static void dal_ddc_i2c_payloads_destroy(struct i2c_payloads *p)
-{
-	if (!p)
-		return;
-
-	dal_vector_destruct(&p->payloads);
-}
-
 #define DDC_MIN(a, b) (((a) < (b)) ? (a) : (b))
 
 void dal_ddc_i2c_payloads_add(
@@ -582,7 +574,7 @@ bool dal_ddc_service_query_ddc_data(
 				ddc->link,
 				&command);
 
-		dal_ddc_i2c_payloads_destroy(&payloads);
+		dal_vector_destruct(&payloads.payloads);
 	}
 
 	return success;
-- 
2.28.0

