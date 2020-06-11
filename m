Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2F31F6A6A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 16:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbgFKO4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 10:56:34 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5819 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728382AbgFKO4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 10:56:33 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B921F8C62A168E5065F7;
        Thu, 11 Jun 2020 22:56:30 +0800 (CST)
Received: from euler.huawei.com (10.175.124.27) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Thu, 11 Jun 2020 22:56:23 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <acme@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>,
        <Markus.Elfring@web.de>, <cj.chengjian@huawei.com>,
        <chenwandun@huawei.com>
Subject: [PATCH next v2 0/2] fix potential memleak in perf events parser
Date:   Thu, 11 Jun 2020 22:56:03 +0800
Message-ID: <20200611145605.21427-1-chenwandun@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix some memleaks for parse_events_term__sym_hw and parse_events_term__clone.

v1 ==> v2
1. split into two patches
2. add jump targets common exception handling
3. add Fixes tag

Chen Wandun (1):
  perf tools: fix potential memleak in perf events parser

Cheng Jian (1):
  perf tools: fix potential memleak in perf events parser

 tools/perf/util/parse-events.c | 51 ++++++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 8 deletions(-)

-- 
2.17.1

