Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074DD2AE2B7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732284AbgKJWL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgKJWLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:11:16 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AEDC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:11:16 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id t19so8469037qta.21
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=aIsdSQcI18Vrv4rqf7/CpzDYxbaOkJ5FCCTIj5rnv9M=;
        b=khJY5VLWB0fCU7+xYzF689nk9gnx8c1dcXCuozAT1mvEnkaLI+Fldsteni9eWB1JDn
         /amaphj0aiEVuoMeFiiebqLAyjR8102vpI43ilHcevpMhhgIVnCDVb9/cPaw96R7izTP
         fXJ8V/oFrJ6AlQtolEdp4CgaYVoFzztf3GbEtGEhOnIHA3Wf3oDrLFrL2VK/8lJNQqyC
         obvsyYzK4Iz/6601Z+i6vx+heHgCvOBan8uDz/x/E+dVsvmxcuh0tK4A9kwIqRRgbdpH
         MGpHdXlkEMO0b6O2RT6Ty1L1WDdjgvSYPnTJeUCRox9BstR69TZuBjSQmdErT8KBTlpu
         om/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aIsdSQcI18Vrv4rqf7/CpzDYxbaOkJ5FCCTIj5rnv9M=;
        b=X4a94wE4cHn6hcdGBx49RKz2//WMEN1dFdBqEo9ZVnAD212Q9eFvESFB00WX1cncEe
         UTPFx83E/DUUc+awDLK8PyuYeRQP5kUu+F8zNrH8NqqkicFqJKzyPieFobTdACiwIqWQ
         cbCIIPSRyru9TdPrGXvEb8fRfL5BAURMmsBtK7YqBjVWpoP67gQa+55zL1BjRZDynUB5
         Uib5A/Tc1vnGCuczg2Rf7f4CEsnjDjjS7YNS+5wEuEUODcm1xWXuOGY3e4P7qD9tgNLk
         Nh7iErYkNvi6Q893x0LsHUFzB5p2cIe1UHfW8DJBdNSAICORBIah4Cq+muawY5wDSmD8
         GOIw==
X-Gm-Message-State: AOAM531pTY5saqHVcSiOHiyYTuABsVCBo8GCRvwcGgtlDJRf2svDWt1f
        331QZrUxQ44MlX86yulCZwEMabhxyxPGdMbi
X-Google-Smtp-Source: ABdhPJzf6oN2Ml2MGV6QLDeXEVna1RSQXrDV5yhz1oPfFI8sWO93N2Yes7I/xkgHbMgTCH/Rj+3pyxzRk/dyOIMz
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:5691:: with SMTP id
 bc17mr12182478qvb.30.1605046275279; Tue, 10 Nov 2020 14:11:15 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:10:01 +0100
In-Reply-To: <cover.1605046192.git.andreyknvl@google.com>
Message-Id: <34c72d612b6b06393ef455520c70f37c8b7a2c6f.1605046192.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v9 04/44] s390/kasan: include asm/page.h from asm/kasan.h
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asm/kasan.h relies on pgd_t and _REGION1_SHIFT definitions and therefore
requires asm/pgtable.h include. Include asm/pgtable.h from asm/kasan.h.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Acked-by: Vasily Gorbik <gor@linux.ibm.com>
---
Change-Id: I369a8f9beb442b9d05733892232345c3f4120e0a
---
 arch/s390/include/asm/kasan.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/include/asm/kasan.h b/arch/s390/include/asm/kasan.h
index e9bf486de136..4753ad0c3cba 100644
--- a/arch/s390/include/asm/kasan.h
+++ b/arch/s390/include/asm/kasan.h
@@ -2,6 +2,8 @@
 #ifndef __ASM_KASAN_H
 #define __ASM_KASAN_H
 
+#include <asm/pgtable.h>
+
 #ifdef CONFIG_KASAN
 
 #define KASAN_SHADOW_SCALE_SHIFT 3
-- 
2.29.2.222.g5d2a92d10f8-goog

