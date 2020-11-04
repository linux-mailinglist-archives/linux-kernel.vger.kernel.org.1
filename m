Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53E92A6EE1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 21:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732273AbgKDUfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 15:35:04 -0500
Received: from mxout03.lancloud.ru ([89.108.73.187]:33280 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732265AbgKDUfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 15:35:02 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 16436206E802
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: [PATCH 1/2] module: fix up 'kernel-doc' comments
From:   Sergey Shtylyov <s.shtylyov@omprussia.ru>
To:     Jessica Yu <jeyu@kernel.org>, <linux-kernel@vger.kernel.org>
References: <8fe9a7be-9f32-6724-a20f-9659b418f184@omprussia.ru>
Organization: Open Mobile Platform, LLC
Message-ID: <fdec4161-9bcd-ad10-8f18-ccc22b5c0932@omprussia.ru>
Date:   Wed, 4 Nov 2020 23:34:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <8fe9a7be-9f32-6724-a20f-9659b418f184@omprussia.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [213.87.161.212]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1908.lancloud.ru (fd00:f066::208)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some 'kernel-doc' function comments do not fully comply with the specified
format due to:

- missing () after the function name;

- "RETURNS:"/"Returns:" instead of "Return:" when documenting the function's
  result.

- empty line before describing the function's arguments.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omprussia.ru>

---
 kernel/module.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

Index: linux/kernel/module.c
===================================================================
--- linux.orig/kernel/module.c
+++ linux/kernel/module.c
@@ -727,13 +727,12 @@ bool __is_module_percpu_address(unsigned
 }
 
 /**
- * is_module_percpu_address - test whether address is from module static percpu
+ * is_module_percpu_address() - test whether address is from module static percpu
  * @addr: address to test
  *
  * Test whether @addr belongs to module static percpu area.
  *
- * RETURNS:
- * %true if @addr is from module static percpu area
+ * Return: %true if @addr is from module static percpu area
  */
 bool is_module_percpu_address(unsigned long addr)
 {
@@ -957,11 +956,10 @@ static int try_stop_module(struct module
 }
 
 /**
- * module_refcount - return the refcount or -1 if unloading
- *
+ * module_refcount() - return the refcount or -1 if unloading
  * @mod:	the module we're checking
  *
- * Returns:
+ * Return:
  *	-1 if the module is in the process of unloading
  *	otherwise the number of references in the kernel to the module
  */
