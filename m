Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABDB22CC5CD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389221AbgLBSsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387582AbgLBSsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:48:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90509C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 10:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=gftQbKifriUZqj/fvWyoxa13BO2BqZypaHTshSxtU4Y=; b=gcIJgt+o82n1E9XqBLSj3jCGnd
        df3d+OAPBx/TiLcBr1Y9ejoSsO2BfH8oFJIAfck4IeYbvO64ILX+CHft3Z1m9rrMN3Rh3oweV/Zeg
        VDV0Tlcd1t1BcyssesyCUuXUVUQ96YIBWB7liTQlM7EQe0yGFVkvh90uatJb2SV4/DIE3ezBYZ6ik
        HhPi6ONj9WCfu2GHkp1emzgiEwX+xDtYLWjh8ZSATQndLmOGdlXgpsZ6kngDf8ItDZMdG4luVBRmO
        eXzPMvq8tfM7Qd+9qqOkxQv9WZu384A1OaWi0WnroydylJLKdv3clDvmJVVeVAHL5hWMG15bqIsLV
        Q3/f4lNg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkX9q-00044K-Js; Wed, 02 Dec 2020 18:47:18 +0000
Date:   Wed, 2 Dec 2020 18:47:18 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
Cc:     catalin.marinas@arm.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PROBLEM] mm :  kmemleaks  related detected
Message-ID: <20201202184718.GF11935@casper.infradead.org>
References: <ecfa0f976740346b26ebdbf62bb3d4519f98602b.camel@rajagiritech.edu.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ecfa0f976740346b26ebdbf62bb3d4519f98602b.camel@rajagiritech.edu.in>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 12:04:22AM +0530, Jeffrin Jose T wrote:
> hello,
> 
> 
> 2 new suspected  memory leaks.   See  below...

You've reported this to the wrong place.  It looks like the HID
driver would be the place which is leaking memory, and is probably
a better place to report it.

> ------------------x-------------------x------------------------------
> $sudo cat /sys/kernel/debug/kmemleak
> [sudo] password for jeffrin: 
> unreferenced object 0xffff88813128bee0 (size 16):
> comm "irq/109-ELAN130", pid 152, jiffies 4294931163 (age 9576.624s)
> hex dump (first 16 bytes):
> 04 03 08 0a eb 03 24 e7 01 80 13 44 00 00 00 00 ......$....D....
> backtrace:
> [<00000000eff80361>] kmemdup+0x1a/0x40
> [<00000000552197bd>] hidraw_report_event+0xbc/0x190 [hid]
> [<00000000a102ccd5>] hid_report_raw_event+0x70a/0x790 [hid]
> [<00000000b1b8f73f>] hid_input_report+0x1b4/0x210 [hid]
> [<00000000e0f74a09>] i2c_hid_irq+0x164/0x1e0 [i2c_hid]
> [<00000000a79c6ce4>] irq_thread_fn+0x40/0xb0
> [<0000000037a84810>] irq_thread+0x23d/0x330
> [<0000000009e057aa>] kthread+0x1cd/0x1f0
> [<000000005e7b7b46>] ret_from_fork+0x22/0x30
> unreferenced object 0xffff88813128b640 (size 16):
> comm "irq/109-ELAN130", pid 152, jiffies 4294931165 (age 9576.616s)
> hex dump (first 16 bytes):
> 04 03 02 0a ee 03 74 e7 01 80 13 44 00 00 00 00 ......t....D....
> backtrace:
> [<00000000eff80361>] kmemdup+0x1a/0x40
> [<00000000552197bd>] hidraw_report_event+0xbc/0x190 [hid]
> [<00000000a102ccd5>] hid_report_raw_event+0x70a/0x790 [hid]
> [<00000000b1b8f73f>] hid_input_report+0x1b4/0x210 [hid]
> [<00000000e0f74a09>] i2c_hid_irq+0x164/0x1e0 [i2c_hid]
> [<00000000a79c6ce4>] irq_thread_fn+0x40/0xb0
> [<0000000037a84810>] irq_thread+0x23d/0x330
> [<0000000009e057aa>] kthread+0x1cd/0x1f0
> [<000000005e7b7b46>] ret_from_fork+0x22/0x30
> $
> ----------------------x-----------------x------------------------x-----
> ------------

> Reported-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
> Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

Tested-by is used to indicate that you tested the patch.  Since there
is no patch yet, you can't have tested it.
