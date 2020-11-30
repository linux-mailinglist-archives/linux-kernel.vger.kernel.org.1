Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABB32C801A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 09:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgK3Igs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 03:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbgK3Igs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 03:36:48 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E70DC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 00:36:02 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id l23so3984pjg.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 00:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=E6KDQhU/zBnr5DKp/uo9Fp1w3M7TMAhCF7S8/nwJn60=;
        b=JPcBIhkNtqGJXqXaNsU+uajwIcfuKJVagu7XEbYyXuwerma5V5AwbB9v/2wjiZu8FN
         AVajotIvA+sGkMAE9iwSV4/Du7oLp93yH+9+xdRsYhKc4jzj34tBcjwIyqgc/3/2xXa7
         7DzlUrKdCTZ0bGyvR4BFSPOw/CFx0nd6v9rHi90AsY7aZ+NhofvCC7IlRAlE7FDujQ5r
         pRirguRMLgWepOmONcAgQYk5VvEh16MEcutaTr2cwYLwDPYbPzjvoIU8GPFKq8lMBSKg
         gWo4MZETah99yB1dLX1v+WBQC6HZRML6wuXD0GdKCiTrgUZCqtUQjXvy2w6O/ay4Lhzx
         +dMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=E6KDQhU/zBnr5DKp/uo9Fp1w3M7TMAhCF7S8/nwJn60=;
        b=BxyFuHP0OTmohXmruTaCxFYyAAitLc1gTjjdlLrNpU9zHNBiN1euBjm0J5SNiyUhCo
         EJV9x2Z8NmU3ijt6q3FDzem+LvuJm6lRbbBZxzrkL/te0NagNwjCducBOhxC50Wta4zj
         nuAkBtW6MdYGDS6wmEvhqNCdMR8cpq1x8INLv6A6QTGeKU/S/AruuHiVeJzzxnQHuLOC
         ucZBaOPxVZgMPdK8UyIZ0yICcuajasp0ITLoGzhHZwf7jvq0IbUF+obryLc3TJ2R/ivS
         k6ntZt6s9VO+KozWnqRSVhOESEzlVmDyVZfTo4mTriYEOwzcF9BIskx1CdAbcFOjKQbX
         40Ug==
X-Gm-Message-State: AOAM532GgQyrnxjfI2IbBKxr90Qe92z2riubRpSkGY4kVglMB/J8X1Ch
        GB/vRBeolNmhkDQrb7is1O8=
X-Google-Smtp-Source: ABdhPJxNmosQxaKOI4OlQed91O513K4sb8JCpFPbSGSCjUxBY2zNlUNI0Yb9ZhZtjldqsFZBmsrI7w==
X-Received: by 2002:a17:90a:67c8:: with SMTP id g8mr24397083pjm.114.1606725361880;
        Mon, 30 Nov 2020 00:36:01 -0800 (PST)
Received: from localhost.localdomain ([8.210.202.142])
        by smtp.gmail.com with ESMTPSA id gj24sm8896637pjb.6.2020.11.30.00.35.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2020 00:36:01 -0800 (PST)
From:   Yejune Deng <yejune.deng@gmail.com>
To:     paul@paul-moore.com, eparis@redhat.com
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        yejune.deng@gmail.com
Subject: [PATCH] audit: replace atomic_add_return()
Date:   Mon, 30 Nov 2020 16:35:45 +0800
Message-Id: <1606725345-7442-1-git-send-email-yejune.deng@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

atomic_inc_return() is a little neater

Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
---
 kernel/audit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index e22f22b..1ffc2e0 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1779,7 +1779,7 @@ unsigned int audit_serial(void)
 {
 	static atomic_t serial = ATOMIC_INIT(0);
 
-	return atomic_add_return(1, &serial);
+	return atomic_inc_return(&serial);
 }
 
 static inline void audit_get_stamp(struct audit_context *ctx,
-- 
1.9.1

