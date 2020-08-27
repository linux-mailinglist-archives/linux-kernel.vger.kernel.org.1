Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42AA2544B3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 14:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgH0MAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 08:00:48 -0400
Received: from crapouillou.net ([89.234.176.41]:52684 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728870AbgH0Loi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1598528652; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=ShExWMVn8zKfTMKQcyEv7erSROekk7sRNIPHvxubNFQ=;
        b=CK+73UlE2UylNErLk+hnL2wkjlSUbbN4YdNqUqAu93pLRVoS7lPH7Q5jW+GLsapI1LWWRd
        rbLHjCjB3jjASHAVhCphyszTuATa+7jQCKHRmNmt2+/DJ6swD7ydBv7C/iJEyvjRp0NlRU
        sG4aslwFwxFcSVns9d3lsJLTSgufK0o=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, od@zcrc.me,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 1/2] drm/ingenic: Fix leak of device_node pointer
Date:   Thu, 27 Aug 2020 13:44:03 +0200
Message-Id: <20200827114404.36748-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_graph_get_remote_node() requires of_node_put() to be called on the
device_node pointer when it's no more in use.

Fixes: fc1acf317b01 ("drm/ingenic: Add support for the IPU")
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index ada990a7f911..c1bcb93aed2d 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -978,6 +978,7 @@ static int ingenic_drm_probe(struct platform_device *pdev)
 	}
 
 	drm_of_component_match_add(dev, &match, compare_of, np);
+	of_node_put(np);
 
 	return component_master_add_with_match(dev, &ingenic_master_ops, match);
 }
-- 
2.28.0

