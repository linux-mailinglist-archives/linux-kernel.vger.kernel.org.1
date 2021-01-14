Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4212F650C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 16:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbhANPre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 10:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbhANPrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 10:47:33 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A232C061574
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:46:53 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id md11so3299372pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7nRa2iQYEz2mBc42Jpcm0+7wU13wlYE4f1yc6Ww/3vA=;
        b=NdAa+iIGyHzL6nF1JU+mNdUWy1xwsV22iMv1QGLOdyYu38Ri1zwDLj4UMAyzpM3cgU
         CnUiX1Zm4Ae7NGjWgoEEEnMw3+yBcBg1DJ8gBAETO9+k6u1bWDv7zX3cT551SNkAa0/6
         2CX5dk8wj0TYSGGtKJX8CvmZsIi0o+7PNEh4NV/dxRFnjc0wf33UUVpJOlJf129usrc9
         G2feEJoXKAEVIPaX413jg+PRxLNzDjxscU0fp0KAVTiLeHbXgFyq6rRKOwaujTHu9nx8
         rId5701y3caQRnxKnYpnSYpKunUf0PaQW3DqFUglT3aAAni/h/wEaNDLeDaD+ooPQDH7
         2LJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7nRa2iQYEz2mBc42Jpcm0+7wU13wlYE4f1yc6Ww/3vA=;
        b=r6Xg+8NNEJ7R0CJr4WG4rnbUoGe7SNuGHcUIdA9BQ4qFKZBw7c0tYGBSQnVJ2jhAgQ
         GK3aOrjsUNtD/BnSMboXJ8TtbeBUa3xmhKhd6f1xDM4fzzi3XBoDV3LJk2gZZqrwa0vr
         LWVq1K5Fbfu5JmoppU6GFW+1iGj6b0PrJtZinQUJjGvNmIMuLGuD1GlioeX3eLTU50fL
         oZwPqbPX1kx9Z5m59tp0/B/rHeoAVUDrYXIlSCg/4AGlVNI9Z0u1dsrFAVgVSwfyjYDB
         Lq1VYWe26KzO0tcTZ0ErZx1F/+sQG6nMpz2OiyXIPHVQPz9sTK+1V/TkpoIPMM6Us9hY
         ClUQ==
X-Gm-Message-State: AOAM530jClZpWb1nvrgpJ2XHwjt0P/LnNDaeRKA8Kh5bSfsrfCVG8LWY
        2Od3YzBLA4rWWq1W9OWj4SgRdg==
X-Google-Smtp-Source: ABdhPJxFVw+6fRfxqEbz30e0DT5OHxKnuCaixKgNvXhDD1yUqUynaG/5FenPtn6QlBEcnfsZ4XUbeg==
X-Received: by 2002:a17:902:7c0a:b029:da:62c8:90cb with SMTP id x10-20020a1709027c0ab02900da62c890cbmr8097793pll.59.1610639212807;
        Thu, 14 Jan 2021 07:46:52 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id t23sm5739577pfc.0.2021.01.14.07.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 07:46:52 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Joe Mario <jmario@redhat.com>, David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 0/6] perf c2c: Code refactoring
Date:   Thu, 14 Jan 2021 23:46:40 +0800
Message-Id: <20210114154646.209024-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is for several minor code refactoring, which is
extracted from the patch series "perf c2c: Sort cacheline with all
loads" [1].

There has a known issue for Arm SPE store operations and Arm SPE is
the only consumer for soring with all loads, this is the reason in this
series drops the changes for dimensions and sorting, and only extracts
the patches related with code refactoring.  So this series doesn't
introduce any functionality change.

The patches have been tested on x86_64 and compared the result before
and after applying the patches, and confirmed no difference for the
output result.

Changes from v3:
* Refined patch 03/06 to remove unnecessary parentheses and test and
  return early in the function filter_display() (Joe Perches);
* Added new patch 04/06 to make argument type as u32 for percent().

Changes from v2:
* Changed to use static functions to replace macros (Namhyung);
* Added Jiri's Ack tags in the unchanged patches;
* Minor improvement in the commit logs.

[1] https://lore.kernel.org/patchwork/cover/1353064/


Leo Yan (6):
  perf c2c: Rename for shared cache line stats
  perf c2c: Refactor hist entry validation
  perf c2c: Refactor display filter
  perf c2c: Fix argument type for percent()
  perf c2c: Refactor node display
  perf c2c: Add local variables for output metrics

 tools/perf/builtin-c2c.c | 168 +++++++++++++++++++++++----------------
 1 file changed, 99 insertions(+), 69 deletions(-)

-- 
2.25.1

