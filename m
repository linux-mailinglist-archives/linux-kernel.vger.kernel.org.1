Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824602CB1EE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 01:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbgLBA6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 19:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgLBA6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 19:58:34 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D85DC0613D4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 16:57:54 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id e23so2312086pgk.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 16:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GphdbdQu3Kcknrat5HROBpVaQjVumjoHB33e1WX0twk=;
        b=Qc51ZzY2fYZ0pmDf1xci/XKQNJX430V8oMhsEEKZdqboYbIxQbh1OYoojtIdWK7h/y
         s7ufRNCdvgtr3PtQjX69l636MmwVOEjh8vz81imyZeufNJa6JpPuX3QuYjOusPmnM4/4
         V7i50NrZl/4AqswMbNBMgS+bkN2VgF4RW1CEj5SxYDfNlGAGv1DiYPobGWb2fqvuAsAb
         joVFcypy6BAON+PUuu3oDIJ9eRF29b0iTXe1r02UFXyc4LeS3K942EBQsIjoeNLRmsE9
         dBRb0oJ/dt+vwGXbt3LjVW69Rl79mjG+kesNYGWGQeOi67aWcFGcpbQH0IFut9F0FdqK
         FFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GphdbdQu3Kcknrat5HROBpVaQjVumjoHB33e1WX0twk=;
        b=TDrOkdi+FMhevCkzGJ86DmgXlKkYWVMOtACVXQj5a3Q9d70A/xz5XN16lNpDv/u95H
         Eq1bfvuiFACLkH03mPhQsNDyQcyjyM6Se1nJJgik7r8zyNZBwW2hwFLnF5ZHOeDUq7hW
         10VYVkTl3CFH9ACMhDRvS9M2QLymTP5V0MYeSOOzdYjGv+jpChKL7w1D0NwJKyPqGei8
         8HKhDdgI9g901x12fcydtGHgkkjMfl+/Y0eAiUXdX+0rtJbr4ZT13cASM0Lyv0Z/8dHT
         z584YUrd/tTizT4f/ymhnpXRdPRu0xma6Jz3D61MeW1G6z4mMZBi6J/cIh1/FWebGwo/
         k+oQ==
X-Gm-Message-State: AOAM533C5eKHhCIZ3+GTetNVh7z1Kn7h3NZGg9yjz1HGB8cfggdJ4Zjj
        Nfrv4phgCdiJepojlhzcsCI=
X-Google-Smtp-Source: ABdhPJwVlO1P3SS8ahJQ1ifd3CV1j+lkNFBxXbaPu0Ti/oSFT8y59weZMiEPjR+mdtGD7sWyx0gsFw==
X-Received: by 2002:a63:3305:: with SMTP id z5mr243875pgz.321.1606870673810;
        Tue, 01 Dec 2020 16:57:53 -0800 (PST)
Received: from robinhsu-p520.ntc.corp.google.com ([2401:fa00:fc:202:1ea0:b8ff:fe77:fe45])
        by smtp.gmail.com with ESMTPSA id gz2sm116974pjb.2.2020.12.01.16.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 16:57:53 -0800 (PST)
From:   Robin Hsu <robinh3123@gmail.com>
To:     linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
        chao@kernel.org
Cc:     linux-kernel@vger.kernel.org, Robin Hsu <robinhsu@google.com>
Subject: [PATCH 0/3] f2fs-tools: sload.f2fs to support compression
Date:   Wed,  2 Dec 2020 08:57:21 +0800
Message-Id: <20201202005724.691458-1-robinh3123@gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Hsu <robinhsu@google.com>

* 3 patch set:
  #1: added some #ifdef for easier support
  #2: main code change
  #3: automake changes

Robin Hsu (3):
  f2fs-tools: Added #ifdef WITH_func
  f2fs-tools:sload.f2fs compression support
  f2fs-tools:sload.f2fs compress: Fixed automake

 configure.ac            |  32 +++++++
 fsck/Makefile.am        |   9 +-
 fsck/compress_wrapper.c | 102 ++++++++++++++++++++
 fsck/compress_wrapper.h |  22 +++++
 fsck/fsck.h             |  15 +++
 fsck/main.c             | 154 +++++++++++++++++++++++++++++-
 fsck/segment.c          | 202 +++++++++++++++++++++++++++++++++++++---
 fsck/sload.c            |  67 +++++++++++++
 include/f2fs_fs.h       |  76 ++++++++++++++-
 lib/libf2fs_io.c        |  33 +++++++
 10 files changed, 695 insertions(+), 17 deletions(-)
 create mode 100644 fsck/compress_wrapper.c
 create mode 100644 fsck/compress_wrapper.h

-- 
2.29.2.454.gaff20da3a2-goog

