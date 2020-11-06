Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3EA02A966F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 13:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbgKFMtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 07:49:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29312 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727014AbgKFMtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 07:49:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604666944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rjoSq9w5FHJ9ialWxeQLeGSh1Vka0U+JlugVi+0MMcg=;
        b=X5x5U1pITboGKU2GJfBhKBkXmuIMQ9OPwfDwiDXkojWTmGoiGaMNH7GIbAIOpiDaqOiKU+
        oZ4jvjn/Fc6orEfWk+pw9+a6wnW7pmbYbsl3SyBuJ/x5JwKkOW21LXNscRwOtHfNZTaJaU
        YJhIVoBpIySdF5FdHeokD2opJWiYbDc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-19NI3trpM0uyBBcXNPF2_w-1; Fri, 06 Nov 2020 07:49:02 -0500
X-MC-Unique: 19NI3trpM0uyBBcXNPF2_w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EA136D243;
        Fri,  6 Nov 2020 12:49:01 +0000 (UTC)
Received: from ovpn-66-140.rdu2.redhat.com (ovpn-66-140.rdu2.redhat.com [10.10.66.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B74973673;
        Fri,  6 Nov 2020 12:49:00 +0000 (UTC)
Message-ID: <44d61059f01188afd833b0e889a360cd4189f293.camel@redhat.com>
Subject: Re: [PATCH] arm64/smp: Move rcu_cpu_starting() earlier
From:   Qian Cai <cai@redhat.com>
To:     Will Deacon <will@kernel.org>
Cc:     paulmck@kernel.org, catalin.marinas@arm.com,
        kernel-team@android.com, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Fri, 06 Nov 2020 07:48:59 -0500
In-Reply-To: <20201106103755.GA9729@willie-the-truck>
References: <20201028182614.13655-1-cai@redhat.com>
         <160404559895.1777248.8248643695413627642.b4-ty@kernel.org>
         <20201105222242.GA8842@willie-the-truck>
         <3b4c324abdabd12d7bd5346c18411e667afe6a55.camel@redhat.com>
         <20201105232813.GR3249@paulmck-ThinkPad-P72>
         <ec2de23c04e400266fcf98dfd282da0b173a68c3.camel@redhat.com>
         <20201106103755.GA9729@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-11-06 at 10:37 +0000, Will Deacon wrote:
> > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> > index 09c96f57818c..10729d2d6084 100644
> > --- a/arch/arm64/kernel/smp.c
> > +++ b/arch/arm64/kernel/smp.c
> > @@ -421,6 +421,8 @@ void cpu_die_early(void)
> >  
> >  	update_cpu_boot_status(CPU_STUCK_IN_KERNEL);
> >  
> > +	rcu_report_dead(cpu);
> 
> I think this is in the wrong place, see:
> 
> https://lore.kernel.org/r/20201106103602.9849-1-will@kernel.org
> 
> which seems to fix the problem for me.
Ah, I had not realized that cpu_psci_cpu_die() could no return. Your patchset
looks good to me.

