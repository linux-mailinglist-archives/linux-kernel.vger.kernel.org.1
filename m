Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6AB1F33A4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 07:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgFIFxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 01:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbgFIFxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 01:53:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6D7C03E97C
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 22:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WDJS0ySUVAw6kQtMQKzgwZm9RScbAWiEhZ1h+MXRv5g=; b=MQcVtyMLgKl+y6Gj+FAVgPDZJ6
        A05JWrb0/FYvd/P5bUzJ02U1p4VlG9s1fYtrgvhzlSCqDi9GfBZBvKM/fn4PhrIbK/Uz845Wgq3gk
        iEiduuys3OM/Ji81sNzehEpoh5TeFSGVQvLy5sV4bBlNr+cVBMbyrWxi+/LtR+TsTs0/3iDlJ48F7
        vWzLTn4lP72aMqDMBGbhEiQMxJwa2IrgBwAqn0R2LdU/IFhvUk2Hdyhu49aCijNsMxc0K8PnBuRPM
        qQ3pWiXnzAYWYWftPcO+L2fz0pz93APi4dyrefTkublCB4/dpvQ7xIW3V7EaNvuWHPVmBtaciqn9N
        d6IdJXFg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jiXCK-0006fA-A0; Tue, 09 Jun 2020 05:53:20 +0000
Date:   Mon, 8 Jun 2020 22:53:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/kprobes: Use probe_address() to read instructions
Message-ID: <20200609055320.GA14237@infradead.org>
References: <7f24b5961a6839ff01df792816807f74ff236bf6.1582567319.git.christophe.leroy@c-s.fr>
 <159168034650.1381411.840854749818290996.b4-ty@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159168034650.1381411.840854749818290996.b4-ty@ellerman.id.au>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 03:28:38PM +1000, Michael Ellerman wrote:
> On Mon, 24 Feb 2020 18:02:10 +0000 (UTC), Christophe Leroy wrote:
> > In order to avoid Oopses, use probe_address() to read the
> > instruction at the address where the trap happened.
> 
> Applied to powerpc/next.
> 
> [1/1] powerpc/kprobes: Use probe_address() to read instructions
>       https://git.kernel.org/powerpc/c/9ed5df69b79a22b40b20bc2132ba2495708b19c4

probe_addresss has been renamed to get_kernel_nofault in the -mm
queue that Andrew sent off to Linus last night.
