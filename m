Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23375298B4A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 12:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1772868AbgJZLDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 07:03:51 -0400
Received: from mail.netline.ch ([148.251.143.178]:51998 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1772365AbgJZLDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 07:03:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id B0E252A6042;
        Mon, 26 Oct 2020 12:03:48 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id jp4ezO7Q-qV7; Mon, 26 Oct 2020 12:03:48 +0100 (CET)
Received: from thor (212.174.63.188.dynamic.wline.res.cust.swisscom.ch [188.63.174.212])
        by netline-mail3.netline.ch (Postfix) with ESMTPSA id 5CBCB2A6016;
        Mon, 26 Oct 2020 12:03:47 +0100 (CET)
Received: from [::1]
        by thor with esmtp (Exim 4.94)
        (envelope-from <michel@daenzer.net>)
        id 1kX0Hy-000TLP-K6; Mon, 26 Oct 2020 12:03:46 +0100
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        alexander.deucher@amd.com, Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>, amd-gfx@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org
References: <1603684905.h43s1t0y05.none.ref@localhost>
 <1603684905.h43s1t0y05.none@localhost>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: amdgpu crashes on OOM
Message-ID: <81568253-518f-43b7-6b20-432f7dbd6c2b@daenzer.net>
Date:   Mon, 26 Oct 2020 12:03:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <1603684905.h43s1t0y05.none@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-26 5:29 a.m., Alex Xu (Hello71) wrote:
> Hi,
> 
> I frequently encounter OOM on my system, mostly due to my own fault.
> Recently, I noticed that not only does a swap storm happen and OOM
> killer gets invoked, but the graphics output freezes permanently.
> Checking the kernel messages, I see:
> 
> kworker/u24:4: page allocation failure: order:5, mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), nodemask=(null)
> CPU: 6 PID: 279469 Comm: kworker/u24:4 Tainted: G        W         5.9.0-14732-g20b1adb60cf6 #2
> Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./B450 Pro4, BIOS P4.20 06/18/2020
> Workqueue: events_unbound commit_work
> Call Trace:
>   ? dump_stack+0x57/0x6a
>   ? warn_alloc.cold+0x69/0xcd
>   ? __alloc_pages_direct_compact+0xfb/0x116
>   ? __alloc_pages_slowpath.constprop.0+0x9c2/0xc14
>   ? __alloc_pages_nodemask+0x143/0x167
>   ? kmalloc_order+0x24/0x64
>   ? dc_create_state+0x1a/0x4d
>   ? amdgpu_dm_atomic_commit_tail+0x1b19/0x227d

Looks like dc_create_state should use kvzalloc instead of kzalloc 
(dc_state_free already uses kvfree).

order:5 means it's trying to allocate 32 physically contiguous pages, 
which can be hard to fulfill even with lower memory pressure.


-- 
Earthling Michel Dänzer               |               https://redhat.com
Libre software enthusiast             |             Mesa and X developer
