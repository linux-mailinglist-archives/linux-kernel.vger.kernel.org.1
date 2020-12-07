Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6CA2D0BF4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 09:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgLGIrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 03:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgLGIrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 03:47:06 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24DAC0613D1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 00:46:25 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id w79so809922qkb.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 00:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XTZhOtD/mfgDmjZI7TlxngV+W/PI5tFf+zUtfTsDwaM=;
        b=TCw4ggubn4E4b34Ozz6AnkYFmgCYW/YdHwm3dkrajSvDu9iF3IwTehK+PVHS/LpGuX
         Uld2WgLFfOLxiQPlmD01/GSOOAUSCggiYyFNwHzRm35H/VlVtskfrhTl6rH2fZvRbLBs
         q2WRkTieE2XegDMdyaF+lMA7jW6X21mJ0XjFRQnK8HLjdarmhnbUekzM9DsTkgiiNLVb
         L/ipv+krnBy95KsKZalE6N0TAKgKL1ZIn3wF7FZ+TTnA+H2MeGLjel1+bdqoeYucdkg6
         tBNdF5MhPiBHj8vIXnaKu29HC7MyGWDP/Yf5WKhFLB6XI+IwTPEXx1OLVvSsHgEv1ftw
         w/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XTZhOtD/mfgDmjZI7TlxngV+W/PI5tFf+zUtfTsDwaM=;
        b=SjSabMzwImuSnd0Uz+oHzsmGCM1lNtm+pZn+Q/ZEnlKG8Jp0ROp44KN7iLbA6HFzTY
         Uh25BTTHCehOtc9PW4/FYizTNqSR+GHStVV0Yq3PtdHpSAw6urFDVC99+dKp77TLKrwE
         XqilYAwTUVuv0vXNcvhBjZn88l5KBTDX6etCYhUs4t2aoCigpojCFT/WHLH0zXJXi4rw
         xyuC1Eb64Hys7Ozutj6XQMZ1aU3ReNXlI7DwDjHxagBXFPcA8CToD1r8DVHo5cQdQ9a3
         a6b9rPMt+xt73W+cL7mB717zSPYOUmF+tj93Z8CyPb8ZoiBeoJ7glnmzJ4QGxWhFr1g1
         RDig==
X-Gm-Message-State: AOAM533EazbTMh96pphPPZEN7s+QcOwNpTdtQR2iG3qd4cE5LYTZI3FX
        J1eVg9kFXjPoIgjsSmu7D58=
X-Google-Smtp-Source: ABdhPJx7aT2XclbJxVMOWrrjzYdD/nc59udTfgiLAzURpOBFj9255P82D7H3hG/Rdwhc2x3wm8J3gQ==
X-Received: by 2002:a37:6403:: with SMTP id y3mr23201617qkb.204.1607330785078;
        Mon, 07 Dec 2020 00:46:25 -0800 (PST)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id a9sm3424681qkk.39.2020.12.07.00.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 00:46:24 -0800 (PST)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ALSA: hda/ca0132 - Change Input Source enum strings.
Date:   Mon,  7 Dec 2020 03:46:14 -0500
Message-Id: <20201207084616.411531-2-conmanx360@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201207084616.411531-1-conmanx360@gmail.com>
References: <20201207084616.411531-1-conmanx360@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the Input Source enumerated control's strings to make it play
nice with pulseaudio.

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

