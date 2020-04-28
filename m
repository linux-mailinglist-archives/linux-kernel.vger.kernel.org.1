Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8547D1BBC15
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 13:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgD1LOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 07:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgD1LOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 07:14:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9510C03C1A9;
        Tue, 28 Apr 2020 04:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z+2cHsAhwOcwa/ZOru5Iyu559NSgRTBiKbey/voC8u8=; b=nIyNbar6GQ2gfHkkoUVhjswdA8
        Vkwis7Zk1JPnkr1oXjqfrAthCSBE1dcsEZHAGvSeAMEZXOEGEaU9ODVZ0BE/qRQWfW8sq/3X6uARA
        asc0G24RG36WSB4dHiVq/3rXfqsnY5iKDhlMjfJlqCrKKDhDh6ORdOVQDti48qO5nzcpPZywR2MCO
        EyC4qcxNpUwymMgQiGoSnY+uivQ9/bdOqOiIiucHyDujj5d4Po652GcaUO4eeDEVucor+8IbdJrnh
        PV92NQ3xzaLTRs8ar9EuIBJ/yRZk9WTpdosuE4NxDu+LzeW84kI2tH/yfayOfP2FPmiSlcCyVzJHr
        SxuOYjFg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTOBf-0006yn-Vr; Tue, 28 Apr 2020 11:14:03 +0000
Date:   Tue, 28 Apr 2020 04:14:03 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] ipc: use GFP_ATOMIC under spin lock
Message-ID: <20200428111403.GJ29705@bombadil.infradead.org>
References: <20200428034736.27850-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428034736.27850-1-weiyongjun1@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 03:47:36AM +0000, Wei Yongjun wrote:
> The function ipc_id_alloc() is called from ipc_addid(), in which
> a spin lock is held, so we should use GFP_ATOMIC instead.
> 
> Fixes: de5738d1c364 ("ipc: convert ipcs_idr to XArray")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

I see why you think that, but it's not true.  Yes, we hold a spinlock, but
the spinlock is in an object which is not reachable from any other CPU.
So it's not possible to deadlock.  This probably confuses all kinds
of automated checkers, and I should probably rewrite the code to not
acquire the new spinlock until we're already holding the xa_lock.

Converting to GFP_ATOMIC is completely wrong.
