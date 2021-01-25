Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F9830279E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 17:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbhAYQRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 11:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730329AbhAYQO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 11:14:59 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315A5C0613D6;
        Mon, 25 Jan 2021 08:14:19 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id m187so11458872wme.2;
        Mon, 25 Jan 2021 08:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dI/Ix4uYo26OWE2SXq060YPzR8/QtIeBAKFWXszmsGU=;
        b=JvGqZ1efjE2YbTW45WdtPJQ5Uq4IVCJWAVFVHujMpxosf6N7Vw0QTJGq8VsjTQJMyN
         Om+iJ39BoXCP0W1LkpqLZ7AXMlN143rJfw9K8lJCUH8Z7CIMErVBPRkKpfkxRpUticxc
         eE3TVc0RnhblbTD7wC3mdqOBPpHzNHkuwoeL1NLvY8gTXp+RBBG4pmL2s1tgrF1un4Ry
         q09VsfwjFzg9zuSlSoDPXjF2eLeRanFPSfkVclnC/jmJPTQwTfpggpd+fGga2C9jEbwm
         +KydHrNEZB/Vv5yALgEZOUUpkklwQwGgiY0CGZfRpfjjTOuiMQUw5aFGJ5BQuB010WNO
         jDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dI/Ix4uYo26OWE2SXq060YPzR8/QtIeBAKFWXszmsGU=;
        b=kmyseYDPaSHSSJ6/1hefdmhSqUExFkaLW8fI+ZMQjl8MjwCY9VL0rRbckj756I9NFE
         iCYhUtI/d75sIJ9pZlKGaPyuldGfYjW86zPLOr4sbERSLvKb50f716SpCIaiVDmAYRak
         E/KUISQh/uLqx35NL1G8Cua1ud8dZdr7IPblbHc0ctTaIYGL4uBh+vr+N4FdvBpshcup
         kexU+1jR2HwclL6DEb7HaKHEzCcqNtyT3VNptLsIMRx2L++IS8QcjuFYHZ0w2+hYWbDi
         eEeBiS7NZyor9cJdo3Qv2z4NlUkXWiJy3Rd8NCYD7OxsgBebu4m3DvcpYKX3kejyCOfe
         t4Yg==
X-Gm-Message-State: AOAM530gaUANhB4rsuFUl0c9fHwDTjgQjbY9+jgvxrKom7DqpSJ50RAt
        aBkr9yLoN7aG9GTPhK9kUhg=
X-Google-Smtp-Source: ABdhPJw/WsyPY2DyzH3foeTV7gKmmtwfrZ2WrYbr3D0NVJHrMeRBMY3K8s0tqiJymivSwyLOmmhWEw==
X-Received: by 2002:a1c:dec6:: with SMTP id v189mr815226wmg.172.1611591257889;
        Mon, 25 Jan 2021 08:14:17 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d4b:4500:649e:f82b:bf2d:2571])
        by smtp.gmail.com with ESMTPSA id s24sm21648629wmh.22.2021.01.25.08.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 08:14:17 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] watch_queue: rectify kernel-doc for init_watch()
Date:   Mon, 25 Jan 2021 17:14:09 +0100
Message-Id: <20210125161409.8478-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The command './scripts/kernel-doc -none kernel/watch_queue.c'
reported a mismatch in the kernel-doc of init_watch().

Rectify the kernel-doc, such that no issues remain for watch_queue.c.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on v5.11-rc5 and next-20210122

David, please pick this minor kernel-doc fixup.

 kernel/watch_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 0ef8f65bd2d7..9c9eb20dd2c5 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -413,7 +413,7 @@ static void put_watch(struct watch *watch)
 }
 
 /**
- * init_watch_queue - Initialise a watch
+ * init_watch - Initialise a watch
  * @watch: The watch to initialise.
  * @wqueue: The queue to assign.
  *
-- 
2.17.1

