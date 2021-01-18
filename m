Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 898902FAD97
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 23:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389880AbhARWys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 17:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731791AbhARWyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 17:54:39 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DF9C061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 14:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=j91181JSgYI8g1sA6WaGkpGkvJ3oK1sV+oKNbvr6sd0=; b=w1XpGYdDUt/+bruJS1bJr7pVKo
        rPBKxJ7D3y5Hw0V12q0ZbxD3+meXB62oluAmJiCVtYSzARHIcdLgEEzD+mH9K+m9YiMN69Nu6xqMY
        igbLeuwxoiIy8/qOnPnVV9PUAgbKhpMFlu5rdXFeFfoyfE46RN8XkHP4iWCCTE5fWSb45YOioiwq8
        ixvcq4sKNHpgivKViqVCbiHDg8hlTCo1LzDCO3+nMr2YBOJOagpZ1IQ/iDt6Bf+gKZs47J0mzqalh
        9vHOb8FYEowLJC39bKo5cvQJuiJm6TjJw0+p37UEHKhYG0/81/NFqsTy1y7qL9dT9CBoiqXAo10Ri
        NIvaZvZQ==;
Received: from [2601:1c0:6280:3f0::9abc]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l1dPC-0004l9-4s; Mon, 18 Jan 2021 22:53:50 +0000
Subject: Re: [PATCH v5 1/2] lib: stackdepot: Add support to configure
 STACK_HASH_SIZE
To:     vjitta@codeaurora.org, minchan@kernel.org, glider@google.com,
        akpm@linux-foundation.org, dan.j.williams@intel.com,
        broonie@kernel.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, ylal@codeaurora.org,
        vinmenon@codeaurora.org, Vineet Gupta <vgupta@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
References: <1610963802-11042-1-git-send-email-vjitta@codeaurora.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2f12a84c-132b-7141-a89e-9e19de0e4b90@infradead.org>
Date:   Mon, 18 Jan 2021 14:53:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1610963802-11042-1-git-send-email-vjitta@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/21 1:56 AM, vjitta@codeaurora.org wrote:
> From: Yogesh Lal <ylal@codeaurora.org>
> 
> Use CONFIG_STACK_HASH_ORDER to configure STACK_HASH_SIZE.
> 
> Aim is to have configurable value for  STACK_HASH_SIZE,
> so depend on use case one can configure it.
> 
> One example is of Page Owner, default value of
> STACK_HASH_SIZE lead stack depot to consume 8MB of static memory.
> Making it configurable and use lower value helps to enable features like
> CONFIG_PAGE_OWNER without any significant overhead.
> 
> Signed-off-by: Yogesh Lal <ylal@codeaurora.org>
> Signed-off-by: Vinayak Menon <vinmenon@codeaurora.org>
> Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>

Hi,

Did you see
https://lore.kernel.org/lkml/202101050729.cwTd47Yw-lkp@intel.com/

It seems that arch/arc/ does not have:
   arc-elf-ld: lib/stackdepot.o: in function `filter_irq_stacks':
   (.text+0x6): undefined reference to `__irqentry_text_start'
>> arc-elf-ld: (.text+0x6): undefined reference to `__irqentry_text_start'
>> arc-elf-ld: (.text+0x26): undefined reference to `__irqentry_text_end'
>> arc-elf-ld: (.text+0x26): undefined reference to `__irqentry_text_end'
>> arc-elf-ld: (.text+0x34): undefined reference to `__softirqentry_text_start'
>> arc-elf-ld: (.text+0x34): undefined reference to `__softirqentry_text_start'
>> arc-elf-ld: (.text+0x3c): undefined reference to `__softirqentry_text_end'
>> arc-elf-ld: (.text+0x3c): undefined reference to `__softirqentry_text_end'




-- 
~Randy
You can't do anything without having to do something else first.
-- Belefant's Law
