Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98D62043DC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 00:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731432AbgFVWnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 18:43:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:60050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731357AbgFVWnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:43:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D50EB20888;
        Mon, 22 Jun 2020 22:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592865800;
        bh=GirLEaU2UtwQcwdoezaA/I2WCWcjM942s/RMh81s37k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yEo/32JH+2gRXYmU+FfqsxOoEmGqMUKYiPay5N9YvmAWj131zwVMnsxlq1bltf+XX
         96bDw2uIsrms1oQzr0tPsNaLAOmxQIJMR6g9YUHZfmcdKwAFHE0efTW/Q4onqc4bMa
         RWP5ikqcB8NYjtr4CkAnKqlQ/NJaVC+CVXnKxd6g=
From:   Sasha Levin <sashal@kernel.org>
To:     peterz@infradead.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        jolsa@redhat.com, alexey.budankov@linux.intel.com,
        songliubraving@fb.com, acme@redhat.com, allison@lohutok.net,
        sashal@kernel.org
Subject: [PATCH v3 14/14] tools/kernel.h: hide task_struct.hardirq_chain_key
Date:   Mon, 22 Jun 2020 18:42:58 -0400
Message-Id: <20200622224258.1208588-15-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200622224258.1208588-1-sashal@kernel.org>
References: <20200622224258.1208588-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a result of c86e9b987cea ("lockdep: Prepare for noinstr sections") we need
to hide hardirq_chain_key from userspace to avoid a build error.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/include/linux/lockdep.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/linux/lockdep.h b/tools/include/linux/lockdep.h
index 4e5f31f28ca3e..b6c9e81eb45e5 100644
--- a/tools/include/linux/lockdep.h
+++ b/tools/include/linux/lockdep.h
@@ -40,6 +40,7 @@ struct task_struct {
 	unsigned long hardirq_disable_ip, hardirq_enable_ip;
 	unsigned int hardirq_disable_event, hardirq_enable_event;
 	int softirq_context, hardirq_context;
+	unsigned long hardirq_chain_key;
 	char comm[17];
 };
 
-- 
2.25.1

