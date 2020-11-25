Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8442C44FF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 17:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731170AbgKYQZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 11:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730835AbgKYQZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:25:31 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1548C0613D4;
        Wed, 25 Nov 2020 08:25:30 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id a9so3975567lfh.2;
        Wed, 25 Nov 2020 08:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OzTWfOWBCqlCat4/nCyb0xyciAZ4J6U15v/8EY+RcY0=;
        b=mFSsVZfbx4WCsqwgF4fnF4uGqk0sZmO3iK5+y6aM/SC6WjJTiRjKGaI8bYqVUw6jMc
         YaCXuNNoVO/+NdFXUHLC1KokGK3e9Ipl+NvwXbkaNIGcKmJTWQe3qnd0F6ox4dgE+Xr1
         DjejSzCx02TPgfoTeKQRP/0VV5L3YO1xJFYgD4SWCRGqLRR1YwB2J42SHCea6NQtTkZf
         Qq0ak5qlfML9BpCa9TOXdZK2Y8geO/AMUQ3PcOyfCxsQ4KJz2/9b5p1JhaxDgi7We3C2
         8V8SkUy8RWcc6+3Fh9cRpzms0r5ThBAFSSohDfaY50a75WZDYVJYji5VYx5KAJXhaXlM
         oJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OzTWfOWBCqlCat4/nCyb0xyciAZ4J6U15v/8EY+RcY0=;
        b=HN1+VYJK1QMG8+kbKhpEI7UwWtzdFAGB3w7OaF0T77QXbrSI5SyDA10i285FNhOZ0y
         5izXfShpvwipVqJFD0FYz++QF/9xmn5vI4s5Ile7N5CS9MbBUXME6Mp3Hc+ruCp1gYSn
         0z5trIL5dLX4gKimI5U/y4d4eHe69+Uog6uXuw7eGWirFB8hfSDvemK3qQ32czZ8eqbi
         60NQzar3H/QwgHLrsxQO0uFRv15jsqTIqGqLytPK1AgtXpDnz+2kS8hpz1jVf/yuYCPR
         xkoxDXDGZl9ArcRjs3Jbe8xHnCkb3LqC5Zk5eNB5P8urRkQ0QE4gYA3Oep70od9pdK+x
         kDJw==
X-Gm-Message-State: AOAM532g8mrr+Pcr8TM90aQncIlM//pHOK2AZBByvXy/R3kKvPKL7FGk
        8Orcx7mDuDpk4ywyUECFUcs=
X-Google-Smtp-Source: ABdhPJxPDnnyHI5db/hy6PJ2Fq5m/OaExWjjzkJ/vyPq6xACkGSkYD2FXwlkbTzi79V3j+/KzOAVGQ==
X-Received: by 2002:a19:f60e:: with SMTP id x14mr1570779lfe.199.1606321529304;
        Wed, 25 Nov 2020 08:25:29 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-6.NA.cust.bahnhof.se. [158.174.22.6])
        by smtp.gmail.com with ESMTPSA id z131sm313881lfc.56.2020.11.25.08.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 08:25:28 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 2/3] usb: typec: Constify static attribute_group structs
Date:   Wed, 25 Nov 2020 17:24:59 +0100
Message-Id: <20201125162500.37228-3-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125162500.37228-1-rikard.falkeborn@gmail.com>
References: <20201125162500.37228-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are never modified, so make them const to allow the compiler to
put them in read-only memory. Done with the help of coccinelle.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/usb/typec/class.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index cb1362187a7c..9eaa5ba8d78b 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -384,7 +384,7 @@ static umode_t typec_altmode_attr_is_visible(struct kobject *kobj,
 	return attr->mode;
 }
 
-static struct attribute_group typec_altmode_group = {
+static const struct attribute_group typec_altmode_group = {
 	.is_visible = typec_altmode_attr_is_visible,
 	.attrs = typec_altmode_attrs,
 };
@@ -574,7 +574,7 @@ static umode_t typec_partner_attr_is_visible(struct kobject *kobj, struct attrib
 	return attr->mode;
 }
 
-static struct attribute_group typec_partner_group = {
+static const struct attribute_group typec_partner_group = {
 	.is_visible = typec_partner_attr_is_visible,
 	.attrs = typec_partner_attrs
 };
@@ -756,7 +756,7 @@ static umode_t typec_plug_attr_is_visible(struct kobject *kobj, struct attribute
 	return attr->mode;
 }
 
-static struct attribute_group typec_plug_group = {
+static const struct attribute_group typec_plug_group = {
 	.is_visible = typec_plug_attr_is_visible,
 	.attrs = typec_plug_attrs
 };
@@ -1446,7 +1446,7 @@ static umode_t typec_attr_is_visible(struct kobject *kobj,
 	return attr->mode;
 }
 
-static struct attribute_group typec_group = {
+static const struct attribute_group typec_group = {
 	.is_visible = typec_attr_is_visible,
 	.attrs = typec_attrs,
 };
-- 
2.29.2

