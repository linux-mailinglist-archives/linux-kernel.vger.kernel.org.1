Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3527A1C8003
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 04:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgEGCay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 22:30:54 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3828 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727800AbgEGCax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 22:30:53 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2A5C5E98BD8581AE56CA;
        Thu,  7 May 2020 10:30:49 +0800 (CST)
Received: from huawei.com (10.67.174.156) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Thu, 7 May 2020
 10:30:43 +0800
From:   ChenTao <chentao107@huawei.com>
To:     <timur@kernel.org>, <nicoleotsuka@gmail.com>,
        <Xiubo.Lee@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>
CC:     <festevam@gmail.com>, <broonie@kernel.org>,
        <alsa-devel@alsa-project.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <chentao107@huawei.com>
Subject: [PATCH -next] soc: fsl_asrc: Make some functions static
Date:   Thu, 7 May 2020 10:29:59 +0800
Message-ID: <20200507022959.183739-1-chentao107@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.156]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warning:

sound/soc/fsl/fsl_asrc.c:157:5: warning:
symbol 'fsl_asrc_request_pair' was not declared. Should it be static?
sound/soc/fsl/fsl_asrc.c:200:6: warning:
symbol 'fsl_asrc_release_pair' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: ChenTao <chentao107@huawei.com>
---
 sound/soc/fsl/fsl_asrc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 067a54ab554f..432936039de4 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -154,7 +154,7 @@ static void fsl_asrc_sel_proc(int inrate, int outrate,
  * within range [ANCA, ANCA+ANCB-1], depends on the channels of pair A
  * while pair A and pair C are comparatively independent.
  */
-int fsl_asrc_request_pair(int channels, struct fsl_asrc_pair *pair)
+static int fsl_asrc_request_pair(int channels, struct fsl_asrc_pair *pair)
 {
 	enum asrc_pair_index index = ASRC_INVALID_PAIR;
 	struct fsl_asrc *asrc = pair->asrc;
@@ -197,7 +197,7 @@ int fsl_asrc_request_pair(int channels, struct fsl_asrc_pair *pair)
  *
  * It clears the resource from asrc and releases the occupied channels.
  */
-void fsl_asrc_release_pair(struct fsl_asrc_pair *pair)
+static void fsl_asrc_release_pair(struct fsl_asrc_pair *pair)
 {
 	struct fsl_asrc *asrc = pair->asrc;
 	enum asrc_pair_index index = pair->index;
-- 
2.22.0

