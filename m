Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191CD25FA2B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 14:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgIGMKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 08:10:31 -0400
Received: from mail.jv-coder.de ([5.9.79.73]:55338 "EHLO mail.jv-coder.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729187AbgIGMEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 08:04:02 -0400
Received: from [10.61.40.7] (unknown [37.156.92.209])
        by mail.jv-coder.de (Postfix) with ESMTPSA id 2595EA3403;
        Mon,  7 Sep 2020 12:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
        t=1599480190; bh=mlFsmUb7LLf8/PbsCfLKGQ+uAfdEnCoK/RJuKas2Gp8=;
        h=Subject:To:From:Message-ID:Date:MIME-Version;
        b=qEJ5iZoJTRhjMPu+QVg44SLjHZmgHiuTvorhFEVYUs7O+4ovLjkA6CZefmsj8JDjF
         Oet+WKkjszU5A6AzBERB1Ez3ikJP9O5Koy6whuBNnyRyXW0vPblt5OoHRQ2fIcRk1X
         sYc5GLfB95aWxWtLXyOKha4Ds8ad1IxvyDwoe77o=
Subject: Re: [BUG RT] dump-capture kernel not executed for panic in interrupt
 context
To:     peterz@infradead.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org,
        Joerg Vehlow <joerg.vehlow@aox-tech.de>
References: <2c243f59-6d10-7abb-bab4-e7b1796cd54f@jv-coder.de>
 <20200528084614.0c949e8d@gandalf.local.home>
 <cbbf7926-148e-7acb-dc03-3f055d73364b@jv-coder.de>
 <20200727163655.8c94c8e245637b62311f5053@linux-foundation.org>
 <c6b095af-fc92-420f-303f-d2efd9f28873@jv-coder.de>
 <20200821110848.6c3183d1@oasis.local.home>
 <20200821134753.9547695c9b782275be3c95b5@linux-foundation.org>
 <20200821170334.73b52fdd@oasis.local.home>
 <95d7a489-a295-1c11-ac62-83e941ed3a87@jv-coder.de>
 <20200907114618.GR2674@hirez.programming.kicks-ass.net>
From:   Joerg Vehlow <lkml@jv-coder.de>
Message-ID: <5c3a502f-2255-5aae-3599-5220aa4b8328@jv-coder.de>
Date:   Mon, 7 Sep 2020 14:03:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200907114618.GR2674@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-1.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,HELO_MISC_IP,NICE_REPLY_A,RDNS_NONE
        autolearn=unavailable autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mail.jv-coder.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/2020 1:46 PM, peterz@infradead.org wrote:
> I think it's too complicated for that is needed, did you see my
> suggestion from a year ago? Did i miss something obvious?
>
This one? 
https://lore.kernel.org/linux-fsdevel/20191219090535.GV2844@hirez.programming.kicks-ass.net/

I think it may be a bit incorrect?
According to the original comment in __crash_kexec, the mutex was used to
prevent a sys_kexec_load, while crash_kexec is executed. Your proposed 
patch
does not lock the mutex in crash_kexec. This does not cover the original 
use
case anymore. The only thing that is protected now are two panicing cores at
the same time.
Actually, this implementation feels even more hacky to me....

Jörg
