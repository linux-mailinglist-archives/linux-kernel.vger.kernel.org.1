Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6077B2D2593
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 09:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgLHIRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 03:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbgLHIRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 03:17:03 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C657C061749
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 00:16:23 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id n7so11518845pgg.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 00:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=doyuajGDAoaPFhb2ThVHLJXkkRiThGYIceTU9U28wvo=;
        b=UwaqcnxsgNg+Eah831M9BmQwB2ktvoblX8ZrsYSTufXDsaw+bp9+Ph2idzejBljmEQ
         KootQ475aqQ/p6z1VvMdVDlqxDNJZk2DiwM4mkuVnbdvY1NAUCFIS7CbTCzdjlhy8N+/
         QML0C1kk8pIoBFI3mcZS8j2acu5RrmCKgR6UlUPNvZdeNdHQQ2+mjpMy6xjO5cewvu0r
         ez2g4+utTrMhUJRFSaVfCLnQyLAQoLoyE8NcfW24WTAl7Ryr/8Lw3XzlSsN5Lcu/GLHo
         zfMFbokaBzuklRj/Ih9/HBsDmzqljDJtiODCCkpDbsiEioNRFqLXDajLE70iqSuYJcY2
         ddWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=doyuajGDAoaPFhb2ThVHLJXkkRiThGYIceTU9U28wvo=;
        b=f+4LVo0j7+Fs1r6gSUDKRf/Lr7YIt5D+5rjePF4Fjlk768nqaHxIc6aIIOghlOwzVe
         sdPLVVWupoyTnNhOHfndYChcQFL8hzBBCI2zqKHtX+Qnd+HuoYn8tUHrPtkjFwlLhqql
         rAmIL34DdZtG95WYavSM+o5yAISALDKSwvtx4Iawg++hzTsZZ0agu35GoeNWUqBMEcEI
         B6tb9hv8rcXmKMj2XZUE9xDEU9nSsPboKOe1fIH7CIfaXebY+1T4F3igGbs4R69qKBQY
         8tddWgxOdQCdpRP0FmD+MUXbRLQRDrZCoos3bidNGyBaVGD3oHN/VJRNLNiMFukJ46Gi
         uNnw==
X-Gm-Message-State: AOAM533KYNvhajzw3oZfPLEBqg9n3nz1Is9sBzfZWSnO4zfEYiQOwbjZ
        OTjRI0s/GgveyAxpAIHLtSo=
X-Google-Smtp-Source: ABdhPJxT0hm+M6B2y31Of0DZaD5YuGsxFjOHmE2hsFsLjElQxEWKGfzPJKNSyCybXynA9FG9qbKYFQ==
X-Received: by 2002:a17:90b:e0d:: with SMTP id ge13mr3120963pjb.111.1607415383065;
        Tue, 08 Dec 2020 00:16:23 -0800 (PST)
Received: from robinhsu-p520.ntc.corp.google.com ([2401:fa00:fc:202:1ea0:b8ff:fe77:fe45])
        by smtp.gmail.com with ESMTPSA id d4sm2093574pjz.28.2020.12.08.00.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 00:16:22 -0800 (PST)
From:   Robin Hsu <robinh3123@gmail.com>
To:     linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
        chao@kernel.org
Cc:     linux-kernel@vger.kernel.org, Robin Hsu <robinhsu@google.com>
Subject: [PATCH v3 0/3] f2fs-tools: sload compression support
Date:   Tue,  8 Dec 2020 16:15:52 +0800
Message-Id: <20201208081555.652932-1-robinh3123@gmail.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
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

v2 fix (from v1): fixed a bug and a more elegant error handling flow.
v3 fix (from v2): ./configure (automake) automatically determine to
compile in lzo and/or lz4 compression support depending on the presence
of liblzo2-dev and/or liblz4-dev

Robin Hsu (3):
  f2fs-tools: Added #ifdef WITH_func
  f2fs-tools:sload.f2fs compression support
  f2fs-tools:sload.f2fs compress: Fixed automake

 configure.ac            |  12 +++
 fsck/Makefile.am        |   9 +-
 fsck/compress_wrapper.c | 102 ++++++++++++++++++++
 fsck/compress_wrapper.h |  22 +++++
 fsck/fsck.h             |  15 +++
 fsck/main.c             | 157 ++++++++++++++++++++++++++++++-
 fsck/segment.c          | 202 +++++++++++++++++++++++++++++++++++++---
 fsck/sload.c            |  67 +++++++++++++
 include/f2fs_fs.h       |  76 ++++++++++++++-
 lib/libf2fs_io.c        |  33 +++++++
 10 files changed, 678 insertions(+), 17 deletions(-)
 create mode 100644 fsck/compress_wrapper.c
 create mode 100644 fsck/compress_wrapper.h

-- 
2.29.2.576.ga3fc446d84-goog

