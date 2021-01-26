Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515FC303F7A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 14:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405529AbhAZN7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 08:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405598AbhAZN5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 08:57:03 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFEDC0611BD
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 05:56:23 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id g3so9829153plp.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 05:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PLopm+nrSb+Okoh9RwkXyxLkE32CQhc9+HXJvPrxQb4=;
        b=RvJfkf28Wk5Xtg8jR3Gp8he1XgD6VQWnnVruv4X1jwyV/oNmxTH+tOQ4LlSR8C1s7B
         HvTXVV6ucfBlY5EFXzq4GVi26U9E41wcQbGtTUU31wJm4syeCVnjIBmHVRwwI/PLK/Xr
         +F9xMZP9Qw+KRwBB9AbuSOIRWmyXGCmZuW6Rq+6IQgJ5YlQzJMkKUNRK54G/x+APJC0Q
         WbgR7MRVa3qD7mgAXbm5Sc9ZbWXxc83h4IIVMk50n5is6fzo5aOBPfxkjzn1+yQje6Dc
         93LpB1ioS8i7PO7Nt/zA9ZkwvdcmIH6fvaBPIZORAfpaOt2FhJDm3Vly0U/G4FBIPOG6
         KnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PLopm+nrSb+Okoh9RwkXyxLkE32CQhc9+HXJvPrxQb4=;
        b=XYnSXQHaYvDlbjIvEe8YFsz1y2aHQ0WqGQ56qa+rSZ/5bvW4nAhRxQAcdGm9TjVMBS
         ziVH4hAKscr154zfW0KU6WQ0SYxGvo6xn8+WRa8+E8hxs0P+765F+0dyyz0uRsPd5ql/
         B+cy8u2n6UR2aNPZ0KOWGnMJlTkYcZzEf8V8nOvjBT5tGNDS9A0ipvUSjJbXeY5v0nFL
         uFa+Vfu6PCggQ5ey7LRDZdEV4pg+B5kQ+YCXgDUgfzgNIxWgdeQDDPDHzbLkNAvfV5aA
         XyRrg6NACfZxHQksu/FWeWlZJBxpxbb6BcUBRgTAQ834DlzpcjXutzPmlXMiGwv5fyFN
         S/sA==
X-Gm-Message-State: AOAM531pJOeI6ZwrJOY5CFEccqF6Pl9vFwZOMGVQ0dscqDu0R86JwZAC
        /JRiwsnoT8V7PRp/nqHzsQc=
X-Google-Smtp-Source: ABdhPJwof+FC12gJZtih8+puFm8cdpF2/TVMbujKejXQOEFMUBGHhS/YQrYaGA7I/Hi1ewa3bbRFkw==
X-Received: by 2002:a17:902:6bca:b029:df:fb48:8c39 with SMTP id m10-20020a1709026bcab02900dffb488c39mr6084593plt.31.1611669383219;
        Tue, 26 Jan 2021 05:56:23 -0800 (PST)
Received: from localhost ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id y21sm19446682pfp.208.2021.01.26.05.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 05:56:22 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: dong.menglong@zte.com.cn
To:     tomba@kernel.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, sebastian.reichel@collabora.com,
        laurent.pinchart@ideasonboard.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Menglong Dong <dong.menglong@zte.com.cn>
Subject: [PATCH] drm/omap: dsi: fix unreachable code in dsi_vc_send_short()
Date:   Tue, 26 Jan 2021 05:55:11 -0800
Message-Id: <20210126135511.10989-1-dong.menglong@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Menglong Dong <dong.menglong@zte.com.cn>

The 'r' in dsi_vc_send_short() is of type 'unsigned int', so the
'r < 0' can't be true.

Fix this by introducing a 'err' insteaded.

Fixes: 1ed6253856cb
("drm/omap: dsi: switch dsi_vc_send_long/short to mipi_dsi_msg")

Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
---
 drivers/gpu/drm/omapdrm/dss/dsi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
index 8e11612f5fe1..febcc87ddfe1 100644
--- a/drivers/gpu/drm/omapdrm/dss/dsi.c
+++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
@@ -2149,11 +2149,12 @@ static int dsi_vc_send_short(struct dsi_data *dsi, int vc,
 			     const struct mipi_dsi_msg *msg)
 {
 	struct mipi_dsi_packet pkt;
+	int err;
 	u32 r;
 
-	r = mipi_dsi_create_packet(&pkt, msg);
-	if (r < 0)
-		return r;
+	err = mipi_dsi_create_packet(&pkt, msg);
+	if (err)
+		return err;
 
 	WARN_ON(!dsi_bus_is_locked(dsi));
 
-- 
2.25.1

