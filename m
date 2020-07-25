Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4309922D681
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jul 2020 11:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgGYJqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jul 2020 05:46:19 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50198 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726572AbgGYJqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 05:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595670377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PN2Xs/Q3DnIYM6SWZ/xYcx0QxiDyrNCnXxiRaYTtKSY=;
        b=FJhTvJluchvoj0+xfU/MglEGmQI+NF+iV7Qmjj4nHngE9zdFCZCqqMuiWOqobXYL2CRgqJ
        xJmnBsVLqY71M6QTfNanklnS8jI4p2Y8BYQHvfDbTsOZGU22E1rWQtbDl1aFAmerLduXhA
        GZEKaKQsyCfqoIK+v4fkSYBYmOZmRU8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-47sI9bpKMlmEqrHyB9koyw-1; Sat, 25 Jul 2020 05:46:13 -0400
X-MC-Unique: 47sI9bpKMlmEqrHyB9koyw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88AC480BCAC;
        Sat, 25 Jul 2020 09:39:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.25])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7DBA05F1EF;
        Sat, 25 Jul 2020 09:39:05 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sat, 25 Jul 2020 11:39:08 +0200 (CEST)
Date:   Sat, 25 Jul 2020 11:39:03 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
Message-ID: <20200725093902.GA3870@redhat.com>
References: <alpine.LSU.2.11.2007221359450.1017@eggly.anvils>
 <CAHk-=wi=vuc6sdu0m9nYd3gb8x5Xgnc6=TH=DTOy7qU96rZ9nw@mail.gmail.com>
 <CAHk-=whEjnsANEhTA3aqpNLZ3vv7huP7QAmcAEd-GUxm2YMo-Q@mail.gmail.com>
 <20200723124749.GA7428@redhat.com>
 <CAHk-=wgyc7en4=HddEYiz_RKJXfqe1JYv3BzHc=+_wYq9ti+LQ@mail.gmail.com>
 <CAHk-=whQK3OGwExTzCrwwvuuVaQAgs8KsR-Yv8m1BmXoNZZ=jQ@mail.gmail.com>
 <alpine.LSU.2.11.2007231549540.1016@eggly.anvils>
 <CAHk-=wgvGOnMF0ePU4xS236bOsP8jouj3rps+ysCaGXvCjh2Dg@mail.gmail.com>
 <20200724152424.GC17209@redhat.com>
 <CAHk-=whuG+5pUeUqdiW4gk0prvqu7GZSMo-6oWv5PdDC5dBr=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whuG+5pUeUqdiW4gk0prvqu7GZSMo-6oWv5PdDC5dBr=A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24, Linus Torvalds wrote:
>
> And in fact, once you do it on top of that, it becomes obvious that we
> can share even more code: move the WQ_FLAG_WOKEN logic _into_ the
> trylock_page_bit_common() function.

Ah, indeed, somehow I didn't realize this,

> I added your reviewed-by, but maybe you should double-check my changes.

Still looks correct to me, thanks.

Oleg.

