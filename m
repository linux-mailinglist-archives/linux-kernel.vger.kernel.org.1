Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7752F1CBE18
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 08:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbgEIGhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 May 2020 02:37:03 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4367 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728898AbgEIGhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 02:37:01 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 27FAF6B2CE454D2DEB60;
        Sat,  9 May 2020 14:36:58 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Sat, 9 May 2020 14:36:47 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 0/3] seq_file: Introduce DEFINE_SEQ_ATTRIBUTE() helper macro
Date:   Sat, 9 May 2020 14:40:28 +0800
Message-ID: <20200509064031.181091-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As discussion in https://lore.kernel.org/lkml/20191129222310.GA3712618@kroah.com/,
we could introduce a new helper macro to reduce losts of boilerplate
code, vmstat and kprobes is the example which covert to use it, if
this is accepted, I will send out more clean ups.

Kefeng Wang (3):
  seq_file: Introduce DEFINE_SEQ_ATTRIBUTE() helper macro
  mm: vmstat: Convert to use DEFINE_SEQ_ATTRIBUTE macro
  kernel: kprobes: Convert to use DEFINE_SEQ_ATTRIBUTE macro

 include/linux/seq_file.h | 19 +++++++++++++++++++
 kernel/kprobes.c         | 33 ++++++---------------------------
 mm/vmstat.c              | 32 ++++++--------------------------
 3 files changed, 31 insertions(+), 53 deletions(-)

-- 
2.26.2

