Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBE02B9B22
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 20:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgKSTEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 14:04:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60687 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726886AbgKSTEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 14:04:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605812647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1qNxLY7LLhUH6+ZHrJNh82Tq2sizSDbuMmtO7hAo1E4=;
        b=biR031L0aFb4IhStVNFtnqK6UE9luGUO+VvmWDt/fSMJOGPTPMTN2QQbU8UkdZ1NM7GuAK
        wrDJV/hlJCg7EVlc31D2ORUB/8eKN1rAqApQSaHpiGt5kR9+bzTwiq3r2Obh1ZpiZdkkOk
        AWj3AcfE04j2Ypv270Ck0n66ElYlLYU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-LbHB2hLRMcWuB9cQjprhtA-1; Thu, 19 Nov 2020 14:04:05 -0500
X-MC-Unique: LbHB2hLRMcWuB9cQjprhtA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7ED1881440E;
        Thu, 19 Nov 2020 19:04:04 +0000 (UTC)
Received: from mail (ovpn-113-32.rdu2.redhat.com [10.10.113.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 062EA5C1D1;
        Thu, 19 Nov 2020 19:03:59 +0000 (UTC)
Date:   Thu, 19 Nov 2020 14:03:58 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] x86: restore the write back cache of reserved RAM in
 iounmap()
Message-ID: <X7bBnsSJk33IyY6k@redhat.com>
References: <20201119175902.17394-1-aarcange@redhat.com>
 <20201119180206.GA24054@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119180206.GA24054@infradead.org>
User-Agent: Mutt/2.0.0 (2020-11-07)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christoph,

On Thu, Nov 19, 2020 at 06:02:06PM +0000, Christoph Hellwig wrote:
> What is the callers?  The whole SetPageReservered + ioremap* thing
> you mention in the actual patch is completely bogus.  I think we'll
> need to reject that as well and fix the caller.

The actual caller is not so much the focus here: the point here is to
be able to either handle the caller gracefully or to get a synchronous
kernel crash in __free_pages.

Otherwise the problem induced by such a caller (no matter if right or
wrong) becomes hardly debuggable.

The caller in question was the EFI_BOOT_SERVICE_DATA that is aliased
on non RAM but then freed later by swapping RAM under it.

Of course the caller has already been changed to stick to write back
and that specific caller is not a concern anymore. My concern is if we
leave the callee (iounmap) as it is, what does guarantee us that we
won't hit again in production a few years down the road?

When I first read the caller it felt nothing should have gone wrong,
it looked ok even the version that would leave PCD leftovers bits in
the direct map. So I didn't get why switching to write back would
prevent the PCD leftovers until I looked at the callee (iounmap).

Thanks,
Andrea

