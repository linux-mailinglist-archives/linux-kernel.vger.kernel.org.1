Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887CB1D7429
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 11:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgERJg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 05:36:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:48196 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbgERJg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 05:36:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5F45EAC46;
        Mon, 18 May 2020 09:36:58 +0000 (UTC)
Subject: Re: [PATCH v5 04/10] mmap locking API: use coccinelle to convert
 mmap_sem rwsem call sites
To:     Michel Lespinasse <walken@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
References: <20200422001422.232330-1-walken@google.com>
 <20200422001422.232330-5-walken@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <54ad4f32-ffa7-e418-24de-2e410361300e@suse.cz>
Date:   Mon, 18 May 2020 11:36:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422001422.232330-5-walken@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/20 2:14 AM, Michel Lespinasse wrote:
> This change converts the existing mmap_sem rwsem calls to use the new
> mmap locking API instead.
> 
> The change is generated using coccinelle with the following rule:
> 
> // spatch --sp-file mmap_lock_api.cocci --in-place --include-headers --dir .
> 
> @@
> expression mm;
> @@
> (
> -init_rwsem
> +mmap_init_lock
> |
> -down_write
> +mmap_write_lock
> |
> -down_write_killable
> +mmap_write_lock_killable
> |
> -down_write_trylock
> +mmap_write_trylock
> |
> -up_write
> +mmap_write_unlock
> |
> -downgrade_write
> +mmap_write_downgrade
> |
> -down_read
> +mmap_read_lock
> |
> -down_read_killable
> +mmap_read_lock_killable
> |
> -down_read_trylock
> +mmap_read_trylock
> |
> -up_read
> +mmap_read_unlock
> )
> -(&mm->mmap_sem)
> +(mm)
> 
> Signed-off-by: Michel Lespinasse <walken@google.com>
> Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
