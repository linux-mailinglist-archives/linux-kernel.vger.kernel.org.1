Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52BF287A47
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 18:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730228AbgJHQqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 12:46:37 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2673 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729965AbgJHQqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 12:46:36 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7f423a0000>; Thu, 08 Oct 2020 09:45:46 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 8 Oct
 2020 16:45:55 +0000
Subject: Re: [RFC PATCH v3 2/2] mm: remove extra ZONE_DEVICE struct page
 refcount
To:     Ram Pai <linuxram@us.ibm.com>
CC:     <linux-mm@kvack.org>, <kvm-ppc@vger.kernel.org>,
        <nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        "Christoph Hellwig" <hch@lst.de>, Jason Gunthorpe <jgg@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Zi Yan <ziy@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
References: <20201001181715.17416-1-rcampbell@nvidia.com>
 <20201001181715.17416-3-rcampbell@nvidia.com>
 <20201008051702.GA4773@ram-ibm-com.ibm.com>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <751582db-9f03-dfbf-1466-131e051def37@nvidia.com>
Date:   Thu, 8 Oct 2020 09:45:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20201008051702.GA4773@ram-ibm-com.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602175546; bh=2oXrv2k21feKjRaE4SwKhy+0xGr1Nj+jNNr7ur3YOOc=;
        h=Subject:To:CC:References:X-Nvconfidentiality:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=bMog1qj4M5hD0xFVcVM4rpg11B7PncavhBkkQIOYBCB3ztXT2ow9SY3iD07FnWJpe
         513GKpf5wzrxu98OoBXIXOhoZqRB8N4aEVZo/02MvMGmpYnbk3rR0zQE++KDUQGHzs
         Ixz0p1G0sYd6Bzdqse0qEGMErkggJAR4TFz9PahrH9LKbDOc195QZ0P26lQPScWWtz
         jWX5kNLuLiORARu4PAFLI6g5QEWPS2T/6ZiWln+nOqN+TIrcPZtxgF3N8TGwvEnA2d
         2+Sw4VFKZ02QPeQh121J9t/i+SfxF6MxvLiskNTn53oaLBZUbqcaq0zy4WZLVB+AOf
         sbi4yYrp6tg0A==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/7/20 10:17 PM, Ram Pai wrote:
> On Thu, Oct 01, 2020 at 11:17:15AM -0700, Ralph Campbell wrote:
>> ZONE_DEVICE struct pages have an extra reference count that complicates the
>> code for put_page() and several places in the kernel that need to check the
>> reference count to see that a page is not being used (gup, compaction,
>> migration, etc.). Clean up the code so the reference count doesn't need to
>> be treated specially for ZONE_DEVICE.
> 
> 
> I was hoping this patch would resolve a page-reference issue that we run
> into at random times while migrating a page to a device page backed by
> secure-memory.
> 
> Unfortunately I continue to see the problem. There is a reference
> held on that page, which fails the migration.
> 
> FYI
> RP

I'm willing to look into it but I would need more information.
Can you give any more details about the conditions when it happens?
It would be great if you have a program that reproduces the problem.
