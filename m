Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848852BC58D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 13:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgKVMKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 07:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbgKVMKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 07:10:22 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECC5C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 04:10:21 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id r17so15713427wrw.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 04:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ij+FO1Ox8gSWzzdMZavhh7O5RzliqX3lYoAw54WTq7w=;
        b=RFRD+zSIatVqWJ20XFneBM86YH0I4/3d0+Y0BRdUpT669H0mSy11frrGIWBsTC3n0x
         Hb13mWPFgGrBE78RgWl/i3OShjePYolcxQsBJO0STCnpdvZ2qRuhWP8oZhI2AFB8icXY
         LkVDc+86s3zSJ9PtvbM4FNMAT9sKDczKBnGt1fAoo//tj2PCShqMUdshZrRnl5m0a4uO
         h0boxG4XDd3UURUtvcrQcOSlCnzcBTOIFcpefExG6XnfkV3QpVTGP0Q+IJc8cKbT+uGE
         ceZDNlCiYd67UYpi8BVi0qd5z/uExPyqKIGE3x02S+QBycgcNviJkV54O53nn/Mt17Mo
         jsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ij+FO1Ox8gSWzzdMZavhh7O5RzliqX3lYoAw54WTq7w=;
        b=EI6kQQR2QhsVELRDlip2bWEqhvRWdMl+y3PG/wK/axSCzHZ8JBNqKl9rzGz25fz0Yr
         Hk1qA4yk2zHilQlszMnffYm/3aNNpTqSNxWiL1hAiG65S4I1ZHjde7t8y04nGkWmS++X
         x6EKQX1K5e5dMl2RreBgF1UhoY6GlBK6wO7j1dG5Q/hKDi6XOr1VVDnu0BvR84hnZyhv
         Khxw3/cIl82BO6X3JQBWpqKwP4QIjdXNEjMWqIWrX91UJ+pIlrSwMkj5UHHcXiVHB08/
         5WDQ9pM6oSZPrcqd5w8U+yE2Zu9yAYBqWbEGJIQT6Bq9AE1EYv8g7p6ZVCn7+ds1HNv+
         S2fg==
X-Gm-Message-State: AOAM531No9+N/z4PJoug4pxedmd0HC6lWTkPiMGf+wzglpPqI5Mey50I
        Yos6TO+8spx8Ggs9H8c2ymB49zAuUg==
X-Google-Smtp-Source: ABdhPJyw7soCzyO6x37pKfSBpZMC0Z0AE0cHGZdUDAakwNEMaTEcwRTkxbvkcGIumkA+QQUd8AB3Mg==
X-Received: by 2002:adf:f304:: with SMTP id i4mr25395465wro.268.1606047020467;
        Sun, 22 Nov 2020 04:10:20 -0800 (PST)
Received: from localhost.localdomain ([46.53.251.228])
        by smtp.gmail.com with ESMTPSA id t15sm10477982wmn.19.2020.11.22.04.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 04:10:19 -0800 (PST)
Date:   Sun, 22 Nov 2020 15:10:18 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] driver core: cleanup kstrto*() usage
Message-ID: <20201122121018.GA48617@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kstrto*() functions can write result directly to target memory
if no additional checks needs to be done.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/base/core.c |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1701,12 +1701,10 @@ ssize_t device_store_ulong(struct device *dev,
 {
 	struct dev_ext_attribute *ea = to_ext_attr(attr);
 	int ret;
-	unsigned long new;
 
-	ret = kstrtoul(buf, 0, &new);
+	ret = kstrtoul(buf, 0, (unsigned long *)ea->var);
 	if (ret)
 		return ret;
-	*(unsigned long *)(ea->var) = new;
 	/* Always return full write size even if we didn't consume all */
 	return size;
 }
@@ -1726,16 +1724,12 @@ ssize_t device_store_int(struct device *dev,
 			 const char *buf, size_t size)
 {
 	struct dev_ext_attribute *ea = to_ext_attr(attr);
+	int val;
 	int ret;
-	long new;
 
-	ret = kstrtol(buf, 0, &new);
+	ret = kstrtoint(buf, 0, (int *)ea->var);
 	if (ret)
 		return ret;
-
-	if (new > INT_MAX || new < INT_MIN)
-		return -EINVAL;
-	*(int *)(ea->var) = new;
 	/* Always return full write size even if we didn't consume all */
 	return size;
 }
