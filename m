Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D528259738
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 18:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731316AbgIAQMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 12:12:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42000 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731318AbgIAQMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 12:12:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598976727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y+b5xXaX5m8wZ2FgPgUYG/nIzSZ1Byhj+uYXSWe5fXo=;
        b=Md535z7Iup0mjWemE0OShauqwxSQ3MXOLmp+t001O+IRDcCuDVSJGYiWoXL7qjyWRtQE7z
        EQ9Jjjz9cdfwO7i9xCbaHV9umtT4dacihpHe7gUx3TXzkjBzkuYu7cq9ggPAtm0wTjHfM7
        6R0KJbawlDqF0GXvMyB6LNLme5e4OHo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-TlXE-Fu8OJ2wdU5uqK2MJQ-1; Tue, 01 Sep 2020 12:12:05 -0400
X-MC-Unique: TlXE-Fu8OJ2wdU5uqK2MJQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EB8510ABDAB;
        Tue,  1 Sep 2020 16:12:02 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.114])
        by smtp.corp.redhat.com (Postfix) with SMTP id 333F01002D51;
        Tue,  1 Sep 2020 16:11:56 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  1 Sep 2020 18:12:02 +0200 (CEST)
Date:   Tue, 1 Sep 2020 18:11:54 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-kselftest@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Jens Axboe <axboe@kernel.dk>, linux-api@vger.kernel.org,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 2/4] exit: support non-blocking pidfds
Message-ID: <20200901161154.GA4386@redhat.com>
References: <20200831134551.1599689-1-christian.brauner@ubuntu.com>
 <20200831134551.1599689-3-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831134551.1599689-3-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/31, Christian Brauner wrote:
>
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -934,6 +934,7 @@ struct wait_opts {
>  
>  	wait_queue_entry_t		child_wait;
>  	int			notask_error;
> +	int			eagain_error;
>  };
>  
>  static int eligible_pid(struct wait_opts *wo, struct task_struct *p)
> @@ -1461,6 +1462,8 @@ static long do_wait(struct wait_opts *wo)
>  
>  notask:
>  	retval = wo->notask_error;
> +	if (!retval)
> +		retval = wo->eagain_error;
>  	if (!retval && !(wo->wo_flags & WNOHANG)) {
>  		retval = -ERESTARTSYS;

I must have missed something but I don't understand why do we need
the new ->eagain_error and the change in do_wait().

> @@ -1544,6 +1551,11 @@ static long kernel_waitid(int which, pid_t upid, struct waitid_info *infop,
>  	wo.wo_flags	= options;
>  	wo.wo_info	= infop;
>  	wo.wo_rusage	= ru;
> +	wo.eagain_error = 0;
> +	if (f_flags & O_NONBLOCK) {
> +		wo.wo_flags	|= WNOHANG;
> +		wo.eagain_error	= -EAGAIN;
> +	}
>  	ret = do_wait(&wo);

Can't kernel_waitid() simply do

	if (f_flags & O_NONBLOCK)
		wo.wo_flags |= WNOHANG;
	ret = do_wait();
	if (!ret & (f_flags & O_NONBLOCK))
		ret = -EAGAIN;

?

Oleg.

