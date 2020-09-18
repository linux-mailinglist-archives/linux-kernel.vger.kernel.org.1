Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3991E26F55F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 07:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgIRF1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 01:27:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29175 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726344AbgIRF1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 01:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600406841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x/q3gUore7zMYpWMNytQTNB0y+piFCSTZflyi2KzLVc=;
        b=OBR8QHs0O4UY3V7rgRk+0X/fSY7O19bkstLVAfOu2rhEbzIuxhxMUMwSp0TBuBd/enNiSK
        nEA2SBU4HYaJa7Vt2x98fbPU0jSHzvy3ZDdIGLIuYrwF/oo+dr0St0gGbEdnvUzdFKoTIh
        WhFQhMxgOcVK/7JGnAmvwV/f/Txpdgc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-pRgiR_Y6MHShvn_qENIzvA-1; Fri, 18 Sep 2020 01:27:17 -0400
X-MC-Unique: pRgiR_Y6MHShvn_qENIzvA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63BC6801AAB;
        Fri, 18 Sep 2020 05:27:14 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-13-81.pek2.redhat.com [10.72.13.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 00D125576E;
        Fri, 18 Sep 2020 05:27:00 +0000 (UTC)
Date:   Fri, 18 Sep 2020 13:26:57 +0800
From:   Dave Young <dyoung@redhat.com>
To:     chenzhou <chenzhou10@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com,
        tglx@linutronix.de, mingo@redhat.com, bhe@redhat.com,
        corbet@lwn.net, John.P.donnelly@oracle.com,
        prabhakar.pkin@gmail.com, bhsharma@redhat.com, horms@verge.net.au,
        robh+dt@kernel.org, arnd@arndb.de, nsaenzjulienne@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        guohanjun@huawei.com, xiexiuqi@huawei.com, huawei.libin@huawei.com,
        wangkefeng.wang@huawei.com
Subject: Re: [PATCH v12 3/9] x86: kdump: use macro CRASH_ADDR_LOW_MAX in
 functions reserve_crashkernel[_low]()
Message-ID: <20200918052657.GA35322@dhcp-128-65.nay.redhat.com>
References: <20200907134745.25732-1-chenzhou10@huawei.com>
 <20200907134745.25732-4-chenzhou10@huawei.com>
 <20200918030112.GA3356@dhcp-128-65.nay.redhat.com>
 <d4296985-7296-b5c9-45f3-b03d28bc7bd8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4296985-7296-b5c9-45f3-b03d28bc7bd8@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/18/20 at 11:57am, chenzhou wrote:
> Hi Dave,
> 
> 
> On 2020/9/18 11:01, Dave Young wrote:
> > On 09/07/20 at 09:47pm, Chen Zhou wrote:
> >> To make the functions reserve_crashkernel[_low]() as generic,
> >> replace some hard-coded numbers with macro CRASH_ADDR_LOW_MAX.
> >>
> >> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> >> ---
> >>  arch/x86/kernel/setup.c | 11 ++++++-----
> >>  1 file changed, 6 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> >> index d7fd90c52dae..71a6a6e7ca5b 100644
> >> --- a/arch/x86/kernel/setup.c
> >> +++ b/arch/x86/kernel/setup.c
> >> @@ -430,7 +430,7 @@ static int __init reserve_crashkernel_low(void)
> >>  	unsigned long total_low_mem;
> >>  	int ret;
> >>  
> >> -	total_low_mem = memblock_mem_size(1UL << (32 - PAGE_SHIFT));
> >> +	total_low_mem = memblock_mem_size(CRASH_ADDR_LOW_MAX >> PAGE_SHIFT);
> > total_low_mem != CRASH_ADDR_LOW_MAX
> I just replace the magic number with macro, no other change.
> Besides, function memblock_mem_size(limit_pfn) will compute the memory size
> according to the actual system ram.
> 

Ok, it is not obvious in patch this is 64bit only, I'm fine with this
then.

