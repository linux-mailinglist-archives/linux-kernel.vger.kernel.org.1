Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486372D63C0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 18:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392797AbgLJRh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 12:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392867AbgLJRgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:36:51 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB805C0617A6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 09:36:07 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id z3so4257856qtw.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 09:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a32EDPT0HiSshwPUiInSLeo1VMTztMu1/h3zf9c4rCk=;
        b=vAgVp1+oGbgVti+8JZI818tBmYOr3pN2SjzOdz5eVqGJ9o01YtOg7qhTuozB9/AEhi
         NdhSEFfUtd1fLKGD+ciOmc9O0ucb2JjZSCSKUZ2j626atG313Mp70LXpfFLi5wqSj7Dr
         5YeqVTaW6mnQuBGqL7Fa6PjbSJlOimtoa1wrbVh9+JfC6AMl0daifmY8S8SaHDBX4/72
         ARraR4V9zmvGyA2IP9SKnwzg1rnv914IUaRtqwVmm7I3a6pjeu2FzTQBm1pQET+pOwcF
         zmLsgAch9fiA2l8yIVMkyiDzC7ikqufnmKXLQTy2gEKniJQAS6hwni5m+A1LXFMQ7slv
         Ak+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a32EDPT0HiSshwPUiInSLeo1VMTztMu1/h3zf9c4rCk=;
        b=LaB4jAAi5UD0Hk1KHYUBjijfzyZ4aQBp6vylaF+dSWIIjoDc+XdWtv4zumwWH2A48m
         OnUZum01amysAHcyCWsdP1fiaaVkGYXizvKfA90ell0SxzfJoQ8H8CHDYRy+6R17lMCR
         KPTLgTr2ZGOtoMI2wLKbI3zYr6fo0DftN9mJAE+mL7X/tRyvgf5s9r8pX2+eWYqnJgBH
         UG60CL+fGc3KDZW/RQ2UxOE8rJYceHU4/R8JJpzTy2Uc3a7xfqJr+u93oMHNCvKem+0C
         A4ESxPCeos28M5IvLY8J6gJ7VFsJaMkmLqX6DdlR5n44Ln84LgDbJwfcFH5i4rwan8Nx
         d0vA==
X-Gm-Message-State: AOAM531/YXrBuH0nYiM+OAVWwBEebz9Obh6pPBuIOfU85oS11j7zwGvh
        CCoJKNM/Wc7+piM/32WxjbM=
X-Google-Smtp-Source: ABdhPJzzbRklBMVNX3N8A5CZObPBV4DmOcB/faCnReSklfjwUlY7uGchAoZBlqC9OsIy76DOGhJ3fw==
X-Received: by 2002:aed:30d1:: with SMTP id 75mr10610494qtf.61.1607621767103;
        Thu, 10 Dec 2020 09:36:07 -0800 (PST)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id y22sm3886786qkj.129.2020.12.10.09.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 09:36:06 -0800 (PST)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, stable@kernel.org,
        Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] ALSA: hda/ca0132 - Change Input Source enum strings.
Date:   Thu, 10 Dec 2020 12:35:49 -0500
Message-Id: <20201210173550.2968-2-conmanx360@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201210173550.2968-1-conmanx360@gmail.com>
References: <20201210173550.2968-1-conmanx360@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the Input Source enumerated control's strings to make it play
nice with pulseaudio.

Fixes: 7cb9d94c05de9 ("ALSA: hda/ca0132: add alt_select_in/out for R3Di + SBZ")
Cc: <stable@kernel.org>
Signed-off-by: Connor McAdams <conmanx360@gmail.com>
Link: https://lore.kernel.org/r/20201208195223.424753-2-conmanx360@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_ca0132.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index e96db73c32f5..793dc5d501a5 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -95,7 +95,7 @@ enum {
 };
 
 /* Strings for Input Source Enum Control */
-static const char *const in_src_str[3] = {"Rear Mic", "Line", "Front Mic" };
+static const char *const in_src_str[3] = { "Microphone", "Line In", "Front Microphone" };
 #define IN_SRC_NUM_OF_INPUTS 3
 enum {
 	REAR_MIC,
-- 
2.25.1

