Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D38C2863D8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 18:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgJGQZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 12:25:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:59260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbgJGQZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 12:25:01 -0400
Received: from gaia (unknown [95.149.105.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B21E216C4;
        Wed,  7 Oct 2020 16:24:56 +0000 (UTC)
Date:   Wed, 7 Oct 2020 17:24:53 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     chenzhou <chenzhou10@huawei.com>
Cc:     will@kernel.org, james.morse@arm.com, tglx@linutronix.de,
        mingo@redhat.com, dyoung@redhat.com, bhe@redhat.com,
        corbet@lwn.net, John.P.donnelly@oracle.com,
        prabhakar.pkin@gmail.com, bhsharma@redhat.com, horms@verge.net.au,
        robh+dt@kernel.org, arnd@arndb.de, nsaenzjulienne@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        guohanjun@huawei.com, xiexiuqi@huawei.com, huawei.libin@huawei.com,
        wangkefeng.wang@huawei.com
Subject: Re: [PATCH v12 9/9] kdump: update Documentation about crashkernel
Message-ID: <20201007162453.GR3462@gaia>
References: <20200907134745.25732-1-chenzhou10@huawei.com>
 <20200907134745.25732-10-chenzhou10@huawei.com>
 <20201005171936.GD14576@gaia>
 <8644712d-1331-1efc-1cd2-6da8640145b7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8644712d-1331-1efc-1cd2-6da8640145b7@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 10:10:54AM +0800, chenzhou wrote:
> On 2020/10/6 1:19, Catalin Marinas wrote:
> > On Mon, Sep 07, 2020 at 09:47:45PM +0800, Chen Zhou wrote:
> >> diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
> >> index 2da65fef2a1c..549611abc581 100644
> >> --- a/Documentation/admin-guide/kdump/kdump.rst
> >> +++ b/Documentation/admin-guide/kdump/kdump.rst
> > [...]
> >> @@ -316,8 +325,18 @@ Boot into System Kernel
> >>     kernel will automatically locate the crash kernel image within the
> >>     first 512MB of RAM if X is not given.
> >>  
> >> -   On arm64, use "crashkernel=Y[@X]".  Note that the start address of
> >> -   the kernel, X if explicitly specified, must be aligned to 2MiB (0x200000).
> >> +   On arm64, use "crashkernel=X" to try low allocation in DMA zone, and
> >> +   fall back to high allocation if it fails. And go for high allocation
> >> +   directly if the required size is too large.
> >> +   We can also use "crashkernel=X,high" to select a high region above
> >> +   DMA zone, which also tries to allocate at least 256M low memory in
> >> +   DMA zone automatically.
> >> +   "crashkernel=Y,low" can be used to allocate specified size low memory
> >> +   in DMA zone.
> >> +   For non-RPi4 platforms, change DMA zone memtioned above to DMA32 zone.
> > I don't think we should mention non-RPi4 explicitly here. I don't even
> > understand what the suggestion is since the only way is to disable
> > ZONE_DMA in the kernel config. I'd just stick to ZONE_DMA description
> > here.
> How about like this:
> If the kernel config ZONE_DMA is disabled, just try low allocation in DMA32 zone
> and high allocation above DMA32 zone.

Something like: "allocate 256M low memory in the DMA zone automatically
(or the DMA32 zone if CONFIG_ZONE_DMA is disabled)".

I'd keep it short.

-- 
Catalin
