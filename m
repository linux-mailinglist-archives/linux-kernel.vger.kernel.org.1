Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D0127BC2F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 06:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbgI2EtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 00:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgI2EtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 00:49:19 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0153C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 21:49:19 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f18so3307649pfa.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 21:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gZJjXeIoqp10fgs412ZBMIhuGHG/6qS/5ErOSn9zoRw=;
        b=L4tOM7XZuoynJQGnQNM8Jw6RcsrFAp2a7NfHNmtUN/3CD5xAUGd3QWa3id5UZcs912
         CFZbwwMKfsVuiDCTbsuSn8tRIhK/LP8tPuYwp1+H7nm2FLSef+DRHybUfAY9Du/BJo8j
         xI6XvgVMyZGQZoTe4m6BzdppnZT12wlk7Jlo5djT/98vWgIEbedDPtCDBH7zpUc/sJ8D
         tbCPwsXDtM3l0VHwPj3KHhtkIm0zRVzMAMEQFTY1s/LbZ/iHOHvRXFcPXN1qlafjpxop
         DGTKxWciIIitSQyeuDXPLHT7TZUlKAg8xn+cJNDLjDJnxSbUG9WXeLWL7wHic949Je/a
         7DCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gZJjXeIoqp10fgs412ZBMIhuGHG/6qS/5ErOSn9zoRw=;
        b=n/xz25Gzp1+tLfQ1F0PwJ63UBnnq9epUguMwuQWP16J7gNCtift3fYilZBmt3w6TgP
         rjgyVYPItsunH99AfOCf09yrEdPjeROYutCfoNVENP0Gxle9jQeHOuuIbfu6j+iniAnw
         nyZc7WjpvB68V33WM57b+AEONpQBCI7FqO4lqP0VCwgqk0pjCTI4EHKi5ZNWwMQgIbL6
         jcmeq0bAN/1LEFX5a4LkwEri0LHd1CEesrnSWwE8HtZ78SwvRxr5A1Isg195K3WHmRfz
         MS9OJNWuDY9LTRIoGc8ujCRvsVQdWL09k8ZyiaY737MVGujh0MOKaki7h/WFa/mVbNbF
         EySg==
X-Gm-Message-State: AOAM530S1sAGReG19Xd/GsZ5jqAVsEe3QDOIz6HSs6V4pTEhtPjGSRTW
        v5gMhWMnu24EhyWSlyofQTo=
X-Google-Smtp-Source: ABdhPJztxLsRS+LCBWAaSFwoZd0rxYav7kddouqGpKhDEplIHmMZ6NV/2Y662JylylYKBGWjHCKZAA==
X-Received: by 2002:aa7:9986:0:b029:142:2501:39db with SMTP id k6-20020aa799860000b0290142250139dbmr2493310pfh.42.1601354959511;
        Mon, 28 Sep 2020 21:49:19 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id s2sm2770102pjg.52.2020.09.28.21.49.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2020 21:49:18 -0700 (PDT)
From:   jiahao <jiahao243@gmail.com>
X-Google-Original-From: jiahao <jiahao@xiaomi.com>
To:     christian@brauner.io, jiahao@xiaomi.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] kernel: exit: fix a spacing coding style
Date:   Tue, 29 Sep 2020 12:48:53 +0800
Message-Id: <1601354933-28526-1-git-send-email-jiahao@xiaomi.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some spaces before and after the operator.

Signed-off-by: jiahao <jiahao@xiaomi.com>
---
 kernel/exit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 733e80f..a3c831c 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -869,7 +869,7 @@ EXPORT_SYMBOL(complete_and_exit);
 
 SYSCALL_DEFINE1(exit, int, error_code)
 {
-	do_exit((error_code&0xff)<<8);
+	do_exit((error_code & 0xff) << 8);
 }
 
 /*
-- 
2.7.4

