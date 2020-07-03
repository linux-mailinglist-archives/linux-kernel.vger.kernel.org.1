Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C07F213EE2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 19:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgGCRnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 13:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgGCRms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:42:48 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D044C08C5DF
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 10:42:48 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z13so33572379wrw.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 10:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xdK7p0WR4ZFrApshqcY/qhz6yObzd2ZId4hOv0Jm2xo=;
        b=gbM9zgU/ZtQMixrhY58EOrWoPPgzazeywce2gbfK5P1I84SGNf8Nu0SBKX+d68YMTv
         wi9405Ct0dsRs4puQmviTl91AT3FHELIv4KYmc6/uBxqOQVfGxIchVRWLT39VOsnD9dj
         iv/XQSGzxJTBXmvi/aCCRJxLysPARMi+m7S1+S4XfBcQY0JvZF9xAToZCKGTRJqm2fGc
         /jgKshjliUS0c9vtSW24xzpTKdikiD/Lc+TKcOQDdjiHZuChpAD3COK7Fa4YNd3QmsYd
         vagHiB2r6sq6uBbnY/IDijHrZIvE1qwTXYPWChLKhJcBZgnvvXhQjBI6w6xZqGm3Eip7
         DRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xdK7p0WR4ZFrApshqcY/qhz6yObzd2ZId4hOv0Jm2xo=;
        b=UnED1Ag8fWuByONzz5Eh/ENWbo9s71o0JGS1UbXlzbd8rmb8xx/7nNm7/kZ+voehAp
         TQ/e0bL7mczbag5Jp7OTtTOsk606a1A1KsUtR5F0twlBwjt3vPixxsmG0UV5+antgnOR
         fiVPEiUHIOksphNTGaP8PWKsA/ru7EGwePmrKa8aZYgqSzE5JKzJ5Yp671T97yXEEB6E
         64AWEy+8f8/p9N/0HmXxAJhg8JDQ/zVEvmbGuhpOsTLRGVKff2hf20jOFy/4DFiS7iS3
         IjeiQs5PF2nmaCjrdNVo8xZ+LKhPUFHlggt0VCrGWLT50BaGbmVWvS7T4xzdMUbQqm/g
         HRlw==
X-Gm-Message-State: AOAM530NMev+uQRyozV9wDlCdRJN0JuAorAnKWmHkFW2wmovcBxTIvDu
        Ir9US84dumAe2C2lijavBEVC2A==
X-Google-Smtp-Source: ABdhPJwaEUB7JhVt7ciPlaLA41ZcKUyXrM0MReikrMV76Gdvn4PvB0S1CBTLkWBqgXpEpkcO7tMK4g==
X-Received: by 2002:a5d:54c9:: with SMTP id x9mr40004482wrv.247.1593798167196;
        Fri, 03 Jul 2020 10:42:47 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id x11sm13625799wmc.26.2020.07.03.10.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 10:42:46 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 20/30] usb: typec: altmodes: displayport: File headers are not good candidates for kerneldoc
Date:   Fri,  3 Jul 2020 18:41:38 +0100
Message-Id: <20200703174148.2749969-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703174148.2749969-1-lee.jones@linaro.org>
References: <20200703174148.2749969-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Demote displayport's file header to a standard comment block.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/typec/altmodes/displayport.c:18: warning: Function parameter or member '_dp' not described in 'DP_HEADER'
 drivers/usb/typec/altmodes/displayport.c:18: warning: Function parameter or member 'cmd' not described in 'DP_HEADER'

Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/typec/altmodes/displayport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index 0edfb89e04a86..d617663b981dd 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * USB Typec-C DisplayPort Alternate Mode driver
  *
  * Copyright (C) 2018 Intel Corporation
-- 
2.25.1

