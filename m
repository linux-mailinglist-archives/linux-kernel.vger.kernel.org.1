Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879AD1B8484
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Apr 2020 10:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgDYIBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Apr 2020 04:01:17 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40186 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725837AbgDYIBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 04:01:17 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 42F0316A7F9B8A4F58D8;
        Sat, 25 Apr 2020 16:01:12 +0800 (CST)
Received: from huawei.com (10.67.174.156) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Sat, 25 Apr 2020
 16:01:03 +0800
From:   ChenTao <chentao107@huawei.com>
To:     <perex@perex.cz>, <shawnguo@kernel.org>, <tiwai@suse.com>,
        <s.hauer@pengutronix.de>
CC:     <lgirdwood@gmail.co>, <ranjani.sridharan@linux.intel.com>,
        <kai.vehmanen@linux.intel.com>, <festevam@gmail.com>,
        <linux-kernel@vger.kernel.org>, <chentao107@huawei.com>
Subject: [PATCH] soc: imx8m: Make imx8m_dsp_ops static
Date:   Sat, 25 Apr 2020 16:00:26 +0800
Message-ID: <20200425080026.143127-1-chentao107@huawei.com>
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
---
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

