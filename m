Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A233008FF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 17:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbhAVQsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 11:48:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31547 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729043AbhAVQmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:42:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611333678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QfffZkp6kc5D3emC3HTSADDepn8w8bDy1JhvkJWFPDM=;
        b=PLQtcs9A4z3i6Z2Ah7OVSVqxsfGPdtRbN6alaU2dO+MADzRiBLQxguENODyatSn+8yiP2O
        yj4bp3zKMYW3Nnq+EKtgLcCElbpkdwxDFi06OERpOYviRY14agh5KLl0b2TWLM5JrwLdHW
        9ZEpscdm5R1l0nYD0uRRnT1BMitpIxw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-esD3n6ljMXqwPlKyMw2jyg-1; Fri, 22 Jan 2021 11:41:16 -0500
X-MC-Unique: esD3n6ljMXqwPlKyMw2jyg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E528800D55;
        Fri, 22 Jan 2021 16:41:14 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-174.ams2.redhat.com [10.36.112.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ECC656EF46;
        Fri, 22 Jan 2021 16:41:11 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH v3 01/13] mfd: arizona: Drop arizona-extcon cells
Date:   Fri, 22 Jan 2021 17:40:55 +0100
Message-Id: <20210122164107.361939-2-hdegoede@redhat.com>
In-Reply-To: <20210122164107.361939-1-hdegoede@redhat.com>
References: <20210122164107.361939-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arizona jack-dection handling is being reworked so that the
codec-child-device drivers directly handle jack-detect themselves,
so it is no longer necessary to instantiate "arizona-extcon"
child-devices.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mfd/arizona-core.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index 75f1bc671d59..ce6fe6de34f8 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -881,11 +881,6 @@ static const char * const wm5102_supplies[] = {
 static const struct mfd_cell wm5102_devs[] = {
 	{ .name = "arizona-micsupp" },
 	{ .name = "arizona-gpio" },
-	{
-		.name = "arizona-extcon",
-		.parent_supplies = wm5102_supplies,
-		.num_parent_supplies = 1, /* We only need MICVDD */
-	},
 	{ .name = "arizona-haptics" },
 	{ .name = "arizona-pwm" },
 	{
@@ -898,11 +893,6 @@ static const struct mfd_cell wm5102_devs[] = {
 static const struct mfd_cell wm5110_devs[] = {
 	{ .name = "arizona-micsupp" },
 	{ .name = "arizona-gpio" },
-	{
-		.name = "arizona-extcon",
-		.parent_supplies = wm5102_supplies,
-		.num_parent_supplies = 1, /* We only need MICVDD */
-	},
 	{ .name = "arizona-haptics" },
 	{ .name = "arizona-pwm" },
 	{
@@ -939,11 +929,6 @@ static const char * const wm8997_supplies[] = {
 static const struct mfd_cell wm8997_devs[] = {
 	{ .name = "arizona-micsupp" },
 	{ .name = "arizona-gpio" },
-	{
-		.name = "arizona-extcon",
-		.parent_supplies = wm8997_supplies,
-		.num_parent_supplies = 1, /* We only need MICVDD */
-	},
 	{ .name = "arizona-haptics" },
 	{ .name = "arizona-pwm" },
 	{
@@ -956,11 +941,6 @@ static const struct mfd_cell wm8997_devs[] = {
 static const struct mfd_cell wm8998_devs[] = {
 	{ .name = "arizona-micsupp" },
 	{ .name = "arizona-gpio" },
-	{
-		.name = "arizona-extcon",
-		.parent_supplies = wm5102_supplies,
-		.num_parent_supplies = 1, /* We only need MICVDD */
-	},
 	{ .name = "arizona-haptics" },
 	{ .name = "arizona-pwm" },
 	{
-- 
2.28.0

