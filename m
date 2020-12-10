Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54EF2D5EAB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 15:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391852AbgLJOvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 09:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391244AbgLJOtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 09:49:51 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645F3C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 06:48:58 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id t6so2893574plq.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 06:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MWNfaQnItR9KZWol9F2v6JJ42p8R6lV6Y8x9e8y3cs4=;
        b=Klg4+hVNpR5G/ok7bH2P4n3wSWstGSelZFceHLc3Krkd3mpuv5hqOoDlrsijOtWkge
         yMsVXb69PEfEyFnh6AS1cZlPl+44iJ4ZXx5sKgUnJQxhHXTtKqDGgigDlZdX2RBJl01m
         tWTRqOEKWH/QciYNe8NrHfkzS0QenahX2zKrhVJgNPoJ9sjt4o8iqyaa4GRhyBs1Puyv
         DPqRyK31IHaqgdNrF1Ajoap5wTAWRCSkZZlLgrs1tebWLem03hRrPg1IxRCJA5iSiYey
         TQzEgWfL3rwqaNQ4zVK9BBP5k8dWsHinPfVhoq6y3lOde7sPHJ4/VV36Ld1MtQTXH9Ie
         xjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MWNfaQnItR9KZWol9F2v6JJ42p8R6lV6Y8x9e8y3cs4=;
        b=aU3vxrPPE+QPLFyYpz5xoHBK5nOkHzBmJMf4IkR8sjoaqj4XR0kLbAV/N05TWWQNnH
         NlfJFQWl0bAM7bpsk7TUaiw0DB3nejc1QDRjzt5Uf9uaagCW0iyvF/Ugt0gj9yQjxpol
         psPKhg5XFpLzekDh5tfq3eEdhI/nuEZWX3LIIucWgDWYFiyWjfEtqceiXr+lkaXsYgpy
         1jHKKUhH9VeifmV3YuPF43cK6QjonLsGuImodSYDdxBrfMBrdSETGJgQbO37EQiuMZQ+
         2X1rH5NHJap9AO48NPXLHzcc/5Shl23cuvlsk25GB/ylupUBslCCFm/Vz9EUjonkJOPq
         98Zg==
X-Gm-Message-State: AOAM530m4S/1F8uqcpl6pHxx5XjR63Ale+2LP/kt8jQjQGjD32CMdB5D
        ulrkZyNxWys74l8VqIUhlns+2MjgAGFidL6/
X-Google-Smtp-Source: ABdhPJy57QW/gT05Mu65PdYKkVtA5NUsGtO2+Ty8lnPvPQeW8w51+sbTqhw0TsG/293UVkfaHXv1rg==
X-Received: by 2002:a17:902:7c04:b029:db:e44d:9366 with SMTP id x4-20020a1709027c04b02900dbe44d9366mr932039pll.51.1607611737348;
        Thu, 10 Dec 2020 06:48:57 -0800 (PST)
Received: from localhost ([221.153.153.187])
        by smtp.gmail.com with ESMTPSA id x12sm6656378pfj.25.2020.12.10.06.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 06:48:56 -0800 (PST)
From:   Chanho Park <parkch98@gmail.com>
X-Google-Original-From: Chanho Park <chanho61.park@samsung.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chanho Park <chanho61.park@samsung.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Khem Raj <raj.khem@gmail.com>
Subject: [PATCH 0/2] fix perf tool build error on MUSL libc
Date:   Thu, 10 Dec 2020 23:48:42 +0900
Message-Id: <20201210144844.72580-1-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__always_inline can cause build error on musl libc because it's not
defined. We need to include <linux/stddef.h> before asm/byteorder.h.
tools/include/uapi/linux/perf_event.h is copied version from
include/uapi/linux/perf_event.h. To fix this, we need to apply this
change both header files.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: John Garry <john.garry@huawei.com>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Khem Raj <raj.khem@gmail.com>

Chanho Park (2):
  perf: fix build error on MUSL libc
  perf: tool: fix build error on MUSL libc

 include/uapi/linux/perf_event.h       | 3 +++
 tools/include/uapi/linux/perf_event.h | 3 +++
 2 files changed, 6 insertions(+)

-- 
2.23.0

