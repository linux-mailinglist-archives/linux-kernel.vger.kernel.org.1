Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F2B2EFBC5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 00:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbhAHXlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 18:41:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28220 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725763AbhAHXlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 18:41:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610149192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o+/HDfNx715tlUSpPNBNlGjDUHVImncoNqnzgPVg4XM=;
        b=gMmUSCRXsSZkL/jWyZf6KdExW4dXBdgYUOc4dfMpyXARZtEGLBGfclTwQ1rHadOgFkbnqr
        FjwYr4qsXySwVVVBEAjTS4L0FMCqNTquLoF12iS1kE6vDTMNQIGPrzYA4ob+ZpGPnI+IH9
        03XdD1BeDrjH7dq7sA3Nmhxnqsnp3Ew=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-8GBRF_-gM7ys2yzfyiPmgQ-1; Fri, 08 Jan 2021 18:39:48 -0500
X-MC-Unique: 8GBRF_-gM7ys2yzfyiPmgQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 139AB801817;
        Fri,  8 Jan 2021 23:39:47 +0000 (UTC)
Received: from mail (ovpn-112-222.rdu2.redhat.com [10.10.112.222])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EE856709A4;
        Fri,  8 Jan 2021 23:39:43 +0000 (UTC)
Date:   Fri, 8 Jan 2021 18:39:43 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>,
        Yu Zhao <yuzhao@google.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] x86/vm86/32: Remove VM86_SCREEN_BITMAP support
Message-ID: <X/jtP5sqLjF9Iie4@redhat.com>
References: <3d34069ab2d249d866ea1d18a47e4170dbfb5982.1610132102.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d34069ab2d249d866ea1d18a47e4170dbfb5982.1610132102.git.luto@kernel.org>
User-Agent: Mutt/2.0.4 (2020-12-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 10:55:05AM -0800, Andy Lutomirski wrote:
> The implementation was rather buggy.  It unconditionally marked PTEs
> released the mmap lock before flushing the TLB, which could allow a racing
> CoW operation to falsely believe that the underlying memory was not
> writable.
> 
> I can't find any users at all of this mechanism, so just remove it.

Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>

