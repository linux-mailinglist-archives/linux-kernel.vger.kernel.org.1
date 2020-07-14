Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E717D21F563
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 16:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbgGNOvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 10:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728827AbgGNOvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 10:51:07 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDB4C08C5DE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 07:51:04 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a6so22168910wrm.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 07:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xAmlwZf9FF5B+fNw3FLwoudWl6EScDCCxEL7TtadPBI=;
        b=MHULfHb/qq2DdPxVtZdND+73JTuMCaIpc5HvzUeGk6dbIqMsJzHFttAq159KGZhl+E
         uc32b1iIIALtw+ydZp8fFCVf22oX/ZdWCauKax3caYhdVkySmLHWnfqsCdIC72Zkwchc
         0HSG5fFKVugqRl0OpEK9Pw86gfD9D3MreYxK7XhNMk+0Inko/tj6sj1308edItjH6uo6
         E5+EcxAVfNcEsuIU/t2HPJ2VjGAKGSOfJyddVycUripolPiZXCNSEbtHOJSdnPoQdyBC
         z5kKNMEq5B9YxP3pmvcBN6urA6s4KBar6ixz9U4qx3EMF/Ca6qnZHRoNaYFvLzVkUo89
         chLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xAmlwZf9FF5B+fNw3FLwoudWl6EScDCCxEL7TtadPBI=;
        b=rDCqN7agqKyEnIaLgQvO/dvNtISPlif66WRnola9Of63znsPAf1CQepH6AKzwL2ZGT
         4LX3irzGwZKkTwkYTf4p6P9WfN7nN2bUBsq5Xe/RWjE5GCzp5vcsawycJjeBAr3/SXyW
         u+TpNsIEYrYalWA+IpYrNnUEJrghIN02v02ljqRDGJO7+pcw4hDqA+NZoCXZ0L6u7I1s
         3iQxEfz+DUoWCl4WTVkjoZ5bnHVEBDv2zC6S+kFQPd1RjwmqBfT3NJB42fN67s+ia8OI
         TNKzeBHZteO8PrjQfAbm9RyNfEIkUfNwwQjM/FBRuBeX/G+KmPvTux+/1v3yiT+GmOpv
         rbdw==
X-Gm-Message-State: AOAM5335Zwjd+MOwjl1nXnGFOimvF+ut8dClaXa7VF931bPnPCG2wcKO
        GVxQ2xy3iZs4TNyzQ1ZuAd6GNA==
X-Google-Smtp-Source: ABdhPJyoziaq49v5CTUiEUg6/TO+E0QrGY8bGLFPGBYZLqb4ZcvlqiI8gGMCMznhtGm8VhY3kHmpDA==
X-Received: by 2002:adf:82f5:: with SMTP id 108mr6085256wrc.218.1594738263620;
        Tue, 14 Jul 2020 07:51:03 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id a84sm4653305wmh.47.2020.07.14.07.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 07:51:03 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Andreas Herrmann <herrmann.der.user@googlemail.com>,
        Dominik Brodowski <linux@brodo.de>,
        Pavel Machek <pavel@ucw.cz>,
        Paul Devriendt <paul.devriendt@amd.com>,
        Mark Langsdorf <mark.langsdorf@amd.com>
Subject: [PATCH 10/13] cpufreq: powernow-k8: Make use of known set but not used variables
Date:   Tue, 14 Jul 2020 15:50:46 +0100
Message-Id: <20200714145049.2496163-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714145049.2496163-1-lee.jones@linaro.org>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we fail to use a variable, even a 'dummy' one, then the compiler
complains that it is set but not used.  We know this is fine, so we
set it to its own value here.

Fixes the following W=1 kernel build warning(s):

 drivers/cpufreq/powernow-k8.c: In function ‘pending_bit_stuck’:
 drivers/cpufreq/powernow-k8.c:89:10: warning: variable ‘hi’ set but not used [-Wunused-but-set-variable]
 89 | u32 lo, hi;
 | ^~
 drivers/cpufreq/powernow-k8.c: In function ‘core_voltage_pre_transition’:
 drivers/cpufreq/powernow-k8.c:285:14: warning: variable ‘lo’ set but not used [-Wunused-but-set-variable]
 285 | u32 maxvid, lo, rvomult = 1;
 | ^~

Cc: Andreas Herrmann <herrmann.der.user@googlemail.com>
Cc: Dominik Brodowski <linux@brodo.de>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Paul Devriendt <paul.devriendt@amd.com>
Cc: Mark Langsdorf <mark.langsdorf@amd.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/cpufreq/powernow-k8.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
index 3984959eed1d5..b76df81044c4f 100644
--- a/drivers/cpufreq/powernow-k8.c
+++ b/drivers/cpufreq/powernow-k8.c
@@ -89,6 +89,7 @@ static int pending_bit_stuck(void)
 	u32 lo, hi;
 
 	rdmsr(MSR_FIDVID_STATUS, lo, hi);
+	hi &= hi; /* Silence set but not used warning */
 	return lo & MSR_S_LO_CHANGE_PENDING ? 1 : 0;
 }
 
@@ -292,6 +293,7 @@ static int core_voltage_pre_transition(struct powernow_k8_data *data,
 		rvomult = 2;
 	rvosteps *= rvomult;
 	rdmsr(MSR_FIDVID_STATUS, lo, maxvid);
+	lo &= lo; /* Silence set but not used warning */
 	maxvid = 0x1f & (maxvid >> 16);
 	pr_debug("ph1 maxvid=0x%x\n", maxvid);
 	if (reqvid < maxvid) /* lower numbers are higher voltages */
-- 
2.25.1

