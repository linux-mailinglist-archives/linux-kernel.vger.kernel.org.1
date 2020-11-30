Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3B12C8D3E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 19:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387693AbgK3Svb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 13:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgK3Sva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:51:30 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D62C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:50:50 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id s21so10977295pfu.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HDV2ZTfnWFj2I1nMXs/QUKPdkXN+jw+xT8fcFlUSOVc=;
        b=lA21FFs7fsI60sDfvj2gxU+FgPkbHvr1U9a3ONx/671C/3d/nKlJpnVk7IAlanZc2m
         bwPmQnaTZX8tMGvHfKP1xSW0Nh1Er7MBelMPy9IB6NBnT4751YJQGutD4EqQmb4syZbd
         CDFMa9xO18awbJw3S9r4cJsdGc1cP1OYBhZbjYphsxKLZ2+jRa6Ljlf80LB+1c8cpYMY
         /tQxq/5EHr5/gGEX0FRYxIcVqbuvP1bp3ACYlmY5FiorxuFPC4xB8u37h/ZBxd/VJhkj
         g/mywk0m80gfxjHgQikUFr9IlQUXoR1Xz1hAghWecDLYfn2TB11eD5PA+U9vrdMV0XxK
         mdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HDV2ZTfnWFj2I1nMXs/QUKPdkXN+jw+xT8fcFlUSOVc=;
        b=Gjm0xABWXBUyNl29h/Cqj8AJ1CsAvNQ3tVMFRKtucZdU1tEXAPnw0tZPcmPH3Bx98K
         pKuZVAktnrCW3xh1jm6AZOq2Y3++gZ7mHCUJ1c3S6Qo8eL/k16NtVaNQxZ2945ElqRuQ
         pnTLDfBe7Xhry1bts+jg85WyYwlw0J29z1XKcPTKbUSxVh5O1breUwGTokwjIvFlLRvE
         Az2gujgcquELWkAu2YT6FCE7xkJc2jnFXjxv7HgZeXDRBRXmd2vvpGaEphVzlo8T2qNR
         gDeMD9kAXcUBNFUSV1VLttDlRqs1iNK2RwsKUzP/+x1bq96LXodkoE88wzOorGbgIqVD
         UXRg==
X-Gm-Message-State: AOAM53190dVDLteFkBGxf0FMQnQP6SuooyYoIGDry+fzr8/EyMB7MzDQ
        wtt/6KYDdnqyZylwWH3yHcwOerFDioz3t2nW
X-Google-Smtp-Source: ABdhPJwUbDjA9NQJXB5RYWAa+yeaMEvTqE2F9OISOPnqBFBf5Ppt4TbB/5X+E3Sfhk8mMDOYCPFfww==
X-Received: by 2002:a62:1c93:0:b029:198:1c0a:ea71 with SMTP id c141-20020a621c930000b02901981c0aea71mr20104155pfc.22.1606762250026;
        Mon, 30 Nov 2020 10:50:50 -0800 (PST)
Received: from google.com ([2620:0:1008:11:7220:84ff:fe09:dc21])
        by smtp.gmail.com with ESMTPSA id a6sm9159555pfo.194.2020.11.30.10.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 10:50:49 -0800 (PST)
Date:   Mon, 30 Nov 2020 10:50:45 -0800
From:   Tom Roeder <tmroeder@google.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Peter Gonda <pgonda@google.com>,
        Marios Pomonis <pomonis@google.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas.Lendacky@amd.com, David.Kaplan@amd.com
Subject: Re: [PATCH v2] nvme: Cache DMA descriptors to prevent corruption.
Message-ID: <20201130185045.GA744128@google.com>
References: <20201120012738.2953282-1-tmroeder@google.com>
 <20201120080243.GA20463@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201120080243.GA20463@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 09:02:43AM +0100, Christoph Hellwig wrote:
>On Thu, Nov 19, 2020 at 05:27:37PM -0800, Tom Roeder wrote:
>> This patch changes the NVMe PCI implementation to cache host_mem_descs
>> in non-DMA memory instead of depending on descriptors stored in DMA
>> memory. This change is needed under the malicious-hypervisor threat
>> model assumed by the AMD SEV and Intel TDX architectures, which encrypt
>> guest memory to make it unreadable. Some versions of these architectures
>> also make it cryptographically hard to modify guest memory without
>> detection.
>
>I don't think this is a useful threat model, and I've not seen a
>discussion on lkml where we had any discussion on this kind of threat
>model either.

Thanks for the feedback and apologies for the lack of context.

I was under the impression that support for AMD SEV SNP will start 
showing up in KVM soon, and my understanding of SNP is that it 
implies this threat model for the guest. See the patchset 
for SEV-ES, which is the generation before SNP: 
https://lkml.org/lkml/2020/9/14/1168. This doesn't get quite to the SNP 
threat model, but it starts to assume more maliciousness on the part of 
the hypervisor.

You can also see the talk from David Kaplan of AMD from the 2019 Linux 
Security Summit for info about SNP: 
https://www.youtube.com/watch?v=yr56SaJ_0QI.

>
>Before you start sending patches that regress optimizations in various
>drivers (and there will be lots with this model) we need to have a
>broader discussion first.

I've added Tom Lendacky and David Kaplan from AMD on the thread now, 
since I don't think I have enough context to say where this discussion 
should take place or the degree to which they think it has or hasn't.

Tom, David: can you please comment on this?

>
>And HMB support, which is for low-end consumer devices that are usually
>not directly assigned to VMs aren't a good starting point for this.

I'm glad to hear that this case doesn't apply directly to cases we would 
care about for assignment to guests. I'm not very familiar with this 
codebase, unfortunately. Do the same kinds of issues apply for the kinds 
of devices that would be assigned to guests?
