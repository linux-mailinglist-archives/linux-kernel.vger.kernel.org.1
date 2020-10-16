Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28E8290E02
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 01:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410667AbgJPXLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 19:11:22 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:28418 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392711AbgJPXLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 19:11:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602889881; h=Message-ID: Subject: Cc: To: From: Date:
 Content-Transfer-Encoding: Content-Type: MIME-Version: Sender;
 bh=KP659FIJpORGhMvLQ93vED7u9wN2xczwCJIEuJ6VKqM=; b=R+kKwoPodvudtiATvOBHc0B1LQV6Z/+bn3aLINvclfqQcKQHY6QjBeHmQxEBDgqGBw1lIuuB
 Fb+IUhAUlNeMHLy1oCM4F/U3EZlCs/PjtwAh5S+Y0cLN24o8vJ2Q8kafFIYYqmXmWENH4dP+
 sIFKKV1szXZr31dUj02Xyd9ieBY=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f8a2897856d9308b5cdcb95 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 16 Oct 2020 23:11:19
 GMT
Sender: sudaraja=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 88906C433FF; Fri, 16 Oct 2020 23:11:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sudaraja)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AC32CC433F1;
        Fri, 16 Oct 2020 23:11:18 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 16 Oct 2020 16:11:18 -0700
From:   Sudarshan Rajagopalan <sudaraja@codeaurora.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Suren Baghdasaryan <surenb@google.com>, pratikp@codeaurora.org,
        Gavin Shan <gshan@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>
Subject: arm64: dropping prevent_bootmem_remove_notifier
Message-ID: <de8388df2fbc5a6a33aab95831ba7db4@codeaurora.org>
X-Sender: sudaraja@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Anshuman,

In the patch that enables memory hot-remove (commit bbd6ec605c0f 
("arm64/mm: Enable memory hot remove")) for arm64, there’s a notifier 
put in place that prevents boot memory from being offlined and removed. 
Also commit text mentions that boot memory on arm64 cannot be removed. 
We wanted to understand more about the reasoning for this. X86 and other 
archs doesn’t seem to do this prevention. There’s also comment in the 
code that this notifier could be dropped in future if and when boot 
memory can be removed.

The current logic is that only “new” memory blocks which are hot-added 
can later be offlined and removed. The memory that system booted up with 
cannot be offlined and removed. But there could be many usercases such 
as inter-VM memory sharing where a primary VM could offline and 
hot-remove a block/section of memory and lend it to secondary VM where 
it could hot-add it. And after usecase is done, the reverse happens 
where secondary VM hot-removes and gives it back to primary which can 
hot-add it back. In such cases, the present logic for arm64 doesn’t 
allow this hot-remove in primary to happen.

Also, on systems with movable zone that sort of guarantees pages to be 
migrated and isolated so that blocks can be offlined, this logic also 
defeats the purpose of having a movable zone which system can rely on 
memory hot-plugging, which say virt-io mem also relies on for fully 
plugged memory blocks.

I understand that some region of boot RAM shouldn’t be allowed to be 
removed, but such regions won’t be allowed to be offlined in first place 
since pages cannot be migrated and isolated, example reserved pages.

So we’re trying to understand the reasoning for such a prevention put in 
place for arm64 arch alone.

One possible way to solve this is by marking the required sections as 
“non-early” by removing the SECTION_IS_EARLY bit in its section_mem_map. 
This puts these sections in the context of “memory hotpluggable” which 
can be offlined-removed and added-onlined which are part of boot RAM 
itself and doesn’t need any extra blocks to be hot added. This way of 
marking certain sections as “non-early” could be exported so that module 
drivers can set the required number of sections as “memory 
hotpluggable”. This could have certain checks put in place to see which 
sections are allowed, example only movable zone sections can be marked 
as “non-early”.

Your thoughts on this? We are also looking for different ways to solve 
the problem without having to completely dropping this notifier, but 
just putting out the concern here about the notifier logic that is 
breaking our usecase which is a generic memory sharing usecase using 
memory hotplug feature.


Sudarshan

--
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
