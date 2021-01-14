Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59D42F6B0D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbhANTeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbhANTeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:34:46 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93C1C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:34:05 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id l10so2638101wry.16
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=To/bHcfhJEpjAdXg3S5DdT78e7w3setGkq3dXznXdGw=;
        b=MaPtjIwr9pHtewP0VgREk/e5O5T4iO0FLEU7+VDCi01yoZUROq41Oe4e0nLuytduou
         EZCyicYct5846oA4xDJIAp64/JMZ5O/VV1PXAcNa5b6t4XsR8UfK8Dm/e466rypWF2mA
         rzED7uUadSlJRoaDGrTgYromffPWqufc2D0Z/I+PdezS3TVkan9eW1MKe3/5Hw7rQW/I
         yipc/cQk2jnsFUJKg2bkiZzMs2RPDQnZvwon2sKUl0JspODE7GgGXvy0ls4eVrf8kSe9
         u4QxjUFeED2/VLKFfijwvpeeG/cBBCX0Y1tzRV6r3yHSYIw6+FKIE1lf2RZpZcO8Bjkd
         wBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=To/bHcfhJEpjAdXg3S5DdT78e7w3setGkq3dXznXdGw=;
        b=bVufZLgvdEjtMaQdJeAWi20vWzsmObTTYUgj8Ii21tkavh2kaZ819DrqzjN7vD0FAN
         G8ia5ArnFqwaufHp/tTrHeL1d7y7qzqNPnIAd+BYYmSFD1WjonLrJ7WZ209joOBoGsuP
         HAbrZTSao2b/e1i3hmJ0CsKVmVNNBaOC1Is9BiLVcwXGGY0h0cjiRAGTIneBagJu5XOy
         IyAoqF0q4nPO79rYWGlxChfiS7GWdFhbaAi5Mc4KXOcggHQgMj0hJnjC//7Or4xBOmN4
         HUUZ/YuLIK74r8/Jo1yQ6+uhWV4JYvLdg4RvTubGKrR8R94exLz7eG5HWP8G1/VCWNi8
         LyKg==
X-Gm-Message-State: AOAM533w1GU5tpjqeNI3Vmv4GzdmFfuJSTTO+4acTng9r8eFqVBV91wW
        GOLEX0+rIV7iI2BWO+PV+1qZWxPGZ1W7Rdt7
X-Google-Smtp-Source: ABdhPJz5/MoxTunXI8Gzed2In595sf6AKJ0RCTzBsYN1cKdVIsB5XlI12Mq8gExcdFOj6qm1qz2KVum7d865PFfm
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a7b:cd91:: with SMTP id
 y17mr5139113wmj.171.1610652844285; Thu, 14 Jan 2021 11:34:04 -0800 (PST)
Date:   Thu, 14 Jan 2021 20:33:55 +0100
Message-Id: <cover.1610652791.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v2 0/2] kasan: fixes for 5.11-rc
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes v1->v2:
- Update changelog of patch #1.

Andrey Konovalov (2):
  kasan, mm: fix conflicts with init_on_alloc/free
  kasan, arm64: fix pointer tags in KASAN reports

 arch/arm64/mm/fault.c | 2 ++
 mm/slub.c             | 7 ++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.30.0.284.gd98b1dd5eaa7-goog

