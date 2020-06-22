Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2E62043DF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 00:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731448AbgFVWny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 18:43:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731342AbgFVWnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:43:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A6442084D;
        Mon, 22 Jun 2020 22:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592865798;
        bh=meQTT1s1Rrlo1gj4g9dJYjkI+GuEn89kJWoTpmyaJRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1izrvPQC0GjYX7zlidK7URpVGI+874I2alsb71HUWeMAhJA2VCA78flEfJ4B4lNnc
         gxQOwpOjMX/hlltAK5YD9t0LsemJdH7wH7m9Ctb8Q7Y86gI7YBaG5WPsRAahsO4mAh
         mKYzii5d5CADTNEtHbZ3gZCnMxHQCSk306k+tlX8=
From:   Sasha Levin <sashal@kernel.org>
To:     peterz@infradead.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        jolsa@redhat.com, alexey.budankov@linux.intel.com,
        songliubraving@fb.com, acme@redhat.com, allison@lohutok.net,
        sashal@kernel.org
Subject: [PATCH v3 12/14] tools/kernel.h: hide noinstr
Date:   Mon, 22 Jun 2020 18:42:56 -0400
Message-Id: <20200622224258.1208588-13-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200622224258.1208588-1-sashal@kernel.org>
References: <20200622224258.1208588-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After 655389666643 ("vmlinux.lds.h: Create section for protection against
instrumentation") we need to ignore "noinstr" in userspace.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/include/linux/kernel.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
index 5ac493eef4237..39fcbb144a34a 100644
--- a/tools/include/linux/kernel.h
+++ b/tools/include/linux/kernel.h
@@ -126,4 +126,6 @@ static __maybe_unused int system_state;
 
 #define in_nmi() 0
 
+#define noinstr
+
 #endif
-- 
2.25.1

