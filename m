Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B5B2B37BE
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 19:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbgKOSW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 13:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgKOSWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 13:22:55 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115EAC0613D1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 10:22:54 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 23so16298633wrc.8
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 10:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=ZIe36ROzo6+salMbb1n1Mr2cByL0OaDO1PyAW3FVZ48=;
        b=XKpzS6rn2YmUgN309ZWl+FK4EbC9twEmQeYVFLfqMdUZcC9TBmtFODe2/V5BygOOFG
         gQHLZoVqrIbyJfDwEp43/dz0bw9xra8nszz1IXFpRxguW1InYRh0EDTGjmuEI5ATHXdY
         62elg+AeBzhUGxctiRIaVXXAWc2L7ufZBIHtjTfmR3lF7Y9XSWGjCUThMs5pjJlu4RK/
         YV/FPejCUtc/Fde+iQklv1OG64kzSA7EkIQse7fAcXgxLZId9BPVTDuUxr5NwPzchZD3
         taYf3UGiApqMPRdXWifZwxXuG0gPrwfp/NId4FMwB1uA0NZHYDWO/3RR+CsTppCvJV4U
         /Ctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZIe36ROzo6+salMbb1n1Mr2cByL0OaDO1PyAW3FVZ48=;
        b=B3lgYWR9f/3d4sgZKmBS4ZgFDshcoDn5min+n30Wj87oGkgUON3VjZS0lDs94wuFA7
         JHztEG+SUd60qlLy1uqFQda0XpY9/ToddD8TqkNmtc5TORT4UDR12kb9qy2QNgWl82u0
         8zE72NQ1I945T3cXUVQx2UZfAksk8oM66Rs7wRa6QT1oexW9pYATumrQBovz1FWngAoz
         tWycR2Zs+/wfB8DoaVlddIdaS4uqnHZa91ZLsNUEwXf58oOYLN+2Mlpl4StplGRF12Uu
         HwVHNubZ3ZiROeqSl7GejD72ZO8LcKD97nkyIorCK+kyNQj+J4+4QcwgWrQMqrmWJKjq
         JKWA==
X-Gm-Message-State: AOAM532U9eg2fHmytdXxt8FGFiFT0ZlQph9L8dVZ+zeQcvoYDL026AWD
        fse2yOyA6jXicnWQ9b59Bh7AEkZHjL6/bg==
X-Google-Smtp-Source: ABdhPJzKqGpBK6NfBHb5qOvv7E8voFNFNTn7iZGYaH6PJvRgdEthKJLKeXg3l+TblsaiNLvhh5nwzg==
X-Received: by 2002:adf:f9c5:: with SMTP id w5mr14634256wrr.69.1605464572821;
        Sun, 15 Nov 2020 10:22:52 -0800 (PST)
Received: from localhost.localdomain ([163.172.76.58])
        by smtp.googlemail.com with ESMTPSA id f17sm16793269wmh.10.2020.11.15.10.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 10:22:52 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] x86/defconfigs: enable HDA realtek codec
Date:   Sun, 15 Nov 2020 18:22:46 +0000
Message-Id: <20201115182246.9208-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have lot of board booting with "hdaudio hdaudioC0D2: Unable to bind the codec".
This is, for all of them, due to missing the HDA realtek codec.

In fact CONFIG_SND_HDA_CODEC_REALTEK was already enabled via commit 5cb04df8d3f0 ("x86: defconfig updates")
but removed later via commit 8b1bb90701f9 ("defconfig reduction")

Anyway, one of those system is part of kernelCI and having
CONFIG_SND_HDA_CODEC_REALTEK back will permit more testing.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/x86/configs/x86_64_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index 9936528e1939..830e4af263a2 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -190,6 +190,7 @@ CONFIG_SND_HRTIMER=y
 CONFIG_SND_SEQUENCER=y
 CONFIG_SND_SEQ_DUMMY=y
 CONFIG_SND_HDA_INTEL=y
+CONFIG_SND_HDA_CODEC_REALTEK=y
 CONFIG_SND_HDA_HWDEP=y
 CONFIG_HIDRAW=y
 CONFIG_HID_GYRATION=y
-- 
2.26.2

