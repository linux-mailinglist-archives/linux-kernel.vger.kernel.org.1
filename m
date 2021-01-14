Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997C82F5C25
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 09:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbhANIHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 03:07:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:59004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728116AbhANIGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 03:06:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21762239FF;
        Thu, 14 Jan 2021 08:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610611500;
        bh=WCkk3qjIarwJn0N59RAvMinFzr5jkiWLHm2feTCLHKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=St6QSUILPjTuu4okjzypsvHNmdUBQAvwFuiNqHZzobbhfv3URHm8ZPagQGwE3rFLk
         vEPuWUH0PvAHfb+hdxaprbvXPIuk4ilef9yJlKqDfEpNLQsTJj5VldbFPU99rVVqDX
         dumc2ECCvKixWD1x2ODE1a5QdwLdxL/ACPzCgyzQryD0JXKdGUfZszi897SU2Pi1+4
         ti2sLo6TYqf0YsOEZwEfhc6GRNhIVzfEWghGhEvbw2YYwCOQigvjJiG/YXY+A7fjrb
         JzHVSka+MUdfqug4ENPvAY/ENnNQaJlKwqAYwpEcX4nWMlzKY3wmEdvM0sJ8zWwzpr
         b87RMIJkBjeSw==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzxcn-00EQ6d-WB; Thu, 14 Jan 2021 09:04:58 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 07/16] lib/crc7: fix a kernel-doc markup
Date:   Thu, 14 Jan 2021 09:04:43 +0100
Message-Id: <1963266e84c6fb0154602f276b04887c85f80bd3.1610610937.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610610937.git.mchehab+huawei@kernel.org>
References: <cover.1610610937.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A function has a different name between their prototype
and its kernel-doc markup.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 lib/crc7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/crc7.c b/lib/crc7.c
index 6a848d73e804..3848e313b722 100644
--- a/lib/crc7.c
+++ b/lib/crc7.c
@@ -51,7 +51,7 @@ const u8 crc7_be_syndrome_table[256] = {
 EXPORT_SYMBOL(crc7_be_syndrome_table);
 
 /**
- * crc7 - update the CRC7 for the data buffer
+ * crc7_be - update the CRC7 for the data buffer
  * @crc:     previous CRC7 value
  * @buffer:  data pointer
  * @len:     number of bytes in the buffer
-- 
2.29.2

