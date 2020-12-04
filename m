Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC59F2CF299
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 18:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388431AbgLDRFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 12:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgLDRFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 12:05:12 -0500
Received: from latitanza.investici.org (latitanza.investici.org [IPv6:2001:888:2000:56::19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C86C061A53
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 09:04:31 -0800 (PST)
Received: from mx3.investici.org (unknown [127.0.0.1])
        by latitanza.investici.org (Postfix) with ESMTP id 4CnfFV5fzTz8sj0;
        Fri,  4 Dec 2020 17:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1607101470;
        bh=jj3P5WJKhBjJXjhj2nHnA+LqEglKEW8VWsBVAqfeHU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CVBq28eY5y/E2J5T940HENRNiWellXmut36E2S7zrKL3j1znsGIp/BvXNEmGDtTA8
         BBIbiUr9fi11xUOSnuleSemZEzRk+l2xTEit9mXUZf9hNK5mR+D1xlcM+e3Fn3az40
         BBx2JHh8BXcMlP0aiMZbc+2/vBoU6tLXV/of2Fgg=
Received: from [82.94.249.234] (mx3.investici.org [82.94.249.234]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CnfFV0sRNz8sfb;
        Fri,  4 Dec 2020 17:04:30 +0000 (UTC)
From:   laniel_francis@privacyrequired.com
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Francis Laniel <laniel_francis@privacyrequired.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 06/12] omap: Replace strstarts() by str_has_prefix().
Date:   Fri,  4 Dec 2020 18:03:12 +0100
Message-Id: <20201204170319.20383-7-laniel_francis@privacyrequired.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201204170319.20383-1-laniel_francis@privacyrequired.com>
References: <20201204170319.20383-1-laniel_francis@privacyrequired.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francis Laniel <laniel_francis@privacyrequired.com>

The two functions indicates if a string begins with a given prefix.
The only difference is that strstarts() returns a bool while str_has_prefix()
returns the length of the prefix if the string begins with it or 0 otherwise.

Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
---
 drivers/gpu/drm/omapdrm/dss/base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/base.c b/drivers/gpu/drm/omapdrm/dss/base.c
index c7650a7c155d..dd3d466293d1 100644
--- a/drivers/gpu/drm/omapdrm/dss/base.c
+++ b/drivers/gpu/drm/omapdrm/dss/base.c
@@ -350,7 +350,7 @@ static bool omapdss_component_is_loaded(struct omapdss_comp_node *comp)
 {
 	if (comp->dss_core_component)
 		return true;
-	if (!strstarts(comp->compat, "omapdss,"))
+	if (!str_has_prefix(comp->compat, "omapdss,"))
 		return true;
 	if (omapdss_device_is_registered(comp->node))
 		return true;
-- 
2.20.1

