Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90ED287B27
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 19:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731657AbgJHRqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 13:46:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:54564 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbgJHRqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 13:46:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BF51BAFC8;
        Thu,  8 Oct 2020 17:46:21 +0000 (UTC)
Subject: Re: [PATCH v2 7/7] mm, page_alloc: disable pcplists during memory
 offline
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <20201008114201.18824-1-vbabka@suse.cz>
 <20201008114201.18824-8-vbabka@suse.cz>
 <20201008124534.GD4967@dhcp22.suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <0a19a42c-34fe-1f52-1e6e-d82295fa5ae7@suse.cz>
Date:   Thu, 8 Oct 2020 19:46:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201008124534.GD4967@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/20 2:45 PM, Michal Hocko wrote:
> On Thu 08-10-20 13:42:01, Vlastimil Babka wrote:
>> Memory offline relies on page isolation can race with process freeing pages to
>> pcplists in a way that a page from isolated pageblock can end up on pcplist.
> 
> "Memory offlining relies on page isolation to guarantee a forward
> progress because pages cannot be reused while they are isolated. But the
> page isolation itself doesn't prevent from races while freed pages are
> stored on pcp lists and thus can be reused.
> "

Much better, thanks.

