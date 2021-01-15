Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85552F7FAB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 16:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733080AbhAOPfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 10:35:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34624 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729384AbhAOPfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 10:35:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610724836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Wfh7XXE4FaRL189SEXwAsYtzgDt+BP8Y2RI5c8Q+mik=;
        b=XnLQq9eKwjLYoifWW7AIIz51wPp2QDDX1l2z+QVZXfxCNG4KDLINIqCJE/MqD4uOalBeCj
        Gwv026NU+enhkKjZjSFWvqgVOVKUhwDQoSFnrFZc4b+EE/pT0w+Gt5MIZOtvkXw9h8+edw
        BlP+uAwwWREo1c7hVeeml3cezqy0Hio=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-HuswXOJgM3qkiXeOiTt9Sw-1; Fri, 15 Jan 2021 10:33:55 -0500
X-MC-Unique: HuswXOJgM3qkiXeOiTt9Sw-1
Received: by mail-qk1-f199.google.com with SMTP id p21so8338843qke.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 07:33:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wfh7XXE4FaRL189SEXwAsYtzgDt+BP8Y2RI5c8Q+mik=;
        b=bPD+uu1qZJNaPe3uku93DlpnYCFzI+s0OquvvH1fu+Qj1WAPX9Sm/LTONc34/uYfrX
         kNOtD3vSUL/gbNdpeTDxPUsTEI39ehz1yf9zYtdV8TU3n+Ft5b5YV5O0dyEYzUD+zh8q
         ex/z+mkYqfpsAWBT+1UoVaCI0VR/aSLDanJmaBAlk2wCXZp+iCDXiCoyffdCqaKB+oPz
         aVql9jjEdelUp7e5XQmUJaxrSxg2veKMAI8e7b6np01AOvHjD57YEZCpzXYV81w/m6qw
         cbGzjq8RtcsAFjeTAo5g9ONeSFW0qR8UFRzv9mYacE4S333/G9P9driva73r4s7pr7Gg
         cEBw==
X-Gm-Message-State: AOAM530ZE8C54dBYbsDOV5EnNpgQExjjwCCUaM9XjNvQmXx0Zb68dZiu
        YfNd+2o5oBfmg1Hz0zIqvPNab4fGZfy45L7re70sLAOAlVK9C7Gh/ybN8qVU2fyr2Oe8OAPRun5
        nF4MRAfS6lo2RRy/6Y0exMP5v
X-Received: by 2002:ac8:6f69:: with SMTP id u9mr11943464qtv.16.1610724834387;
        Fri, 15 Jan 2021 07:33:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx2Z2TMToLc+Z+6dBEeTfi85S/wapTmboEB97lvUvbgxb5jxMVSAs2sw7Z/VqdvS8Bp87Rn7g==
X-Received: by 2002:ac8:6f69:: with SMTP id u9mr11943450qtv.16.1610724834214;
        Fri, 15 Jan 2021 07:33:54 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id q185sm5228245qka.96.2021.01.15.07.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 07:33:53 -0800 (PST)
From:   trix@redhat.com
To:     rostedt@goodmis.org, mingo@kernel.org, karolherbst@gmail.com,
        ppaalanen@gmail.com
Cc:     linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] tracing: remove definition of DEBUG
Date:   Fri, 15 Jan 2021 07:33:48 -0800
Message-Id: <20210115153348.131791-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Defining DEBUG should only be done in development.
So remove DEBUG.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 kernel/trace/trace_mmiotrace.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/trace/trace_mmiotrace.c b/kernel/trace/trace_mmiotrace.c
index 84582bf1ed5f..2c3c31791497 100644
--- a/kernel/trace/trace_mmiotrace.c
+++ b/kernel/trace/trace_mmiotrace.c
@@ -5,8 +5,6 @@
  * Copyright (C) 2008 Pekka Paalanen <pq@iki.fi>
  */
 
-#define DEBUG 1
-
 #include <linux/kernel.h>
 #include <linux/mmiotrace.h>
 #include <linux/pci.h>
-- 
2.27.0

