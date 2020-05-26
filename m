Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7789A1C4A86
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 01:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgEDXoi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 May 2020 19:44:38 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:34839 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgEDXoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 19:44:38 -0400
Received: from [192.168.1.4] (50-39-163-217.bvtn.or.frontiernet.net [50.39.163.217])
        (Authenticated sender: josh@joshtriplett.org)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 23895240008;
        Mon,  4 May 2020 23:44:28 +0000 (UTC)
Date:   Mon, 04 May 2020 16:38:03 -0700
In-Reply-To: <CAKgT0Uf7e5514SOi8dmkB5oXUK9bwqD_z-5KJ_F3MUn3CAQyPQ@mail.gmail.com>
References: <20200430201125.532129-1-daniel.m.jordan@oracle.com> <20200430201125.532129-7-daniel.m.jordan@oracle.com> <CAKgT0Uf7e5514SOi8dmkB5oXUK9bwqD_z-5KJ_F3MUn3CAQyPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 6/7] mm: parallelize deferred_init_memmap()
To:     Alexander Duyck <alexander.duyck@gmail.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>, Zi Yan <ziy@nvidia.com>,
        linux-crypto@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Josh Triplett <josh@joshtriplett.org>
Message-ID: <3C3C62BE-6363-41C3-834C-C3124EB3FFAB@joshtriplett.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 4, 2020 3:33:58 PM PDT, Alexander Duyck <alexander.duyck@gmail.com> wrote:
>On Thu, Apr 30, 2020 at 1:12 PM Daniel Jordan
><daniel.m.jordan@oracle.com> wrote:
>>         /*
>> -        * Initialize and free pages in MAX_ORDER sized increments so
>> -        * that we can avoid introducing any issues with the buddy
>> -        * allocator.
>> +        * More CPUs always led to greater speedups on tested
>systems, up to
>> +        * all the nodes' CPUs.  Use all since the system is
>otherwise idle now.
>>          */
>
>I would be curious about your data. That isn't what I have seen in the
>past. Typically only up to about 8 or 10 CPUs gives you any benefit,
>beyond that I was usually cache/memory bandwidth bound.

I've found pretty much linear performance up to memory bandwidth, and on the systems I was testing, I didn't saturate memory bandwidth until about the full number of physical cores. From number of cores up to number of threads, the performance stayed about flat; it didn't get any better or worse.

- Josh
