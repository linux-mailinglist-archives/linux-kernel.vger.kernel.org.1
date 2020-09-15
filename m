Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5077269DAD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 07:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgIOFEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 01:04:14 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38718 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgIOFEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 01:04:13 -0400
Received: from [192.168.0.121] (unknown [209.134.121.133])
        by linux.microsoft.com (Postfix) with ESMTPSA id 45C3F209F317;
        Mon, 14 Sep 2020 22:04:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 45C3F209F317
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600146252;
        bh=npcy577ZxUqCs2+tnngCijE6kMnP6yWhvgdFcTGoUoU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Iwj5XWIyffOpY1YLj6C7ibWbSJotcOLYCjz1epzoHcGF3bhatzP/yCOosq6gMdzXS
         ocQ6CphCNubdvpOiD7NHRSREo7biPUWo0GGuXeyXy9G7fXpV4R7Z1mhH1HXMAIJZub
         qqg1sVG5btovd/VYQvLSHpzVfcDIxjgs6Hkcn8mc=
Subject: Re: [[PATCH]] mm: khugepaged: recalculate min_free_kbytes after
 memory hotplug as expected by khugepaged
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Allen Pais <apais@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <1599770859-14826-1-git-send-email-vijayb@linux.microsoft.com>
 <20200910220145.5j7iogqulmvg5vr6@black.fi.intel.com>
From:   Vijay Balakrishna <vijayb@linux.microsoft.com>
Message-ID: <041b4c73-42b0-5cb1-716f-0a0d466fcdf0@linux.microsoft.com>
Date:   Mon, 14 Sep 2020 22:04:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200910220145.5j7iogqulmvg5vr6@black.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/10/2020 3:01 PM, Kirill A. Shutemov wrote:
> On Thu, Sep 10, 2020 at 01:47:39PM -0700, Vijay Balakrishna wrote:
>> When memory is hotplug added or removed the min_free_kbytes must be
>> recalculated based on what is expected by khugepaged.  Currently
>> after hotplug, min_free_kbytes will be set to a lower default and higher
>> default set when THP enabled is lost. This leaves the system with small
>> min_free_kbytes which isn't suitable for systems especially with network
>> intensive loads.  Typical failure symptoms include HW WATCHDOG reset,
>> soft lockup hang notices, NETDEVICE WATCHDOG timeouts, and OOM process
>> kills.
>>
>> Fixes: f000565adb77 ("thp: set recommended min free kbytes")
>>
>> Signed-off-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
>> Cc: stable@vger.kernel.org
> 
> NAK. It would override min_free_kbytes set by user.

Hi Kirill,

To fix the issue you raised I just submitted
https://lore.kernel.org/lkml/1600145748-26518-1-git-send-email-vijayb@linux.microsoft.com/

Thanks,
Vijay

> 
