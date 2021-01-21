Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4612FF116
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 17:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388224AbhAUQxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 11:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729690AbhAUQwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 11:52:47 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477DCC061786
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 08:52:07 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id b5so2056580pjl.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 08:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fAAepta+Tqry3dwEzmnD+L2F5Kc/TshmNl4dFx/u10Q=;
        b=R3fyu0fHBeYFl8+KllQfgKo0GAS/EQ3LTyUPJWmtJgJW/t2r2NA/soXcdnOc8pwjm/
         YV/nH3KzMnuXXy+Td3v5rqnS6jAeHQrnhXtOhTAQv63hH6VwAzzkOfuOwc80HNS7nZXA
         iwUKhfx4UYhsomTYcEZTkNhKDlu7ooAKDts+YM5YmpOwzG6J8t0dB8YD8RYL8OTuJSj1
         32qJDCp60EUdnqxMsXAh5HADvCNHU86tiFMiKeMQ/HeGGwcm21NAi9E62FeYUtQyIXku
         xQEeiIB/L1QvWJJztzz969TQrziOFBR+ZwuU3EUSLovuW4F5EwGX6lm8HQpnlQwwQh+J
         cd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fAAepta+Tqry3dwEzmnD+L2F5Kc/TshmNl4dFx/u10Q=;
        b=FNkpIQS9bn/y6s5lbF53i+dwjiMpQgsqLjsAlyM+q1cLy6tm70ARtpy/LH7T71If0r
         jywD9SbgH3V/V8oXJX3yRFUsNCONXvtlhwWm/+/Ouz0PDFOzNE4GKWhd1+lK0gHYllvO
         0dwxkItaNrmuc5wr9bU/kxCMeCnQkWbdmfqTWdL8T3DlWjgjlMFHhFlh6S6zTi7Xpeu3
         c9y3nQkw73ntf07r96x1stSDDie5TyUqq5uxvUHk6szzVBmueHKPnWYm3issfqydCCMA
         hTMq2xNUrccjD32iJXrytO1LR5QoaK69SZjo4PjMcWsN09W7o+OnD7NXuBGZDto6NfsO
         QU+g==
X-Gm-Message-State: AOAM533kbSTZf9HofhWIXygEAS8mFSU9bgO9JngL87F9wLJ/z9q1w7/+
        FIX6XDeGYxZytpcNaeM3iX+ZHsvDXuV3jIUU
X-Google-Smtp-Source: ABdhPJxvXPxDfEVdok2+F/Npp9UDEVvDC8WJg+QQg60J6Q9IZeX4O9BqYh34M6w1BtwugxcCclTKQg==
X-Received: by 2002:a17:90a:4a0e:: with SMTP id e14mr317436pjh.200.1611247926455;
        Thu, 21 Jan 2021 08:52:06 -0800 (PST)
Received: from localhost.localdomain ([2405:201:5c0b:3035:cd47:c5b3:4276:dc05])
        by smtp.gmail.com with ESMTPSA id m27sm5924291pgn.62.2021.01.21.08.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 08:52:05 -0800 (PST)
From:   Prathu Baronia <prathubaronia2011@gmail.com>
X-Google-Original-From: Prathu Baronia <prathu.baronia@oneplus.com>
To:     linux-kernel@vger.kernel.org
Cc:     chintan.pandya@oneplus.com,
        Prathu Baronia <prathu.baronia@oneplus.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "glider@google.com" <glider@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/1] mm: Optimizing hugepage zeroing in arm64
Date:   Thu, 21 Jan 2021 22:21:50 +0530
Message-Id: <20210121165153.17828-1-prathu.baronia@oneplus.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This patch removes the unnecessary kmap calls in the hugepage zeroing path and
improves the timing by 62%.

I had proposed a similar change in Apr-May'20 timeframe in memory.c where I
proposed to clear out a hugepage by directly calling a memset over the whole
hugepage but got the opposition that the change was not architecturally neutral.

Upon revisiting this now I see significant improvement by removing around 2k
barrier calls from the zeroing path. So hereby I propose an arm64 specific
definition of clear_user_highpage().

Prathu Baronia (1):
  mm: Optimizing hugepage zeroing in arm64

 arch/arm64/include/asm/page.h | 3 +++
 arch/arm64/mm/copypage.c      | 8 ++++++++
 2 files changed, 11 insertions(+)

-- 
2.17.1

