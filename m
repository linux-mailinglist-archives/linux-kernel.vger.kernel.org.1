Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38F22F2A07
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 09:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405460AbhALI3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 03:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731604AbhALI3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 03:29:50 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A935CC061794
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 00:29:09 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 15so956105pgx.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 00:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CrBTMwuCocMXNaZlBloj14p7TaV3dUqyAg3ZjdKSdtQ=;
        b=SheSm7pPzbdgKTGIS5Wbrtm+EyLFpf3IdIFMHUhJjjd5RQsq61KHB9elZRuoTCC2Eu
         LhpDn7kN9a6R63hOsxSvvK9hDTeYJ7SEtf4ru2381HGPyfNGlGMggNq+C+T5igUUdWu4
         3AR0la2JlukQLl4bU9bpUeZiz/TW1WQ8YQ6KDxI2/405yKKJT4JB+qRx+zwCY+FDMvKM
         8LQe6n459ZQlGeYxWMcdJBvgCrPcDPRqS0Uzgeh8X/lACZyHl2RjwmWzCdtqDCelh1qM
         pidA75ympxCe2WCGm3+XyvVw2REGMrrOcPYYuF70ZbeLxzJGg3UX7qhSjISoshlYIikH
         eNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CrBTMwuCocMXNaZlBloj14p7TaV3dUqyAg3ZjdKSdtQ=;
        b=Wc3ZVIkpgjCpsd+VrSz7IXqjY4NXAV1gRecQRTYqnVF98/ioVy8MdFqk5f5jNXcLEw
         eyf3lRhnrHJek0uWJQy1XyoTMgBDOqhtnnv7PfLPu8h9AIIcixyDa5vJnDD0WpLB/RrO
         JREzTX0AdFf65Jq/3S/gbzy5K2ni1X4rd/188j+IAssEHJtcqrnCtnhZsDEyzbrzN0eH
         248Rx/P9ArRW0Z/LVpWmL0T3r9v3xV2ei0PW3UWHrsZ/cFTdBUGzI90CTSln74kAafCy
         CkmKmWNFk/s3lsRRtIojR7C7KPMssvuF4P6oAkjGjn8p5oH5lZkFHJCaaxw95Akk0KHZ
         MdVA==
X-Gm-Message-State: AOAM530Qo/9oEvXPlUZTkdRmAopXir3dhyBjODwkI8OSIoztULwnEGIe
        Q+kqMDMSXgK4UjelR/93sRkT+Q==
X-Google-Smtp-Source: ABdhPJweEioWpVtvQX71VyotDntXRJ0bZz1J7VJsaDO6OCrG4WuPO1/Yj0aac3RBFhQPfdcf3jYj+g==
X-Received: by 2002:a63:d601:: with SMTP id q1mr3608947pgg.417.1610440149194;
        Tue, 12 Jan 2021 00:29:09 -0800 (PST)
Received: from localhost ([122.172.85.111])
        by smtp.gmail.com with ESMTPSA id r79sm2187433pfc.166.2021.01.12.00.29.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jan 2021 00:29:08 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bill Mills <bill.mills@linaro.org>, anmar.oueja@linaro.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH V4 0/3] scripts: dtc: Build fdtoverlay
Date:   Tue, 12 Jan 2021 13:58:59 +0530
Message-Id: <cover.1610431620.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will start building overlays for platforms soon in the kernel and
would need fdtoverlay tool going forward. Lets start fetching and
building it.

While at it, also remove fdtdump.c file, which isn't used by the kernel.

V4:
- Don't fetch and build fdtdump.c
- Remove fdtdump.c

Viresh Kumar (3):
  scripts: dtc: Add fdtoverlay.c to DTC_SOURCE
  scripts: dtc: Build fdtoverlay tool
  scripts: dtc: Remove the unused fdtdump.c file

 scripts/dtc/Makefile             |   6 +-
 scripts/dtc/fdtdump.c            | 163 -------------------------------
 scripts/dtc/update-dtc-source.sh |   6 +-
 3 files changed, 8 insertions(+), 167 deletions(-)
 delete mode 100644 scripts/dtc/fdtdump.c

-- 
2.25.0.rc1.19.g042ed3e048af

