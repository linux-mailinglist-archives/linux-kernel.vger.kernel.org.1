Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3CC2C8BE2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 19:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbgK3R5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:57:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:50040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728519AbgK3R5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:57:54 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7F57206E3;
        Mon, 30 Nov 2020 17:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606759033;
        bh=zAn0U39uj2gW7KHPapxndRa/sHkW/TfgOLMEtCLmEaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XmDjRpd66b8EbduMPVQB7tYz6biMwawTv/Ts3eBO+4iR2AinDnfaxEmyZ/IB2plbC
         FZUyPivcgpHis+LM08Q8fYpLJieg4CamOuskqhpbI1wj499I3AoJv57yGPcdCgVXvn
         PrgJiUyAMpcsV0c9teBA8YGvJE9kbQaza7+pRPzo=
Date:   Mon, 30 Nov 2020 17:57:07 +0000
From:   Will Deacon <will@kernel.org>
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>
Cc:     catalin.marinas@arm.com, bjorn.andersson@linaro.org,
        shawnguo@kernel.org, vkoul@kernel.org, geert+renesas@glider.be,
        Anson.Huang@nxp.com, michael@walle.cc, krzk@kernel.org,
        olof@lixom.net, vincenzo.frascino@arm.com, ardb@kernel.org,
        masahiroy@kernel.org, gshan@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64:msr: Add MSR driver
Message-ID: <20201130175706.GA25457@willie-the-truck>
References: <20201130174833.41315-1-rongwei.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130174833.41315-1-rongwei.wang@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 01:48:30AM +0800, Rongwei Wang wrote:
> MSR ARM driver aims to provide interfacs for user to read or write data to all
> system registers. Its functions is same as MSR driver (x86 platform). It mainly
> depends on kprobe and undef exception to read or write system registers
> dynamicly.

... but why? These are privileged registers for a reason, and giving
userspace access to them is bound to cause serious problems. Why can't we
do whatever it is that userspace is trying to do by poking these things in
the kernel instead? This interface is a bit like using /dev/mem instead of
writing a proper device driver.

Thanks,

Will
