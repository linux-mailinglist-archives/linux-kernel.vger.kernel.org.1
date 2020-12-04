Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803FC2CE578
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 03:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgLDCAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 21:00:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22515 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725960AbgLDCAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 21:00:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607047165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AO9KskpXVmAduaic0zCXBgWNAte8nJh9/1a58DWq0Gw=;
        b=Tnz/EzaCTvjOVaIZWSQWsCKff+UzSA+d7jpCOcht3DHtw8vgzbVb4oaIIb0x2deyEJW9hN
        oaEZ7TjExqdXvtCmy+kHy+L9bvXGgRCrV5qiuiDnfxIGRHN91hbwyhbBuUb4xYJ7xP7HX8
        bsV7E5nRoAxL4hnpOLH8RDuEWI4uN8s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-ESXzDMVUOfKMufvWxj-Q8g-1; Thu, 03 Dec 2020 20:59:21 -0500
X-MC-Unique: ESXzDMVUOfKMufvWxj-Q8g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD4391005513;
        Fri,  4 Dec 2020 01:59:18 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-98.rdu2.redhat.com [10.10.117.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 319671001901;
        Fri,  4 Dec 2020 01:59:14 +0000 (UTC)
Subject: Re: [PATCH 2/3] rwsem: Implement down_read_interruptible
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jann Horn <jannh@google.com>,
        Vasiliy Kulikov <segoon@openwall.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Christopher Yeoh <cyeoh@au1.ibm.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <87tut2bqik.fsf@x220.int.ebiederm.org>
 <87k0tybqfy.fsf@x220.int.ebiederm.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <620f0908-c70a-9e54-e1b5-71d086b20756@redhat.com>
Date:   Thu, 3 Dec 2020 20:59:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <87k0tybqfy.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/20 3:11 PM, Eric W. Biederman wrote:
> In preparation for converting exec_update_mutex to a rwsem so that
> multiple readers can execute in parallel and not deadlock, add
> down_read_interruptible.  This is needed for perf_event_open to be
> converted (with no semantic changes) from working on a mutex to
> wroking on a rwsem.
>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
>   include/linux/rwsem.h  |  1 +
>   kernel/locking/rwsem.c | 26 ++++++++++++++++++++++++++
>   2 files changed, 27 insertions(+)
>
> diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
> index 13021b08b2ed..4c715be48717 100644
> --- a/include/linux/rwsem.h
> +++ b/include/linux/rwsem.h
> @@ -123,6 +123,7 @@ static inline int rwsem_is_contended(struct rw_semaphore *sem)
>    * lock for reading
>    */
>   extern void down_read(struct rw_semaphore *sem);
> +extern int __must_check down_read_interruptible(struct rw_semaphore *sem);
>   extern int __must_check down_read_killable(struct rw_semaphore *sem);
>   
>   /*
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 54d11cb97551..a163542d178e 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -1345,6 +1345,18 @@ static inline void __down_read(struct rw_semaphore *sem)
>   	}
>   }
>   
> +static inline int __down_read_interruptible(struct rw_semaphore *sem)
> +{
> +	if (!rwsem_read_trylock(sem)) {
> +		if (IS_ERR(rwsem_down_read_slowpath(sem, TASK_INTERRUPTIBLE)))
> +			return -EINTR;
> +		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
> +	} else {
> +		rwsem_set_reader_owned(sem);
> +	}
> +	return 0;
> +}
> +
>   static inline int __down_read_killable(struct rw_semaphore *sem)
>   {
>   	if (!rwsem_read_trylock(sem)) {
> @@ -1495,6 +1507,20 @@ void __sched down_read(struct rw_semaphore *sem)
>   }
>   EXPORT_SYMBOL(down_read);
>   
> +int __sched down_read_interruptible(struct rw_semaphore *sem)
> +{
> +	might_sleep();
> +	rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
> +
> +	if (LOCK_CONTENDED_RETURN(sem, __down_read_trylock, __down_read_interruptible)) {
> +		rwsem_release(&sem->dep_map, _RET_IP_);
> +		return -EINTR;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(down_read_interruptible);
> +
>   int __sched down_read_killable(struct rw_semaphore *sem)
>   {
>   	might_sleep();

Acked-by: Waiman Long <longman@redhat.com>

-Longman

