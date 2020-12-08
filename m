Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285072D2587
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 09:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgLHIPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 03:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbgLHIPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 03:15:20 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC38C061749
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 00:14:39 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id e2so3168726pgi.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 00:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=doyuajGDAoaPFhb2ThVHLJXkkRiThGYIceTU9U28wvo=;
        b=XplbGEVMkw49ATGj0X5s2zGBOZ4Law2VvqzRfG2IzcCND6tnlpL9MisVk3WH/AJO2F
         +dXdWMjXhEysVTatNrp1YDGXNy1m7qxvUj7p3Uuv95atsnPQy6d3216A4mntr1eLyVPm
         hsaaXSHez8W8K3wtQZ/kWxOX0PlwhaaaciQpQHNJIWKEACUuziWdd/KrHQyn6YhRiU3c
         n/5mqBUaZ/EfzKKxKQf2mpXbvbpx825jQd3fogEMiR6/ibmZU4oQqVDvg9F8vlczmaFQ
         L7jipQneYO134IPROf3y6TTjvdba0harss/GQKgo+N5aZ/DilyRZGvr90ZsMduGBEuDM
         Qh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=doyuajGDAoaPFhb2ThVHLJXkkRiThGYIceTU9U28wvo=;
        b=pX7lSzCeeHZRwrRY97iIYfZKKFqTsT3wqvUsOPJ8GBZHT15T5nuiMAtDxVELX2t2pL
         j2rGrP8q5hazLA7ritc0MnnkWGGS8IFKpvTx/Ir4m9oxVjVtbh+vzd74oGipZ+r2yqEy
         rPSreeGRGzHXesp0mjVYdvQi4Gph0sBguxNvNS0WHQrsQ0OPB4CBFeU/0WwPIxFaxOK3
         HTBYspzJvuny4f8j0Ur/AKH/Z2M3BtU3Ud+CCoQFWkBg9wIRvJGzLT7ZSHFDZ89PamnT
         rDWjZuIAh7PRnT3dwBg7HmPLRVGlArq2uQeRp3nYO4VG/S+5F+dyhgsHmaYWQb0s8KIB
         V0Pg==
X-Gm-Message-State: AOAM533ntjT6yArRzwhaMli+7b8cqjupS9bAyY8BQY9BKRGU3q1Idnlm
        AxOXOh+ARUz42aosHdCsNvE=
X-Google-Smtp-Source: ABdhPJw0w/qfucPI9qD2kNAbfwIDKVlACeVmCEPvGem828ZlHRxCWhDk4BOJH4lJJFMyFymrQywmzg==
X-Received: by 2002:a63:da03:: with SMTP id c3mr21821637pgh.133.1607415279406;
        Tue, 08 Dec 2020 00:14:39 -0800 (PST)
Received: from robinhsu-p520.ntc.corp.google.com ([2401:fa00:fc:202:1ea0:b8ff:fe77:fe45])
        by smtp.gmail.com with ESMTPSA id 19sm2665387pfu.85.2020.12.08.00.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 00:14:38 -0800 (PST)
From:   Robin Hsu <robinh3123@gmail.com>
To:     linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
        chao@kernel.org
Cc:     linux-kernel@vger.kernel.org, Robin Hsu <robinhsu@google.com>
Subject: [PATCH v3 0/3] f2fs-tools: sload compression support
Date:   Tue,  8 Dec 2020 16:13:41 +0800
Message-Id: <20201208081344.652430-1-robinh3123@gmail.com>
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

