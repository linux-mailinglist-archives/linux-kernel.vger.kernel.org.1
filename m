Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751312A717B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 00:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732775AbgKDXYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 18:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732828AbgKDXYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 18:24:14 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7820C0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 15:24:12 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id b13so12382qvz.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 15:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=u5wayZ9AVFMGS2ijaBJPPdXKpeLHXYLicPYl2nj1shI=;
        b=iVIITovvfmdqa7ENQHfnvmD7E7Q89Vqx621sZYGic9iXL2Yt4kyuIGXc0RlopwO7eF
         lMDFCTi295lj6kNhA98o6Zr8zYdKlcMltOwo0dfKAi9YEyQKs+nE2yXjekyLbllbELIj
         XOJbSndFOfrxPkQaMFyE4+3GqLIp0+PMRJ31QE2eBw4/rjyfOBCwzCNzqlxsMw+/J0Ka
         v9tyd9lhBbSnQ1BPj2z2kKMquvyq1DnDjrwCjfogbkKy/s2KInZ/EykovZhbmuijp9HT
         3iDehlrdMA9rygPnHkxRgqbrIjoJf/sGBxoyn/J3CjHx5DAdyBhChRxqhNcejq090UIq
         eMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=u5wayZ9AVFMGS2ijaBJPPdXKpeLHXYLicPYl2nj1shI=;
        b=U76as0d7wcM0mgflpAvDDu7BAOhYTJbOR1OvWIvK0HM7VGyTachmLqEf9cBih7Gx+X
         QakwtDPCTRs1RPEROj1XUFWYKPTkXIQhHafkziPCMAX2rbTnEhU6LxoRLchKoxAavlLl
         1fREpsTfw273B7p/5/USCk+1k/tNHznZ3pfYz2N7HJa32eCvvqCDcpimSpeGwSUnbVzB
         BQQ0f4jgtkOq2J18Mz81TZEDxZuz457xuMELoFRBHk/lKzMmHGuiYxXz8yk41UxKCVX/
         QR1qWbYewlK4+OZ0SMt1X7jh/LticyeJ1dyrIhlvH3KJWDP2QI47pZPX1ggdj0JgSJ3U
         MNSw==
X-Gm-Message-State: AOAM531BKmCfPg+CyhCJZjv4qPjoIJlxormTzL0u/HbNQvzHNpgoGNWQ
        h23WlkVU+242ZzKTVH3DAElhfLUtfAgOZzk=
X-Google-Smtp-Source: ABdhPJwjKo0cRX9EmzXQSkYgc/ChZZniluSDDdAeEjXvu1+EPop/QjPtY/4CxN+WF6Ie5LvnM2VAnbfDX7ilMx4=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a0c:e346:: with SMTP id
 a6mr179397qvm.9.1604532252026; Wed, 04 Nov 2020 15:24:12 -0800 (PST)
Date:   Wed,  4 Nov 2020 15:23:42 -0800
In-Reply-To: <20201104232356.4038506-1-saravanak@google.com>
Message-Id: <20201104232356.4038506-6-saravanak@google.com>
Mime-Version: 1.0
References: <20201104232356.4038506-1-saravanak@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v1 05/18] Revert "of: platform: Batch fwnode parsing when
 adding all top level devices"
From:   Saravana Kannan <saravanak@google.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        kernel-team@android.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 93d2e4322aa74c1ad1e8c2160608eb9a960d69ff.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/platform.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index b557a0fcd4ba..79bd5f5a1bf1 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -538,9 +538,7 @@ static int __init of_platform_default_populate_init(void)
 	}
 
 	/* Populate everything else. */
-	fw_devlink_pause();
 	of_platform_default_populate(NULL, NULL, NULL);
-	fw_devlink_resume();
 
 	return 0;
 }
-- 
2.29.1.341.ge80a0c044ae-goog

