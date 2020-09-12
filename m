Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69303267A39
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 14:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbgILMOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 08:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgILMOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 08:14:01 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA55C061573;
        Sat, 12 Sep 2020 05:14:00 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id p9so16969932ejf.6;
        Sat, 12 Sep 2020 05:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gEpdRqAvRKHN0Q4Rm3fCmgidSOyPeuBoBtSoBHiF1iM=;
        b=TKCneEZYS78YeCzkuObuNRlmqDwnQ5CAdjUjwQPmNPFFqN4sw1USBAFbuh4yfzTAXI
         d89QuRbQfprknG7kM693aUeZgoiVLBvGWLfDdPF+Jsg6qwR/qd7ry1Nh1unyvpBBslFv
         JLp+V4AvrsYElb4iLFN0Et6lsoTOXOqY9SenmNn8Lg4zipZ23EjTClY1EevDaQwK5QDq
         WRV0OUCKca9r7m03MNC2wPYhEv2q9JbZZFUk8laj5MBrimncEdqibw4OKTWc4e7gU273
         8ntc/UJD3QfzODiPkOtNwMkWyw2mDaDTviYsMrXu1KNwhdgLMQc15C6CIAB+IZch9tCm
         NTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gEpdRqAvRKHN0Q4Rm3fCmgidSOyPeuBoBtSoBHiF1iM=;
        b=Jim0HxzSyNUlrKzvaoQwIxtEnBqekwShysI10O9SltuKJbVlHEPOYz8cQWK+LBN6FN
         OsB9uPeaU2Y4Vv9u0ZDVFPiV3aZtKL5zXg6q2sT7dZBt3v6QHVzE5e2ThX4Ifezw8H49
         KSLZHEChUkJoWiS37vGEkNp+xc+jDmFBJFb0xRlrw/4I7KbLcqg+XqMtuVzJIyJF9v7q
         a2F+1D+Z+T4gZGOeyy9Z1tDXlXUzBMGsS2sI0n5GPDMxScweE31IuNs6bI0YVq+2Osyq
         yHWKulDYgLa0mpygOateRgIM2Mq9rCzwlfhu51e17fxsTi3wbA7cFsCTjJllIhRcbNQ2
         4ruA==
X-Gm-Message-State: AOAM530M0QkCDNgAApAK5WE5ZOO/fASMJnHsJm6m9oXEZPbi1m4YkHZT
        DuWstOk4jpRhEq5jzCsSWno=
X-Google-Smtp-Source: ABdhPJz0i2HLJ4Q4WLY7Fe3aVzacLAzPDRqohJ5LhoMI3ZKwHaH9Q6bmI2jsZKWienwLlFq266hoeA==
X-Received: by 2002:a17:906:e0c7:: with SMTP id gl7mr5771634ejb.109.1599912839273;
        Sat, 12 Sep 2020 05:13:59 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2dd9:a000:782a:45ff:c1e1:cfe9])
        by smtp.gmail.com with ESMTPSA id t14sm4606365edc.7.2020.09.12.05.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 05:13:58 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: make linux-usb list remarks consistent
Date:   Sat, 12 Sep 2020 14:13:46 +0200
Message-Id: <20200912121346.2796-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f24f27b85ead ("MAINTAINERS: add entry for mediatek usb3 DRD IP
driver") claims linux-usb@vger.kernel.org is moderated for
non-subscribers, but all other 46 entries for linux-usb@vger.kernel.org
do not mention that.

Adjust this entry to be consistent with all others.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on current master and next-20200911

Greg, please pick this minor non-urgent clean-up patch for your -next tree.

This patch submission will also show me if linux-usb is moderated or not.
I have not subscribed to linux-usb and if it shows up quickly in the
archive, the list is probably not moderated, and hence, validating the
patch.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 26af84f97353..4396a8986518 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11112,7 +11112,7 @@ F:	net/dsa/tag_mtk.c
 
 MEDIATEK USB3 DRD IP DRIVER
 M:	Chunfeng Yun <chunfeng.yun@mediatek.com>
-L:	linux-usb@vger.kernel.org (moderated for non-subscribers)
+L:	linux-usb@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-- 
2.17.1

