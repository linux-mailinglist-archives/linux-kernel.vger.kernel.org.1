Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE7A30460E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394246AbhAZSM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 13:12:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:36982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731480AbhAZRaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 12:30:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8339120731;
        Tue, 26 Jan 2021 17:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611682206;
        bh=vSXKKnE/bLBTYW50gSYHtVaoA4CgDmimolqgLlfelRM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=sXbwAGTP/5Sqws5TJzQGuE1z+JnSDvWUtL6CfygmHovUFWdQGET5UPBfhvBoS8Psz
         8seaHA75ynp+t3LmsQqoAkpVMjpa880FbamQVZeYQTIvkjryWnOMjOjd4R4Uvrj1gc
         7yzfl7OVkD10bFQAGQGhe4PL9/DASguadRCPKefjJh5BrG8Hc9q7DSC5ROO9nxnCdk
         Z+vc73h7zLBE8avPqVER5Ao3NBva98fLvu1ArPKm7zhbTw2Sx/fsXKyBuIaPqj4t6p
         Et9RMTdBZ7sbjOc8oWuDaEpBT4wZkQwGbmenccb7BkKDmVPhghWx/Fij4yYpS3xn8R
         u3Bi6CrxViw/A==
Subject: Re: [PATCH 0/2] introduce DUMP_PREFIX_UNHASHED for hex dumps
To:     Vlastimil Babka <vbabka@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        Petr Mladek <pmladek@suse.com>, roman.fietze@magna.com,
        keescook@chromium.org, Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>, linux-mm@kvack.org,
        Akinobu Mita <akinobu.mita@gmail.com>
References: <20210116220950.47078-1-timur@kernel.org>
 <20210118182635.GD2260413@casper.infradead.org>
 <ed7e0656-9271-3ccf-ef88-153da1ee31c9@kernel.org>
 <YAYtbbHAHeEwunkW@jagdpanzerIV.localdomain>
 <20210119014725.GH2260413@casper.infradead.org>
 <YAa2oCNWjExWlQTu@jagdpanzerIV.localdomain>
 <09c70d6b-c989-ca23-7ee8-b404bb0490f0@suse.cz>
 <cd9e7a31-e4f6-69d3-0648-c6228108b592@kernel.org>
 <083dd940-60c1-4cc8-fc89-8815b253d5c5@suse.cz>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <a9b38fe7-8a22-71b7-1e84-0ebf1e864306@kernel.org>
Date:   Tue, 26 Jan 2021 11:30:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <083dd940-60c1-4cc8-fc89-8815b253d5c5@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/21 11:14 AM, Vlastimil Babka wrote:
> If it was a boot option, I would personally be for leaving hashing enabled by
> default, with opt-in boot option to disable it.

A boot option would solve all my problems.  I wouldn't need to recompile 
the kernel, and it would apply to all variations of printk.
