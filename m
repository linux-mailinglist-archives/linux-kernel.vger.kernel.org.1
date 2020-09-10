Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18BD263C80
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 07:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgIJFgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 01:36:04 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:48508 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725855AbgIJFgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 01:36:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=1;SR=0;TI=SMTPD_---0U8T1QsA_1599716159;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U8T1QsA_1599716159)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 10 Sep 2020 13:35:59 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] lib/mpi: remove A_LIMB_1
Date:   Thu, 10 Sep 2020 13:35:57 +0800
Message-Id: <1599716157-2826-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 7cf4206a99d1b3 Remove unused code from MPI library, the
macro is not used anymore.

Remove it to tame gcc warning:
../lib/mpi/mpi-bit.c:24: warning: macro "A_LIMB_1" is not used
[-Wunused-macros]

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org 
---
 lib/mpi/mpi-bit.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/mpi/mpi-bit.c b/lib/mpi/mpi-bit.c
index 503537e08436..18030a01494f 100644
--- a/lib/mpi/mpi-bit.c
+++ b/lib/mpi/mpi-bit.c
@@ -21,8 +21,6 @@
 #include "mpi-internal.h"
 #include "longlong.h"
 
-#define A_LIMB_1 ((mpi_limb_t) 1)
-
 /****************
  * Sometimes we have MSL (most significant limbs) which are 0;
  * this is for some reasons not good, so this function removes them.
-- 
1.8.3.1

