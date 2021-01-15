Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408022F82BC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732145AbhAORm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbhAORm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:42:58 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DD6C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:41:59 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id p21so8720170qke.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=s2BQxqmasNBEOjHNthhB8zI5jOrrfc4sePLKP1wu5tY=;
        b=fZny2t5N5k2rVmRtz+2cM40lh5NtS4CthMQnGgxlsTvvCudLGe6L4nLEpgdgaYEfHd
         9EaEIRyl3mlS6b0npXQRJBENcATpIXMpN6kHiAPxYYsraPeVgMky9/baI44ihToWGaqG
         c/CmKZWH1Ml2ZgX6geD9ZDOeDxUPRYhjW7ksZ8MUIWqhaYu5nbe+LST92ne5tUTvM3bN
         YuAO0y8KxjLwcNIf3am4GKBp9nyd9Zt/DbIDGTERuHJJ1y2hIyL+xSJMm1Iatt+KTmSd
         tqyZTygEw/zID1PNJtbDIRt1nFlESBw6X+WYHkopk/Nge2q2fTUea8bRLwBDX+bos0+I
         3zxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=s2BQxqmasNBEOjHNthhB8zI5jOrrfc4sePLKP1wu5tY=;
        b=S38cVLoRvgfljH54Gjf43bj1RHXW7i7ddnaXMuAnMtWw1Ijk4KjXZL5xB3nfYDopEU
         8gPOz9jC6ZWpRtv2C2mQpgJKHgcIXVukWYOccaP9e3RcYuJUcG16OnaFQwS+e0s8/Vtc
         Z5d/nFh96DubZ4PYmNBcKWl9uW36JLSMpHGN1mrGyJDU+rdbQOH101jqgitHAv0honSp
         yXWnwwx3OhcYXkXBTTSLr7o0snmtuoXQJgXZbuD0/3tTQAnPshvWZQDKT6/hI4SVtN63
         iXLBH1QBCNu8YcCvqEQaSKfLYzs4qeC0+tiEnKfFuNjycd4qEvR0idoHoeld8Tbiz1pn
         0JLQ==
X-Gm-Message-State: AOAM532Hi2NmMfNUp9DNnmVa1DGm7B0zfQhtZOwmremLa6gpETaQrUtW
        W6UMaXyt03G+ppI/t8BGljVSy2V0f3qsH7/w
X-Google-Smtp-Source: ABdhPJzV7xSbpv84UN+gBbM1cqSXTMQHs+zlvx0YMHiTc9V08UJOR68VhyQrAk3eYPmRjP0g2BtSXoaNGMLWxIdX
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:434e:: with SMTP id
 q14mr13123760qvs.15.1610732518339; Fri, 15 Jan 2021 09:41:58 -0800 (PST)
Date:   Fri, 15 Jan 2021 18:41:51 +0100
Message-Id: <cover.1610731872.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v3 0/2] kasan: fixes for 5.11-rc
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

Changes v2->v3:
- Fix up kernel pointer tag in do_tag_check_fault() instead of
  report_tag_fault().

Andrey Konovalov (2):
  kasan, mm: fix conflicts with init_on_alloc/free
  kasan, arm64: fix pointer tags in KASAN reports

 arch/arm64/mm/fault.c | 7 ++++---
 mm/slub.c             | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

-- 
2.30.0.284.gd98b1dd5eaa7-goog

