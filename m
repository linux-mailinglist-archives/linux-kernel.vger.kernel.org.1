Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D482C57BE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 16:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391286AbgKZPBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 10:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390811AbgKZPBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 10:01:45 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98BBC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 07:01:44 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id e8so1871802pfh.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 07:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YBBDP4mSopcfuTFCAYlEnNAgNCuA2bebai0CbzK0+1Y=;
        b=BX0/A0I2f/dIMqnY7ZHR9Z2d4t0/iZyOoKFEuYzsqxyi2F8a9XNJLQsGh3Zca2/dlW
         0ESZmeNu18zuPjd+NTg+rmmzuxUdX6f623qdKfP6LXp9goz95BcTSCAsS1pLRRUi3FHm
         5sAJ1nMRkjjtoAHJ5FfwKiie1NZPtWqjrLUobqrdJALCPAS7LTUqflJwNzrKTIaAazFw
         ml6DKM8XglRJ/2vivvA1pYLa3xAunvZO1CQZNUHOikwl8ZL6q+pfUmCF22lOAwMd6c5z
         0NmhM/9MVfXcw7iqvExaztMh6mSJh8J4/GNwi/eRioDWDQCO0xjrbzYdJCMl+HyxAJv4
         GDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YBBDP4mSopcfuTFCAYlEnNAgNCuA2bebai0CbzK0+1Y=;
        b=lCdDgch6kqo/8cZAUwRLehjUHxE/KN48N7jhyNrDLF6P/d9bw4RVPcYWlf3J8llxMR
         HDVwnNQFxGVhQGZyWYyDWiV0HyPU9D50Q6oyE6GZuXuUqngj+oP8Fs94fj6YlST+wIBh
         tJi8SQNpxI9hWB+Xuo6htlxDumF2T36yLO9Hi/+z+sLxZW4NjM7uz79Gz06tiyJjyxJI
         coouXyMiOaEjA6Z9ISM+MRHKqMifmB92LC+1CSbZXeuGJbw4Qs/7cVJvcPmIv29UkPKp
         t8RWnMd/nPfoxaWWqjfzNxx+iJWMwwRy4kkD0Jf0wOhgF0k0YEdJ9ENPuNKbTyXWlhiv
         oDng==
X-Gm-Message-State: AOAM532s/mniLsKEuNSHIMyA+TvZ0YGqvFU8/v4hD/Az12DEk0DXNr7A
        Aw9TEUJ++buNFlPfMJeGRNu9kt2ShpE=
X-Google-Smtp-Source: ABdhPJzo+zCK/GbEbDxwMt3RRNEGmRW8O0bixkn825znAlxY23Szhi1U1HrVgfzqDtC4Byu+Car1Ag==
X-Received: by 2002:a17:90a:940e:: with SMTP id r14mr4242967pjo.47.1606402904501;
        Thu, 26 Nov 2020 07:01:44 -0800 (PST)
Received: from localhost ([221.153.153.187])
        by smtp.gmail.com with ESMTPSA id c6sm4891444pgl.38.2020.11.26.07.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 07:01:43 -0800 (PST)
From:   Chanho Park <parkch98@gmail.com>
X-Google-Original-From: Chanho Park <chanho61.park@samsung.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH] drivers core: export symbols for device hotplug
Date:   Fri, 27 Nov 2020 00:01:38 +0900
Message-Id: <20201126150138.159896-1-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support module build for cpu hotplug driver on type-1 hypervisor
such as drivers/xen/cpu_hotplug.c, we need to export below four symbols.

lock_device_hotplug / unlock_device_hotplug
device_online / device_offline

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 drivers/base/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index d661ada1518f..1bfd0c54a778 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1586,11 +1586,13 @@ void lock_device_hotplug(void)
 {
 	mutex_lock(&device_hotplug_lock);
 }
+EXPORT_SYMBOL_GPL(lock_device_hotplug);
 
 void unlock_device_hotplug(void)
 {
 	mutex_unlock(&device_hotplug_lock);
 }
+EXPORT_SYMBOL_GPL(unlock_device_hotplug);
 
 int lock_device_hotplug_sysfs(void)
 {
@@ -3419,6 +3421,7 @@ int device_offline(struct device *dev)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(device_offline);
 
 /**
  * device_online - Put the device back online after successful device_offline().
@@ -3450,6 +3453,7 @@ int device_online(struct device *dev)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(device_online);
 
 struct root_device {
 	struct device dev;
-- 
2.23.0

