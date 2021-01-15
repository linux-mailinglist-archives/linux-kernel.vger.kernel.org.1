Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13C42F7BA7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 14:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387983AbhAONE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 08:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387579AbhAONEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 08:04:21 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D8CC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:03:41 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id k67so2965031wmk.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=8pVBeAmHPVH4sqJoIpZrjNUbTTeWSJqiF6QuBFFBEnk=;
        b=ccJ5Z7VTBZPDX9JXev9i/OkwG95wzB3NCH8osolNVfLSMNex77i24yMeYluWI570PJ
         Ztx+IYoIByjgjWR1EYhlJ5+vQo8SExAPpe6rwX6eQLSyWesAeMwp+LApKK2ACATBLGEB
         LKABYbNC7cUSleQvufFz2DxsJ/hFHdd1QHpOh3yH6K4+z+cIpvFi2hGQ0hXOl3kTVzEB
         QY0yPFKjdDXAAduUGb6gPLUxMBzd671MQSORe2QjgzvbhAiR89bvtcneajK2teINgXyX
         VxGBs0yr0meKUdterygUTx0hUe4K12rZ/d+YGSR3tiH0jlpxvy/1mTEp6m+A8FJyhv8p
         3f2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=8pVBeAmHPVH4sqJoIpZrjNUbTTeWSJqiF6QuBFFBEnk=;
        b=NovLi9rY4MjVtniXPLDz35rqxPJYsVlU6QdRNalm9crSnP3BAcD9VvksLxfl0/o9Q0
         SvnxX25MrfnS+UBAIVsNkajAbHUAUMJM2LEYp5ngkSWaaeAE1guhOfmsNX2ZEVaMNqx4
         pQ1cRzljU7cSCWhcGfi7RNVcaRKNj1kSlr91uAYeguCvmzYW/y4i9poOH/I8yt2X02Jb
         oQsqlMbMC5aJj9wayfbI5BvoQaTnuqxHZCD4Wr+otg7axRwEPDBEmZHvxW5ChBHgMel0
         k/6VLofDbSv2syC5bf3eQZxEbZWtBLN0olqtFZXdARCyXiohcVVnVQGFjR6X1y0ZIk+b
         GVOA==
X-Gm-Message-State: AOAM532ndFCLauF+jSksDUiCQkPIGUzr+bagtc2GKiU1nqTkzrmz40U8
        mf73AbBor/lAc+qXaZI6m8FyrZXF/ogkVI2D6bFCe08jQiq9+82aNF7kbG0Xv3jTkpaNkFUToxK
        0OVMY0xifmxLb7zaw3ewy19FKKP/s+KHvd5Y8dOugBXPKNZqdRNCCRuW7uXcaftkhgYcCZg==
X-Google-Smtp-Source: ABdhPJxUvIPL0i29Yl8JtZjMDJ/eXdCqsve6tD+d3QCJyO9+vAeeTKUGu85ayMrOb0A4kaU2HyWSQ25LC2w=
Sender: "glider via sendgmr" <glider@glider.muc.corp.google.com>
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:9ff])
 (user=glider job=sendgmr) by 2002:adf:fdce:: with SMTP id i14mr13164778wrs.58.1610715819702;
 Fri, 15 Jan 2021 05:03:39 -0800 (PST)
Date:   Fri, 15 Jan 2021 14:03:31 +0100
Message-Id: <20210115130336.2520663-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v2 0/5] Add sysfs interface to collect reports from debugging tools
From:   Alexander Potapenko <glider@google.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc:     andreyknvl@google.com, dvyukov@google.com, mingo@redhat.com,
        elver@google.com, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, glider@google.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds a library that captures error reports from debugging
tools like KASAN or KFENCE and exposes those reports to userspace via
sysfs. Report capturing is controlled by two new types of tracepoints:
error_report_start and error_report_end, that must be added to the tools
that want to use this new feature.

v2:
 - added ABI documentation for /sys/kernel/error_report/
 - changed error_report_start and error_report end tracepoints to take
   a fixed set of values for the error detector

Alexander Potapenko (5):
  tracing: add error_report trace points
  lib: add error_report_notify to collect debugging tools' reports
  docs: ABI: add /sys/kernel/error_report/ documentation
  kfence: use error_report_start and error_report_end tracepoints
  kasan: use error_report_start and error_report_end tracepoints

 .../ABI/testing/sysfs-kernel-error_report     |  41 +++
 include/trace/events/error_report.h           |  84 ++++++
 kernel/trace/Makefile                         |   1 +
 kernel/trace/error_report-traces.c            |  11 +
 lib/Kconfig.debug                             |  14 +
 lib/Makefile                                  |   2 +
 lib/error_report_notify.c                     | 278 ++++++++++++++++++
 mm/kasan/report.c                             |  15 +-
 mm/kfence/report.c                            |   3 +
 9 files changed, 443 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-error_report
 create mode 100644 include/trace/events/error_report.h
 create mode 100644 kernel/trace/error_report-traces.c
 create mode 100644 lib/error_report_notify.c

-- 
2.30.0.284.gd98b1dd5eaa7-goog

