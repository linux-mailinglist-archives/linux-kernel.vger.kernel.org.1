Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C945A259C4B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 19:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732553AbgIARNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 13:13:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729519AbgIARNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 13:13:13 -0400
Received: from gaia (unknown [46.69.195.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9625F2087D;
        Tue,  1 Sep 2020 17:13:09 +0000 (UTC)
Date:   Tue, 1 Sep 2020 18:13:07 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     chenzhou <chenzhou10@huawei.com>
Cc:     Dave Young <dyoung@redhat.com>, will@kernel.org,
        james.morse@arm.com, tglx@linutronix.de, mingo@redhat.com,
        bhe@redhat.com, corbet@lwn.net, John.P.donnelly@oracle.com,
        prabhakar.pkin@gmail.com, bhsharma@redhat.com, horms@verge.net.au,
        robh+dt@kernel.org, arnd@arndb.de, nsaenzjulienne@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        guohanjun@huawei.com, xiexiuqi@huawei.com, huawei.libin@huawei.com,
        wangkefeng.wang@huawei.com
Subject: Re: [PATCH v11 5/5] kdump: update Documentation about crashkernel
Message-ID: <20200901171306.GK5561@gaia>
References: <20200801130856.86625-1-chenzhou10@huawei.com>
 <20200801130856.86625-6-chenzhou10@huawei.com>
 <20200808100239.GB60590@dhcp-128-65.nay.redhat.com>
 <96d0da23-d484-7f66-1680-07b4b5984831@huawei.com>
 <20200810060355.GB6988@dhcp-128-65.nay.redhat.com>
 <2e6aebf9-3765-5d8c-933c-698442db1d52@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e6aebf9-3765-5d8c-933c-698442db1d52@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 03:07:04PM +0800, chenzhou wrote:
> On 2020/8/10 14:03, Dave Young wrote:
> >>> Previously I remember we talked about to use similar logic as X86, but I
> >>> remember you mentioned on some arm64 platform there could be no low
> >>> memory at all.  Is this not a problem now for the fallback?  Just be
> >>> curious, thanks for the update, for the common part looks good.
> >>
> >> Did you mean this discuss: https://lkml.org/lkml/2019/12/27/122?
> > I meant about this reply instead :)
> > https://lkml.org/lkml/2020/1/16/616
> 
> Sorry for not repley in time, I was on holiday last week.
> 
> The platform James mentioned may exist for which have no devices and
> need no low memory.

If there is no memory below 4GB, the arm64 kernel assumes that the
32-bit devices will have some DMA offsets shifting the addresses to the
bottom of the available RAM. So even if RAM starts above 4GB, we
ZONE_DMA32 will be allocated in the bottom 4GB of the high memory (and
if the hardware designers forgot to shift those DMA accesses, we don't
have to support the platform ;)).

So the arm64 notion of low memory differs slightly from the x86 one.

-- 
Catalin
