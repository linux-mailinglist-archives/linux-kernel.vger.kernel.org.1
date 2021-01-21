Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5221C2FE371
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbhAUHDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:03:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:36824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbhAUG7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 01:59:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00A26239FC;
        Thu, 21 Jan 2021 06:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611212250;
        bh=WJvWrFK9fc75sCSmuE1qEYnR4t588PoUxstOjbsDInU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XrtyMOUFnTVGe7agfKhHviDT2vplCTL2PA3eyN8maMstspteejSjITPmPIKBc0x1G
         YtteVnbH1cfzB4k3lQ7r0XCrVbgjS2qS7HN/rNPaEUNEyVKbtjlAMLKgFSYI1hFg7Y
         B8idC093oxruxnWJcYfXgaPD5pdBtyCWapaWOULu3AUkywV+UrNkrSXlA7flJOHA++
         5YwMpEnOAZRXIyP2P00O/VsEeKsaGB1Rwac7hpZ/96//fo6M0UonSYj1amlk34AW5S
         ivm/yPOE3SbeSZPC8vSiD1LdQ5XFEFgsVl1pRS86EIoDwooWqowQsDu0nZuBw3uR/C
         BppfjwHQJXBHg==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Tian Tao <tiantao6@hisilicon.com>,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 22/29] csky: remove unused including <linux/version.h>
Date:   Thu, 21 Jan 2021 14:53:42 +0800
Message-Id: <20210121065349.3188251-22-guoren@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210121065349.3188251-1-guoren@kernel.org>
References: <20210121065349.3188251-1-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tian Tao <tiantao6@hisilicon.com>

Remove including <linux/version.h> that don't need it.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/include/asm/thread_info.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/csky/include/asm/thread_info.h b/arch/csky/include/asm/thread_info.h
index 21456a3737c2..f704e271a87a 100644
--- a/arch/csky/include/asm/thread_info.h
+++ b/arch/csky/include/asm/thread_info.h
@@ -6,7 +6,6 @@
 
 #ifndef __ASSEMBLY__
 
-#include <linux/version.h>
 #include <asm/types.h>
 #include <asm/page.h>
 #include <asm/processor.h>
-- 
2.17.1

