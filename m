Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A711A272973
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 17:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbgIUPGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 11:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgIUPGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 11:06:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C667FC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 08:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KKSOebSqFBQq+k0gm/kiYdMJdTo/44slQm7w5kX1m+Q=; b=pTx1IOlI+CsJ0c/Zhiy8r+N+om
        tKXNWba4lvApQb5hocKzZFp0PXbZ1e9dnH+0JswfYYOJ7sTvfjiBuhpC3K0Xu5qH0xLC8rPhJxivf
        +OxF6yHAgirK99LEu6ZZvGG1sMdzFy5cjrhSgVR+TIPEd1R1jWuL6gWdN0T36WrzMdPa8c9a1lbg5
        FElG4i4KGmnN6sir2RSVCXATiE+WBr8oflN9lhcwjyra6FHd7YoCWc+PnS96zClt0NiP8iZtjGBpV
        jdJvBw0YDAfxUWtlxJVp0pQ31DqdGg8et452N8axYuWippxkg4jqXHKqRkstzKx7/fgLTFm9xMpnM
        ZImGjjMg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKNOk-0002lZ-9s; Mon, 21 Sep 2020 15:06:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DC1D7301478;
        Mon, 21 Sep 2020 17:06:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C8502202075F1; Mon, 21 Sep 2020 17:06:31 +0200 (CEST)
Date:   Mon, 21 Sep 2020 17:06:31 +0200
From:   peterz@infradead.org
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, eranian@google.com, ak@linux.intel.com
Subject: Re: [RESEND PATCH V2 0/6] Support PCIe3 uncore PMU on Snow Ridge
Message-ID: <20200921150631.GS1362448@hirez.programming.kicks-ass.net>
References: <1600094060-82746-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600094060-82746-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 07:34:14AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Changes since V1:
> - Drop the platform device solution
> - A new uncore PCI sub driver solution is introduced which searches
>   the PCIe Root Port device via pci_get_device() and id table.
>   Register a PCI bus notifier for the remove notification. Once the
>   device is removed, the uncore driver can be notified to unregister
>   the corresponding PMU.
> - Modify the parameters of uncore_pci_pmu_unregister() function.

Bjorn, you hated on the last version of this thing, are you OK with this
one?
