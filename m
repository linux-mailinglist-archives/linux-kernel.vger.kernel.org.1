Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB452E3D54
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 15:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440393AbgL1OOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 09:14:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:48566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440340AbgL1OOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 09:14:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65D68206E5;
        Mon, 28 Dec 2020 14:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609164836;
        bh=zYZgqytYpVxvRNMrzkJ5uRDr3iyaoyaxFjbENdYl2IM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WcQqBOO6AKzEqxSd6nsfYbtHML4u5OXmvRpNYXw/Km86pJ1N3hgqMPRIq4UykCg+0
         Ylwdrf6aVFB4Yn2wqMv0ASZuqwC5dnM1Cx9zlu0aqevjjc+w48Fn5+kZiVBkeuDOMk
         zhhXvtmCi2Hrjh4RobdrmHIMidecXwkv0v1WCLq4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhang Qilong <zhangqilong3@huawei.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 275/717] hwmon: (ina3221) Fix PM usage counter unbalance in ina3221_write_enable
Date:   Mon, 28 Dec 2020 13:44:33 +0100
Message-Id: <20201228125034.193166117@linuxfoundation.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201228125020.963311703@linuxfoundation.org>
References: <20201228125020.963311703@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Qilong <zhangqilong3@huawei.com>

[ Upstream commit bce776f10069c806290eaac712ba73432ae8ecd7 ]

pm_runtime_get_sync will increment pm usage counter
even it failed. Forgetting to putting operation will
result in reference leak here. We fix it by replacing
it with pm_runtime_resume_and_get to keep usage counter
balanced. It depends on the mainline commit[PM: runtime:
Add pm_runtime_resume_and_get to deal with usagecounter].

Fixes: 323aeb0eb5d9a ("hwmon: (ina3221) Add PM runtime support")
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
Link: https://lore.kernel.org/r/20201202145320.1135614-1-zhangqilong3@huawei.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/ina3221.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index 41fb17e0d6416..ad11cbddc3a7b 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -489,7 +489,7 @@ static int ina3221_write_enable(struct device *dev, int channel, bool enable)
 
 	/* For enabling routine, increase refcount and resume() at first */
 	if (enable) {
-		ret = pm_runtime_get_sync(ina->pm_dev);
+		ret = pm_runtime_resume_and_get(ina->pm_dev);
 		if (ret < 0) {
 			dev_err(dev, "Failed to get PM runtime\n");
 			return ret;
-- 
2.27.0



