Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6AD2EA131
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 00:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbhADX5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 18:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbhADX5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 18:57:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6EDC061795
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 15:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=iFr49j27FeRQhKYK4FBLO58mqA8kg383YQLNRmKkdFk=; b=dhuWv12EqLl+BKVLZdAyjPpXlV
        PpKEmQOF6FiVvRdfhCkYCkq+oO5Jr0428qa8Z2yoN8EKqpwnMDXAHWinogBbNR1O59BdC5xGAM1/P
        hzcUb41J3ae67z8zfRjeZSZ9L2fatrHPGKdNDLQW1NyJ/bZn6MzG9X5e4KUtr+yQBZC7Dd8NGvMZz
        wL77RqGE8HmzpJHnyJOOZM5iWR32ZvvVcGEVI41VFW9/7GFj2KC2Vojg5+fr8p2rTsNu5VmrFiVU3
        QH7mJlmodTSFo6uF8cWdv4W/0MiVbB7UW4BJ417JtDkyEmziL4pL9ix54xgZ/sVKevk7xMJJAUcro
        OveqdAzg==;
Received: from [2601:1c0:6280:3f0::2c43]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kwZhO-000fHb-LB; Mon, 04 Jan 2021 23:56:01 +0000
Subject: Re: [PATCH] x86/compat: Pull huge_encode_dev() outside of UACCESS
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <984353b44a4484d86ba9f73884b7306232e25e30.1608737428.git.jpoimboe@redhat.com>
 <20210104122825.GM3021@hirez.programming.kicks-ass.net>
 <20210104153127.e44uchjhlgg3hq2g@treble>
 <20210104155347.GC3040@hirez.programming.kicks-ass.net>
 <20210104172423.guiqwovibivcrqum@treble>
 <20210104231442.s4fdemacapnsqxse@treble>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f2a28e68-be2c-b83c-feb0-729b1967bc11@infradead.org>
Date:   Mon, 4 Jan 2021 15:55:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210104231442.s4fdemacapnsqxse@treble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/21 3:14 PM, Josh Poimboeuf wrote:
> On Mon, Jan 04, 2021 at 11:24:23AM -0600, Josh Poimboeuf wrote:
>> On Mon, Jan 04, 2021 at 04:53:47PM +0100, Peter Zijlstra wrote:
>>> On Mon, Jan 04, 2021 at 09:31:27AM -0600, Josh Poimboeuf wrote:
>>>> Peter, care to submit a proper patch?
>>>
>>> Here goes..
>>>
>>> ---
>>> Subject: x86/compat: Pull huge_encode_dev() outside of UACCESS
>>> From: Peter Zijlstra <peterz@infradead.org>
>>> Date: Mon, 4 Jan 2021 13:28:25 +0100
>>>
>>> Fixes the following warning:
>>>
>>>   arch/x86/kernel/sys_ia32.o: warning: objtool: cp_stat64()+0xd8: call to new_encode_dev() with UACCESS enabled
>>>
>>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>
>> Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
> 
> Actually the other patch was already merged into Linus' tree.
> 
> Maybe add a revert of the other patch to this one?
> 

Glad you noticed.

I reverted the kdev_t patch and applied Peter's patch and it
still tested OK, so (still):

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

-- 
~Randy
