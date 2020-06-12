Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604CE1F75EF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 11:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgFLJ2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jun 2020 05:28:53 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:33443 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726357AbgFLJ2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 05:28:53 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U.LF6lt_1591954130;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U.LF6lt_1591954130)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 12 Jun 2020 17:28:50 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH 0/4] tracing: cleanup trace event macro
Date:   Fri, 12 Jun 2020 17:28:40 +0800
Message-Id: <20200612092844.56107-1-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TRACE_EVENT definition is some kind of magic. We define/un-define some
elements to implement it.

During the code reading, I found there are some redundant definition of the
macro. Let's reform and remove some of them.

Wei Yang (4):
  tracing: not necessary to undefine DEFINE_EVENT again
  tracing: not necessary re-define DEFINE_EVENT_PRINT
  tracing: define DEFINE_EVENT_PRINT not related to DEFINE_EVENT
  tracing: not necessary to define DEFINE_EVENT_PRINT to be empty again

 include/trace/trace_events.h | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

-- 
2.20.1 (Apple Git-117)

