Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEAA02B9F98
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 02:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgKTBJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 20:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgKTBJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 20:09:46 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87661C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 17:09:46 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id v5so2204468pff.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 17:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4K9iPhC4qNk/Rh7UFJxvkVuXYE1ScmXCx5XNoAoo/BE=;
        b=E3GJkkDUqRZcXOyddzcINghpgvYz14dVycTO5GBG/X8xKxQGkdk61gAfgNosA+BnrD
         DhtJQ6e8tMom+YYPIqk23Jw5SqIoZz7vdbzFyFT8RisdczKdIb4GfLoPhR+AbER0ZlHS
         IR3i5nest+Wdeh8ILGUPy6OlF2IeMsx79P/E+cMqDxO1spMZbJf+lVvHyvtmPwWPLYem
         UgMxICwkAvDt0epg4fjoojKXIZq9f8fvoXbIyX/KS6gopdru9Do6qv5y6i8XApp9KoU7
         5FeGwEbL6MZF4XVusM+xWmuIeUtjsRjEPYWl4HVr4KjjXKMLM1B0Qxcu9HsMurpfBDfv
         nLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4K9iPhC4qNk/Rh7UFJxvkVuXYE1ScmXCx5XNoAoo/BE=;
        b=NCPoyZ2+bVlHGIDdNW4Z67ziMiDo1IyGkx8UXBj+UtoGTwp6NluRDUCqLkg9LRQ6PQ
         dvqK4B5A9v1ZMjhlTBLOAubGVI65OsG4IuxyKSM8YgFFWh+eVjtSCGvP25LO43CwKVCW
         +yzlN4t6P7gGW1gJSiHPsOW6Su3i6Ds4uhQ0mCKffoYhnm3uYQl16pe2cDPtgHL5CK4v
         Q/b7T1LHdlRfe9K2lU93XcXgm4yfv+vpVI/nOVcwXMD42oqfxOvSf/dVp/6FwYMC7AzV
         B4QIdMHZwd65JKTjNcqcjVsbJpS8UTBziTvSMM7cWUkWDLY8tEJRTY+3HAPhcSLDN3t6
         tP3Q==
X-Gm-Message-State: AOAM532oYzSvvmgYyu43Py+IuKC/9eqFU/v72pcmywbreK4Wzu2JB7LA
        jHDGEx5su2Cu80e80mDVV+XfcIORVhjguQ==
X-Google-Smtp-Source: ABdhPJwlQHuDk/3sbVsTxG6I9t/kxU4uJxWjz9B0da63wH9QjC6ZNPQcfMtvS2PlHQFuu0Guz2jJXg==
X-Received: by 2002:a17:90a:4802:: with SMTP id a2mr7781069pjh.22.1605834585766;
        Thu, 19 Nov 2020 17:09:45 -0800 (PST)
Received: from google.com ([2620:0:1008:11:7220:84ff:fe09:dc21])
        by smtp.gmail.com with ESMTPSA id c193sm1206226pfb.78.2020.11.19.17.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 17:09:44 -0800 (PST)
Date:   Thu, 19 Nov 2020 17:09:40 -0800
From:   Tom Roeder <tmroeder@google.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Peter Gonda <pgonda@google.com>,
        Marios Pomonis <pomonis@google.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Cache DMA descriptors to prevent corruption.
Message-ID: <20201120010940.GA2943603@google.com>
References: <20201119185919.2742954-1-tmroeder@google.com>
 <20201119210914.GB2855047@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201119210914.GB2855047@dhcp-10-100-145-180.wdc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 01:09:14PM -0800, Keith Busch wrote:
>On Thu, Nov 19, 2020 at 10:59:19AM -0800, Tom Roeder wrote:
>> This patch changes the NVMe PCI implementation to cache host_mem_descs
>> in non-DMA memory instead of depending on descriptors stored in DMA
>> memory. This change is needed under the malicious-hypervisor threat
>> model assumed by the AMD SEV and Intel TDX architectures, which encrypt
>> guest memory to make it unreadable. Some versions of these architectures
>> also make it cryptographically hard to modify guest memory without
>> detection.
>>
>> On these architectures, Linux generally leaves DMA memory unencrypted so
>> that devices can still communicate directly with the kernel: DMA memory
>> remains readable to and modifiable by devices. This means that this
>> memory is also accessible to a hypervisor.
>>
>> However, this means that a malicious hypervisor could modify the addr or
>> size fields of descriptors and cause the NVMe driver to call
>> dma_free_attrs on arbitrary addresses or on the right addresses but with
>> the wrong size. To prevent this attack, this commit changes the code to
>> cache those descriptors in non-DMA memory and to use the cached values
>> when freeing the memory they describe.
>
>If the hypervisor does that, then the device may use the wrong
>addresses, too. I guess you can't do anything about that from the
>driver, though.
I agree; I don't think there's anything the driver can do about that.

>
>> +	/* Cache the host_mem_descs in non-DMA memory so a malicious hypervisor
>> +	 * can't change them.
>> +	 */
>> +	struct nvme_host_mem_buf_desc *host_mem_descs_cache;
>>  	void **host_mem_desc_bufs;
>
>This is never seen by an nvme device, so no need for an nvme specific
>type here. You can use arch native types.

Thanks! I'll change the type to a new struct that has the addr and size 
fields as native integers and send out a v2 for this patch that makes 
that change and cleans up a couple of minor style issues in my code.
