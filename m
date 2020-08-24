Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73EA0250032
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 16:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgHXOwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 10:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgHXOwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 10:52:39 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF09C061573;
        Mon, 24 Aug 2020 07:52:38 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c15so8962613wrs.11;
        Mon, 24 Aug 2020 07:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=maYxkadvfVGHjTEoYFrkgW4rniaUuEx8JmifeotSE1I=;
        b=AsCueFr5jn9blAC4tR/EED5jjVRIvRTyBnu2Byudhgi0GeZB1rK4e4rxcO5s3mmf54
         qrmG6fYf0abHZzh5gcnwt36qLw0Hr3sGY9A2m+JwLEY3IOTWVhHen+Vvg8Ln5rpCJSUZ
         WfkeFok8pN2RAKPDxy5C2paWFQhXTXtewfVAJttB8ku16cx7JmisjZUFKbc9SMS9HVvQ
         KQqe8TDNvGy/nR9jy80qs3QHDLZlAUDBBmBgKW0xpT7g0g2yPIi89V4o+8DkHJh5K2oI
         dlVYSHTEu3Tt+LJdlngi3FJ0LvWXv/KdAgq+BNrK1EuHzLP9kvsk2KVkspYLctHOL0hb
         heYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=maYxkadvfVGHjTEoYFrkgW4rniaUuEx8JmifeotSE1I=;
        b=moD0skMiRKo3S3Jcmebzdtpj5/CW0raPXeq4coGkR8LaypChNZApzYLVy4ZKvwWbux
         uxVGQaJ36N+r2G08hbIPNWGDhEr1Z+PkdVPzlwpI1A58/3S+Jsth+tRIKyWW8Edbdens
         yc2vCoYMc+aoCvXvoG4HmejEmnW9Hm4rIf6s7Vi6jz2qR6kt/Lv8yEcjv1qqqcjSGq0r
         AxttjCUJuwuYPpmLGTJlxXZXTAxUWAGa1vfMeUc3LeZ6nVa5aNNLURhW/yeUbtGz9NAt
         /JHE5HhRUKE2WZBJBzndHVia+u/I4HNM8goVjNZF0DAXnfuGZE4+vYJ0U7KZ2wfEw5Zh
         onhQ==
X-Gm-Message-State: AOAM531PUIfSuxZoq9ISgshH7NHwim1009Af95LqfONQ1XQ0wsxeA3Nf
        lw+fR0rHWhZx6hnqMUGvvn95+rfJV+jTtBxP
X-Google-Smtp-Source: ABdhPJx/c+hJHlTuEfjleVzvC1y+b9nSw/44sBGPW74jQ37/FppAKE88ZEXjAoN76vHKzlvkqVF/rQ==
X-Received: by 2002:adf:ea92:: with SMTP id s18mr6275431wrm.269.1598280757560;
        Mon, 24 Aug 2020 07:52:37 -0700 (PDT)
Received: from a-VirtualBox.Dlink ([103.120.71.253])
        by smtp.gmail.com with ESMTPSA id 126sm25953778wme.42.2020.08.24.07.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 07:52:36 -0700 (PDT)
From:   Bilal Wasim <bilalwasim676@gmail.com>
To:     b.zolnierkie@samsung.com, corbet@lwn.net
Cc:     dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bilal Wasim <bilalwasim676@gmail.com>
Subject: [PATCH] docs: fb: Correcting the location of FRAMEBUFFER_CONSOLE option.
Date:   Mon, 24 Aug 2020 19:51:55 +0500
Message-Id: <20200824145155.42502-1-bilalwasim676@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fbcon doc mentions FRAMEBUFFER_CONSOLE option to be under
Device Drivers->Graphics Support->Frame buffer Devices->
Console display driver support->Framebuffer Console Support,
while its under Device Drivers->Graphics Support->
Console display driver support->Framebuffer Console Support.

Correcting it in the docs.

Signed-off-by: Bilal Wasim <bilalwasim676@gmail.com>
---
 Documentation/fb/fbcon.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/fb/fbcon.rst b/Documentation/fb/fbcon.rst
index e57a3d1d085a..a7b487cba307 100644
--- a/Documentation/fb/fbcon.rst
+++ b/Documentation/fb/fbcon.rst
@@ -20,8 +20,8 @@ A. Configuration
 ================
 
 The framebuffer console can be enabled by using your favorite kernel
-configuration tool.  It is under Device Drivers->Graphics Support->Frame
-buffer Devices->Console display driver support->Framebuffer Console Support.
+configuration tool.  It is under Device Drivers->Graphics Support->
+Console display driver support->Framebuffer Console Support.
 Select 'y' to compile support statically or 'm' for module support.  The
 module will be fbcon.
 
-- 
2.25.1

