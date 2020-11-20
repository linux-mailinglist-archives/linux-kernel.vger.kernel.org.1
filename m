Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6DF62BA6B3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgKTJ4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgKTJ4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:56:12 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9A7C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 01:56:11 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id x13so2549112wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 01:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=65HrmNqKftUnE1asqIayt2cnQblLlYt2XJU4abNkW2c=;
        b=cIig+mZbWoziis9QAEDrcbFB/GOPYHBGkq8UJPfrMuHlRHA1uJlZUg8f7WhD8KenMR
         81/gLvFGeeEBXJjDhsMMENeHrnWQTkCblsMZLAlIKI8XYReN/YfTx4TFLK4x62j8vMcv
         NMAQZYA3LmtaSpp4bf8bDO41FIZ2kz913tElM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=65HrmNqKftUnE1asqIayt2cnQblLlYt2XJU4abNkW2c=;
        b=qJpaiYKVytUDrmBnla3mFCMkchcuTyLNgIEjY+l48qdKSV0CBtZVN4WiQduHT6IqF5
         jF0dE0MGd0oNJ4IhTNzktSW5owldGDSjFsze49e4/vh0CaOFDKsM4QnnB7Lpa0B8Hycc
         RvmEUTt25VLLAkdy/QOA9dC65SIv79hVYKFUaK36nTr3cVS4fFdFM3gURAffbBGx6Zy8
         ThwYHkmD1XUZxbAqF5Zt7JvQsdvdyZGocE+5a48PLwi+6+RHjJojrA8ErOGVWmJb9rS0
         mP/7hCBPHeh75V/O7Ld1PU9NfMXDqJ3R4aAL65A/e3AKJdkqAfMnDbCCkY60UHc7qbzg
         BjHQ==
X-Gm-Message-State: AOAM533GW7v4VCEs+MIeDVGIp+aaxH43GtOINLaLcfl/UdwqpWLeg8HR
        N8nbAzo2aaIInjcpZyBOZbLWew==
X-Google-Smtp-Source: ABdhPJyxRsNqKBpDLy2jcbxhd6SI4PAi8++rl2ervW+Oj/NwJ6Q8RtMk6ldX7hjCBVGGsevXbc8h9w==
X-Received: by 2002:a7b:c772:: with SMTP id x18mr9460582wmk.185.1605866170156;
        Fri, 20 Nov 2020 01:56:10 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t9sm4500208wrr.49.2020.11.20.01.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 01:56:09 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 0/3] mmu_notifier fs fs_reclaim lockdep annotations
Date:   Fri, 20 Nov 2020 10:54:41 +0100
Message-Id: <20201120095445.1195585-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've finally gotten around to polish of my lockdep anntotation patches
from a while ago:

https://lore.kernel.org/dri-devel/20200610194101.1668038-1-daniel.vetter@ffwll.ch/

That patch has been in -mm for a few days already, but it immediately hit
some issues with xfs.

Changes since v2:
- Now hopefully the bug that bombed xfs fixed.
- With unit-tests (that's the part I really wanted and never got to)
- might_alloc() helper thrown in for good.

The unit test stuff was the major drag until I figured out how to make
this very easy with the locking selftests.

Comments, review, testing all very much welcome.

Cheers, Daniel

Daniel Vetter (3):
  mm: Track mmu notifiers in fs_reclaim_acquire/release
  mm: Extract might_alloc() debug check
  locking/selftests: Add testcases for fs_reclaim

 include/linux/sched/mm.h | 16 ++++++++++++++
 lib/locking-selftest.c   | 47 ++++++++++++++++++++++++++++++++++++++++
 mm/mmu_notifier.c        |  7 ------
 mm/page_alloc.c          | 31 ++++++++++++++++----------
 mm/slab.h                |  5 +----
 mm/slob.c                |  6 ++---
 6 files changed, 86 insertions(+), 26 deletions(-)

-- 
2.29.2

