Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A30E23BA87
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 14:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgHDMlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 08:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgHDMle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 08:41:34 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF881C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 05:41:34 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v65so4880244ybv.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 05:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=EW4ws3cnCq+yc75UdLo6m+LVSSHzgz4WkI84lcOYn3g=;
        b=qRIWjL/aEST9Bgmmx1TReXVYXWMihOsuP+mAYj0qjuyBiTphgrU8vG2kDlWWLDxxZc
         Jg/LIbVqWQjdvN5QE8h4YxR5/B9yyZrsWE8c8qZW41jeLrHYTrlw9Cgi5XREl8IxDRfC
         co///64tOPGz+FN54l2XLrTcKdQjbLgUiQfL0z3QjR2C4z46DUpqY7w/AgukOpoxYc3p
         CD9+UVlpekMWPXavUVNf5FWgoZzMzg5BltVr5+w/viNnAaKQBsKSXLhBzBu/rH/ShMam
         93k5taOEn8vzxT+jZUIfKqfUVPR7WK1vFT7PcRQ0StCmtlNMT8Nh+075v3BYofndZUtW
         VoeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=EW4ws3cnCq+yc75UdLo6m+LVSSHzgz4WkI84lcOYn3g=;
        b=L3F+jw3AK83WjkOSQXEdRDzLmbNJ3ArcuCRh8t8qt1lGT6h0tNED0nEVV0jrEnNBNX
         hDAgkkcxyVw5KWRAYvI2wnljtBJJl3nxGCuUaDWBsUFUWBr8OWY0GkmEAG7u+pNJVwbL
         PbwkIJXuuIsFOVW0Tp+T3SY+7k7aYtUUYW8DWiMCZ4cIXA65Yugllem5a9uhIVoPscxo
         dROdLso8HxdMl17n+zl1s34uo507tauQem2aYaR2oKgW0mhSI7fLCZkxGCFP49QC1vUT
         ti+goAoxjCIlmErb/dZhbqRLXA7nPn2/KpS0vZNi1pPEm+DLf84UyXcICyeXDJUBwdEq
         YjJw==
X-Gm-Message-State: AOAM531gKWB9pfHuuJjwwuku+uQk7x+azkDrcolB+K92BEowH52VWzDi
        TF0gfAMhOD3gTnW9xVDkM9BTSEHrlTx/QqSi
X-Google-Smtp-Source: ABdhPJzh3yXfnlrh952yFi751mKOqrTYGBJNP8FaBO9bCdmzHWrwFtNMq9Jua++VtvKtWW7vV9nXY4rjJmmS8ewv
X-Received: by 2002:a25:cc07:: with SMTP id l7mr33304214ybf.440.1596544893505;
 Tue, 04 Aug 2020 05:41:33 -0700 (PDT)
Date:   Tue,  4 Aug 2020 14:41:23 +0200
Message-Id: <cover.1596544734.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v2 0/5] kasan: support stack instrumentation for tag-based mode
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Elena Petrova <lenaptr@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This goes on top of Walter's patch titled "kasan: fix KASAN unit tests
for tag-based KASAN" (already in mm tree).

Bugzilla link: https://bugzilla.kernel.org/show_bug.cgi?id=203497

Thanks to Walter Wu for debugging and testing.

Changes v1 -> v2:
- Add efi patch to undefined reference to `efi_enter_virtual_mode'.
- Reorder attributes for start_kernel().

Andrey Konovalov (5):
  kasan: don't tag stacks allocated with pagealloc
  efi: provide empty efi_enter_virtual_mode implementation
  kasan, arm64: don't instrument functions that enable kasan
  kasan: allow enabling stack tagging for tag-based mode
  kasan: adjust kasan_stack_oob for tag-based mode

 arch/arm64/kernel/setup.c | 2 +-
 include/linux/efi.h       | 4 ++++
 init/main.c               | 2 +-
 kernel/fork.c             | 3 ++-
 lib/test_kasan.c          | 2 +-
 scripts/Makefile.kasan    | 3 ++-
 6 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.28.0.163.g6104cc2f0b6-goog

