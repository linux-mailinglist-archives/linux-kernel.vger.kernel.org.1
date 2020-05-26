Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F45E1D7996
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 15:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgERNUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 09:20:07 -0400
Received: from foss.arm.com ([217.140.110.172]:40412 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727917AbgERNTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 09:19:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DFC2101E;
        Mon, 18 May 2020 06:19:41 -0700 (PDT)
Received: from melchizedek.cambridge.arm.com (melchizedek.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E31863F305;
        Mon, 18 May 2020 06:19:39 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        James Morse <james.morse@arm.com>
Subject: [PATCH v3 05/10] x86/resctrl: Include pid.h
Date:   Mon, 18 May 2020 14:19:18 +0100
Message-Id: <20200518131924.7741-6-james.morse@arm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200518131924.7741-1-james.morse@arm.com>
References: <20200518131924.7741-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are about to disturb the header soup. This header uses struct pid
and struct pid_namespace. Include their header.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 include/linux/resctrl.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index daf5cf64c6a6..9b05af9b3e28 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -2,6 +2,8 @@
 #ifndef _RESCTRL_H
 #define _RESCTRL_H
 
+#include <linux/pid.h>
+
 #ifdef CONFIG_PROC_CPU_RESCTRL
 
 int proc_resctrl_show(struct seq_file *m,
-- 
2.19.1

