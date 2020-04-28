Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931FB1BC516
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 18:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgD1QYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 12:24:10 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:63502 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbgD1QYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 12:24:10 -0400
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 03SGNTwR043009;
        Wed, 29 Apr 2020 01:23:29 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav301.sakura.ne.jp);
 Wed, 29 Apr 2020 01:23:29 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav301.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 03SGNNE4042973
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 29 Apr 2020 01:23:29 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: Add loglevel for "do not print to consoles".
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Yafang Shao <laoar.shao@gmail.com>
References: <20200424024239.63607-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200425004609.GE8982@jagdpanzerIV.localdomain>
 <842ff40b-a232-6098-4333-996a3033b30a@i-love.sakura.ne.jp>
 <20200427062117.GC486@jagdpanzerIV.localdomain>
 <4dae86af-1d9a-f5a8-cff6-aa91ec038a79@i-love.sakura.ne.jp>
 <20200428121828.GP28637@dhcp22.suse.cz>
 <b4d74234-8009-9ffd-011f-bd5d1a4b85f6@i-love.sakura.ne.jp>
 <20200428154532.GU28637@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <b1d507b1-dae7-f526-c74a-d465ddecea6a@i-love.sakura.ne.jp>
Date:   Wed, 29 Apr 2020 01:23:15 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428154532.GU28637@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/04/29 0:45, Michal Hocko wrote:
> On Tue 28-04-20 22:11:19, Tetsuo Handa wrote:
>> Existing KERN_$LEVEL allows a user to determine whether he/she wants that message
>> to be printed on consoles (even if it spams his/her operation doing on consoles), and
>> at the same time constrains that user whether that message is saved to log files.
>> KERN_NO_CONSOLES allows a user to control whether he/she wants that message to be
>> saved to log files (without spamming his/her operation doing on consoles).
> 
> I understand that. But how do I know whether the user considers the
> particular information important enough to be dumped on the console.
> This sounds like a policy in the kernel to me.

I'm still unable to understand your question.

>                                                I simply cannot forsee
> any console configuration to tell whether my information is going to
> swamp the console to no use or not.

Neither can I.

>                                     Compare that to KERN_$LEVEL instead.
> I know that an information is of low/high importance. It is the user
> policy to decide and base some filtering on top of that priority.

Whether to use KERN_NO_CONSOLES is not per-importance basis but per-content basis.

Since both pr_info("[%7d] %5d %5d %8lu %8lu %8ld %8lu         %5hd %s\n", ...) from dump_tasks() and
pr_info("oom-kill:constraint=%s,nodemask=%*pbl", ...) from dump_oom_summary() use KERN_INFO importance,
existing KERN_$LEVEL-based approach cannot handle these messages differently. Since changing the former to
e.g. KERN_DEBUG will cause userspace to discard the messages, we effectively can't change KERN_$LEVEL.
If the kernel allows the former to use KERN_NO_CONSOLES in addition to KERN_INFO, the administrator can
select from two choices: printing "both the former and the latter" or "only the latter" to consoles.

