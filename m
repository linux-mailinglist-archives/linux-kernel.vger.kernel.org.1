Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBDA2ED042
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 13:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbhAGM4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 07:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbhAGM4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 07:56:53 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31B1C0612F9;
        Thu,  7 Jan 2021 04:56:12 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id n9so6616417ili.0;
        Thu, 07 Jan 2021 04:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uApyszem/ROfh/q8GyAsaUk/VqjtHZu4fUgb+wmUYG4=;
        b=N+ljDYZ6bfE7tFgoZXG9Mx2bjNY2ifzv0DeAOJIWeDakDqQfASoFPjX/TZZz/ZjaGZ
         gT/Qazz/cfI9rPuZGQ1gtkBhIiktXWCBMknNvI6tA4TyM7hz5JIY3aNFruoEowceS6n6
         /mV65Mfk8+Lhyp3+HJ6qrSOGG0AbSQ7ztDhWIVuIk4TZZVtQUuhAgDQ3swOdfn91ZrmM
         bKL9JOOSJOvDJrEt5Wvj6cbu8WnhIBfiCadMKvWahsGDOqrECRRMqpuJGh0rrRli8z6C
         SzCPldfeOzIM0qIT3AHfNKdZ1b82wN7wOI3jVpZU28AHOMpu9orW6uKi0ujciotHErXw
         lkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uApyszem/ROfh/q8GyAsaUk/VqjtHZu4fUgb+wmUYG4=;
        b=mEHtouFzrdCZ7nJEA6NXPROQf2blDB09GPnGZuA5G7C1ZQOJP1jrtGEWZBgZjEPeqP
         6dST39myfGg11ZbyDKnq9rf8lLHXxhatyVG/kKlfHUjVZIT8CbqtIOS5S1UAC9Zwegwo
         ALcGkF8SEGFsSmQ4SikPXFK9Urofdm3s+4llWbloYt1aKo8WnBd8ggmpaFS3UK8Frb/l
         30dW/V583U5lRQ0we4ZatA2hK35jRjR0UMO3fSz55PGmRr5BRjCnobr//F2nsjFmWpBc
         n21wN0Rln0hDev9WuVrp2AqyrV9nEOjntAblmDwDkCfpUm3nijZdrmHa3skV0/WYujqd
         9wmA==
X-Gm-Message-State: AOAM532D6UvRJT3dLvWFl6c4le5da3vq+X7g6lOzXb4UkiXtg2Rs4OET
        5Lc4VTcyHRaRHjfbFMoZ69OBhP+VVGO/ztSj
X-Google-Smtp-Source: ABdhPJwod1tUHUGFZnuwP7eUJHp/I8z5qLhXrV8NSn9EKf9GOh2pnjX3CsL81hFK3zGkHdLIqSc2iA==
X-Received: by 2002:a92:4019:: with SMTP id n25mr8786806ila.25.1610024172282;
        Thu, 07 Jan 2021 04:56:12 -0800 (PST)
Received: from localhost.localdomain ([138.199.10.65])
        by smtp.gmail.com with ESMTPSA id b18sm4363893iln.46.2021.01.07.04.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 04:56:11 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     mhiramat@kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] docs: admin-guide: bootconfig: Fix feils to fails
Date:   Thu,  7 Jan 2021 18:26:10 +0530
Message-Id: <20210107125610.1576368-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/feils/fails/p

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/admin-guide/bootconfig.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index 9b90efcc3a35..452b7dcd7f6b 100644
--- a/Documentation/admin-guide/bootconfig.rst
+++ b/Documentation/admin-guide/bootconfig.rst
@@ -154,7 +154,7 @@ get the boot configuration data.
 Because of this "piggyback" method, there is no need to change or
 update the boot loader and the kernel image itself as long as the boot
 loader passes the correct initrd file size. If by any chance, the boot
-loader passes a longer size, the kernel feils to find the bootconfig data.
+loader passes a longer size, the kernel fails to find the bootconfig data.

 To do this operation, Linux kernel provides "bootconfig" command under
 tools/bootconfig, which allows admin to apply or delete the config file
--
2.30.0

