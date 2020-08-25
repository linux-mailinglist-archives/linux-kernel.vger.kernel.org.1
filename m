Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D964B251829
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 14:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbgHYMGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 08:06:04 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52608 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728126AbgHYMGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 08:06:02 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 35D83423E0EFD375A76F;
        Tue, 25 Aug 2020 20:06:00 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Tue, 25 Aug 2020
 20:05:51 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <timur@kernel.org>, <nicoleotsuka@gmail.com>,
        <Xiubo.Lee@gmail.com>, <festevam@gmail.com>,
        <shengjiu.wang@gmail.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <kernel@pengutronix.de>, <linux-imx@nxp.com>, <xobs@kosagi.com>
CC:     <alsa-devel@alsa-project.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <yukuai@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH 0/2] do exception handling appropriately in imx_es8328_probe()
Date:   Tue, 25 Aug 2020 20:05:29 +0800
Message-ID: <20200825120531.1479304-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu Kuai (2):
  ASoC: fsl: imx-es8328: add missing kfree() call in imx_es8328_probe()
  ASoC: fsl: imx-es8328: add missing put_device() call in
    imx_es8328_probe()

 sound/soc/fsl/imx-es8328.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

-- 
2.25.4

