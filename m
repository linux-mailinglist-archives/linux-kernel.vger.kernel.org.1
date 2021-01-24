Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0CF301929
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 03:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbhAXCBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 21:01:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:52776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbhAXCBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 21:01:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66F8C225AC;
        Sun, 24 Jan 2021 02:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1611453669;
        bh=ru6rEZb57xkA0U2WwjNNXhXwODx+Gd/wB0CNya2LX8c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vxg5RMFGYzw/CkTn99KZw5yq9jz8VDHjYGXTn+T2MG6uNufJmXh3gMs6l7fiQJsLL
         ircroI3i2tU8yQ4Cig5GLV4FhxtQtxbjDQBiGmVyUVrq5LreLlUDnXKhNZeDx9XCXd
         UoiB6Np7GccyfBX9VLNB7JJqIABgAtGe2CuP9Mkg=
Date:   Sat, 23 Jan 2021 18:01:07 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <tglx@linutronix.de>, <dave.hansen@intel.com>,
        <jpoimboe@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] mm: Fix potential pte_unmap_unlock pte error
Message-Id: <20210123180107.95f54cc0849a6d8c6afa16ee@linux-foundation.org>
In-Reply-To: <2c691a87-42fd-63f6-6d7a-136be6572fab@huawei.com>
References: <20210109080118.20885-1-linmiaohe@huawei.com>
        <20210110171443.GC1914459@tassilo.jf.intel.com>
        <530deddf-705e-045d-f7c6-521531dced71@huawei.com>
        <2c691a87-42fd-63f6-6d7a-136be6572fab@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jan 2021 16:27:23 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> Hi Andrew:
> On 2021/1/14 10:51, Miaohe Lin wrote:
> > Hi:
> > On 2021/1/11 1:14, Andi Kleen wrote:
> >> On Sat, Jan 09, 2021 at 03:01:18AM -0500, Miaohe Lin wrote:
> >>> Since commit 42e4089c7890 ("x86/speculation/l1tf: Disallow non privileged
> >>> high MMIO PROT_NONE mappings"), when the first pfn modify is not allowed,
> >>> we would break the loop with pte unchanged. Then the wrong pte - 1 would
> >>> be passed to pte_unmap_unlock.
> >>
> >> Thanks.
> >>
> >> While the fix is correct, I'm not sure if it actually is a real bug. Is there
> >> any architecture that would do something else than unlocking the underlying
> >> page?  If it's just the underlying page then it should be always the same
> >> page, so no bug.
> >>
> > 
> > It's just a theoretical issue via code inspection.
> 
> Should I send a new one without Cc statle or just drop this patch? Thanks.

Your patch makes the code much less scary looking.  I added Andi's
observation to the changelog, removed the cc:stable and queued it up,
thanks.

