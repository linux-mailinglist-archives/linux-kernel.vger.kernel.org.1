Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5052DA430
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 00:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgLNXeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 18:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgLNXeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 18:34:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2288C061793
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 15:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=vMhvU7UzeNy1QTs5M35EIFjoiT74uF3HtGRCg1kwYRk=; b=ORVpSO/nEfmsI4jHjB10cRl2WC
        LRrMJieOdajYK6itsRxYbd2yUOrQcP783vyEa1gkCQy1oQiFFiyZCSb8xApIjrznibmWVGwIY0nQu
        vQybrWEzdUUZypWTO2dRfG7PqKswcVlbrV6gOCTUf5ERze/aPdoqOJC0u+Nd6Ll65WfUSfE6k6Llz
        RX+LkmqxFnTyB4KsEvLkGq6SofOPQU5/uE2QD13VfKXkQJPNtWG9rNSWrCO+nXzlg7/0dCB5N7Ekq
        cfZ5zrb+csAaGa5UKey+BIG74VaEMe4vM6ioEyjcD+xSl9ApEBhMusLAHOnzK1oXeBT3CNWav9qWf
        S34H1oOg==;
Received: from [2601:1c0:6280:3f0::1494] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1koxLG-0007d4-FX; Mon, 14 Dec 2020 23:33:23 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 -next] drm/rockchip: cdn-dp-core: fix function not used when PM_SLEEP is not set
Date:   Mon, 14 Dec 2020 15:33:16 -0800
Message-Id: <20201214233316.19725-1-rdunlap@infradead.org>
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
v2: use preferred __maybe_unused instead of ifdeffery:
      https://lore.kernel.org/patchwork/patch/732981/

 drivers/gpu/drm/rockchip/cdn-dp-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20201214.orig/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ linux-next-20201214/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -1121,7 +1121,7 @@ static int cdn_dp_suspend(struct device
 	return ret;
 }
 
-static int cdn_dp_resume(struct device *dev)
+static __maybe_unused int cdn_dp_resume(struct device *dev)
 {
 	struct cdn_dp_device *dp = dev_get_drvdata(dev);
 
