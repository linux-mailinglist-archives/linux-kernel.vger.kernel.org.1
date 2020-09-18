Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00ECD26F4A1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 05:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgIRDRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 23:17:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34114 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726201AbgIRDRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 23:17:49 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 91A8980447C78EE05DFC;
        Fri, 18 Sep 2020 11:17:45 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Fri, 18 Sep 2020
 11:17:35 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <amd-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <alexander.deucher@amd.com>, <yangyingliang@huawei.com>
Subject: [PATCH -next] drm/amd/display: remove unused variable in dcn30_hwseq.c
Date:   Fri, 18 Sep 2020 11:16:10 +0800
Message-ID: <20200918031610.2466524-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the compile warning:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c:322:27: warning: variable ‘optc’ set but not used [-Wunused-but-set-variable]
  struct timing_generator *optc;
                           ^~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c:641:7: warning: variable ‘is_dp’ set but not used [-Wunused-but-set-variable]
  bool is_dp;
       ^~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 204773ffc376..f875b1e98dd3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -319,13 +319,10 @@ void dcn30_enable_writeback(
 {
 	struct dwbc *dwb;
 	struct mcif_wb *mcif_wb;
-	struct timing_generator *optc;
 
 	dwb = dc->res_pool->dwbc[wb_info->dwb_pipe_inst];
 	mcif_wb = dc->res_pool->mcif_wb[wb_info->dwb_pipe_inst];
 
-	/* set the OPTC source mux */
-	optc = dc->res_pool->timing_generators[dwb->otg_inst];
 	DC_LOG_DWB("%s dwb_pipe_inst = %d, mpcc_inst = %d",\
 		__func__, wb_info->dwb_pipe_inst,\
 		wb_info->mpcc_inst);
@@ -638,7 +635,6 @@ void dcn30_set_avmute(struct pipe_ctx *pipe_ctx, bool enable)
 void dcn30_update_info_frame(struct pipe_ctx *pipe_ctx)
 {
 	bool is_hdmi_tmds;
-	bool is_dp;
 
 	ASSERT(pipe_ctx->stream);
 
@@ -646,7 +642,6 @@ void dcn30_update_info_frame(struct pipe_ctx *pipe_ctx)
 		return;  /* this is not root pipe */
 
 	is_hdmi_tmds = dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal);
-	is_dp = dc_is_dp_signal(pipe_ctx->stream->signal);
 
 	if (!is_hdmi_tmds)
 		return;
-- 
2.25.1

