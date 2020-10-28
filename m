Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0EE729DA52
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387696AbgJ1XUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:20:52 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19147 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728764AbgJ1XUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:20:33 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f990a1c0000>; Tue, 27 Oct 2020 23:05:16 -0700
Received: from [10.2.58.85] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Oct
 2020 06:05:12 +0000
Subject: Re: [PATCH 1/2] mm: reorganize internal_get_user_pages_fast()
From:   John Hubbard <jhubbard@nvidia.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>
CC:     <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>, Peter Xu <peterx@redhat.com>
References: <1-v1-281e425c752f+2df-gup_fork_jgg@nvidia.com>
 <16c50bb0-431d-5bfb-7b80-a8af0b4da90f@nvidia.com>
 <20201027093301.GA16090@quack2.suse.cz> <20201027131509.GU36674@ziepe.ca>
 <0e04a7ed-a3e6-76f6-0fa8-26e2bbf10ee3@nvidia.com>
Message-ID: <ba1b04b8-fdab-e2e5-ef4c-8e65634ef92a@nvidia.com>
Date:   Tue, 27 Oct 2020 23:05:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <0e04a7ed-a3e6-76f6-0fa8-26e2bbf10ee3@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603865116; bh=X+ldJhBsOvVh/1070geeKle22duU4jw7H+CpDV2/1sI=;
        h=Subject:From:To:CC:References:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=DnD5otbjYnI47ggc/thGnUA0GcIybx3tHlgJyghnMMFJg4/lSn2N1x7ROmp4sjpGg
         lOx7uEftmo0gWF8/5ZPMeQACeRpJVunHyYCk1U7MP3uZETq6iQejnWk8I6sb3U0oec
         6oSCn3iDOCWXN8RdRgysuWD+yKUCcFP0H+x9WwqV1LmqcRiXd4RFJJNEE7t4vVyvRi
         /FH7Aj3lmMDIyTu70JDumdanGPK1mnblPO5IdpPJhUvBwmgwbr2AO20+E+nQq471jj
         rhe9Tj6toN/03uneNemBu5xffmgZTmlAj5hhT26F1K1uoUmqJ9LPRS3QpFX+Un9fiD
         66WxJrUya79nw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/20 11:00 PM, John Hubbard wrote:
> On 10/27/20 6:15 AM, Jason Gunthorpe wrote:
>> On Tue, Oct 27, 2020 at 10:33:01AM +0100, Jan Kara wrote:
>>> On Fri 23-10-20 21:44:17, John Hubbard wrote:
>>>> On 10/23/20 5:19 PM, Jason Gunthorpe wrote:
...
> 
> I'll fix up that one above (using your Reported-by, I assume), unless someone else is
> already taking care of it.
> 

ummm, strike that--that won't need fixing, it will pick up the fix automatically.
Arghh. Let me blame this on the late hour. haha :)


thanks,
-- 
John Hubbard
NVIDIA
