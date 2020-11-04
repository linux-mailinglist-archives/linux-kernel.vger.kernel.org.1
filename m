Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6842A6EE2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 21:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731552AbgKDUfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 15:35:55 -0500
Received: from mxout04.lancloud.ru ([89.108.124.63]:39994 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgKDUfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 15:35:54 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 548DB20510B0
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: [PATCH 2/2] module: add more 'kernel-doc' comments
From:   Sergey Shtylyov <s.shtylyov@omprussia.ru>
To:     Jessica Yu <jeyu@kernel.org>, <linux-kernel@vger.kernel.org>
References: <8fe9a7be-9f32-6724-a20f-9659b418f184@omprussia.ru>
Organization: Open Mobile Platform, LLC
Message-ID: <8e1e5391-c6ef-a403-a4c7-573cff9e8984@omprussia.ru>
Date:   Wed, 4 Nov 2020 23:35:51 +0300
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

Some functions have the proper 'kernel-doc' comments but these don't start
with proper /** -- fix that, along with adding () to the function name on
the following lines to fully comply with the 'kernel-doc' format.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omprussia.ru>

---
 kernel/module.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

Index: linux/kernel/module.c
===================================================================
--- linux.orig/kernel/module.c
+++ linux/kernel/module.c
@@ -4491,8 +4491,8 @@ out:
 	return e;
 }
 
-/*
- * is_module_address - is this address inside a module?
+/**
+ * is_module_address() - is this address inside a module?
  * @addr: the address to check.
  *
  * See is_module_text_address() if you simply want to see if the address
@@ -4509,8 +4509,8 @@ bool is_module_address(unsigned long add
 	return ret;
 }
 
-/*
- * __module_address - get the module which contains an address.
+/**
+ * __module_address() - get the module which contains an address.
  * @addr: the address.
  *
  * Must be called with preempt disabled or module mutex held so that
@@ -4534,8 +4534,8 @@ struct module *__module_address(unsigned
 	return mod;
 }
 
-/*
- * is_module_text_address - is this address inside module code?
+/**
+ * is_module_text_address() - is this address inside module code?
  * @addr: the address to check.
  *
  * See is_module_address() if you simply want to see if the address is
@@ -4553,8 +4553,8 @@ bool is_module_text_address(unsigned lon
 	return ret;
 }
 
-/*
- * __module_text_address - get the module whose code contains an address.
+/**
+ * __module_text_address() - get the module whose code contains an address.
  * @addr: the address.
  *
  * Must be called with preempt disabled or module mutex held so that
