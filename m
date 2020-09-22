Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1943627463B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 18:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgIVQKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 12:10:49 -0400
Received: from linux.microsoft.com ([13.77.154.182]:39770 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgIVQKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 12:10:48 -0400
Received: from [192.168.0.121] (unknown [209.134.121.133])
        by linux.microsoft.com (Postfix) with ESMTPSA id B3F8A20B7179;
        Tue, 22 Sep 2020 09:10:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B3F8A20B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600791048;
        bh=btgqUGlPHcXDJBGoFCQBBLV5shRqPbZbzBUxZ/4bsTE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gG61C516bFmLMoBcukPvU1B3pY25eovLiNFOj6RkTDp/N9dWt72B14UQImyRh1xi4
         kZiQs9XRdcO4IkjCzYRgkonVZSgvziHQpRUYbcRW5/nyWLaSGp3rRW98D39o+cToSg
         AKlcQ+ZQ9SsE/KkDLkM09DeOBGWh+L8wcQoWzm0s=
Subject: Re: [v4] mm: khugepaged: avoid overriding min_free_kbytes set by user
To:     Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Allen Pais <apais@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <1600324779-6782-1-git-send-email-vijayb@linux.microsoft.com>
 <20200917092805.GA29887@dhcp22.suse.cz>
 <21c4788c-2516-2e47-5885-486c352c2b6e@linux.microsoft.com>
 <20200917175217.GD29887@dhcp22.suse.cz>
 <f2231b44-6d14-fb63-43cd-43aaad02bef1@linux.microsoft.com>
 <20200918055637.GB28827@dhcp22.suse.cz>
 <e4eb32bb-f905-d15b-8596-13bf387b9f57@linux.microsoft.com>
 <20200922070726.dlw24lf3wd3p2ias@black.fi.intel.com>
 <20200922100702.GX12990@dhcp22.suse.cz>
From:   Vijay Balakrishna <vijayb@linux.microsoft.com>
Message-ID: <a55f1f0b-d26e-3cc3-370f-bd6f50692e34@linux.microsoft.com>
Date:   Tue, 22 Sep 2020 09:10:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200922100702.GX12990@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/2020 3:07 AM, Michal Hocko wrote:
> On Tue 22-09-20 10:07:26, Kirill A. Shutemov wrote:
>> On Mon, Sep 21, 2020 at 12:07:23PM -0700, Vijay Balakrishna wrote:
>>>>
>>>> I would recommend reposting the patch which adds heuristic for THP (if
>>>> THP is enabled) into the hotplug path, arguing with the consistency and
>>>> surprising results when adding memory decreases the value.
>>>
>>> I hope my reposted patch
>>> ([v3 1/2] mm: khugepaged: recalculate min_free_kbytes after memory hotplug
>>> as expected by khugepaged)
>>> change log is ok:
>>>
>>> When memory is hotplug added or removed the min_free_kbytes must be
>>> recalculated based on what is expected by khugepaged.  Currently
>>> after hotplug, min_free_kbytes will be set to a lower default and higher
>>> default set when THP enabled is lost.  This change restores min_free_kbytes
>>> as expected for THP consumers.
>>
>> Any scenario when hotremove would result in changing min_free_kbytes?
> 
> init_per_zone_wmark_min is called from both online and offline path. But
> I believe the problem is not in the offlining path. A decrease wrt
> previous auto tuned value is to be expected. The primary problem is that
> the hotadding memory after boot (without any user configured value) will
> decrease the value effectively because khugepaged tuning
> (set_recommended_min_free_kbytes) is not called.

Thank you Michal and Kirill.

Vijay
> 
