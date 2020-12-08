Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9AB32D337D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 21:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbgLHUT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbgLHUT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:19:58 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A1AC0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 12:19:18 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id z20so4948902qtq.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 12:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=152BxGF2Vf3o7ouLnSNnkB/czUx41j3NRQWNvs5OtJk=;
        b=G9oBrHcRh1mT7t67YPd6k3JYk+wl+OPm/+E7tUn8hwTmHD3ntCavAw1162Lb3a0fiO
         GckqZGHeaCtTlAbwF0Vkjr7d7lLKwTCFKIXXkIOaq2YZuFdsEA26c4geckClVC++36yH
         YE647Vv7Yyn0z0EAnOh8Ag3kpK85OJphMXbu6Q6ZTZqLSurVEIGZHuTXc5nMVMewE0Of
         7UArXNhpTnUCt0UPhCuyGb86uuD2kNo8jLVIeLJqvj+frtIyaaqMlQxDYPs5AHoswhgW
         M3ZjfwYOM1xuEcSXJzZoDyJqeldfb7Pxq1m6zKQBwiRYpCTJ8PMQprrfk5NH7R9IpMTy
         TYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=152BxGF2Vf3o7ouLnSNnkB/czUx41j3NRQWNvs5OtJk=;
        b=DqPhLX7pJG/HUpMqf1hvKurVsxmcLoLm2vFbGZiTB+VFUQYoiAR0+UJnYyih/GA/QL
         u61wnhRbtJrrBeg2hS3vMhrUlqSXX7sJaq+GHHJgPkWFOfvZvxhpDriO8VoPL87deu9W
         fFYMjHt+3MBrFEXvmYb0hL2lsRkJ2792N5szyG8DotXVG21XXZv4EebcOGSdTGdiGSSK
         Xn87x2T/+5OfhhBbu/Ae2PQIvQiZGpp8f24tTIC76Xef3pVZUbOb7V+O5CVFB6/x08QV
         XsV3qZPAN1wTAUkMFmYl6M6VTVfPeM+5rSSNb1nAI5cxgP8RGCw8Ja3GGhsqgVTH+nUs
         2B8g==
X-Gm-Message-State: AOAM532VZVqYmHWEb7WyPsmL2FXgESBhLZ9u2dlS7mg7Wxmbo/oh/bBU
        fy7oQnnbBT/EaMZsjH/NLWs7hC2RVDU=
X-Google-Smtp-Source: ABdhPJzuabtNUb4lJMygzpgxUHWosGtj/6u3mCMQlUsirxMgKnElMjVa+50EoV2oxQml9YDRALeiKA==
X-Received: by 2002:ae9:c01a:: with SMTP id u26mr10232124qkk.372.1607457152391;
        Tue, 08 Dec 2020 11:52:32 -0800 (PST)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id x24sm14169458qkx.23.2020.12.08.11.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 11:52:31 -0800 (PST)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, stable@kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] ALSA: hda/ca0132 - Change Input Source enum strings.
Date:   Tue,  8 Dec 2020 14:52:21 -0500
Message-Id: <20201208195223.424753-2-conmanx360@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201208195223.424753-1-conmanx360@gmail.com>
References: <20201208195223.424753-1-conmanx360@gmail.com>
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

