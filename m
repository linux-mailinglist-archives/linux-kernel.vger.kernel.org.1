Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0CE6213EE7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 19:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgGCRn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 13:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbgGCRmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:42:40 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E16C08C5DD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 10:42:40 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g75so32749110wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 10:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nrHavSfwF9zAzDxN+izm9d2TdfMW/Gzo00Jgx4fI6x0=;
        b=v3Wh3lvwukp/VboEADjur5pV3CgcRQ5RkHq6J0z1dtnbvy+t8z27eXoBypluVuR9M9
         gMJ2vWmKe3aCAcLApcN3rjLts+Br5bLcuqfQQIp5OgANFlNv9Wi7KG5tV6nVcJXepR3r
         v5qTQt6JhwEqc5+DytL3t6eMYc9yHBIdaVzI92jZ3uw4Fs8bcZSzoR+arUihmQkTgbtC
         qCNNhTqAkpyTMo9UHUjOouAGRnQl2nZrV8JJlwp1JwtPtzan/g8IERYJNLj2X2aY2Z5w
         kZY/PYvdMzmHhzvMrvbr+ZM5B12KTRMQK5jANWzIOYrKLgHcCZl0R2TUUNE88t13kyAd
         I7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nrHavSfwF9zAzDxN+izm9d2TdfMW/Gzo00Jgx4fI6x0=;
        b=MRDE+grnpzewQ4zjQSAAtxYHRmkfoBmZRwToQCNwqf+tEB7e1aa3VWF2Zxt8/QRxpu
         O7k1zOsUXM/01t5uza/xxT4D1gz7ZxxJsOxAvBpBasKrHYaNBN3BJ2M+htxqQbzSEDQT
         TM6bgFl9SNq3WvW0h4ImPqjvHSg+NeuRoyl2IuLnOF8XexeRGjj6vPcygvVmbfJ3Qmf/
         I0J34rkpOYw5q9KPALNm25k8uhm8JY0aZQi3rdKyT0JT17seXm7n52zpdZHsTiE2QU5/
         9SRW+ZPbbsqTGiCKC0lVh5W41PiCl2AoKDDHZtb3a/+Kf3TwfnxiqJOd3dGMM5WGeE3P
         SiNw==
X-Gm-Message-State: AOAM532evBOmGKh/LEpYKJwHb+UYqWMlURqQwhoYytJpsVr3FZvECzoX
        tQIFcJD16jaH1z8DQ1iVaB06R9h5O2s=
X-Google-Smtp-Source: ABdhPJzi/uWfkCbo8xC3My6JR+VXn+MbLHVx87b8vwenP30eUAYU/lrCQXZAAU72yIqMQn2cgDaH3A==
X-Received: by 2002:a1c:3504:: with SMTP id c4mr4440719wma.177.1593798159020;
        Fri, 03 Jul 2020 10:42:39 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id x11sm13625799wmc.26.2020.07.03.10.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 10:42:38 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 15/30] usb: host: xhci-dbgcap: File headers are not good candidates for kerneldoc
Date:   Fri,  3 Jul 2020 18:41:33 +0100
Message-Id: <20200703174148.2749969-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703174148.2749969-1-lee.jones@linaro.org>
References: <20200703174148.2749969-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Demote xhci-dbgcap's file header to a standard comment block.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/host/xhci-dbgcap.c:20: warning: Function parameter or member 'xhci' not described in 'dbc_dma_alloc_coherent'
 drivers/usb/host/xhci-dbgcap.c:20: warning: Function parameter or member 'size' not described in 'dbc_dma_alloc_coherent'
 drivers/usb/host/xhci-dbgcap.c:20: warning: Function parameter or member 'dma_handle' not described in 'dbc_dma_alloc_coherent'
 drivers/usb/host/xhci-dbgcap.c:20: warning: Function parameter or member 'flags' not described in 'dbc_dma_alloc_coherent'

Cc: Mathias Nyman <mathias.nyman@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/host/xhci-dbgcap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index 93e2cca5262d1..987f893e941c7 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * xhci-dbgcap.c - xHCI debug capability support
  *
  * Copyright (C) 2017 Intel Corporation
-- 
2.25.1

