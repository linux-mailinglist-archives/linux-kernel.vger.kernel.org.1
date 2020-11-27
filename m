Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F522C6B02
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732725AbgK0RxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732686AbgK0RxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:53:13 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711F8C0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:53:13 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id w202so5167145pff.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dNWv6jMtUXr1D5Ne1cJMYgh7oECpaBPZ9FSLHbHGa/E=;
        b=FXr+FYJR7t7brym1d9qu5y9wAuLMmD0Zci/y7tFjqPd2Vg6nudIGMPNr8wbRBgoAjG
         6tnvv3ZZP6i0ncvQn/ZJ8fymUIE3Ff/RU5e/FlrTXypLIquOMzqd5K77ExbtK/lQjBmR
         bx4fjmLCYlzZw3yBaYKcK8vCIezlLyqL2HkMYeaUcM1Bj10F42vntfxqTQYW0FMRBa4L
         rAxA5hMffk7LDMUcPR3tkEcYkWzuDKQd7SEPTi9y5piPEgFqdIf+BiH0WlDCoB6jFvgO
         NVElnxXNwxV36WXf+28u2wI3/L24IDQu+pQj5GA9Gd80bYs3U3TQoJk8aUuHPY9M2YZB
         4t8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dNWv6jMtUXr1D5Ne1cJMYgh7oECpaBPZ9FSLHbHGa/E=;
        b=qkopu7yPE6Jnqis+y3u11r1q7F/yDAM1UhSVKmF/8z+45VYtxep7yVPhrWOr5NUHAV
         5vtye8YGhmDgZ2fcKGxWISzdovbexSw8x8BJYR5l3fsQczIXZ8L2a5Pv6WW6b6UJXQ4j
         tCir5SpaDubJIt63dvS7UhgRXVoNpWG0/Lyn4WnlPWvSY5egHvuyIM9UVfjWdWJ4vwGK
         /nonOVmBidEfXM49fqZv/320MU38+5bwHE9vdKMq3m5XUiHnOyeX5kB+VnwF2PPAhy16
         nyTk8xZa4nyWmTSxoJXichnF8hHsW/tnHQxLZS7Hf2dx0xKOF0qvWZmtFX5xKIWTLgAB
         sb2w==
X-Gm-Message-State: AOAM531YSaIa2ZHXz17hVTw1DG51o4Rj2q3WB1NkUaMcd5OZKCmZZ9Z6
        MOcelLvMPFl0AGRbPFdWdq2OOvVcmOk/fods
X-Google-Smtp-Source: ABdhPJyH7OR3XRN+Sq52ZqjxSQ4hVx+Lqa517YDhoOS+AGPiiuSAVYu13cOiQJVP1sh0GDj23sFpXA==
X-Received: by 2002:a17:90b:3011:: with SMTP id hg17mr7057002pjb.22.1606499593062;
        Fri, 27 Nov 2020 09:53:13 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id t18sm10536724pji.1.2020.11.27.09.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 09:53:12 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/15] coresight-stm: Fix W=1 warning in STM driver
Date:   Fri, 27 Nov 2020 10:52:56 -0700
Message-Id: <20201127175256.1092685-16-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201127175256.1092685-1-mathieu.poirier@linaro.org>
References: <20201127175256.1092685-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  CC      drivers/hwtracing/coresight/coresight-cti-core.o
  CC      drivers/hwtracing/coresight/coresight-cti-platform.o
  CC      drivers/hwtracing/coresight/coresight-cti-sysfs.o
drivers/hwtracing/coresight/coresight-stm.c:109: warning: Function parameter or member 'guaranteed' not described in 'channel_space'

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-stm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index b0ad912651a9..32d29704206b 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -96,7 +96,7 @@ module_param_named(
 	boot_nr_channel, boot_nr_channel, int, S_IRUGO
 );
 
-/**
+/*
  * struct channel_space - central management entity for extended ports
  * @base:		memory mapped base address where channels start.
  * @phys:		physical base address of channel region.
-- 
2.25.1

