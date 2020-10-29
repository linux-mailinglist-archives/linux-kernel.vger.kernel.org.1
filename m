Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C16629F6D9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 22:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgJ2V3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 17:29:32 -0400
Received: from z5.mailgun.us ([104.130.96.5]:32021 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbgJ2V32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 17:29:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604006968; h=Message-ID: Subject: Cc: To: From: Date:
 Content-Transfer-Encoding: Content-Type: MIME-Version: Sender;
 bh=l7Ake0uL6NQI9lG1v2HvqhfOM5xinBrlrKZV7xLlyFI=; b=SnMvsFMt2SSV4dwMme6btju6bqXqRi5rkeau6QOaKjbhNbhFvGpoqvd/bh2bxyRWdvZrz0OR
 H3sd0CNMNH6b/+X/DFbgOm8zCbfZ7Auny+RMos7Kl5cNBjy6QcWvO8OsUeDm1DDcr3mFw7Mu
 NMVhW1phujqjPWkTuvWtcpdmXMU=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f9b3437d5ed89ceee3ed792 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 29 Oct 2020 21:29:27
 GMT
Sender: sudaraja=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C360DC43387; Thu, 29 Oct 2020 21:29:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sudaraja)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2A5FBC433C9;
        Thu, 29 Oct 2020 21:29:27 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 29 Oct 2020 14:29:27 -0700
From:   Sudarshan Rajagopalan <sudaraja@codeaurora.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Steven Price <steven.price@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg Kroah-Hartman <gregkh@google.com>,
        Pratik Patel <pratikp@codeaurora.org>
Subject: mm/memblock: export memblock_{start/end}_of_DRAM
Message-ID: <d0580051d03df3f3e9f333f6bfe968cf@codeaurora.org>
X-Sender: sudaraja@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

We have a usecase where a module driver adds certain memory blocks using 
add_memory_driver_managed(), so that it can perform memory hotplug 
operations on these blocks. In general, these memory blocks aren’t 
something that gets physically added later, but is part of actual RAM 
that system booted up with. Meaning – we set the ‘mem=’ cmdline 
parameter to limit the memory and later add the remaining ones using 
add_memory*() variants.

The basic idea is to have driver have ownership and manage certain 
memory blocks for hotplug operations.

For the driver be able to know how much memory was limited and how much 
actually present, we take the delta of ‘bootmem physical end address’ 
and ‘memblock_end_of_DRAM’. The 'bootmem physical end address' is 
obtained by scanning the reg values in ‘memory’ DT node and determining 
the max {addr,size}. Since our driver is getting modularized, we won’t 
have access to memblock_end_of_DRAM (i.e. end address of all memory 
blocks after ‘mem=’ is applied).

So checking if memblock_{start/end}_of_DRAM() symbols can be exported? 
Also, this information can be obtained by userspace by doing ‘cat 
/proc/iomem’ and greping for ‘System RAM’. So wondering if userspace can 
have access to such info, can we allow kernel module drivers have access 
by exporting memblock_{start/end}_of_DRAM().

Or are there any other ways where a module driver can get the end 
address of system memory block?


Sudarshan

--
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
