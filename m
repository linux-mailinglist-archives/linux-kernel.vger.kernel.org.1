Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CDF28AD59
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 06:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgJLEuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 00:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgJLEuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 00:50:16 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20733C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 21:50:16 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f19so12392514pfj.11
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 21:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5EKZs60ksc+C2mu0NsIjhHU08u0xHxXWsdgv8V8eFP0=;
        b=Li52b2kHX9x7ticLBS6QsQ9odgPel9CR8bmvd0J2IN4ss5soWyxOpqU2jbJeDsr/jv
         RLmf3LOU6o32xIuqRBWOO6bHY++nXMGO50y+0mWjuMHtZ+RcEKArkPygJgPJFMi0+uPS
         iB0QFKRKza4OQzr7qkVA5yFzitUPVjyIsamhm6+6873ZL+AcrsoJLYvX5LsBLE+4LTzw
         qjG6zGHmmuIi1eUEWnkgQfvGJtc3q3XUeGpmuFKediuL8+rdekQ9lHbiZQ3S5AiD2B+K
         qU2LGCw2Cp7xCsEIfCkFWCXUFDJ8uUE3rzkYa7IOHrDklrCqLpEtJWZkodF+VZlXm3pe
         yvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5EKZs60ksc+C2mu0NsIjhHU08u0xHxXWsdgv8V8eFP0=;
        b=VxQm4PB/HM8H1BGK8eOkdDfeCHspp/F2mT2OJcGpKdj7HWTPXfwVnJmMxbWE4eWNI8
         WwHj7yytjrvHlpLvqHXdbBQukhkQtzkSEEKH/7/KxYfbxY3kgggLRLUEf/XBnWSQ6B5C
         OzQ/Qll+HS/RvSaejBGosM3xbWs6YXdVufHogMELDE0/+xsyd9CaLT7LEqngaxoiGS2Y
         WmFxi4c07tqbCoK1Hjtkos0gXnWubkjVq+RmNq1634csFYyCsDKEeAqvT1TIPBADi2LZ
         kzAZ7h5E2hLFRG20GyhNic53UFDKx3i+jsTxWKHF779D2mUwelmh8QSCpLR1fTlrHQm0
         Cgtg==
X-Gm-Message-State: AOAM530vGu4hN6nYHRn0HmhL+b94vDeNfoZS8sj/YTE4NQwDzI3/iNJW
        G+Y4hKfQFrSlAyc4TlpHCBG6pQ==
X-Google-Smtp-Source: ABdhPJwgPGyOize8k9X+CFBTrgh9pPEeE3nVg6DLQfoivM2ZpN/FvLmtpOFwEwo4Op6xTL2lxrI31A==
X-Received: by 2002:a17:90a:6f21:: with SMTP id d30mr17643381pjk.165.1602478215616;
        Sun, 11 Oct 2020 21:50:15 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id s20sm13091945pfc.201.2020.10.11.21.50.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Oct 2020 21:50:14 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel test robot <lkp@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: stats: Fix string format specifier mismatch
Date:   Mon, 12 Oct 2020 10:20:07 +0530
Message-Id: <9c499a132d06f31e81a516c91bd92d619eb118ba.1602478204.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following warning:

drivers/cpufreq/cpufreq_stats.c:63:10: warning: %d in format string (no.
1) requires 'int' but the argument type is 'unsigned int'

Fixes: 40c3bd4cfa6f ("cpufreq: stats: Defer stats update to cpufreq_stats_record_transition()")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 1b1389face85..6cd5c8ab5d49 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -62,7 +62,7 @@ static ssize_t show_total_trans(struct cpufreq_policy *policy, char *buf)
 	if (READ_ONCE(stats->reset_pending))
 		return sprintf(buf, "%d\n", 0);
 	else
-		return sprintf(buf, "%d\n", stats->total_trans);
+		return sprintf(buf, "%u\n", stats->total_trans);
 }
 cpufreq_freq_attr_ro(total_trans);
 
-- 
2.25.0.rc1.19.g042ed3e048af

