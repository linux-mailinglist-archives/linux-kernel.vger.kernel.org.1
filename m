Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59B72CE756
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 06:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgLDFTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 00:19:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:51198 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgLDFTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 00:19:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 81AF5B1C4;
        Fri,  4 Dec 2020 05:19:01 +0000 (UTC)
Date:   Thu, 3 Dec 2020 20:54:01 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Waiman Long <longman@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
Subject: Re: [PATCH 0/3] exec: Transform exec_update_mutex into a rw_semaphore
Message-ID: <20201204045401.4njfkrgpbmeak4qw@linux-p48b.lan>
References: <87tut2bqik.fsf@x220.int.ebiederm.org>
 <CAHk-=wjocT58h24do391ZFQwAcOd7EBqBB=qOUyHVU=ubU09Yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHk-=wjocT58h24do391ZFQwAcOd7EBqBB=qOUyHVU=ubU09Yw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Dec 2020, Linus Torvalds wrote:

>On Thu, Dec 3, 2020 at 12:10 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> The simplest and most robust solution appears to be making
>> exec_update_mutex a read/write lock and having everything execept for
>> exec take the lock for read.
>
>Looks sane to me.
>
>I'd like the locking people to look at the down_read_*() functions,
>even if they look simple. Adding Waiman and Davidlohr to the cc just
>in case they would look at that too, since they've worked on that
>code.

rwsem changes look good to me - and 3/3 looks much nicer than the previous
alternatives to the deadlock.

Acked-by: Davidlohr Bueso <dbueso@suse.de>
