Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4F42497CD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 09:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgHSH4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 03:56:13 -0400
Received: from foss.arm.com ([217.140.110.172]:57586 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbgHSH4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 03:56:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 766AA1FB;
        Wed, 19 Aug 2020 00:56:11 -0700 (PDT)
Received: from [10.163.66.190] (unknown [10.163.66.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E0223F6CF;
        Wed, 19 Aug 2020 00:56:08 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] mm/pageblock: mitigation cmpxchg false sharing in
 pageblock flags
To:     Alex Shi <alex.shi@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1597816075-61091-1-git-send-email-alex.shi@linux.alibaba.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <8ec2a4b0-9e51-abf9-fa7a-29989d3f1fac@arm.com>
Date:   Wed, 19 Aug 2020 13:25:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1597816075-61091-1-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/19/2020 11:17 AM, Alex Shi wrote:
> pageblock_flags is used as long, since every pageblock_flags is just 4
> bits, 'long' size will include 8(32bit machine) or 16 pageblocks' flags,
> that flag setting has to sync in cmpxchg with 7 or 15 other pageblock
> flags. It would cause long waiting for sync.
> 
> If we could change the pageblock_flags variable as char, we could use
> char size cmpxchg, which just sync up with 2 pageblock flags. it could
> relief much false sharing in cmpxchg.

Do you have numbers demonstrating claimed performance improvement
after this change ?
