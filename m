Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3BA5279D0F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 02:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgI0AJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 20:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgI0AJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 20:09:28 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F915C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 17:09:28 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s12so7776834wrw.11
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 17:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DNz77pZ4NvgqY3W+gdzJU+WJ+JLhIrLzpr3ODNJxtsI=;
        b=I8R2sfkfGUF6sNeiy9b3/yujHnowUYSPhBe//oC5I56hsVJlmaI3Y49d6gP2rCRS0H
         DI8SgevNevTpUL55h/PFEUVIyX+zChUhapMXAceM2fVXiS0IbBLlxVWLqSEznNAngHyH
         Li/xsV2SYwr4MJ739H5jg0oHhOj7S/aLok2n8NoiE4A/A84uPuDcf+g5axEEOnFZbglK
         /Z/BbirP78fs1WuVE6su4EMcS/oN6Qlm/0SCqr0e6gbIwYZV35KaSj91pUtkw1zNnwn+
         9hdEOwCtZO/43MwxO9emaKJ+se/w2W6nYKwgkRawhJA//ReR+vWFzuWyRYgtwx5ekJ5B
         mdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DNz77pZ4NvgqY3W+gdzJU+WJ+JLhIrLzpr3ODNJxtsI=;
        b=F9xx5KvchKn60BptyVGB9CtPsBbR+CHBAKHQvl9nx40mlQSSuX/dea9Ng/dWJmnAhp
         isjVytjIGUP+Gw/xsab5FUFouHwvL/1Cbp7rlC/+8dgYdUJCuSUF0H8STgiyBfkp/tGz
         Ybbf0p+2pfGqIqT7QXQom52Vxt/97NqRMiGXai3FLOXcGpbHImDxgVpjcellzrgbUh/t
         YejR3zpJSHWwcdSzsnTp60rClJr6kz/17V864uTitLg1koY1yeewrQ0ZPrBN0/51PzOE
         pf9aNTvHVG3DBIy2+L8+Vuv4hA/0Frryec2ijkfgLrnxR0HNWK9y+gPnBVkZDnK0z27K
         gBdA==
X-Gm-Message-State: AOAM531eg0rgssCmMv9ykDsdpEV/cyDK9bV/f2+IVSQseAp865fkSxjP
        7BJC8FVJyNn/5okpDyh7k7DR3G+J+jv41g==
X-Google-Smtp-Source: ABdhPJyxV9/38FZnmd2bmkoW9483iZ4yLq+SoQ7BUFzLwd9liR6srADtWF8jHX5YhOnFJElfOGSnaA==
X-Received: by 2002:adf:e6cf:: with SMTP id y15mr11429653wrm.346.1601165366571;
        Sat, 26 Sep 2020 17:09:26 -0700 (PDT)
Received: from localhost.localdomain (188.147.123.201.nat.umts.dynamic.t-mobile.pl. [188.147.123.201])
        by smtp.gmail.com with ESMTPSA id u126sm4797554wmu.9.2020.09.26.17.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 17:09:26 -0700 (PDT)
From:   mateusznosek0@gmail.com
To:     linux-kernel@vger.kernel.org
Cc:     Mateusz Nosek <mateusznosek0@gmail.com>, tglx@linutronix.de,
        mingo@redhat.com
Subject: [PATCH] kernel/futex.c: fix incorrect 'should_fail_futex' handling
Date:   Sun, 27 Sep 2020 02:08:58 +0200
Message-Id: <20200927000858.24219-1-mateusznosek0@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mateusz Nosek <mateusznosek0@gmail.com>

Previously if 'futex_should_fail' returned true, then only 'ret' variable
was set, which was later overwritten without being read. The patch fixes
the problem.

Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
---
 kernel/futex.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index a5876694a60e..39681bf8b06c 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1502,8 +1502,10 @@ static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_pi_state *pi_
 	 */
 	newval = FUTEX_WAITERS | task_pid_vnr(new_owner);
 
-	if (unlikely(should_fail_futex(true)))
+	if (unlikely(should_fail_futex(true))) {
 		ret = -EFAULT;
+		goto out_unlock;
+	}
 
 	ret = cmpxchg_futex_value_locked(&curval, uaddr, uval, newval);
 	if (!ret && (curval != uval)) {
-- 
2.20.1

