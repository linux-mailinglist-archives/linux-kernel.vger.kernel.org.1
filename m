Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7E929FC48
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 04:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgJ3Dr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 23:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgJ3Drz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 23:47:55 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307B2C0613CF;
        Thu, 29 Oct 2020 20:47:54 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id x13so4066141pgp.7;
        Thu, 29 Oct 2020 20:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UVKG3zAIrzLM+YmbjUI0UOUBR3kgrHfU7Anw+Xp8VNU=;
        b=SfZ50ZwCxLVjJjo+q3Sg9Mw2sVOGQ1UxV5RoTa4zjMERyzmBeN53eDCKYRFqDOkb3W
         nGZlvzF8oGQs4uvY0K89KbT8c6dYuKvqFhuEMsVvlji6+Ki/9ntvdukq29gUCSYXHiX/
         ChiYzRbJFgZtMHuz03E/dpHaLJbDo27Y/3hPVOPCR/07hK5VzV7FIYB5UM0h/Efr25h6
         DZzIH7qavbPlqlJqKQZGGDDZDNtONEBcWN8jE4ouqF4L44Cdj1YD0Gt8AvoWCMlneBwR
         RxB1xWxYEIlJYP5rORibwZ2EWSNACM+uyYSDfVWMfCkgc/SZRtaef3KAu3rTeIkvySKO
         XEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UVKG3zAIrzLM+YmbjUI0UOUBR3kgrHfU7Anw+Xp8VNU=;
        b=FmJmKEnCoJ23h3LONlZKBX+vzPznf+oJL7ZIE9kZNmE/b15pMGxvQoYfQcJcSAxE9G
         1glylJzjD3SBxdZGNQimcHuRgA8BKTKz4R438E5Czgdh9YAegou/wmu2j6SnE3N4O5CI
         COdlgd0cXphK9SjTLww66MqJV50L9YS7iCaY4hL24WOByGCWosJXzXBsEvePPCY8Tv1l
         /kLaiQaVI2r2c4lasNt3TZhMeaKo3cyEsj79010ucSXwnkroH9kVQdolc8LqwgwR1qrK
         JfFJPjpMgDvKfsZup3+1Ha6ryXk8ev8yla8zlUkS71yFYXBXE6dSKJoJTLJcALxr8okj
         ydEA==
X-Gm-Message-State: AOAM532Wt1PBXzMu4Fdz7b+MNyz1/14wF2pWgaH2FTrxLXX6kqGXKUVz
        jd7ldW40LSSXsLgPOLCnEhY=
X-Google-Smtp-Source: ABdhPJwvqS+6RY3ORg0bvRJ2A4tDPRLkTtJpB+5uvKzNsq6P7j6KL1h4FgcjljDxTo6W/Wnunxn5GA==
X-Received: by 2002:a17:90a:cf86:: with SMTP id i6mr372015pju.187.1604029673738;
        Thu, 29 Oct 2020 20:47:53 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id f21sm4323093pfn.173.2020.10.29.20.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 20:47:53 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH v2 0/2] fixes and improvement for sprd hwspinlock
Date:   Fri, 30 Oct 2020 11:46:52 +0800
Message-Id: <20201030034654.15775-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Changes since v1:
* Change to add __maybe_unsed rather than not use of_match_ptr().

Chunyan Zhang (2):
  hwspinlock: sprd: fixed warning of unused variable
    'sprd_hwspinlock_of_match'
  hwspinlock: sprd: use module_platform_driver() instead postcore
    initcall

 drivers/hwspinlock/sprd_hwspinlock.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

-- 
2.20.1

