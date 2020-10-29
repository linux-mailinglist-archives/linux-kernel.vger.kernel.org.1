Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8447F29ED7F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 14:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbgJ2Nss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 09:48:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28597 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727692AbgJ2Nsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 09:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603979326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o+6ALnmfHcbX2Kh97Sk3d/ZU9yuOlfGICNtafCoGnYo=;
        b=FwRfxyuqLngzLRAeP8SufhMFnGhhO/SWP2rK/tRciVewtCn5NwZOo2In8VSxkbC1L/gnD7
        DX+FFOSasaoOUFGVjqB3m0fsClqYBGI5ZEfZIp8Iidv5piLq+nR9tARvHvu9nHKwZSjh6z
        tSnoSvt5WpUflYbvcFf2+NdVcbpN7Jo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-RccU4qHMN-6y7QVzvonbrQ-1; Thu, 29 Oct 2020 09:48:40 -0400
X-MC-Unique: RccU4qHMN-6y7QVzvonbrQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E23A1902EA4;
        Thu, 29 Oct 2020 13:48:38 +0000 (UTC)
Received: from ovpn-66-212.rdu2.redhat.com (ovpn-66-212.rdu2.redhat.com [10.10.66.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1705560C17;
        Thu, 29 Oct 2020 13:48:37 +0000 (UTC)
Message-ID: <50aea6567bbdf89e03d50820c19cfb16bb764338.camel@redhat.com>
Subject: Re: [PATCH] powerpc/smp: Move rcu_cpu_starting() earlier
From:   Qian Cai <cai@redhat.com>
To:     paulmck@kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Thu, 29 Oct 2020 09:48:36 -0400
In-Reply-To: <20201029003127.GJ3249@paulmck-ThinkPad-P72>
References: <20201028182334.13466-1-cai@redhat.com>
         <87lffpx598.fsf@mpe.ellerman.id.au>
         <20201029003127.GJ3249@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-10-28 at 17:31 -0700, Paul E. McKenney wrote:
> On Thu, Oct 29, 2020 at 11:09:07AM +1100, Michael Ellerman wrote:
> > Qian Cai <cai@redhat.com> writes:
> > > The call to rcu_cpu_starting() in start_secondary() is not early enough
> > > in the CPU-hotplug onlining process, which results in lockdep splats as
> > > follows:
> > 
> > Since when?
> > What kernel version?
> > 
> > I haven't seen this running CPU hotplug tests with PROVE_LOCKING=y on
> > v5.10-rc1. Am I missing a CONFIG?
> 
> My guess would be that adding CONFIG_PROVE_RAW_LOCK_NESTING=y will
> get you some splats.

Well, I don't have that set, so it should be CONFIG_PROVE_RCU_LIST=y. Anyway,
this is .config to reproduce on Power9 NV:

https://cailca.coding.net/public/linux/mm/git/files/master/powerpc.config

