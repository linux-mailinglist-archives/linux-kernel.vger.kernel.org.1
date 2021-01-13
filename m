Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED532F49CE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbhAMLPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:15:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:58650 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727555AbhAMLPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:15:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 59C0BAEE0;
        Wed, 13 Jan 2021 11:14:59 +0000 (UTC)
Date:   Wed, 13 Jan 2021 12:14:56 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andi Kleen <ak@linux.intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v4 4/6] mm: hugetlb: retry dissolve page
 when hitting race
Message-ID: <20210113111449.GA26873@linux>
References: <20210113052209.75531-1-songmuchun@bytedance.com>
 <20210113052209.75531-5-songmuchun@bytedance.com>
 <20210113093331.GV22493@dhcp22.suse.cz>
 <CAMZfGtUObSSyRZfv8CHucp6WmUZZBupKD9hbNHVpAv_PuWtMhw@mail.gmail.com>
 <20210113103836.GW22493@dhcp22.suse.cz>
 <CAMZfGtUTZZyL6Pdop-SHt2vs2hLuYfB9dumhRHBm7QLzyRNzZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtUTZZyL6Pdop-SHt2vs2hLuYfB9dumhRHBm7QLzyRNzZA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 07:11:06PM +0800, Muchun Song wrote:
> If there is no task to be scheduled. Here is just a while loop.
> The cpu_relax is a good thing to insert into busy-wait loops,
> right?

But if the race window is that small, does it make sense?

-- 
Oscar Salvador
SUSE L3
