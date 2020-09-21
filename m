Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C0A27191F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 04:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgIUCC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 22:02:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34158 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726236AbgIUCC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 22:02:57 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A477B2FCBAD75EBC1A33;
        Mon, 21 Sep 2020 10:02:55 +0800 (CST)
Received: from mdc.huawei.com (10.175.112.208) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 10:02:46 +0800
From:   Chen Jun <chenjun102@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <catalin.marinas@arm.com>, <akpm@linux-foundation.org>,
        <rui.xiang@huawei.com>, <weiyongjun1@huawei.com>
Subject: =?UTF-8?q?=5BPATCH=20-next=200/5=5D=20mm/kmemleak=EF=BC=9Asupport=20for=20percpu=20memory=20leak=20detect?=
Date:   Mon, 21 Sep 2020 02:00:02 +0000
Message-ID: <20200921020007.35803-1-chenjun102@huawei.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.112.208]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the reporting of the percpu chunks leaking problem are not supported.
This patch set introduce this feature.

PATCH 1-2 do some cleanup to current kmemleak.
PATCH 3 make percpu memleak works.
PATCH 4-5 add test case for percpu memleak detector.

Following links are some real cases detected by it:
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=71e843295c680898959b22dc877ae3839cc22470
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=667e57da358f61b6966e12e925a69e42d912e8bb

*** BLURB HERE ***

Chen Jun (1):
  mm/kmemleak-test: Add a test case for alloc_percpu

Wei Yongjun (4):
  mm/kmemleak: make create_object return void
  mm/kmemleak: skip update_checksum for OBJECT_NO_SCAN objects
  mm/kmemleak: Add support for percpu memory leak detect
  mm/kmemleak-test: use %px instead of %p in print

 mm/kmemleak-test.c | 37 ++++++++++++----------
 mm/kmemleak.c      | 79 +++++++++++++++++++++++++++++++++++++---------
 2 files changed, 84 insertions(+), 32 deletions(-)

-- 
2.25.0

