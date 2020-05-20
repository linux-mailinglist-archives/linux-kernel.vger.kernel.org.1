Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07A31DAC3B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 09:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgETHcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 03:32:55 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:3330 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgETHcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 03:32:54 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec4dd1a0001>; Wed, 20 May 2020 00:32:42 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 20 May 2020 00:32:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 20 May 2020 00:32:54 -0700
Received: from [10.2.90.179] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 20 May
 2020 07:32:54 +0000
Subject: Re: [PATCH v5.5 10/10] mmap locking API: rename mmap_sem to mmap_lock
To:     Michel Lespinasse <walken@google.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
References: <20200422001422.232330-1-walken@google.com>
 <20200422001422.232330-11-walken@google.com>
 <20200422015829.GR5820@bombadil.infradead.org>
 <CANN689EnGsJXA8n6JvTryQfkCtARPvtZbkH+9Dd2a4X+fvqU9g@mail.gmail.com>
 <20200423015917.GA13910@bombadil.infradead.org>
 <20200424012612.GA158937@google.com> <20200424013958.GC158937@google.com>
 <f20ab834-cddb-eaa7-c03e-18f0c4897a33@linux.ibm.com>
 <20200519131009.GD189720@google.com>
 <7c540ac9-ba44-7187-5dc2-60b4c761e91c@linux.ibm.com>
 <20200519153251.GY16070@bombadil.infradead.org>
 <10d48b77-5c6e-2e10-84e6-16cdd76a45f1@nvidia.com>
 <CANN689EubtJL2mbcz5Au05nW87gVuY-19r7nZd9x0y320PUb0g@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <9c45327f-5542-c033-ec5e-201e9b0583aa@nvidia.com>
Date:   Wed, 20 May 2020 00:32:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CANN689EubtJL2mbcz5Au05nW87gVuY-19r7nZd9x0y320PUb0g@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589959962; bh=VfcekzJCan2B7C+vng8WaKitp9wnyMh8WoZOorv+eKA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=sKQjNrWs7FFZ5lMu/k6F8hbVIhDRoE1dadrgLMiGhCOG+Impk1HvTYGl6l/l0TpY5
         GnD0bQS4zFK82fSIzAmzD6Cq5lJYQUFnIadRE+xNaIhZrxB9Z5OclF+Xfmm9oJEdmW
         YWs31UueL0HhlA2UhytrcYxLA+AjZylmGRguiyIFg3gTaDQmp0SKJe9SJMd2nqXORF
         hkKGCnHoY7g82M18x+Tgd+zL+U5WqB1n2b/AbbKR5/9fdwm95rk8gYXEWJ7QMuGdAL
         vTSAJzOdDAAUTdUBQw+7nTKnUJhHdT+QXaiHb48sZyXzuJ3glfEps8t6mTT3p4Npw+
         k1IPqqsDB6rgQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-19 19:39, Michel Lespinasse wrote:
...
>> That gives you additional options inside internal_get_user_pages_fast(), such
>> as, approximately:
>>
>> if (!(gup_flags & FOLL_FAST_ONLY))
>>          might_lock_read(&current->mm->mmap_lock);
>>
>> ...not that that is necessarily a great idea, seeing as how it merely changes
>> "might lock" into "maybe might lock".  :)
> 
> I think that is completely fine, makes sure everyone not using
> FOLL_FAST_ONLY realizes that the call could block.
> 
> Can I ask you to add that assertion in your patchset ? Based on
> Matthew's feedback, I would do it in my patchset, but it doesn't seem
> worth doing if we know this will conflict with your changes.
> 

Sure, that's no problem. Although it looks like my changes may land
in mmotm first, and then your patchset, so maybe the right move is to
make this change *after* both of those things happen, yes?


thanks,
-- 
John Hubbard
NVIDIA
