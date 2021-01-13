Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D952F475B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 10:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbhAMJRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 04:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbhAMJRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 04:17:42 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5288C061786
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 01:17:01 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id 22so891768qty.14
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 01:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=63pl/aS2wHam/AsylCEoY/1tqy/k+q1Go1i6UVadOa8=;
        b=S5jEmBDfc5/GL0JdOJPWuSgqdiB03H3YFCF63TgKOBBQ/pzGsvZ6xnZDy/0pyE3tCF
         W0dux4Oqj6j6OA8SRJhrJpw+DV5XVRr6nw+MRgP6tc+tnk5jSWD/8r4SBUgU01qwq8jL
         erJCU6lgMGpvEhIJ6+2A25JizThP2kMQGTq4Z9t8DNULGnYCs0derrIm2bTMvKk5clG7
         31SxhfRZu2gVfMSlQEAA9UQPo7JaYKdyi3xWhSw8eOt4mKqtnprHbHy4IrOBWUEFXOnL
         Q971ohdSsdefgtSIbokvzFXh2PeDeK+2QN//atuZkXqBX39EgV1D3xzpqO2ElXuWk0vp
         Z74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=63pl/aS2wHam/AsylCEoY/1tqy/k+q1Go1i6UVadOa8=;
        b=L0AVJwuzOeEGNWd6nZ+0DJLLRFnkoMu8ykHmuiRXX3OR69KDbJjCdsI4B8UlbYu4uY
         KM2qGyUuvCeWpVudKScW2DVOWycvBfAyLhFPeURCncdUdWxijNW/hasBetZ+F5UjM+DM
         BwsYu9zRTEVP+OIhLevm0Qhe9V+9Zqjrzi6wAlFpQKaFaAncq1yfYm4V7pyCeF/PQD5w
         jh3bGDfzMZ4OLK72uBJ5yZMD/o5yO2XIQFvIoYGKir+wvV5xidRx3b/yQ2yhEZrsP9MU
         qgVQDzbeZQf+MsvWD5IZagd1QwsD22Uaht5QpKnQmFdv6LqzUglx+u8abNvARlpDWTpi
         EJsA==
X-Gm-Message-State: AOAM531qvH1BSAad/mVfW8SleweHQYpYfqenaQfrznAM2V00dUs8M01I
        FTZOe0OCgjVM+1oyhU9uhEPwQdFtjso=
X-Google-Smtp-Source: ABdhPJwmJllYPVYu7xBhe2K6A43qMvIolCEIaxhTK2SDRI13ePR+mHoVUmKF0j3hzBIH6v05khmN4YdZOpI=
Sender: "glider via sendgmr" <glider@glider.muc.corp.google.com>
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:9ff])
 (user=glider job=sendgmr) by 2002:a05:6214:321:: with SMTP id
 j1mr1452876qvu.32.1610529421134; Wed, 13 Jan 2021 01:17:01 -0800 (PST)
Date:   Wed, 13 Jan 2021 10:16:53 +0100
Message-Id: <20210113091657.1456216-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 0/4] Add sysfs interface to collect reports from debugging tools
From:   Alexander Potapenko <glider@google.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds a library that captures error reports from debugging
tools like KASAN or KFENCE and exposes those reports to userspace via
sysfs. Report capturing is controlled by two new types of tracepoints:
error_report_start and error_report_end, that must be added to the tools
that want to use this new feature.

Alexander Potapenko (4):
  tracing: add error_report trace points
  lib: add error_report_notify to collect debugging tools' reports
  kfence: use error_report_start and error_report_end tracepoints
  kasan: use error_report_start and error_report_end tracepoints

 include/trace/events/error_report.h |  51 +++++
 kernel/trace/Makefile               |   1 +
 kernel/trace/error_report-traces.c  |  11 ++
 lib/Kconfig.debug                   |  14 ++
 lib/Makefile                        |   2 +
 lib/error_report_notify.c           | 278 ++++++++++++++++++++++++++++
 mm/kasan/report.c                   |  15 +-
 mm/kfence/report.c                  |   3 +
 8 files changed, 369 insertions(+), 6 deletions(-)
 create mode 100644 include/trace/events/error_report.h
 create mode 100644 kernel/trace/error_report-traces.c
 create mode 100644 lib/error_report_notify.c

-- 
2.30.0.284.gd98b1dd5eaa7-goog

