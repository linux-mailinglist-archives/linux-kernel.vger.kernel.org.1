Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9CA1E4400
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 15:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388532AbgE0NlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 09:41:02 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:53082 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387627AbgE0NlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:41:02 -0400
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 04RDf0IC022702;
        Wed, 27 May 2020 22:41:00 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav405.sakura.ne.jp);
 Wed, 27 May 2020 22:41:00 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav405.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 04RDexlT022667
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 27 May 2020 22:40:59 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] twist: allow converting pr_devel()/pr_debug() into
 printk(KERN_DEBUG)
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     kbuild test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20200524145034.10697-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <202005271707.bUYELlt7%lkp@intel.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <e4766ed8-905e-faf0-fcbf-3c806ef2b267@i-love.sakura.ne.jp>
Date:   Wed, 27 May 2020 22:41:00 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <202005271707.bUYELlt7%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 3406a1853564618f167a5d0a815f174d2fb295f5 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Wed, 27 May 2020 22:34:50 +0900
Subject: [PATCH] dev_printk: Explicitly include dynamic_debug.h

While printk.h included dynamic_debug.h before pr_debug(), dev_printk.h
did not include it before dynamic_dev_dbg(). Include it in dev_printk.h
in case future patch touches CONFIG_DYNAMIC_DEBUG case in printk.h .

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 include/linux/dev_printk.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/dev_printk.h b/include/linux/dev_printk.h
index 5aad06b4ca7b..69f0b3708eaf 100644
--- a/include/linux/dev_printk.h
+++ b/include/linux/dev_printk.h
@@ -110,6 +110,7 @@ void _dev_info(const struct device *dev, const char *fmt, ...)
 	_dev_info(dev, dev_fmt(fmt), ##__VA_ARGS__)
 
 #if defined(CONFIG_DYNAMIC_DEBUG)
+#include <linux/dynamic_debug.h>
 #define dev_dbg(dev, fmt, ...)						\
 	dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
 #elif defined(DEBUG)
-- 
2.18.2

