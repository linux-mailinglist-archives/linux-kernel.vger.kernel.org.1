Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A5C27909C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 20:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730044AbgIYSdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 14:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729739AbgIYSdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 14:33:46 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88E8C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 11:33:45 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a9so2245487pjg.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 11:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z3aAxPMl4vXGO6SQG5uOhkRvPzoZ7Ff2bs8SM/RvFA4=;
        b=gpDRDw5C0YiK25MSEqsXxy3no9XMDsRhptDJTUFc6XaXxK0+tJIYoIIhzlBjQNARQa
         m78mhqSgDjB8zPTFTQ8ivqNprTMg8hb/iJwy6BWdj+fCi+kGQ01r4HjiaIhoOA+GKZqy
         y2OA5c1fkAnYt/avmNUHA3DmWRlKLK/HvmsCVZGKf2xE7C4pwKRpaEt85EKRkYQNaJqh
         LR4faHgXxTiDHHx5dWcUf08EuKteVEE9inINjKKP8MOBC0C4Saf7NqAhjGKy+FuOI7f9
         zIaHOMYb43uml+OSfJKlBmstylb5voz44T8Qtv7B8RKapmtJ59tNcxKOejv7Q/x0RjPe
         GWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z3aAxPMl4vXGO6SQG5uOhkRvPzoZ7Ff2bs8SM/RvFA4=;
        b=YP7LygqbSyjoPBmwAOaD41XYLaUl8bksT2EXuVVchkbB5VZghZMiJ91ubwtmnm7+AA
         IHd4u8ERRWgEdghjvdu3oVGVPY1iO6rvTa6jCQNe1/g3zoJJdkttWZi0PMSKVAd3dkdg
         SaG5UQKUU6ZZ831B0Tt3LtnsBFwCdfez/3k3QRmCjvOTtSiOvthEaBnFsowK0J/FKy0b
         xUp47pbU5tc3kHzr+/umlt/aD1Y+BSLJYdRdNSrJV+x9E+AO3I16V5mmlppXmTOBdc3d
         PtFwQ1za9eP4GFGGXod17Tqj8k60uvzmt25j1CI2KlVPhNia49VF/npvSLcolMOMPKyr
         mk7Q==
X-Gm-Message-State: AOAM532Aaxd1YSwwKHkCXcVOV4L+FnhR8ykXhglGO6aOhcFQ9zzHw8er
        k6ADuRMK7PmGRa66cvEOPPkiNA==
X-Google-Smtp-Source: ABdhPJxSiNc6igRsZSi+sSwsmRMZbrWk5a0Qvj/50ImCNIuOapDp8w29AOIdNNMtiXNgMT0gPV7h7A==
X-Received: by 2002:a17:90a:6741:: with SMTP id c1mr824105pjm.6.1601058825347;
        Fri, 25 Sep 2020 11:33:45 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id r16sm2554546pjo.19.2020.09.25.11.33.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2020 11:33:44 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     gregkh@linuxfoundation.org, mchehab@kernel.org, hverkuil@xs4all.nl,
        laurent.pinchart@ideasonboard.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH RFT/RFC v2 25/47] staging: media: zoran: zoran does not support STD_ALL
Date:   Fri, 25 Sep 2020 18:30:35 +0000
Message-Id: <1601058657-14042-26-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601058657-14042-1-git-send-email-clabbe@baylibre.com>
References: <1601058657-14042-1-git-send-email-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In fact, zoran does not support V4L2_STD_ALL, so let's enumerate what we
support.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/staging/media/zoran/zoran_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/zoran/zoran_driver.c b/drivers/staging/media/zoran/zoran_driver.c
index 858e0910884c..60bbc8235cff 100644
--- a/drivers/staging/media/zoran/zoran_driver.c
+++ b/drivers/staging/media/zoran/zoran_driver.c
@@ -1765,7 +1765,7 @@ static int zoran_enum_input(struct file *file, void *__fh,
 
 	strscpy(inp->name, zr->card.input[inp->index].name, sizeof(inp->name));
 	inp->type = V4L2_INPUT_TYPE_CAMERA;
-	inp->std = V4L2_STD_ALL;
+	inp->std = V4L2_STD_NTSC | V4L2_STD_PAL | V4L2_STD_SECAM;
 
 	/* Get status of video decoder */
 	decoder_call(zr, video, g_input_status, &inp->status);
-- 
2.26.2

