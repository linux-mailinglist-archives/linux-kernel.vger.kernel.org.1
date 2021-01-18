Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02D12F9C7D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 11:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388934AbhARJe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 04:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388681AbhARJWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 04:22:52 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CF3C0613C1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 01:22:12 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id k126so16544702qkf.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 01:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=exfgNhM4N6uxD6xPVxC+GkQm5KFoVDD34vOu2HQsR3U=;
        b=ePa1WRaCHti215OfsTBoRnjp4MNG6hanio44aTAdKSk7OEAeDYW5/CKBE91Wpfm4uF
         JPjSsc8RKA/agGfzfj/fG4LSrFfXTB0qYOJ+I6dnQIS1xC1ZKo0wIREzG27iu4Aao5JN
         lCw7K2vIXOpyZMneU/1cCghX6s4Hm6qiRrwFMlQKQTGfhhizvNmhGEAivNiePPYmxFZC
         RfL8cOqWYkMsyvcF/RmmBZ9vFbgRmJCEtqxMPLCdMBppJkIpG0zHhsvJCGMNL5kKXcmi
         la3nxydC/oLo5cf3APb/ZEpxDFLqVil3fhbQY+uE7sYOOTKsFgkNOgD8RhKtCaBsokxD
         /lLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=exfgNhM4N6uxD6xPVxC+GkQm5KFoVDD34vOu2HQsR3U=;
        b=Dw44lW9Q2O2qdmiG5DY9420n/7M8B9waDoeeGLf28n2On4H/th+lQAwhHtQFBfwvDn
         77qikQXJUbZUy1Kh21UlC73NIY3CiEhNykFFG8CgT2jI/QQjSU+3JJ03/lHk7iMF3dGs
         riapo2ea3oKWovY1qr8zRrxrLIfOBl3cHv4WF0YFbaS5iKvQQ2ZU7mhVPP89yk7wZs2R
         JfZ5XvCKLYk2tO9oQ0oJhEYhTCUcdR18MomkQqDYSpafH/YO8QHoeeV86V+apUJURqgw
         0c8GoflJJuo9V8TJ+7sFF0krEFksNv53mAtDk3TtaUZozTqamNC5bFOb0aZpTE80sR1Z
         yf3Q==
X-Gm-Message-State: AOAM533qBTzmPAc8WAuWO9IPDf2BUgNV8nshFsL/54CnyALq0kmHPvr8
        bUlYTtj6i0G+8oFROniOKlNGil4wnA==
X-Google-Smtp-Source: ABdhPJy8ONyucjfHLa97PFzhpN5DSEpMmxhWWaRYJ69zcueJZKwhz/5HDEgSPCZMClEEXg/UelKUDYehmQ==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:a0c:8e04:: with SMTP id v4mr23462144qvb.56.1610961731717;
 Mon, 18 Jan 2021 01:22:11 -0800 (PST)
Date:   Mon, 18 Jan 2021 10:21:59 +0100
In-Reply-To: <20210118092159.145934-1-elver@google.com>
Message-Id: <20210118092159.145934-4-elver@google.com>
Mime-Version: 1.0
References: <20210118092159.145934-1-elver@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH mm 4/4] kfence: add missing copyright header to documentation
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org
Cc:     glider@google.com, dvyukov@google.com, andreyknvl@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing copyright header to KFENCE documentation.

Signed-off-by: Marco Elver <elver@google.com>
---
If appropriate, to be squashed into:

	kfence, Documentation: add KFENCE documentation
---
 Documentation/dev-tools/kfence.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/dev-tools/kfence.rst b/Documentation/dev-tools/kfence.rst
index 06a454ec7712..58a0a5fa1ddc 100644
--- a/Documentation/dev-tools/kfence.rst
+++ b/Documentation/dev-tools/kfence.rst
@@ -1,4 +1,5 @@
 .. SPDX-License-Identifier: GPL-2.0
+.. Copyright (C) 2020, Google LLC.
 
 Kernel Electric-Fence (KFENCE)
 ==============================
-- 
2.30.0.284.gd98b1dd5eaa7-goog

