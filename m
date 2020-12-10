Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A762D65E8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 20:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404256AbgLJTFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 14:05:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:38560 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387409AbgLJTFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 14:05:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 175C3ACE0;
        Thu, 10 Dec 2020 19:04:28 +0000 (UTC)
Date:   Thu, 10 Dec 2020 10:38:49 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jann Horn <jannh@google.com>,
        Vasiliy Kulikov <segoon@openwall.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] perf: Break deadlock involving exec_update_mutex
Message-ID: <20201210183849.fdgcagdn4pyghtfn@linux-p48b>
References: <87ft4mbqen.fsf@x220.int.ebiederm.org>
 <AM6PR03MB5170412C2B0318C40CED55E5E4F10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wi6inOF5yvQRwUFbqMt0zFJ8S8GhqE2M0judU7RiGru8Q@mail.gmail.com>
 <875z5h4b7a.fsf@x220.int.ebiederm.org>
 <CAHk-=wio3JXxf3fy8tRVzb69u1e5iUru8p-dw+Mnga6yAdz=HQ@mail.gmail.com>
 <AM6PR03MB51704629E50F6280A52D9FAFE4F10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wgxe-KAqR_y2jP58GthOYKk0YG=6gNxKHxVUJbG7z2CoQ@mail.gmail.com>
 <20201207090953.GF3040@hirez.programming.kicks-ass.net>
 <CAHk-=wjgG=_-zONkBkKnkOv3uoVRy45hTxx8e-6Ks3j-3TVHKQ@mail.gmail.com>
 <20201208083412.GR2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201208083412.GR2414@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Dec 2020, Peter Zijlstra wrote:

>I suppose I'll queue the below into tip/perf/core for next merge window,
>unless you want it in a hurry?

I'm thinking we'd still want Eric's series on top of this for the reader
benefits of the lock.

Thanks,
Davidlohr
