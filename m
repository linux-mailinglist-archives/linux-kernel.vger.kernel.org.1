Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1531D2B1397
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 02:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbgKMA7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 19:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgKMA7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 19:59:49 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93979C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 16:59:39 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 33so7938042wrl.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 16:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lUzaJ8EeMucOBsVFqVgnjqj6uVdboqkKaNck4oy6TCM=;
        b=BhQEmLVS8QvaL4usGLTz03Q2p3nCy3Q2M2mt/Ke8s9PkBHv/+YpDoE9ciVvqZVZxgm
         ibT3BuXwzKyldbeNBbfKZrWd6xTBZ61kDcYN8fNfTZJNC+sgVprF49qFMeY07rGu0MiC
         PGfk/rIPDzQhjhdwu76hfGJZHdHeF7yhOAwgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lUzaJ8EeMucOBsVFqVgnjqj6uVdboqkKaNck4oy6TCM=;
        b=fp50N6xI3/T4RAtgiUWh2yiJZIkhGFsYg2X2Q6GZ6WYc8OIGoIkGbekwaAjjv0IHTl
         hV8y+zP287pRbVWaIxR3voORxh8oj9fqNOJED7BUyLkognHz42bJx+JTi7D7c/NJZuYk
         YxQu41Yj0436KKul8tr8KbgnutLXnsGrj/7xlpeoUvLS8/ufOQCQuXH9qrVcXuKxI5Rh
         5tUYcHJ5GQY1xTLJgrzxU9ZHzOYb8De61v2VN61f3zjOMF619Lb3m3D/2kqKGmtzzmJA
         wQko1Ta1IRQQTyyZvvktCXFqZZTqbE19C2kXjZtqt3iEXI+M7AySMo20U/tafwfuXwKu
         xuXw==
X-Gm-Message-State: AOAM531RTje/BheGS5yAutZN8on85gGCnnK03ShK0cnGGB8UEX5zklqK
        2J8a12xCRtoB5vj0ZeSLNT/7ZIU9qPWjv5Zd
X-Google-Smtp-Source: ABdhPJwT/4eiKGRT5v/QCR+GVLnIIbBdMu7AYCziCtPSsmKFM6kn59mviL6UbKz5M6j7M2GKbpNSdQ==
X-Received: by 2002:adf:fdc5:: with SMTP id i5mr2668465wrs.26.1605229178129;
        Thu, 12 Nov 2020 16:59:38 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id m3sm4508104wrv.6.2020.11.12.16.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 16:59:37 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next v3 0/2] Sleepable LSM Hooks
Date:   Fri, 13 Nov 2020 00:59:28 +0000
Message-Id: <20201113005930.541956-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KP Singh <kpsingh@google.com>

# v2 -> v3

  * Remove the list of non-sleepable hooks, will send a separate patch
    to the lsm list based on the discussion with Daniel.
  * Add Andrii's ack for real

# v1 -> v2

  * Fixed typos and formatting errors.
  * Added Andrii's ack.

KP Singh (2):
  bpf: Augment the set of sleepable LSM hooks
  bpf: Expose bpf_d_path helper to sleepable LSM hooks

 include/linux/bpf_lsm.h  |  7 ++++
 kernel/bpf/bpf_lsm.c     | 81 ++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c    | 16 +-------
 kernel/trace/bpf_trace.c |  7 +++-
 4 files changed, 95 insertions(+), 16 deletions(-)

-- 
2.29.2.299.gdc1121823c-goog

