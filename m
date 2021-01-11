Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B702F1B45
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 17:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389033AbhAKQmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 11:42:40 -0500
Received: from mail.thundersoft.com ([114.242.213.61]:36452 "EHLO
        mail2.thundersoft.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1728302AbhAKQmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 11:42:39 -0500
Received: from localhost.localdomain (unknown [192.168.8.82])
        by mail2.thundersoft.com (Postfix) with ESMTPSA id 28043E608BA;
        Tue, 12 Jan 2021 00:34:50 +0800 (CST)
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
Subject: [PATCH 2/2] resource: Make it possible to reserve memory on 64bit platform
Date:   Mon, 11 Jan 2021 08:33:18 -0800
Message-Id: <1610382798-4528-2-git-send-email-zhaowei1102@thundersoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610382798-4528-1-git-send-email-zhaowei1102@thundersoft.com>
References: <1610382798-4528-1-git-send-email-zhaowei1102@thundersoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Wesley.Zhao" <zhaowei1102@thundersoft.com>

For now "reserve=" is limitied to 32bit,not available on 64bit
platform,so we change the get_option() to get_option_ull(added in
patch: commit 4b6bfe96265e ("lib/cmdline: add new function
get_option_ull()"))

Signed-off-by: Wesley.Zhao <zhaowei1102@thundersoft.com>
---
 kernel/resource.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 833394f..ee2a0e5 100644
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

