Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED641E65B8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 17:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404238AbgE1PQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 11:16:35 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:64923 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404142AbgE1PQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 11:16:28 -0400
Received: from fsav108.sakura.ne.jp (fsav108.sakura.ne.jp [27.133.134.235])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 04SFGQWf065430;
        Fri, 29 May 2020 00:16:26 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav108.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav108.sakura.ne.jp);
 Fri, 29 May 2020 00:16:26 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav108.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 04SFGQOM065427
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 29 May 2020 00:16:26 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2] twist: allow converting pr_devel()/pr_debug() into
 snprintf()
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <e3b30905-4497-29b4-4636-a313283dbc56@i-love.sakura.ne.jp>
 <20200528065603.3596-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200528110646.GC11286@linux-b0ei>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <e0d6c04f-7601-51e7-c969-300e938dedc0@i-love.sakura.ne.jp>
Date:   Fri, 29 May 2020 00:16:22 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200528110646.GC11286@linux-b0ei>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/05/28 20:06, Petr Mladek wrote:
> Now, it requires lib/Kconfig.twist that is added by a patch in
> Andrew's tree. One approach is to push this into linux-next
> via Andrew's -mm tree.
> 
> Another possibility would be to remove lib/Kconfig.twist
> changes from this patch and replace
> CONFIG_TWIST_ALWAYS_EVALUATE_PRINTK_ARGUMENTS with
> CONFIG_TWIST_FOR_SYZKALLER_TESTING.
> Then I could push it into linux-next via printk/linux.git tree.

CONFIG_TWIST_FOR_SYZKALLER_TESTING is meant for linux-next only.
But CONFIG_TWIST_KERNEL_BEHAVIOR is meant for Linus's tree.

That is, lib/Kconfig.twist will be there in printk/linux.git tree
after 5.8-rc1. But maybe twist related patches should be gathered
into one tree for easier management.
