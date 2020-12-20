Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1602DF59A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 15:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbgLTN7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 08:59:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25208 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726467AbgLTN7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 08:59:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608472690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ygmL3q/5ll9cPmj4O5J98mOLWYORoXLNBSNGUyVxYN4=;
        b=HtqpMG6PU5CaStv9KQICKgogecGqQfrsaiJdAWMIvEcfil7bM4pFQJHTprfQPyJdD8zhsY
        7yk1ANaftS713jURmCImMI4kkqMaUTN+Rckf08a6s4FxWHDUkSFD7Gq6BAfdH8DaP2fwqX
        jFpnlJvrz7NMFYx4J8zYJsl8HimZTzw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-qLGM88QXPemeFrVfmyVfEA-1; Sun, 20 Dec 2020 08:58:08 -0500
X-MC-Unique: qLGM88QXPemeFrVfmyVfEA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E75BF1842141;
        Sun, 20 Dec 2020 13:58:06 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.9])
        by smtp.corp.redhat.com (Postfix) with SMTP id 141E960C61;
        Sun, 20 Dec 2020 13:58:04 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sun, 20 Dec 2020 14:58:06 +0100 (CET)
Date:   Sun, 20 Dec 2020 14:58:03 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC] exit: do exit_task_work() before shooting off mm
Message-ID: <20201220135803.GA16470@redhat.com>
References: <abab9af4e0d26358538a45a2826650e9cefd2924.1606961931.git.asml.silence@gmail.com>
 <20201208013722.GG3579531@ZenIV.linux.org.uk>
 <ce5be208-99eb-f7bd-e602-9361008ff83c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce5be208-99eb-f7bd-e602-9361008ff83c@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20, Pavel Begunkov wrote:
>
> On 08/12/2020 01:37, Al Viro wrote:
> > On Thu, Dec 03, 2020 at 02:30:46AM +0000, Pavel Begunkov wrote:
> >> Handle task works and lock it earlier before it starts killing off
> >> task's resources like mm. io_uring makes use of it a lot and it'd
> >> nicer to have all added task_work finding tasks in a consistent state.

I too do not understand this patch. task_work_add() will fail after
exit_task_work(). This means that, for example, exit_files() will use
schedule_delayed_work().

> One more moment, after we've set PF_EXITING any task_work_run() would be
> equivalent to exit_task_work()

Yes, currently task_work_run() can not be called after exit_signals().
And shouldn't be called imo ;)

> io_uring
> may want (currently doesn't) to run works for cancellation purposes.

Please see https://lore.kernel.org/io-uring/20200407163816.GB9655@redhat.com/

> Shouldn't it be like below (not tested)? Also simplifies task_work_run().

I'd prefer the patch from the link above, but your version looks correct too.
However, I still think it would be better to not abuse task_work_run() too
much...

Oleg.

