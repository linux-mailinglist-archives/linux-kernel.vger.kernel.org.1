Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC1626CE6D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 00:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgIPWNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 18:13:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40394 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726411AbgIPWNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 18:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600294384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kpo7xwAZ6M+ZyAMOUgacMMQsd0LMITNlkn7wYNkHEHg=;
        b=S9FjfvIz1v7gkCgWORx5fnOlMzoK+OF7K4b1lNhj37xGbjBzWAyPqb0Mb6Migz876tA3mQ
        yDmEUWV/FdHTzCA2p8QMviYZWdB3MOiGnhFdnQ6ips/coHVB/GHBJ/7rGztA6VUkF5sbAV
        QuqNCTlW8kjHDTB2v4D5L6KQ3tUPrk4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-2-RlLNKvP9eVaFvRR19N3A-1; Wed, 16 Sep 2020 17:12:05 -0400
X-MC-Unique: 2-RlLNKvP9eVaFvRR19N3A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69CA81868431;
        Wed, 16 Sep 2020 21:12:04 +0000 (UTC)
Received: from ovpn-66-86.rdu2.redhat.com (ovpn-66-86.rdu2.redhat.com [10.10.66.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F4CE19D61;
        Wed, 16 Sep 2020 21:11:59 +0000 (UTC)
Message-ID: <607c446bc8d3a0cc6e96aa9792e075913ad6b2c6.camel@redhat.com>
Subject: Re: [RFC v7 11/19] lockdep: Fix recursive read lock related
 safe->unsafe detection
From:   Qian Cai <cai@redhat.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Waiman Long <longman@redhat.com>
Date:   Wed, 16 Sep 2020 17:11:59 -0400
In-Reply-To: <20200916161404.GD127490@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200807074238.1632519-1-boqun.feng@gmail.com>
         <20200807074238.1632519-12-boqun.feng@gmail.com>
         <17343f6f7f2438fc376125384133c5ba70c2a681.camel@redhat.com>
         <20200916081046.GC127490@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
         <20200916161404.GD127490@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-09-17 at 00:14 +0800, Boqun Feng wrote:
> Found a way to resolve this while still keeping the BFS. Every time when
> we want to enqueue a lock_list, we basically enqueue a whole dep list of
> entries from the previous lock_list, so we can use a trick here: instead
> enqueue all the entries, we only enqueue the first entry and we can
> fetch other silbing entries with list_next_or_null_rcu(). Patch as
> below, I also took the chance to clear the code up and add more
> comments. I could see this number (in /proc/lockdep_stats):
> 
> 	max bfs queue depth:                   201
> 
> down to (after apply this patch)
> 
> 	max bfs queue depth:                   61
> 
> with x86_64_defconfig along with lockdep and selftest configs.
> 
> Qian, could you give it a try?

It works fine as the number went down from around 3000 to 500 on our workloads.

