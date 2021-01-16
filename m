Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3149B2F8D06
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 11:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbhAPKrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 05:47:00 -0500
Received: from mail.thundersoft.com ([114.242.213.35]:51297 "EHLO
        mail1.thundersoft.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbhAPKq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 05:46:59 -0500
Received: from localhost.localdomain (unknown [192.168.8.81])
        by mail1.thundersoft.com (Postfix) with ESMTPSA id 87E7417A2E6E;
        Sat, 16 Jan 2021 18:46:14 +0800 (CST)
From:   Wesley Zhao <zhaowei1102@thundersoft.com>
To:     akpm@linux-foundation.org
Cc:     andriy.shevchenko@linux.intel.com, keescook@chromium.org,
        tglx@linutronix.de, kerneldev@karsmulder.nl, nivedita@alum.mit.edu,
        joe@perches.com, gpiccoli@canonical.com, aquini@redhat.com,
        gustavoars@kernel.org, zhaowei1102@thundersoft.com,
        ojeda@kernel.org, ndesaulniers@gooogle.com,
        linux-kernel@vger.kernel.org, david@redhat.com,
        dan.j.williams@intel.com, guohanjun@huawei.com,
        mchehab+huawei@kernel.org
Subject: [PATCH v2 2/2] resource: Make it possible to reserve memory on 64bit platform
Date:   Sat, 16 Jan 2021 02:45:04 -0800
Message-Id: <1610793904-64073-1-git-send-email-zhaowei1102@thundersoft.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For now "reserve=" is limitied to 32bit,not available on 64bit
platform,so we change the get_option() to get_option_ull(added in
patch: commit 4b6bfe96265e ("lib/cmdline: add new function
get_option_ull()"))

Signed-off-by: Wesley Zhao <zhaowei1102@thundersoft.com>
---
 kernel/resource.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 833394f9c608..ee2a0e5d196f 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1567,13 +1567,13 @@ static int __init reserve_setup(char *str)
 	static struct resource reserve[MAXRESERVE];
 
 	for (;;) {
-		unsigned int io_start, io_num;
+		unsigned long long io_start, io_num;
 		int x = reserved;
 		struct resource *parent;
 
-		if (get_option(&str, &io_start) != 2)
+		if (get_option_ull(&str, &io_start) != 2)
 			break;
-		if (get_option(&str, &io_num) == 0)
+		if (get_option_ull(&str, &io_num) == 0)
 			break;
 		if (x < MAXRESERVE) {
 			struct resource *res = reserve + x;
-- 
2.7.4

