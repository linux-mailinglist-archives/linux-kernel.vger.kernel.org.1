Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE8E2CE570
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 02:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgLDB5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 20:57:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27802 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725885AbgLDB5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 20:57:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607046986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AF4gEX/vocn6ADKGRD/a87GO0jg5J5yO20C1aSjch7U=;
        b=QPzUPtwFwFzxKI0RBVJEd/NREsPxOY111xbbLPNhvPm3GEIjAfYzOzwDW2v+R+vnRFQBlC
        FV0A00wupcow0ipqL+CNnbDKxhoisRodEAdRS/yxhkAPlgq9xdJCVVqRPu+kFmJMh8sYiV
        7UQ859iCCFToi5e9daNQPp8xsyD2u6I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-uxkl4M0IONqi5co7ssqmCA-1; Thu, 03 Dec 2020 20:56:24 -0500
X-MC-Unique: uxkl4M0IONqi5co7ssqmCA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2140180A086;
        Fri,  4 Dec 2020 01:56:21 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-98.rdu2.redhat.com [10.10.117.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 406EB620D7;
        Fri,  4 Dec 2020 01:56:16 +0000 (UTC)
Subject: Re: [PATCH 0/3] exec: Transform exec_update_mutex into a rw_semaphore
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
 <CAHk-=wjocT58h24do391ZFQwAcOd7EBqBB=qOUyHVU=ubU09Yw@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <874ffe6a-628f-e504-037f-ec321565a40c@redhat.com>
Date:   Thu, 3 Dec 2020 20:56:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjocT58h24do391ZFQwAcOd7EBqBB=qOUyHVU=ubU09Yw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/20 5:42 PM, Linus Torvalds wrote:
> On Thu, Dec 3, 2020 at 12:10 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>> The simplest and most robust solution appears to be making
>> exec_update_mutex a read/write lock and having everything execept for
>> exec take the lock for read.
> Looks sane to me.
>
> I'd like the locking people to look at the down_read_*() functions,
> even if they look simple. Adding Waiman and Davidlohr to the cc just
> in case they would look at that too, since they've worked on that
> code.

I have looked at patches 1 & 2 on adding down_read_killable_nested() and 
down_read_interruptible(). They looks good to me.

Cheers,
Longman

