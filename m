Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64F01DC7C6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 09:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbgEUHfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 03:35:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:60224 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728245AbgEUHfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 03:35:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E0F3FACE3;
        Thu, 21 May 2020 07:35:39 +0000 (UTC)
Subject: Re: [PATCH v6 09/12] mmap locking API: add mmap_assert_locked() and
 mmap_assert_write_locked()
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
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>
References: <20200520052908.204642-1-walken@google.com>
 <20200520052908.204642-10-walken@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <b7e2e113-ea82-792e-18cc-3a1d604f62a7@suse.cz>
Date:   Thu, 21 May 2020 09:35:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200520052908.204642-10-walken@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/20 7:29 AM, Michel Lespinasse wrote:
> Add new APIs to assert that mmap_sem is held.
> 
> Using this instead of rwsem_is_locked and lockdep_assert_held[_write]
> makes the assertions more tolerant of future changes to the lock type.
> 
> Signed-off-by: Michel Lespinasse <walken@google.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
