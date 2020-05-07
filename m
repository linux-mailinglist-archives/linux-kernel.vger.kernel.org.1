Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9781C9661
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 18:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgEGQXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 12:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726627AbgEGQXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 12:23:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C524C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 09:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=HWcYFhwuKZBkcAlypnWomG6dn+SIe9TYlotFgzRCTJg=; b=fWwekOEKyltFs3du68d9ZNphza
        oLlBD7294ZfcEiOENvK6tGCjvvhIWyUaDESHwoTHPU6/tgJGEz3i3LgseeEUER9jFcTC4OetLfs35
        tx371+qnyiE+CrPMV9ptgA7quZgLqGIfhrBZi5XHmcYeKRhbz+cCUMoso9/YbdoBRv9RaFqKnpEiv
        jp2utHCAAJhotGbQ6esIDg8npjaSdXQFWfg2l4odPJhV919bMwSEWdRBd/PHoi0YmFQNSJ1v8KtHw
        8z9RYYp9/G1BA0y4XSdAhuYPBDjdA3aNVZZx8kpeh7rapIl1FZl6BW+9PPN/CIfuWLdQx9WGUjXI3
        dkUGf+xA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWjIm-0008To-Fd; Thu, 07 May 2020 16:23:12 +0000
To:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] drm: panel: add MODULE_LICENSE to
 panel-visionox-rm69299.c
Message-ID: <bbb7b3b3-9968-9a1f-8ef6-2e8e3be998f6@infradead.org>
Date:   Thu, 7 May 2020 09:23:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Add MODULE_LICENSE() to the panel-visionox-rm69299 driver
to fix a build warning.

WARNING: modpost: missing MODULE_LICENSE() in drivers/gpu/drm/panel/panel-visionox-rm69299.o

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/panel/panel-visionox-rm69299.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20200507.orig/drivers/gpu/drm/panel/panel-visionox-rm69299.c
+++ linux-next-20200507/drivers/gpu/drm/panel/panel-visionox-rm69299.c
@@ -300,3 +300,4 @@ static struct mipi_dsi_driver visionox_r
 module_mipi_dsi_driver(visionox_rm69299_driver);
 
 MODULE_DESCRIPTION("Visionox RM69299 DSI Panel Driver");
+MODULE_LICENSE("GPL v2");

