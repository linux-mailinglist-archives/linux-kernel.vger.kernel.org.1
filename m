Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38C42CE574
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 03:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgLDCAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 21:00:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58129 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726028AbgLDCAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 21:00:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607047125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PcsI/8i8s21MPFmJfyYOyMMbKAfWF0mrFKbIFuaOgvo=;
        b=Df4qx4EQ/zdq9q4YaM+ufj9gNdpaIKwEFyCA01LRoadMfhRHkAd4fD/fif/dE7ihXurXSo
        ZGX82VznMTOTRyxJAoDqmE5lLq7btCqAMybciamipdl3Bhb6Mu0Ycxvi05hlT0R4vj5OCN
        tjFkwit01zyxiFIECZBhtISld/xXe+I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-0jl4hAROO8GO_A2F9x3dJA-1; Thu, 03 Dec 2020 20:58:41 -0500
X-MC-Unique: 0jl4hAROO8GO_A2F9x3dJA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25568107ACE4;
        Fri,  4 Dec 2020 01:58:39 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-98.rdu2.redhat.com [10.10.117.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8BCD91001901;
        Fri,  4 Dec 2020 01:58:33 +0000 (UTC)
Subject: Re: [PATCH 1/3] rwsem: Implement down_read_killable_nested
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
 <87o8jabqh3.fsf@x220.int.ebiederm.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <c4e66f5a-a48c-5a72-a733-9e1bcd77274a@redhat.com>
Date:   Thu, 3 Dec 2020 20:58:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <87o8jabqh3.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/20 3:10 PM, Eric W. Biederman wrote:
> In preparation for converting exec_update_mutex to a rwsem so that
> multiple readers can execute in parallel and not deadlock, add
> down_read_killable_nested.  This is needed so that kcmp_lock
> can be converted from working on a mutexes to working on rw_semaphores.
>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
>   include/linux/rwsem.h  |  2 ++
>   kernel/locking/rwsem.c | 14 ++++++++++++++
>   2 files changed, 16 insertions(+)
>
> diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
> index 25e3fde85617..13021b08b2ed 100644
> --- a/include/linux/rwsem.h
> +++ b/include/linux/rwsem.h
> @@ -171,6 +171,7 @@ extern void downgrade_write(struct rw_semaphore *sem);
>    * See Documentation/locking/lockdep-design.rst for more details.)
>    */
>   extern void down_read_nested(struct rw_semaphore *sem, int subclass);
> +extern int __must_check down_read_killable_nested(struct rw_semaphore *sem, int subclass);
>   extern void down_write_nested(struct rw_semaphore *sem, int subclass);
>   extern int down_write_killable_nested(struct rw_semaphore *sem, int subclass);
>   extern void _down_write_nest_lock(struct rw_semaphore *sem, struct lockdep_map *nest_lock);
> @@ -191,6 +192,7 @@ extern void down_read_non_owner(struct rw_semaphore *sem);
>   extern void up_read_non_owner(struct rw_semaphore *sem);
>   #else
>   # define down_read_nested(sem, subclass)		down_read(sem)
> +# define down_read_killable_nested(sem, subclass)	down_read_killable(sem)
>   # define down_write_nest_lock(sem, nest_lock)	down_write(sem)
>   # define down_write_nested(sem, subclass)	down_write(sem)
>   # define down_write_killable_nested(sem, subclass)	down_write_killable(sem)
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index f11b9bd3431d..54d11cb97551 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -1605,6 +1605,20 @@ void down_read_nested(struct rw_semaphore *sem, int subclass)
>   }
>   EXPORT_SYMBOL(down_read_nested);
>   
> +int down_read_killable_nested(struct rw_semaphore *sem, int subclass)
> +{
> +	might_sleep();
> +	rwsem_acquire_read(&sem->dep_map, subclass, 0, _RET_IP_);
> +
> +	if (LOCK_CONTENDED_RETURN(sem, __down_read_trylock, __down_read_killable)) {
> +		rwsem_release(&sem->dep_map, _RET_IP_);
> +		return -EINTR;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(down_read_killable_nested);
> +
>   void _down_write_nest_lock(struct rw_semaphore *sem, struct lockdep_map *nest)
>   {
>   	might_sleep();

Acked-by: Waiman Long <longman@redhat.com>

-Longman

