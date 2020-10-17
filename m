Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A815291135
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 11:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436622AbgJQJwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 05:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411859AbgJQJwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 05:52:54 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F525C061755
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 02:52:54 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id gm14so2682267pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 02:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=T8WCR0uqO7FdRKPquY75xpPQ5KYI1PWYHzaEu+F4REg=;
        b=EDAOR9TOW4rzbEdkYiwre3sa1QYU+Kz2sn3CXj9SgAE+r9pM3wcIo+w3FFZdd6vR4g
         LFtHdvoev254jrxMHfM4CNotKss6u3aiUHUxZfomyLRaUT/4vgLMUb4Xfe0Sxpfj4Dsd
         WV1UnpnjY5335JjFtYGa4nVrHxYiiaAfFOFBOYTGEUlhZ3XQ3gZWALH/qRrtJgBLDb+t
         eF+YVEo2yC8H+VlX6rgNxV8+iJx+ZPfPuYUzdZErnFGhFFSyh560Hhe31rVIXW5wp7Pw
         2HA93JGb6qhEIW0RfRd7RiNaHnWwDjgBzLmkm0lQ4imemiVLii1fbhEHInNNEjNpPg5/
         WetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T8WCR0uqO7FdRKPquY75xpPQ5KYI1PWYHzaEu+F4REg=;
        b=PpqeQJnq3o2uBfexJryVEE/pTvONw9A5of+zm5d5a18EEqkacE7kSn24vwcr2YgbwU
         FtVHU6nE0Yit/mW6irZaPcjspOTZhT+sE9FKSMB6aLreZPbHSp8WETzKXWO8Cp01KqCC
         +taT4wOf/sixg4MJbWilR2shApegj9k5Gmtgbodvz7O47/BmHpRjHG3R7r/kj1c/an2K
         tQ51Ra2+cc2qh2i7bmjriGhXyaOpmUhF04cCTBmbt0PF0JPCPhRe7ee23UHCdC1pHpgI
         lcar2hDubr0RJ8xgl9Ndkm+mTXuXACzAhSXc2Pq2+vcpWrhGQLb5J/3NEzfovyiOPFh4
         Oorg==
X-Gm-Message-State: AOAM533AZUgrXCLa/c7lJfp5iL5/dMBcL9XS7M02U0ky2AHboDntgxpk
        5K0wp8JyPQ0ZItS/2BpcMK0=
X-Google-Smtp-Source: ABdhPJyNvTapF4i7x+sOCVb/Ff08khLMiaMxKldKRA5q9LHSpcFQAstKttdzdSW9je8SGeoUltzY/Q==
X-Received: by 2002:a17:902:bcc1:b029:d3:9bdf:32e3 with SMTP id o1-20020a170902bcc1b02900d39bdf32e3mr8155869pls.1.1602928373668;
        Sat, 17 Oct 2020 02:52:53 -0700 (PDT)
Received: from localhost ([13.94.42.177])
        by smtp.gmail.com with ESMTPSA id v129sm5209214pfc.76.2020.10.17.02.52.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Oct 2020 02:52:53 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] ring-buffer: Update the description for ring_buffer_wait
Date:   Sat, 17 Oct 2020 17:52:46 +0800
Message-Id: <20201017095246.5170-1-hqjagain@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function changed at some point, but the description was not
updated.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 kernel/trace/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index b2c6f2546d69..598c388d6436 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -793,7 +793,7 @@ static void rb_wake_up_waiters(struct irq_work *work)
  * ring_buffer_wait - wait for input to the ring buffer
  * @buffer: buffer to wait on
  * @cpu: the cpu buffer to wait on
- * @full: wait until a full page is available, if @cpu != RING_BUFFER_ALL_CPUS
+ * @full: wait until the percentage of pages are available, if @cpu != RING_BUFFER_ALL_CPUS
  *
  * If @cpu == RING_BUFFER_ALL_CPUS then the task will wake up as soon
  * as data is added to any of the @buffer's cpu buffers. Otherwise
-- 
2.17.1

