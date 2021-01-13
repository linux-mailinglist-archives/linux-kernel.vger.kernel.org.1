Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5202F4F71
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbhAMQER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbhAMQEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:04:16 -0500
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39938C061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:03:36 -0800 (PST)
Received: by mail-ed1-x54a.google.com with SMTP id m16so1067810edd.21
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=uxn0PEieT9aKbavqBd55kNusrAII89J23REmBtgP+I8=;
        b=rJYBEOIFbk5v9Kl0QmYxxdWTYr7aAZsMatQiuxI84XM7XerGTkNXTFzAHWiEb4YyjQ
         IXc7qrvAWEMQ7Vp8B9zI7AmrKyaEYxUUVG1i9c+xOiZ5u1IiIxvnMIXOWHnS7ilIsoU5
         F8ANa+Lwl9l1Tw/gWWHqHG+kTT1v0TY4ejfGxrc36IIKVdNULYbwFoo3lXmZuWmy9k5E
         TIFh1sql+gvgT1H3+E43ymWybRyX2lgwSZNfzZHa4u2uvhXK7NdhQqxHcdTuyXaVYF3m
         ZajP0Fggki9L7FbyC396SeSnzvSDBQUV5i732v9mStJqSmcutRIS269Kqs8zlYPfDPj3
         CuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=uxn0PEieT9aKbavqBd55kNusrAII89J23REmBtgP+I8=;
        b=Uu9R91mZKr0OJetR3BdlmkbZCnFwZA87Xp/BEEAJl5TU0iSqCqORpzt88ZLvGOx8X9
         rQwjFAbEcJaOcWtafJxggu1QvSw2iMgQcnyoXa4n+SCJ+R8Rk87fBYr+8TpNetlJ2Pio
         sWScnCTblu23ZsEkAwkBX6ixb1A2fIneOH0h2+R0cNuJFu3GVbBwS67k35cyQqdpkZ/l
         I/cUGl/Y+8xRgCwu6fBVnV6xDKio3IzPiOy4Nxa/7sIM6z7KBWEstmsNd6rEdMGOZs/s
         JpdAELRl8JzuYo7OScw8KM8/E/r81I/B00yIf47sKNr52j+bis/ku+BiakpewcQoU/cp
         n98g==
X-Gm-Message-State: AOAM533MHTOxJTiH96ooLPQ2QldxIBYRQko2fGHtoiIH4cdQiPoH/kaH
        PhcUt5vpbV9p+vIby2QBal5mYAewDCGLakro
X-Google-Smtp-Source: ABdhPJyklRiG7rIr5COisSyRFmcyHmLEu9FamX5mdcHo1+1RFUIKvUhTtVDwtKJ5HenCSMircmxRzM4ODB0iXfai
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a17:906:e94c:: with SMTP id
 jw12mr2149396ejb.56.1610553814149; Wed, 13 Jan 2021 08:03:34 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:03:28 +0100
Message-Id: <cover.1610553773.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 0/2] kasan: fixes for 5.11-rc
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
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

Andrey Konovalov (2):
  kasan, mm: fix conflicts with init_on_alloc/free
  kasan, arm64: fix pointer tags in KASAN reports

 arch/arm64/mm/fault.c | 2 ++
 mm/slub.c             | 7 ++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.30.0.284.gd98b1dd5eaa7-goog

