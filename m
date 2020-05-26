Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB7F19FD2F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 20:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgDFS35 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Apr 2020 14:29:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:56644 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgDFS35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 14:29:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 91434AF85;
        Mon,  6 Apr 2020 18:29:54 +0000 (UTC)
Date:   Mon, 6 Apr 2020 09:03:56 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     Michel Lespinasse <walken@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>
Subject: Re: [PATCH 8/8] mmap locking API: rename mmap_sem to mmap_lock
Message-ID: <20200406160356.py26by67dhprte5d@linux-p48b>
Mail-Followup-To: Laurent Dufour <ldufour@linux.ibm.com>,
        Michel Lespinasse <walken@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>
References: <20200326070236.235835-1-walken@google.com>
 <20200326070236.235835-9-walken@google.com>
 <4eaa33a1-8144-253e-ac99-eeb354b6f871@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <4eaa33a1-8144-253e-ac99-eeb354b6f871@linux.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Apr 2020, Laurent Dufour wrote:

>Le 26/03/2020 � 08:02, Michel Lespinasse a �crit�:
>>Rename the mmap_sem field to mmap_lock. Any new uses of this lock
>>should now go through the new mmap locking api. The mmap_lock is
>>still implemented as a rwsem, though this could change in the future.
>
>Since you don't change the type of the mmap_sem, it's still a 
>semaphore, I don't think mmap_lock is a good name. This is not a lock.

Well a semaphore is still a kind of lock. I think the naming in this
patch is good and generic enough.

Thanks,
Davidlohr
