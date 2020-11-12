Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505E32B0EBC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 21:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgKLUDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 15:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbgKLUDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 15:03:50 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F25AC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 12:03:50 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id c17so7292111wrc.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 12:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fDF5l0n3msRGgGGH1jpdrBrGSoTCWyYhlZaMIFoRHNY=;
        b=PxCDajPYS+KMhHly7PQAn7plJ/zYAleZ+YiSv2SUa754kwXS/aJGSZwC+TDW/rdQCv
         q05aiakbtJAtUYBPNycY+A3kwd12STIpUnbMkxkd610OR0mCJ1l6idQrSXY6s2PhrXN5
         fsux1Ln24Wq+x9r5mJm65U+rSJc8QKcVLJNGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fDF5l0n3msRGgGGH1jpdrBrGSoTCWyYhlZaMIFoRHNY=;
        b=KZugocXq4pRxSxcHTyx8hlVgQ/n/eqhvg/0Iypwvler1ee7tCxBIxho1FIhwcnpNzC
         reR3RSOymxsfpsv0suUGbpwst8urZDTmsp2G1HmB+Nq63jmyBcdwEWNRRVkrw4f+b8H+
         b+RzELB897pGy2I9wsFZIBD+5gSFzC8dvnSbwheFEtRsQXjz+MPapm7eCa/OJ/4KQ5An
         sQ0pF2yyr4EXhACW/I2m/xkTwixKh2ra+6n6/4Uh5IEWdqP5w2Oz07P16JZZMfxMOptb
         g0hotN7pW6cDk65xggQ6joN9eIN/FApk2/4Etn+L5+FoC+kLymhC86gZNrPsDa2QWy0J
         pGGA==
X-Gm-Message-State: AOAM533U/0tt4GjTGIKW5UUimRdjQp6jOK5oe0OQJLV0pYHpOnYAiKCN
        zyD+vvO8QeNopXJ5fEyBkeoHDBoBQHQKint6
X-Google-Smtp-Source: ABdhPJwVb+LsMJ0DjHqzXuECZpfn2+MFgdWWTcckzcS+fCFdEmaOUz+OteWD+70e25ksjgaZahkqBw==
X-Received: by 2002:adf:de85:: with SMTP id w5mr1476604wrl.90.1605211428534;
        Thu, 12 Nov 2020 12:03:48 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id f5sm8488472wrg.32.2020.11.12.12.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 12:03:48 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next v2 0/2] Sleepable LSM Hooks
Date:   Thu, 12 Nov 2020 20:03:44 +0000
Message-Id: <20201112200346.404864-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KP Singh <kpsingh@google.com>

# v1 -> v2

  * Fixed typos and formatting errors.
  * Added Andrii's ack.

KP Singh (2):
  bpf: Augment the set of sleepable LSM hooks
  bpf: Expose bpf_d_path helper to sleepable LSM hooks

 include/linux/bpf_lsm.h  |   7 +++
 kernel/bpf/bpf_lsm.c     | 121 +++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c    |  16 +-----
 kernel/trace/bpf_trace.c |   7 ++-
 4 files changed, 135 insertions(+), 16 deletions(-)

-- 
2.29.2.222.g5d2a92d10f8-goog

