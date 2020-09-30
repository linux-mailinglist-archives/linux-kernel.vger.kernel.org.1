Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2076827F38C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 22:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbgI3Ur4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 16:47:56 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51274 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3Ur4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 16:47:56 -0400
Received: from [192.168.0.121] (unknown [209.134.121.133])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1F11120B7178;
        Wed, 30 Sep 2020 13:47:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1F11120B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1601498875;
        bh=PVNkh3izsumfD/YQ5rKpitT/cl9kAeWDKyqH2QVj+5k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HbS+w7Q099ye2QEz7Hk9X5hAjuajdACKS2YYb9CsQn5EV/ZkQzYnxISlcn4WNn+xG
         MCj7W1HZhJ8GDNrBKdgjrYI0KCZG6zIMk1PYFja6pP5MT+UCOUXyUQZ1MiD3WcPEdy
         34roj4LAK00aUaaUJ/Bw/+QZ7f3cGC1fpOMrn0rY=
Subject: Re: [v5] mm: khugepaged: recalculate min_free_kbytes after memory
 hotplug as expected by khugepaged
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Michal Hocko <mhocko@suse.com>,
        Allen Pais <apais@microsoft.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <1601398153-5517-1-git-send-email-vijayb@linux.microsoft.com>
 <2a380b84-4fee-fa4e-e862-8a8577961088@oracle.com>
From:   Vijay Balakrishna <vijayb@linux.microsoft.com>
Message-ID: <8cdb105c-2b7b-1997-ed82-22f4bb25638c@linux.microsoft.com>
Date:   Wed, 30 Sep 2020 13:47:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <2a380b84-4fee-fa4e-e862-8a8577961088@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/30/2020 11:20 AM, Mike Kravetz wrote:
> On 9/29/20 9:49 AM, Vijay Balakrishna wrote:
>> When memory is hotplug added or removed the min_free_kbytes should be
>> recalculated based on what is expected by khugepaged.  Currently
>> after hotplug, min_free_kbytes will be set to a lower default and higher
>> default set when THP enabled is lost.  This change restores min_free_kbytes
>> as expected for THP consumers.
>>
>> Fixes: f000565adb77 ("thp: set recommended min free kbytes")
>>
>> Signed-off-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
>> Cc: stable@vger.kernel.org
>> Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
>> Acked-by: Michal Hocko <mhocko@suse.com>
> 
> Sorry for jumping in so late.  Should we use this as an opportunity to
> also fix up the messages logged when (re)calculating mfk?  They are wrong
> and could be quite confusing.


Sure.  Please share your thoughts regarding appropriate message.  Here 
is what I'm thinking

pr_warn("min_free_kbytes is not updated to %d because current value %d 
is preferred\n", new_min_free_kbytes, min_free_kbytes);

If above message is reasonable I can post a new revision (v6).

Thanks,
Vijay

> For example consider the following sequence
> of operations and corresponding log messages produced.
> 
> Freshly booted VM with 2 nodes and 8GB memory:
> # cat /proc/sys/vm/min_free_kbytes
> 90112
> # echo 90000 > /proc/sys/vm/min_free_kbytes
> # cat /proc/sys/vm/min_free_kbytes
> 90000
> # echo 0 > /sys/devices/system/node/node1/memory56/online
> [  135.099947] Offlined Pages 32768
> [  135.102362] min_free_kbytes is not updated to 11241 because user defined value 90000 is preferred
> [  135.109070] khugepaged: raising min_free_kbytes from 90000 to 90112 to help t
> ransparent hugepage allocations
> # cat /proc/sys/vm/min_free_kbytes
> 90112
> # echo 1 > /sys/devices/system/node/node1/memory56/online
> [  231.656075] min_free_kbytes is not updated to 11334 because user defined value 90000 is preferred
> # cat /proc/sys/vm/min_free_kbytes
> 90112
> 
