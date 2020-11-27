Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED432C6AFA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732480AbgK0RxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732435AbgK0RxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:53:00 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72932C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:53:00 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id bj5so3027519plb.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q7Nnn3J+H568c7HE5IOpt8GvSqhl1ODBnmI1m9Ur3qE=;
        b=X4nxJ4aJHVRNcZ9CMjGybUz8SBBIX5nf5ODjEGspY+Mcf39dfqWMxgL9G1O+RHtZUN
         l9WtSx1zchxf9XYw3kEfGPLUI7V+wMWa1Bo+cERKuHpAhzpA4Nwv6IAHaFK8YDYDkzrJ
         vednCAn+8LvJAnyAxXju8yOSHmm/w2bqkUCNuYUX+0otId6W26YjpbklfASes+xgJu6+
         iSpaM0iBjiKfFUKllVfahlNIHUbe33SBQl02GsPx/jtaAwqopbkBb9S1vXPdaf48j3vr
         WLuuuUxR5ksBvRhoE0knvLJj0i3EqPdH9PjrWolHSbI8/bpBd+dzUzjzfDtoOxWwFaVp
         2tAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q7Nnn3J+H568c7HE5IOpt8GvSqhl1ODBnmI1m9Ur3qE=;
        b=aucsTdTWWaXO8xbNk2MWmKh/gHyaWHugNzl3nbvOBBAMJkGSB90ORCZuJdB4QYNAk/
         l4ZAZaETSawakFq4RXeQXxut7mKsafFI7slHKhUabE6abM5t6LwD+TbbERzcpKB98tlT
         //aJLkjeep3pQY7zylw1+mhZDFw4Z+wFuUQ0ntZkhYHYQvzxZEgX6q81B2JsOApaRB3G
         rMPqCdHkr/ca4Br5D21UKujM/M9sxsRzOp9lVgusN1L6aU5jZ+gx02/715urbETrU6ur
         lTJaBjI/uuvXRrt5tqJeh2hkpHfowTV1rm5DRgj+/YPjW3U5/GFIxi90clUycCWt/geG
         SruQ==
X-Gm-Message-State: AOAM5312yYMSCt5av7dIqK6QsFmefHgGXXmYhxS6HHeT2A3/NX8TYNPp
        ztL7cDmEvKU7NNh0gZ9w485+RKfJshk+X9Cu
X-Google-Smtp-Source: ABdhPJyQQ1BUEbYtI6BqhdvA1ubPQIpHPMHbxwJtEFi78IRbZnz6eCqkmjyPFPkIvevYVXZUx4ro1Q==
X-Received: by 2002:a17:902:fe12:b029:da:5be6:60a8 with SMTP id g18-20020a170902fe12b02900da5be660a8mr843779plj.21.1606499580048;
        Fri, 27 Nov 2020 09:53:00 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id t18sm10536724pji.1.2020.11.27.09.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 09:52:59 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/15] coresight: core: Remove unneeded semicolon
Date:   Fri, 27 Nov 2020 10:52:43 -0700
Message-Id: <20201127175256.1092685-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201127175256.1092685-1-mathieu.poirier@linaro.org>
References: <20201127175256.1092685-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zou Wei <zou_wei@huawei.com>

Fixes coccicheck warning:

./drivers/hwtracing/coresight/coresight-core.c:421:4-5: Unneeded semicolon

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index cc9e8025c533..29c83eac3106 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -418,7 +418,7 @@ static int coresight_enable_source(struct coresight_device *csdev, u32 mode)
 			if (ret) {
 				coresight_control_assoc_ectdev(csdev, false);
 				return ret;
-			};
+			}
 		}
 		csdev->enable = true;
 	}
-- 
2.25.1

