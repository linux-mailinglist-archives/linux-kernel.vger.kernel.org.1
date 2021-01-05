Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974562EB26E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 19:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbhAESWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 13:22:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55547 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727875AbhAESWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 13:22:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609870865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wOGZ4SXcv5XhB1eUlHk/uUKIqAYwbBMmvsDuvaV4E7Q=;
        b=EC7ogexiiu/pzFRU9kUZEBkhk6fmvaK0DN3drbJGYWw8OfWoDitt6Qx4XodRjOoDIoDz7k
        VTPc8oOGwgfCEgWJeAUwADPlVbYspTKL3yB07EMDtcVJWw1meDMqBJ/S75kT1o2tUGY69x
        s2THdk1abnyiE1Le7XIV3girFJ0PHvg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-tynonjhpMzquqVP_ui9CGA-1; Tue, 05 Jan 2021 13:21:01 -0500
X-MC-Unique: tynonjhpMzquqVP_ui9CGA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AC0580F044;
        Tue,  5 Jan 2021 18:20:59 +0000 (UTC)
Received: from mail (ovpn-112-76.rdu2.redhat.com [10.10.112.76])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 36B7B5D9DD;
        Tue,  5 Jan 2021 18:20:56 +0000 (UTC)
Date:   Tue, 5 Jan 2021 13:20:55 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>, Yu Zhao <yuzhao@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2 2/2] fs/task_mmu: acquire mmap_lock for write on
 soft-dirty cleanup
Message-ID: <X/SuBxFfR+bncRhU@redhat.com>
References: <20201225092529.3228466-1-namit@vmware.com>
 <20201225092529.3228466-3-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201225092529.3228466-3-namit@vmware.com>
User-Agent: Mutt/2.0.4 (2020-12-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 25, 2020 at 01:25:29AM -0800, Nadav Amit wrote:
> Fixes: 0f8975ec4db2 ("mm: soft-dirty bits for user memory changes tracking")

Targeting a backport down to 2013 when nothing could wrong in practice
with page_mapcount sounds backwards and unnecessarily risky.

In theory it was already broken and in theory
09854ba94c6aad7886996bfbee2530b3d8a7f4f4 is absolutely perfect and the
previous code of 2013 is completely wrong, but in practice the code
from 2013 worked perfectly until Aug 21 2020.

Since nothing at all could go wrong in soft dirty and uffd-wp until
09854ba94c6aad7886996bfbee2530b3d8a7f4f4, the Fixes need to target
that, definitely not a patch from 2013.

This means the backports will apply clean, they don't need a simple
solution but one that doesn't regress the performance of open source
virtual machines and open source products using clear_refs and uffd-wp
in general.

Thanks,
Andrea

