Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024592FCCDD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 09:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730947AbhATIjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 03:39:33 -0500
Received: from foss.arm.com ([217.140.110.172]:50288 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729747AbhATIht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 03:37:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1131711B3;
        Wed, 20 Jan 2021 00:37:01 -0800 (PST)
Received: from [10.163.90.172] (unknown [10.163.90.172])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84E963F68F;
        Wed, 20 Jan 2021 00:36:56 -0800 (PST)
Subject: Re: [PATCH V3 0/3] mm/memory_hotplug: Pre-validate the address range
 with platform
To:     Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hca@linux.ibm.com,
        catalin.marinas@arm.com, Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1610975582-12646-1-git-send-email-anshuman.khandual@arm.com>
 <d57036a1-de12-2d32-be65-daaa3dc5b772@redhat.com>
 <20210119134016.GA23408@linux>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <8df4e1e1-1ddd-398e-c9a6-17a67d8a95bc@arm.com>
Date:   Wed, 20 Jan 2021 14:07:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210119134016.GA23408@linux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/19/21 7:10 PM, Oscar Salvador wrote:
> On Tue, Jan 19, 2021 at 02:33:03PM +0100, David Hildenbrand wrote:
>> Minor thing, we should make up our mind if we want to call stuff
>> internally "memhp_" or "mhp". I prefer the latter, because it is shorter.
> 
> I would rather use the latter as well. I used that in [1].

Okay, will change all that is 'memhp' as 'mhp' instead.

> MEMHP_MERGE_RESOURCE should be renamed if we agree on that.
> 
> [1] https://patchwork.kernel.org/project/linux-mm/cover/20201217130758.11565-1-osalvador@suse.de/
> 
> 
