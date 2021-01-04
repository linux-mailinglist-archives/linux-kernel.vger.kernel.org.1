Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F57E2E93F5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 12:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbhADLJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 06:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbhADLJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 06:09:39 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E8DC061793
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 03:08:58 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id j13so10670211pjz.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 03:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0ItdJ1LSMf4LRTA/k0/t7wHPApah3k0HwfaJy6Rm24k=;
        b=UVeGTkLNW3QsjKoVK74gXQRlBo4Ov2BKdPZ/14HAPDcjC3JHuHYynnsA75EFLJxVyH
         KgV6OUzhbozrKbOfhG6W/CKzJoC9Koa2nWw3Og17AvUiCSWAj9uMDxoFZPTWwGDpKS64
         08hSoD+HHb/Pcfe0j5j0XRTtx7ref1UL4uvT6zYijjlyjDoS2do36iaremLFZ6r2SQbm
         B4Hg+limvE6Z4Go3Kt3TysSm0m0CToH6E3QkpEbStkqZDukHNSvGmGRzCsncwxvqgw4u
         ry2V6riOccoaugLbAKpHcc1EOAhPqn+rVz3zK2IE2+B2ozVrMT1Flui1EFBKawdGOK98
         r9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0ItdJ1LSMf4LRTA/k0/t7wHPApah3k0HwfaJy6Rm24k=;
        b=ans7K0fSkXiO/pc42rfFeeIBaBEONc+160kZD/8Q61zA7H/V8x2Mr6XTWe4MbOKPxd
         Fqouv0awxuFEeRd/G7tprr2ntn1hjmo/lgB7mEsYG//cCScvN7GYjiALGit9FHOR2Z7Q
         jnwea+W1BpNTFD7pIVVVFyghSUXkdS7C0qGwxFQRNgU6yBrslsR4h4x9riNgZFLCecHP
         bCqVvQ6YOOa/xtPL+6VBS0Qq3zdG9qiiKFCFHIapTZjXG9SkP6FjYUdpsI+NTbUjchf3
         K2F0nooUzLMeUHnzRnB3zr1W5txW1b1RZBFEqU9cKyYRHohiEz3vlMLSxzO/ygsPba6d
         F8hg==
X-Gm-Message-State: AOAM533DvZrb59g7fTQvtl+aiHpXDnLhs2cWfZ3xZyPx/YEq0D3GK/PC
        VbMXbn2zG3iRVjNi7laq+5Q=
X-Google-Smtp-Source: ABdhPJwjQaTr+e4DfDjdr7lfP/IyVO6UXm7et2jChW45sk7RSiJ51nlRm1ZFvIktKx5dnq6slPVORw==
X-Received: by 2002:a17:902:42:b029:da:e72b:fe9e with SMTP id 60-20020a1709020042b02900dae72bfe9emr73046403pla.31.1609758538375;
        Mon, 04 Jan 2021 03:08:58 -0800 (PST)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id 9sm40705121pfn.188.2021.01.04.03.08.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jan 2021 03:08:57 -0800 (PST)
From:   zhouchuangao <chuangaozhou@gmail.com>
X-Google-Original-From: zhouchuangao <zhouchuangao@xiaomi.com>
To:     fenghua.yu@intel.com, reinette.chatre@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org,
        zhouchuangao <zhouchuangao@xiaomi.com>
Subject: [PATCH] x86/kernel/cpu/resctrl: replace 'of->kn->priv' with of_rft()
Date:   Mon,  4 Jan 2021 19:08:53 +0800
Message-Id: <1609758533-14337-1-git-send-email-zhouchuangao@xiaomi.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of 'of->kn->priv' to get rftype can be found in several
places in arch/x86/kernel/cpu/resctrl/rdtgroup.c, which may reduce
readability.

So replace the direct use 'of->kn->priv' with inline function
of_rft(), which is more readable.

Signed-off-by: zhouchuangao <zhouchuangao@xiaomi.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h | 5 +++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 6 +++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index ee71c47..f684b6d 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -409,6 +409,11 @@ struct rdt_membw {
 	u32				*mb_map;
 };
 
+static inline struct rftype *of_rft(struct kernfs_open_file *of)
+{
+	return of->kn->priv;
+}
+
 static inline bool is_llc_occupancy_enabled(void)
 {
 	return (rdt_mon_features & (1 << QOS_L3_OCCUP_EVENT_ID));
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 29ffb95..b0ea6fc 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -222,7 +222,7 @@ static int rdtgroup_add_file(struct kernfs_node *parent_kn, struct rftype *rft)
 static int rdtgroup_seqfile_show(struct seq_file *m, void *arg)
 {
 	struct kernfs_open_file *of = m->private;
-	struct rftype *rft = of->kn->priv;
+	struct rftype *rft = of_rft(of);
 
 	if (rft->seq_show)
 		return rft->seq_show(of, m, arg);
@@ -232,7 +232,7 @@ static int rdtgroup_seqfile_show(struct seq_file *m, void *arg)
 static ssize_t rdtgroup_file_write(struct kernfs_open_file *of, char *buf,
 				   size_t nbytes, loff_t off)
 {
-	struct rftype *rft = of->kn->priv;
+	struct rftype *rft = of_rft(of);
 
 	if (rft->write)
 		return rft->write(of, buf, nbytes, off);
@@ -253,7 +253,7 @@ static const struct kernfs_ops kf_mondata_ops = {
 
 static bool is_cpu_list(struct kernfs_open_file *of)
 {
-	struct rftype *rft = of->kn->priv;
+	struct rftype *rft = of_rft(of);
 
 	return rft->flags & RFTYPE_FLAGS_CPUS_LIST;
 }
-- 
2.7.4

