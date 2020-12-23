Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B3A2E19E5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 09:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgLWIYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 03:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbgLWIYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 03:24:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E7EC0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 00:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FLukLelJh4KqDKIST5NV0UwhmlnpmjKTGDxZ6k/Xzps=; b=LIMyxtT+VE0w+deWxXyycWQBMa
        Xj3+oH9kJHWAD+odl/SNpIJ6pAM8SqPpTq4tzOXsVGZJ8dyhZR2b8Yn3BaIqG1U9dpSOrd1OAuLoV
        ThQ/1wqY66Z5GuUi5zuCXzb6lUkoBwOtqmsIaWB8xdcOg7IZu3GIGTWHuVK4WT7jF31OaPWiBTBk2
        QXp2aCn0uMEGjYy+77qrIhdeAKoNgNOLxAzPrzdWAp5RqVfoEk/DFfYVXUdOm2cyjbRcLFCBe36zX
        iEWBdiB8q0HAWfMyvPxR5DPAl5KqQAMGRmu5dFhBcNkEih336pytbkfqGFCEQ+0yM3Ruw6UyW/kjh
        QJXB3pkw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1krzQg-0006YI-Df; Wed, 23 Dec 2020 08:23:30 +0000
Date:   Wed, 23 Dec 2020 08:23:30 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-riscv@lists.infradead.org, daniel.lezcano@linaro.org,
        kernel test robot <lkp@intel.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        kernel-team@android.com
Subject: Re: [PATCH] clocksource: clint: Avoid remove __iomem in
 get_cycles_hi()
Message-ID: <20201223082330.GA24581@infradead.org>
References: <20201222053230.3229427-1-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222053230.3229427-1-palmer@dabbelt.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 09:32:30PM -0800, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmerdabbelt@google.com>
> 
> This cast loses the __iomem qualifier from clint_timer_val, which
> triggers an sparse warning.

I'm not a native speaker, but the subject line sounds strange to me.
Shouldn't this be:

	"don't cast away the __iommu annotation"

or something similar?

Also this adds an overly long line.  Otherwise it looks fine.
