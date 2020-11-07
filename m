Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662E02AA69B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 17:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgKGQNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 11:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbgKGQNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 11:13:37 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082D4C0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Nov 2020 08:13:37 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id b12so2410756plr.4
        for <linux-kernel@vger.kernel.org>; Sat, 07 Nov 2020 08:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=P5jbgj6ga3DTAIYJLP70354dsAkH43LDVwNjCSc3Lu8=;
        b=JVzsJXqnRxVNXvlRmJMFPFOahQlHR9Afqzwd04hKgojEWJKuB/n5dsHk1UEFWKgw+A
         1cMq+UmuQG8L1UnMR5Ca1nQE2WrbFNV0ktIpKjRy/sX+iMIK5bct30X0xU5mwIvTAjBf
         ODs8HE3iHHGqcDqudeBT40ITTnu59wtKgS766jR1c/WWsRn5eLaz9Xb0+KiCbub+OWHm
         MCD5qKz/smkYJctz7zvPJtbqJ3jDeeN9Qt05JRHXeXpN09qsmZFQ34JRg+73CpmO1tvd
         +H0yS7/AaD2uEqyuTXecxpgsUSoAFmz0vsseQ0ztbHREOWuBUzFbxR9wn/FKeKGlfbCj
         I1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P5jbgj6ga3DTAIYJLP70354dsAkH43LDVwNjCSc3Lu8=;
        b=Viw0DNVJT5Z5W4lYf6qsjCpLITKWigNsUm85D3hS4FSWgdPWq7DOGTXcdH4EVWcire
         /YHWLGoY+H/z2DyJ1264vFinvbyKL1so/dYfv614aRvNcfIecL8H14WNWMUsquIHW01G
         1tKSS9JfontiT8n5o8YQLpCWqdXe6TTtzPtVHiFA3dguudAhFsH+jvzioUWkavBlUmut
         9Nze/N1Z3nGZ2yjCPKww5K2pF3csTzIlf1L42Ouz/7j02Zgt4aJALY8gWUfOq8W+kIBW
         LVDEMn/QXuvGJ/+eaaxSNHP5Xbrzh/QnNpthRN5k5DOvDFbwKN+eWOqrrf+wxyNTrbwa
         Amvw==
X-Gm-Message-State: AOAM530L+YpkoqEbmlB9VLQGMiiu496FDhm9Bu292/nMOvi/GPkJyaEW
        /UYYztDrRMG1CK9/rOqlOA==
X-Google-Smtp-Source: ABdhPJzo8ABN6u+mCozytwwHLIrUDVpJSNi7I1by0dKWmCdbnYZnYUpcGIzn9/b4+GA5dQotttfeUQ==
X-Received: by 2002:a17:902:8504:b029:d6:7552:19ab with SMTP id bj4-20020a1709028504b02900d6755219abmr6032101plb.83.1604765616580;
        Sat, 07 Nov 2020 08:13:36 -0800 (PST)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com. [67.216.221.250])
        by smtp.gmail.com with ESMTPSA id l62sm5623296pga.63.2020.11.07.08.13.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Nov 2020 08:13:35 -0800 (PST)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] ALSA: firewire: fix comparison to bool warning
Date:   Sun,  8 Nov 2020 00:13:31 +0800
Message-Id: <1604765611-8209-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

Fix the following coccicheck warning:

./sound/firewire/amdtp-stream.h:273:6-19: WARNING: Comparison to bool

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 sound/firewire/amdtp-stream.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index 2ceb57d1d58e..a3daa1f2c1c4 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -270,7 +270,7 @@ static inline bool amdtp_stream_wait_callback(struct amdtp_stream *s,
 					      unsigned int timeout)
 {
 	return wait_event_timeout(s->callback_wait,
-				  s->callbacked == true,
+				  s->callbacked,
 				  msecs_to_jiffies(timeout)) > 0;
 }
 
-- 
2.20.0

