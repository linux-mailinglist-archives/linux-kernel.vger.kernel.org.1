Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF3D2B2ADA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 03:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgKNClc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 21:41:32 -0500
Received: from z5.mailgun.us ([104.130.96.5]:46264 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgKNClb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 21:41:31 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605321691; h=Message-ID: Subject: To: From: Date:
 Content-Transfer-Encoding: Content-Type: MIME-Version: Sender;
 bh=EB58wdI9Dt3Cl+zcCD+PGvSh+hKiJNn9Kj37xFgOX3w=; b=SvXNtrSaR8MH5CITv0GjLfSCLtLXh/+6bq1V5wmyk4yq38GnZG4RApcSqtn1z37PHX/P3Wmw
 PaljZO5B+YYcHJpCQgqjbczBvjB47yLSB8VxA4JFslyTGJiee6WH+xyDqWUQ5WEtWkHJJBSc
 y2ytMMoz7/2PcY40UYG5XfGeXdU=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5faf43d324ba9b3b02af8094 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 14 Nov 2020 02:41:23
 GMT
Sender: sudaraja=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 72CACC433FF; Sat, 14 Nov 2020 02:41:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sudaraja)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A07A6C433C6;
        Sat, 14 Nov 2020 02:41:22 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 13 Nov 2020 18:41:22 -0800
From:   Sudarshan Rajagopalan <sudaraja@codeaurora.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Price <steven.price@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Pratik Patel <pratikp@codeaurora.org>
Subject: [RFC] depopulate_range_driver_managed() for removing page-table
 mappings for hot-added memory blocks
Message-ID: <bb30aa44d367ad217e9c877eba7b0a12@codeaurora.org>
X-Sender: sudaraja@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

When memory blocks are removed, along with removing the memmap entries, 
memory resource and memory block devices, the arch specific 
arch_remove_memory() is called which takes care of tearing down the 
page-tables.

Suppose there’s a usecase where the removed memory blocks will be added 
back into the system at later point, we can remove/offline the block in 
a way that all entries such as memmaps, memory resources and block 
devices can be kept intact so that they won’t be needed to be created 
again when blocks are added back. Now this can be done by doing offline 
alone. But if there’s special usecase where the page-table entries are 
needed to be teared down when blocks are offlined in order to avoid 
speculative accesses on offlined memory region, but also keep the memmap 
entries and block devices intact, I was thinking if we can implement 
something like {populate|depopulate}_range_driver_managed() that can be 
called after online/offline which can create/tear down page table 
mappings for that range. This would avoid us from the need to do 
remove_memory() entirely just for the sake of page-table entries being 
removed. We can now just offline the block and call 
depopulate_range_driver_managed.

This basically isolates arch_{add/remove}_memory outside of 
add/remove_memory routines so that drivers can choose if it needs to 
just offline and remove page-table mappings or hotremove memory 
entirely. This gives drivers the flexibility to retain memmap entries 
and memory resource and block device creation so that they can be 
skipped when blocks are added back – this helps us reduce the latencies 
for removing and adding memory blocks.

I’m still in the process the creating the patch that implements this, 
which would give clear view about this RFC but just putting out the 
thought here if it makes sense or not.


Sudarshan
--
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
