Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA6B1A3E24
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 04:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgDJCVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 22:21:37 -0400
Received: from [106.54.107.2] ([106.54.107.2]:60556 "EHLO mail.kaowomen.cn"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbgDJCVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 22:21:36 -0400
Received: by mail.kaowomen.cn (Postfix, from userid 1001)
        id 2783D41329; Fri, 10 Apr 2020 10:21:33 +0800 (CST)
Date:   Fri, 10 Apr 2020 10:21:33 +0800
From:   Bo YU <tsu.yubo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     tsu.yubo@gmail.com
Subject: [PATCH -next] include/linux: remove duplicated kernel.h from
 nodemask.h
Message-ID: <20200410022133.mx3xyqb4f3l6asjb@kaowomen.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has included kernel.h in bitmap.h,so maybe it is safe to remove
kernel.h here

Signed-off-by: Bo YU <tsu.yubo@gmail.com>
---
 include/linux/nodemask.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 27e7fa36f707..980b48e05d05 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -46,7 +46,7 @@
  * int next_node(node, mask)		Next node past 'node', or MAX_NUMNODES
  * int next_node_in(node, mask)		Next node past 'node', or wrap to first,
  *					or MAX_NUMNODES
- * int first_unset_node(mask)		First node not set in mask, or
+ * int first_unset_node(mask)		First node not set in mask, or
  *					MAX_NUMNODES
  *
  * nodemask_t nodemask_of_node(node)	Return nodemask with bit 'node' set
@@ -90,7 +90,6 @@
  * for such situations. See below and CPUMASK_ALLOC also.
  */

-#include <linux/kernel.h>
 #include <linux/threads.h>
 #include <linux/bitmap.h>
 #include <linux/numa.h>
--
2.11.0

