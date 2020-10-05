Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF793283D0F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 19:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgJERJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 13:09:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726615AbgJERJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 13:09:45 -0400
Received: from gaia (unknown [95.149.105.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3241E2078E;
        Mon,  5 Oct 2020 17:09:41 +0000 (UTC)
Date:   Mon, 5 Oct 2020 18:09:38 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     John Donnelly <john.p.donnelly@oracle.com>
Cc:     Chen Zhou <chenzhou10@huawei.com>, will@kernel.org,
        james.morse@arm.com, tglx@linutronix.de, mingo@redhat.com,
        dyoung@redhat.com, bhe@redhat.com, corbet@lwn.net,
        prabhakar.pkin@gmail.com, bhsharma@redhat.com, horms@verge.net.au,
        robh+dt@kernel.org, arnd@arndb.de, nsaenzjulienne@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        guohanjun@huawei.com, xiexiuqi@huawei.com, huawei.libin@huawei.com,
        wangkefeng.wang@huawei.com
Subject: Re: [PATCH v12 0/9] support reserving crashkernel above 4G on arm64
 kdump
Message-ID: <20201005170937.GA14576@gaia>
References: <20200907134745.25732-1-chenzhou10@huawei.com>
 <e9b1b5db-a848-468e-6baf-2f7b4d658805@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9b1b5db-a848-468e-6baf-2f7b4d658805@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 12, 2020 at 06:44:29AM -0500, John Donnelly wrote:
> On 9/7/20 8:47 AM, Chen Zhou wrote:
> > Chen Zhou (9):
> >    x86: kdump: move CRASH_ALIGN to 2M
> >    x86: kdump: make the lower bound of crash kernel reservation
> >      consistent
> >    x86: kdump: use macro CRASH_ADDR_LOW_MAX in functions
> >      reserve_crashkernel[_low]()
> >    x86: kdump: move reserve_crashkernel[_low]() into crash_core.c
> >    arm64: kdump: introduce some macroes for crash kernel reservation
> >    arm64: kdump: reimplement crashkernel=X
> >    kdump: add threshold for the required memory
> >    arm64: kdump: add memory for devices by DT property
> >      linux,usable-memory-range
> >    kdump: update Documentation about crashkernel
[...]
> I did a brief unit-test on 5.9-rc4.
> 
> Please add:
> 
> Tested-by:  John Donnelly <John.p.donnelly@oracle.com>

Thanks for testing.

> This activity is over a year old. It needs accepted.

It's getting there, hopefully in 5.11. There are some minor tweaks to
address.

-- 
Catalin
