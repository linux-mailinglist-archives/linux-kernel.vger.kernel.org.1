Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401EB28F29C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 14:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgJOMps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 08:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgJOMps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 08:45:48 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAFBC061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 05:45:48 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id h6so1857918pgk.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 05:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6mvSgSzdrG2Kf5lb3MWun4iW1eHn9iEbQn483O97LIM=;
        b=aTwNHgpk37miOmIvDzfMfIoPnp7G+nTSMSavBtn1FisyMgQJTaOIi/cZ9GfgowCVlt
         inMSrOwdbW9GdDBKySPQMBPpszluc2DRvK52PBy5+np/QPNQrkDjE1aKtpmhc1Er+NEf
         s5kXnqHAz6bGaz3kOJT9/GNRh/K1bUngfCobJudp2ZZZgK4Qs3NHWeXSUXgDn7gUtK1p
         FUFkWLPb+kIl6YhJpnPNJj94kqZpsdNQ9XfRbsPxr5hDNg5jXYzWQin+Q+dojPiKrOwE
         mqW0ovZ9ERnj6Us8uwk7tTc/L1MgkspiRcCdpMsRNVhjYDLn/dx+9MpraDVQwGsunuQd
         SW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6mvSgSzdrG2Kf5lb3MWun4iW1eHn9iEbQn483O97LIM=;
        b=LRA2AlsH4jBrjPEuT9VT5Exw/pieSLK09PqGo3QvLyhaPssVcis/iv3ZkKmCfnBFcs
         meTZVvRCcQz8L3gh/Gglilm7Jq6oIViMQ+Hv1LxcCh6IDoPlSJbViewiWWnTOHqMZUKV
         sOqtX0/BiNWAf53hZUvbu4U9JtfSV180fWfolJ5hCgxHpELwbet+xIhgrskNxyd6E1Y4
         613hoiW46MYQPB32NRktkFGCbaCzHDIfeR0jvW+lwZmazRcTbSiqRrXZv7rDBpm3h21R
         eunpjMoKx5FXp11tg2jr+nuQxU2t6yiqi6UKs2eicl/JexcFgXUF1fAUEJbsFc3scVtJ
         f3AA==
X-Gm-Message-State: AOAM5334PWyNmkxv1+m6u542u69fzWVNu0HCJWVG+si+mrwv5+edZ6dY
        s5kstj9kmoRKdWD4Uxr6UAvwVQmD5goljw==
X-Google-Smtp-Source: ABdhPJzlCrMGZ+8lx296M4DWxczLFUlW9iOq0TKuxofIvWd7tJiddoGn7si2M9GiShabfsg7/e3Sug==
X-Received: by 2002:a63:1604:: with SMTP id w4mr3167693pgl.148.1602765947882;
        Thu, 15 Oct 2020 05:45:47 -0700 (PDT)
Received: from localhost.localdomain (sau-465d4-or.servercontrol.com.au. [43.250.207.1])
        by smtp.gmail.com with ESMTPSA id f15sm3482850pfk.21.2020.10.15.05.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 05:45:46 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     w@1wt.eu, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] tools: nolibc: Absolute nit,fix a spelling in the comment, huh
Date:   Thu, 15 Oct 2020 18:15:17 +0530
Message-Id: <20201015124517.3524567-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fix a spelling in the comment line.

s/memry/memory/p

This is on linux-next.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 tools/include/nolibc/nolibc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 2551e9b71167..0e39f89e8fe1 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -107,7 +107,7 @@ static int errno;
 #endif

 /* errno codes all ensure that they will not conflict with a valid pointer
- * because they all correspond to the highest addressable memry page.
+ * because they all correspond to the highest addressable memory page.
  */
 #define MAX_ERRNO 4095

--
2.28.0

