Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1B426E67C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 22:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgIQUTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 16:19:04 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:9204 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgIQUTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 16:19:04 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f63c48c0000>; Thu, 17 Sep 2020 13:18:20 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 17 Sep 2020 13:19:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 17 Sep 2020 13:19:03 -0700
Received: from [10.2.52.182] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 17 Sep
 2020 20:19:03 +0000
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Peter Xu <peterx@redhat.com>, Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        "Yang Shi" <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        "Kirill Shutemov" <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Christoph Hellwig" <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200915213330.GE2949@xz-x1> <20200915232238.GO1221970@ziepe.ca>
 <e6c352f8-7ee9-0702-10a4-122d2c4422fc@nvidia.com>
 <20200916174804.GC8409@ziepe.ca> <20200916184619.GB40154@xz-x1>
 <20200917112538.GD8409@ziepe.ca> <20200917181411.GA133226@xz-x1>
 <CAHk-=wgMVPAhD7C24ipe03+MScgp6F=zMS-roOznvxJ+hOGfSA@mail.gmail.com>
 <20200917190332.GB133226@xz-x1>
 <CAHk-=wgw3GNyF_6euymOFxM62Y3B=C=f2iUJn8Py-u5YELJ5JA@mail.gmail.com>
 <20200917200638.GM8409@ziepe.ca>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <24b8ad6b-4e4c-4651-86e6-bc2232fce772@nvidia.com>
Date:   Thu, 17 Sep 2020 13:19:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200917200638.GM8409@ziepe.ca>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600373900; bh=zJdwNYAMx90ir5RMJ1DLuiQztq3J/XgFvjEA6+/wCH8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=nyoerkUlDkmYju8FLrprAmhFwQ2yQ14beGJqSa/ebssucj/MOaDQ8TlVyNJyCcTbr
         HVn0czbJOxKuW86+K2B7KNDFD/gWfMVnbM39MsyrQf6Le7ItzRkuOtPuS1ZrOa11i5
         0MAuMVfw+0ebfVFZfSybhpd+BDBAJlB2mHRS8Ay5Hmz6CxaC1HoX7Dhs2IX4vTeFaE
         BB+9RH5wbrhH0VpBrASXC93Sna9D1yGhaE6AUFsSHl8t1SQgEb8DgXS9f1gPukvo6I
         /oAwpjV3RhBI+XcQwZrgTMHokp/LtyixkCfwwpvHySIj9RHMtKHUpSWoDKM42coCPZ
         3jMy4K3ZPxhhQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/20 1:06 PM, Jason Gunthorpe wrote:
> On Thu, Sep 17, 2020 at 12:42:11PM -0700, Linus Torvalds wrote:
...
>> Is there possibly somethign else we can filter on than just
>> GUP_PIN_COUNTING_BIAS? Because it could be as simple as just marking
>> the vma itself and saying "this vma has had a page pinning event done
>> on it".
> 
> We'd have to give up pin_user_pages_fast() to do that as we can't fast
> walk and get vmas?

oops, yes. I'd forgotten about that point. Basically all of the O_DIRECT
callers need _fast. This is a big problem.

thanks,
-- 
John Hubbard
NVIDIA

> 
> Hmm, there are many users. I remember that the hfi1 folks really
> wanted the fast version for some reason..
> 
>> Because if we only start copying the page *iff* the vma is marked by
>> that "this vma had page pinning" _and_ the page count is bigger than
>> GUP_PIN_COUNTING_BIAS, than I think we can rest pretty easily knowing
>> that we aren't going to hit some regular old-fashioned UNIX server
>> cases with a lot of forks..
> 
> Agree
> 
> Given that this is a user visible regression, it is nearly rc6, what
> do you prefer for next steps?
> 
> Sorting out this for fork, especially if it has the vma change is
> probably more than a weeks time.
> 
> Revert this patch and try again next cycle?
> 
> Thanks,
> Jason
> 

