Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CABB217F2E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 07:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbgGHFkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 01:40:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:41964 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbgGHFkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 01:40:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C55DEABE4;
        Wed,  8 Jul 2020 05:40:15 +0000 (UTC)
Subject: Re: [PATCH v2 2/3] xen/privcmd: Mark pages as dirty
To:     John Hubbard <jhubbard@nvidia.com>,
        Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, Paul Durrant <xadimgnik@gmail.com>
References: <1594059372-15563-1-git-send-email-jrdr.linux@gmail.com>
 <1594059372-15563-3-git-send-email-jrdr.linux@gmail.com>
 <8fdd8c77-27dd-2847-7929-b5d3098b1b45@suse.com>
 <CAFqt6zZRx3oDO+p2e6EiDig9fzKirME-t6fanzDRh6e7gWx+nA@mail.gmail.com>
 <4abc0dd2-655c-16fa-dfc3-95904196c81f@suse.com>
 <4c6e52e7-1d33-132b-1d7e-e57963966dcc@nvidia.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <df0a79be-540a-5f5f-4aa4-41a11131b9b5@suse.com>
Date:   Wed, 8 Jul 2020 07:40:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <4c6e52e7-1d33-132b-1d7e-e57963966dcc@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.07.20 21:30, John Hubbard wrote:
> On 2020-07-07 04:43, Jürgen Groß wrote:
>> On 07.07.20 13:30, Souptick Joarder wrote:
>>> On Tue, Jul 7, 2020 at 3:08 PM Jürgen Groß <jgross@suse.com> wrote:
> ...
>>>>> diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
>>>>> index 33677ea..f6c1543 100644
>>>>> --- a/drivers/xen/privcmd.c
>>>>> +++ b/drivers/xen/privcmd.c
>>>>> @@ -612,8 +612,11 @@ static void unlock_pages(struct page *pages[], 
>>>>> unsigned int nr_pages)
>>>>>    {
>>>>>        unsigned int i;
>>>>>
>>>>> -     for (i = 0; i < nr_pages; i++)
>>>>> +     for (i = 0; i < nr_pages; i++) {
>>>>> +             if (!PageDirty(pages[i]))
>>>>> +                     set_page_dirty_lock(pages[i]);
>>>>
>>>> With put_page() directly following I think you should be able to use
>>>> set_page_dirty() instead, as there is obviously a reference to the page
>>>> existing.
>>>
>>> Patch [3/3] will convert above codes to use 
>>> unpin_user_pages_dirty_lock()
>>> which internally do the same check. So I thought to keep linux-stable 
>>> and
>>> linux-next code in sync. John had a similar concern [1] and later 
>>> agreed to keep
>>> this check.
>>>
>>> Shall I keep this check ?  No ?
> 
> It doesn't matter *too* much, because patch 3/3 fixes up everything by
> changing it all to unpin_user_pages_dirty_lock(). However, there is 
> something
> to be said for having correct interim patches, too. :)  Details:
> 
>>>
>>> [1] 
>>> https://lore.kernel.org/xen-devel/a750e5e5-fd5d-663b-c5fd-261d7c939ba7@nvidia.com/ 
>>>
>>
>> I wasn't referring to checking PageDirty(), but to the use of
>> set_page_dirty_lock().
>>
>> Looking at the comment just before the implementation of
>> set_page_dirty_lock() suggests that it is fine to use set_page_dirty()
>> instead (so not calling lock_page()).
> 
> 
> no no, that's a misreading of the comment. Unless this xen/privcmd code has
> somehow taken a reference on page->mapping->host (which I do *not* think is
> the case), then it is still racy to call set_page_dirty() here. Instead,
> set_page_dirty_lock() should be used.

Ah, okay. Thanks for the clarification.

So you can add my

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
