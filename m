Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B451B03C9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 10:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgDTIEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 04:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgDTIEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 04:04:45 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9507C061A0F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 01:04:44 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y24so10233400wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 01:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fv2Oi9ufX0LkGa3j+9DwW6rcNLKbTdnyozIfpaN2Whs=;
        b=jcFahNVCM1FBuXtg3EweZLC281pBCbnwwWQTVjrnL/WcgQZhHqVBIjCzie6c2d8nyb
         vNgcVmnhtHIAgNL64bNehP28fil40pHJ2BsfMiHRGbzUMLfUckJTpIHI4NmQPFOX0KsJ
         4WAnubBP4jvYNcJK43JeJLC+iDj9pMHl4iZ51OmpcVcQEk5BBdKHa8p+2eLMbMGOjC2N
         1Jz3LuDQCwWxj1CXv/MWN79JSY6enw5AeRPLmc14IXq9VFYWdFQXcJ/c8N6tiQYXjoeR
         8qEBixXQQLjX9IvILjpvb85YZePx9lzxQWjBqiu+AjxHqMXU+j9UtmYFlRYsfB/xNXQP
         WpqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fv2Oi9ufX0LkGa3j+9DwW6rcNLKbTdnyozIfpaN2Whs=;
        b=NwSkMkYZY0Rede9/ym6V+Dc1QZ/wV1GkxrfKPtp3IvJ9SOk8MmYAN6B9MYWnsEceAa
         FIXk8wjs8+RGe8j1yTmprSQrYbLcZLn1mTp6xys5UqTGVxE+CuwI4t2drtG8szxff4E6
         C+PSxP/dpic7EEyiKOj3fREXCYtlkmYf417j3qUMQAMa8CSaa0bb8btH+XRKiLiHljwt
         +pTsgoeUTlLxE2HwYvGHwxRnct2axb1H3vP8g50H0O8tCuL3k13uhVP4VZAsz06Qzmbn
         kWsJlyn65F8P2/Su4r35ZXdmbGrH/2vPRfqiCAJ7xXlprxmF8TtGBXVzR7PYlC5sc4+h
         farg==
X-Gm-Message-State: AGi0PuZ4d4Hm8xEuceq+YIwSb3wc/lrPSmxVHZCMKyfL2E65DhlfzEDg
        N2fqVCeNT2UV0yndC0U++Cm3Rw==
X-Google-Smtp-Source: APiQypJjiSUFYYQJVEwwmdO78/PS77Qb2pg5Locx//XIF9CmAuSIYC86/h+9eaBWFWJIxbf1MCg9mw==
X-Received: by 2002:a7b:ce88:: with SMTP id q8mr17515560wmj.161.1587369883251;
        Mon, 20 Apr 2020 01:04:43 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id a67sm335827wmc.30.2020.04.20.01.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 01:04:42 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        Martijn Coenen <maco@android.com>
Subject: [PATCH 0/4] Add a new LOOP_SET_FD_AND_STATUS ioctl.
Date:   Mon, 20 Apr 2020 10:04:05 +0200
Message-Id: <20200420080409.111693-1-maco@android.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces a new ioctl that makes it possible to atomically
configure a loop device. Previously, if you wanted to set parameters
such as the offset on a loop device, this required calling LOOP_SET_FD
to set the backing file, and then LOOP_SET_STATUS to set the offset.
However, in between these two calls, the loop device is available and
would accept requests, which is generally not desirable.

There are also performance benefits with combining these two ioctls into
one, which is described in more detail in the last change in the series.

Note that this series depends on
"loop: Call loop_config_discard() only after new config is applied."
[0], which I sent as a separate patch as it fixes an unrelated bug.

[0]: https://lkml.org/lkml/2020/3/31/755

Martijn Coenen (4):
  loop: Refactor size calculation.
  loop: Factor out configuring loop from status.
  loop: Move loop_set_from_status() and friends up.
  loop: Add LOOP_SET_FD_AND_STATUS ioctl.

 drivers/block/loop.c      | 309 ++++++++++++++++++++++----------------
 include/uapi/linux/loop.h |   6 +
 2 files changed, 189 insertions(+), 126 deletions(-)

-- 
2.26.1.301.g55bc3eb7cb9-goog

