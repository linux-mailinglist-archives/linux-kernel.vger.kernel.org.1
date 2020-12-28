Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB8D2E3B15
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 14:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404886AbgL1Npe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 08:45:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:46154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404815AbgL1NpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 08:45:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28FF52072C;
        Mon, 28 Dec 2020 13:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609163083;
        bh=CQjY1AciMA1uijxz4NGYW/S23Vf/sQz0kV0LWbr95b8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p8ww4XeZeZp/cQBS2v2XypyIXOk/KGF53QQar2w12HwogkkJTCeLYnsT0ieIU3K/c
         px/KpF1rwQsXVgjvxLeCsay3GPnk14FdSkIO2LWqPJ4bX3190cfausyeQXdmZrmI3V
         XP20DYfx49pit1H0wG++MbJ6rPWvhOBkyTFH1ISs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Zhihao Cheng <chengzhihao1@huawei.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 163/453] mmc: pxamci: Fix error return code in pxamci_probe
Date:   Mon, 28 Dec 2020 13:46:39 +0100
Message-Id: <20201228124945.054026795@linuxfoundation.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201228124937.240114599@linuxfoundation.org>
References: <20201228124937.240114599@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhihao Cheng <chengzhihao1@huawei.com>

[ Upstream commit d7b819b5d33869d41bdaa427aeb98ae24c57a38b ]

Fix to return the error code from devm_gpiod_get_optional() instaed
of 0 in pxamci_probe().

Fixes: f54005b508b9a9d9c ("mmc: pxa: Use GPIO descriptor for power")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Link: https://lore.kernel.org/r/20201121021431.3168506-1-chengzhihao1@huawei.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/pxamci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index b2bbcb09a49e6..953e7457137a2 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -729,6 +729,7 @@ static int pxamci_probe(struct platform_device *pdev)
 
 		host->power = devm_gpiod_get_optional(dev, "power", GPIOD_OUT_LOW);
 		if (IS_ERR(host->power)) {
+			ret = PTR_ERR(host->power);
 			dev_err(dev, "Failed requesting gpio_power\n");
 			goto out;
 		}
-- 
2.27.0



