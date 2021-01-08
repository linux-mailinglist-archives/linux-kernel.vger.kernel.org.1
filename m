Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32EA92EFB95
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 00:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbhAHXKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 18:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbhAHXKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 18:10:15 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CD7C061574;
        Fri,  8 Jan 2021 15:09:34 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id m12so26792273lfo.7;
        Fri, 08 Jan 2021 15:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QxReFlRL658xHbvF0w+cE6+pBgV0FdWMdR2zg93M1ho=;
        b=KFVj7EsONPRX+yGIGJEUXCf3seHQC1ULt3DEDoRhBXrEIkKUECrTPT69UjjwrpS4cv
         4GD0cqlHvWb9YxQ923LrYbrJfRwQDuhaBfRnyAyKpyy5KKTdVpOAD8QOB8ToKg3s1YIP
         ldP56SJzJpxIy1q3ngaXS6Ffdp23MOBjGlWXV+NMjcehm7HybKBb8QV/0i8zqx6wjF9J
         6dWKAq8K7C3vm/0DWEsXF7rMIy9kX3ecEZlZ516K0TFka7CJjn5NhaLVkYdoxzyF0/qo
         pQ0JZRePMaoxazT1mUOkSYCRdltpw0mGNaxwzcvU6EksyzDK3bhfOIBahTZKGy8CBLCt
         xhqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QxReFlRL658xHbvF0w+cE6+pBgV0FdWMdR2zg93M1ho=;
        b=DhNhUZOvNi1bn7lxuVVMvW22HVS98KWnVBPMLXFk8kiboIkDhdci01QGOzWItj5pI3
         7dHi0+rpMdolZLJ/m8/0AQAb1G0T1XkhlTQ7piSrpbhgdVZ8ZueUlrbIfjQuwKIwb+At
         GnvJSPHoS825srw8mwExHqJxAX+xet+ShdWTE4krEPdEC2zK0G9Wb2n6sh3NuVJrDP2M
         /HjrsCriM6ttBlqfPVauYA92e/bWu52Utpl6dDpoHM4H2+wp2x/tyO0yr3FXqB0PW47w
         zO+YE8eJN5Q8J6JXzew1at4Z8GCzUfRQ9xHtvyGcFPpA6fXT2VbxaN9qC7yanCLU9+fo
         20Kg==
X-Gm-Message-State: AOAM532oW1Zwp/AeL0HXA1xif1xjT+a6iDCBC7Rhe7wSg6x+OTMbVRZL
        eeA+9ADlu+IYCS15JcaBe84=
X-Google-Smtp-Source: ABdhPJyo0u75Qam4b0FEJ3p7PCVVqvhna9BNUi2RGv29+MVF36Zq+whghy7BdnIrmEkhHVsfUpFoOA==
X-Received: by 2002:a05:6512:788:: with SMTP id x8mr2778551lfr.250.1610147372821;
        Fri, 08 Jan 2021 15:09:32 -0800 (PST)
Received: from localhost.localdomain (h-98-128-228-148.NA.cust.bahnhof.se. [98.128.228.148])
        by smtp.gmail.com with ESMTPSA id w16sm2186264lfn.227.2021.01.08.15.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 15:09:31 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] thunderbolt: Constify static attribute_group structs
Date:   Sat,  9 Jan 2021 00:09:19 +0100
Message-Id: <20210108230918.32302-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of these is to put their addresses in arrays of pointers
to const attribute_groups. Make them const to allow the compiler to put
them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/thunderbolt/domain.c  | 2 +-
 drivers/thunderbolt/switch.c  | 2 +-
 drivers/thunderbolt/xdomain.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
index f0de94f7acbf..d2b92a8be577 100644
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -289,7 +289,7 @@ static umode_t domain_attr_is_visible(struct kobject *kobj,
 	return attr->mode;
 }
 
-static struct attribute_group domain_attr_group = {
+static const struct attribute_group domain_attr_group = {
 	.is_visible = domain_attr_is_visible,
 	.attrs = domain_attrs,
 };
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index a8572f49d3ad..602e1835bf61 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1771,7 +1771,7 @@ static umode_t switch_attr_is_visible(struct kobject *kobj,
 	return sw->safe_mode ? 0 : attr->mode;
 }
 
-static struct attribute_group switch_group = {
+static const struct attribute_group switch_group = {
 	.is_visible = switch_attr_is_visible,
 	.attrs = switch_attrs,
 };
diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index 9b3a299a1202..f2d4db1cd84d 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -756,7 +756,7 @@ static struct attribute *tb_service_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group tb_service_attr_group = {
+static const struct attribute_group tb_service_attr_group = {
 	.attrs = tb_service_attrs,
 };
 
@@ -1239,7 +1239,7 @@ static struct attribute *xdomain_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group xdomain_attr_group = {
+static const struct attribute_group xdomain_attr_group = {
 	.attrs = xdomain_attrs,
 };
 
-- 
2.30.0

