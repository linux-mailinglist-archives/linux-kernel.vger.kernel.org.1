Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5774D1D6278
	for <lists+linux-kernel@lfdr.de>; Sat, 16 May 2020 18:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgEPP74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 May 2020 11:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgEPP7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 11:59:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9249C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 08:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=hTjKFbKjAPRBSfEP6JDKZO4Ccm6OlreCSUNy5KNK3gY=; b=TsPEwLELXKbMhOT38tckuR02be
        ER6h3IsJ0f8/GOmtLh3t/fLqHcam3B6OxZRABtHn5AjjV+/fsvU6uUvQ5w8rMY911DC4CR+UyCR8/
        be6hzS4EETC3b0HLE7aswfpnWUHI9Fz5PGI9OX3NWuiRKOUAAWFmoInn5OMs3Y8du4oywFBQYtXna
        HGLrikW+keM+engUTPxglHUzTjVeVDw4JqO7yPn/d5NqY39Z8u7xEa3AlSl9S8RZOkHSJA+bPXJbM
        sYmAK902dNCM5D/DWOOm9olWe+6t/eo4Y95UZxJAXEbdZdBSPNAx136ekQZNaT1Mm3YnTjEDoxHU5
        VbrqZ9Kw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZzEA-0004kC-AJ; Sat, 16 May 2020 15:59:54 +0000
Subject: Re: general protection fault vs Oops
To:     =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Subhashini Rao Beerisetty <subhashbeerisetty@gmail.com>
Cc:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-kernel@vger.kernel.org
References: <CAPY=qRQ6gzN1BWh=ianVDBQ1C9kibWHwxs5Z0+QSwGxKymLDTQ@mail.gmail.com>
 <374485.1589637193@turing-police>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <af03bee5-27b2-4e92-359a-b1cc8f500d6d@infradead.org>
Date:   Sat, 16 May 2020 08:59:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <374485.1589637193@turing-police>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/20 6:53 AM, Valdis Klētnieks wrote:
> On Sat, 16 May 2020 18:05:07 +0530, Subhashini Rao Beerisetty said:
> 
>> In the first attempt when I run that test case I landed into â€œgeneral
>> protection fault: 0000 [#1] SMP" .. Next I rebooted and ran the same
>> test , but now it resulted the â€œOops: 0002 [#1] SMP".
> 
> And the 0002 is telling you that there's been 2 previous bug/oops since the
> reboot, so you need to go back through your dmesg and find the *first* one.
> 
>> In both cases the call trace looks exactly same and RIP points to
>> â€œnative_queued_spin_lock_slowpath+0xfe/0x170"..
> 
> The first few entries in the call trace are the oops handler itself. So...
> 
> 
>> May 16 12:06:17 test-pc kernel: [96934.567347] Call Trace:
>> May 16 12:06:17 test-pc kernel: [96934.569475]  [<ffffffff8183c427>]__raw_spin_lock_irqsave+0x37/0x40
>> May 16 12:06:17 test-pc kernel: [96934.571686]  [<ffffffffc0606812>] event_raise+0x22/0x60 [osa]
>> May 16 12:06:17 test-pc kernel: [96934.573935]  [<ffffffffc06aa2a4>] multi_q_completed_one_buffer+0x34/0x40 [mcore]
> 
> The above line is the one where you hit the wall.
> 
>> May 16 12:59:22 test-pc kernel: [ 3011.405602] Call Trace:
>> May 16 12:59:22 test-pc kernel: [ 3011.407892]  [<ffffffff8183c427>] _raw_spin_lock_irqsave+0x37/0x40
>> May 16 12:59:22 test-pc kernel: [ 3011.410256]  [<ffffffffc0604812>] event_raise+0x22/0x60 [osa]
>> May 16 12:59:22 test-pc kernel: [ 3011.412652]  [<ffffffffc06b72a4>] multi_q_completed_one_buffer+0x34/0x40 [mcore]
> 
> And again.
> 
> However,  given that it's a 4.4 kernel from 4 years ago, it's going to be
> hard to find anybody who really cares.

Right.

> In fact. I'm wondering if this is from some out-of-tree or vendor patch,
> because I'm not finding any sign of that function in either the 5.7 or 4.4
> tree.  Not even a sign of ## catenation abuse - no relevant hits for
> "completed_one_buffer" or "multi_q" either

Modules linked in:
dbg(OE) mcore(OE) osa(OE)

Out-of-tree, unsigned modules loaded.
We don't know what those are or how to debug them.

> I don't think anybody's going to be able to help unless somebody first
> identifies where that function is....
> 


-- 
~Randy

