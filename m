Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37048206AD1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 05:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388797AbgFXD40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 23:56:26 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:57567 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388393AbgFXD40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 23:56:26 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0U0YpXZ6_1592970982;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U0YpXZ6_1592970982)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 24 Jun 2020 11:56:22 +0800
Date:   Wed, 24 Jun 2020 11:56:22 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm/spase: never partially remove memmap for early section
Message-ID: <20200624035622.GA10774@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200623094258.6705-1-richard.weiyang@linux.alibaba.com>
 <CAPcyv4ipnZ2jXd-obBk4KMGPNz4DMu0jGXFEEPCnST+A2zR+Uw@mail.gmail.com>
 <20200624014737.GG3346@MiWiFi-R3L-srv>
 <20200624034638.GA10687@L-31X9LVDL-1304.local>
 <20200624035236.GI3346@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624035236.GI3346@MiWiFi-R3L-srv>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 11:52:36AM +0800, Baoquan He wrote:
>On 06/24/20 at 11:46am, Wei Yang wrote:
>> On Wed, Jun 24, 2020 at 09:47:37AM +0800, Baoquan He wrote:
>> >On 06/23/20 at 05:21pm, Dan Williams wrote:
>> >> On Tue, Jun 23, 2020 at 2:43 AM Wei Yang
>> >> <richard.weiyang@linux.alibaba.com> wrote:
>> >> >
>> >> > For early sections, we assumes its memmap will never be partially
>> >> > removed. But current behavior breaks this.
>> >> 
>> >> Where do we assume that?
>> >> 
>> >> The primary use case for this was mapping pmem that collides with
>> >> System-RAM in the same 128MB section. That collision will certainly be
>> >> depopulated on-demand depending on the state of the pmem device. So,
>> >> I'm not understanding the problem or the benefit of this change.
>> >
>> >I was also confused when review this patch, the patch log is a little
>> >short and simple. From the current code, with SPARSE_VMEMMAP enabled, we
>> >do build memmap for the whole memory section during boot, even though
>> >some of them may be partially populated. We just mark the subsection map
>> >for present pages. 
>> >
>> >Later, if pmem device is mapped into the partially boot memory section,
>> >we just fill the relevant subsection map, do return directly, w/o building
>> >the memmap for it, in section_activate(). Because the memmap for the
>> >unpresent RAM part have been there. I guess this is what Wei is trying to 
>> >do to keep the behaviour be consistent for pmem device adding, or
>> >pmem device removing and later adding again.
>> >
>> >Please correct me if I am wrong.
>> 
>> You are right here.
>> 
>> >
>> >To me, fixing it looks good. But a clear doc or code comment is
>> >necessary so that people can understand the code with less time.
>> >Leaving it as is doesn't cause harm. I personally tend to choose
>> >the former.
>> >
>> 
>> The former is to add a clear doc?
>
>Sorry for the confusion. The former means the fix in your patch. Maybe a
>improved log and some code comment adding can make it more perfect.
>

Sure, I would try to add more log and comments, in case you have some good
suggestion, just let me know :)

-- 
Wei Yang
Help you, Help me
