Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A6B2B45A4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbgKPOPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728667AbgKPOPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:15:49 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB16C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 06:15:47 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id u2so8449687pls.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 06:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Sy8R4ugPJG9tnE1Ku7jK0RtMl7j/7GMhh3QOorrX1DU=;
        b=wegQFmXuNrMEY2H31jDHGwmTITMb/rVWDzjgAiHWbqZfvbBaYb/bkzHaLQNF7gODxd
         aOB4xLJedTP7hMNgTGyEfLXqtfL/OyeT17bXzrAkpaUIpyyN19Bj9GWsXvlGJaHLvPfn
         LkLudCoHtqeeGKNThs/7IsadY5XxsM8TPAl74xH8GhGpMY1BcZ1G155ydu6uwoml13+V
         q1PvZLvYMwjCD35GS0vVCj9G8ECLO0YkUzg4p2vokAvmXBeV1GYR8ElP24X8s1t1v3bZ
         MUgh3J+Q2gJpETO3H9MdswujNfY+gKHEz7wdcOh/T2kEOt+LPc8ZtXFnF+kl87kq35Pp
         6b3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Sy8R4ugPJG9tnE1Ku7jK0RtMl7j/7GMhh3QOorrX1DU=;
        b=QsvfVqyVp6EBpkkQXFgU+Ro7z3Q4beDa56sqTqsDl0jj7kQSv9PN2RcXV6yimDYTkA
         1vUEFq+XLozRh5rG0xX2P/8FEqKFNmkom/E1dN1PIH3eILWMnP37NmA7SbGlmOIxRSdo
         wTObKYt3puzhvDGRTAsXfZs7vhOwE32lOj5dPUWf/sL+OvVgPjn7sE4Lwp62pW2DOzQx
         hjLWSOE/rFm1tyxCdsSDKCPFnSnYYn3T+JNIbm2yh5idOBAMzRp6A7I1hlTMZkdMa1k8
         M5ET7AnaWgNAvEsTvqCAKIq/tLM7DdCIMW19VY6H8Z/q156WqQDwS82M3rW18tfsCouK
         qfVA==
X-Gm-Message-State: AOAM532kpUxdzeE2Gxudy9AtE0OAo23XrYtsWWzpCUjDgd2ePKKBx0r/
        z2HL//q0BEhO6fpYbYsdnC4bej3zi0v+LPko
X-Google-Smtp-Source: ABdhPJwgKWJJ+Jv+fL88npV+R+72mjcJU1uMkNeTS8AZBCVZN8iNLEDg6+DEYrj0Uz8nhdW7ypG2mQ==
X-Received: by 2002:a17:902:c281:b029:d7:ce5d:6406 with SMTP id i1-20020a170902c281b02900d7ce5d6406mr13122742pld.35.1605536146406;
        Mon, 16 Nov 2020 06:15:46 -0800 (PST)
Received: from localhost.localdomain ([163.172.76.58])
        by smtp.googlemail.com with ESMTPSA id z16sm18641260pfq.179.2020.11.16.06.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 06:15:45 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2] x86/defconfigs: enable HDA realtek codec
Date:   Mon, 16 Nov 2020 14:15:30 +0000
Message-Id: <20201116141530.18321-1-clabbe@baylibre.com>
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
Change since v1:
- Do the same change on i386, to keep them sync.

 arch/x86/configs/i386_defconfig   | 1 +
 arch/x86/configs/x86_64_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index 78210793d357..070615a63308 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -196,6 +196,7 @@ CONFIG_SND_HRTIMER=y
 CONFIG_SND_SEQUENCER=y
 CONFIG_SND_SEQ_DUMMY=y
 CONFIG_SND_HDA_INTEL=y
+CONFIG_SND_HDA_CODEC_REALTEK=y
 CONFIG_SND_HDA_HWDEP=y
 CONFIG_HIDRAW=y
 CONFIG_HID_GYRATION=y
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

