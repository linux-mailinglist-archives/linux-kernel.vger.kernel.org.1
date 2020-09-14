Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086B7269739
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 22:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgINU4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 16:56:23 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:19086 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgINU4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 16:56:20 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5fd8e70000>; Mon, 14 Sep 2020 13:56:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 14 Sep 2020 13:56:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 14 Sep 2020 13:56:20 -0700
Received: from [10.2.52.22] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 14 Sep
 2020 20:56:19 +0000
Subject: Re: [PATCH] mm/gup.c: Handling ERR within unpin_user_pages()
To:     Souptick Joarder <jrdr.linux@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <1600007555-11650-1-git-send-email-jrdr.linux@gmail.com>
 <20200913145520.GH6583@casper.infradead.org>
 <CAFqt6zYru2VfaBFHEB6+7vMPXUbgX8R5f+GHqxaGjhP8QZEyzw@mail.gmail.com>
 <20200914140814.GE1221970@ziepe.ca>
 <CAFqt6zasxyAc9heAFuQ0xXuwpk8s7RThordModvLVDNDfFYvkA@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <e56f3bd8-c025-cd68-a7b2-cb1e8eafae72@nvidia.com>
Date:   Mon, 14 Sep 2020 13:56:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAFqt6zasxyAc9heAFuQ0xXuwpk8s7RThordModvLVDNDfFYvkA@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600116967; bh=+oWEarvEQBjCBkRKG8S6c1RiGqvrOZjaYdIkoM8VZak=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=lxOEgomUBCeFRQfM06OboOEEMpuSYIM1iyaBr3WI8AKriJzrsnI1SRg08LANEPTYv
         U7L8Nc3YNQbbNqdGzEiEhnjxPnM+hEaAdwn13wHAy/lUry/ocsvIVzA4Sy9GWRy0wL
         nTz3ChKIy0byq8u7cc7O8VpdxADX7YnR7ulzMEwR0WL5eRaRXAnMOyja8gCNQBdRLS
         q8pqDeF8wsICChU8kSfv7p6jCNjh5/fyOG6CRPm9bolkr/fLhWbxGoqAtDpS1hH8Pf
         fFKR7wx8HsG1Y0RJmRhgVAvByGa07r+Wy8f+Eugz8bj8TfwP5JsiaNT3/5M4MNqm0W
         qo1FTAerE34dg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/20 1:52 PM, Souptick Joarder wrote:
> On Mon, Sep 14, 2020 at 7:38 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>
>> On Mon, Sep 14, 2020 at 07:20:34AM +0530, Souptick Joarder wrote:
>>> On Sun, Sep 13, 2020 at 8:25 PM Matthew Wilcox <willy@infradead.org> wrote:
>>>>
>>>> On Sun, Sep 13, 2020 at 08:02:35PM +0530, Souptick Joarder wrote:
>>>>> It is possible that a buggy caller of unpin_user_pages()
>>>>> (specially in error handling path) may end up calling it with
>>>>> npages < 0 which is unnecessary.
>>>>> @@ -328,6 +328,9 @@ void unpin_user_pages(struct page **pages, unsigned long npages)
>>>>>   {
>>>>>        unsigned long index;
>>>>>
>>>>> +     if (WARN_ON_ONCE(npages < 0))
>>>>> +             return;
>>>>
>>>> But npages is unsigned long.  So it can't be less than zero.
>>>
>>> Sorry, I missed it.
>>>
>>> Then, it means if npages is assigned with -ERRNO by caller, unpin_user_pages()
>>> may end up calling a big loop, which is unnecessary.
>>
>> How will a caller allocate memory of the right size and still manage
>> to call with the wrong npages? Do you have an example of a broken caller?
> 
> These are two broken callers which might end up calling unpin_user_pages()
> with -ERRNO.
> drivers/rapidio/devices/rio_mport_cdev.c#L952
> drivers/misc/mic/scif/scif_rma.c#L1399
> 
> They both are in error handling paths, so might not have any serious impact.
> But theoretically possible.
> 

Eventually, I settled on fixing up the callers so that they match the gup/pup
API better. In other words, gup/pup has signed int for both input and return
value, and the callers need to handle that perfectly.

So let's fix up the callers.

thanks,
-- 
John Hubbard
NVIDIA
