Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D420327228C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 13:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgIULaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 07:30:35 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13795 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726457AbgIULaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 07:30:35 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7D983B3294659409B620;
        Mon, 21 Sep 2020 19:30:33 +0800 (CST)
Received: from huawei.com (10.175.112.208) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Mon, 21 Sep 2020
 19:30:24 +0800
From:   Wang Wensheng <wangwensheng4@huawei.com>
To:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <npiggin@gmail.com>, <gwalbon@linux.ibm.com>,
        <renesas@glider.be>, <wangwensheng4@huawei.com>,
        <jniethe5@gmail.com>, <yuehaibing@huawei.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] powerpc/security: Fix symbol undeclared warning
Date:   Mon, 21 Sep 2020 11:27:45 +0000
Message-ID: <20200921112745.85968-1-wangwensheng4@huawei.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.208]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build kernel with `C=2`:
arch/powerpc/kernel/security.c:253:6: warning: symbol 'stf_barrier' was
not declared. Should it be static?

Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
---
 arch/powerpc/kernel/security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index c9876aab3142..fbcd5611a67e 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -250,7 +250,7 @@ ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr, c
 
 static enum stf_barrier_type stf_enabled_flush_types;
 static bool no_stf_barrier;
-bool stf_barrier;
+static bool stf_barrier;
 
 static int __init handle_no_stf_barrier(char *p)
 {
-- 
2.25.0

