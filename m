Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A90A2D7FAF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 20:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394419AbgLKTt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 14:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394393AbgLKTsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 14:48:32 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81BDC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 11:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=HBfnftZnbBrqQ2L8AVQLmkUI6WPMZLgfMtK+X7BxoY8=; b=HhzXululOSOrfvp/5YAOmPtSYq
        Kknf7NDUIJ8zqpvoHdy/Sj9Qsqc6FB0Kzf9iV9JR+K72F2AuOAVD2FzdsSzP/0rZxWImjIFDbY9YD
        EZYIe8VF0oTe/fPNAzMvQShkoFkY7kGDl8sAl2q6A4WWSS2VsE/JMijPnamd030yjtG5Ecr+ii4Of
        WQ8mfaiiYZ3ZptXiLmYi9BHV4Ymno7gPWn6n+FqeRTMIvJS/UVZKqjuY6CceaOtD8iG9TzTrULsgA
        ibXM0NsfbXMgqMWvaDqZbnFZfPUN5JAvny0SyF3khm2I10p6gDDNwl6HjJEbY02KcM7JBvKLVRZuN
        0B/t38Xg==;
Received: from [2601:1c0:6280:3f0::1494] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knoOD-0008PD-Te; Fri, 11 Dec 2020 19:47:42 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH -next] drm/rockchip: cdn-dp-core: fix function not used when not PM_SLEEP
Date:   Fri, 11 Dec 2020 11:47:36 -0800
Message-Id: <20201211194736.7908-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build warning when CONFIG_PM_SLEEP is not enabled.

../drivers/gpu/drm/rockchip/cdn-dp-core.c:1124:12: warning: ‘cdn_dp_resume’ defined but not used [-Wunused-function]
 static int cdn_dp_resume(struct device *dev)

Fixes: 7c49abb4c2f8 ("drm/rockchip: cdn-dp-core: Make cdn_dp_core_suspend/resume static")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Sandy Huang <hjc@rock-chips.com>
Cc: Heiko Stübner <heiko@sntech.de>
Cc: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/rockchip/cdn-dp-core.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20201210.orig/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ linux-next-20201210/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -1121,6 +1121,7 @@ static int cdn_dp_suspend(struct device
 	return ret;
 }
 
+#ifdef CONFIG_PM_SLEEP
 static int cdn_dp_resume(struct device *dev)
 {
 	struct cdn_dp_device *dp = dev_get_drvdata(dev);
@@ -1133,6 +1134,7 @@ static int cdn_dp_resume(struct device *
 
 	return 0;
 }
+#endif
 
 static int cdn_dp_probe(struct platform_device *pdev)
 {
