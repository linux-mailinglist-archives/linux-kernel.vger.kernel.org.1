Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88A81BD270
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 04:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgD2Cp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 22:45:28 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3376 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726536AbgD2Cp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 22:45:28 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5DC3EA1674A07F2163AD;
        Wed, 29 Apr 2020 10:45:23 +0800 (CST)
Received: from huawei.com (10.67.174.156) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Wed, 29 Apr 2020
 10:45:14 +0800
From:   ChenTao <chentao107@huawei.com>
To:     <perex@perex.cz>, <shawnguo@kernel.org>, <tiwai@suse.com>,
        <s.hauer@pengutronix.de>, <broonie@kernel.org>
CC:     <lgirdwood@gmail.co>, <ranjani.sridharan@linux.intel.com>,
        <kai.vehmanen@linux.intel.com>, <festevam@gmail.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <chentao107@huawei.com>
Subject: [PATCH v2] soc: imx8m: Make imx8m_dsp_ops static
Date:   Wed, 29 Apr 2020 10:44:36 +0800
Message-ID: <20200429024436.30657-1-chentao107@huawei.com>
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

sound/soc/sof/imx/imx8m.c:95:20: warning:
symbol 'imx8m_dsp_ops' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: ChenTao <chentao107@huawei.com>
Acked-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
---
v1->v2:
- add recipient broonie@kernel.org alsa-devel@alsa-project.org

 sound/soc/sof/imx/imx8m.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/imx/imx8m.c b/sound/soc/sof/imx/imx8m.c
index 07451ba4efae..1a5b0f9ebac1 100644
--- a/sound/soc/sof/imx/imx8m.c
+++ b/sound/soc/sof/imx/imx8m.c
@@ -92,7 +92,7 @@ static void imx8m_dsp_handle_request(struct imx_dsp_ipc *ipc)
 	snd_sof_ipc_msgs_rx(priv->sdev);
 }
 
-struct imx_dsp_ops imx8m_dsp_ops = {
+static struct imx_dsp_ops imx8m_dsp_ops = {
 	.handle_reply		= imx8m_dsp_handle_reply,
 	.handle_request		= imx8m_dsp_handle_request,
 };
-- 
2.22.0

