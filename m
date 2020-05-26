Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06DD41AD55C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 06:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgDQElr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 00:41:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:58478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgDQElr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 00:41:47 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C922C20857;
        Fri, 17 Apr 2020 04:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587098507;
        bh=q0+ZrS4en2WNXGJtxGr4zom20hpkM8cyAL17PgaJesM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=chsZ72cLuaZOsF85xKIeiQ2NcLV4bwY/tWjPX3CSdbmavw7LUV5sbqUxvUv3pKrQL
         pO9g8kx6HncpuObVnnb9Qc1rBPDlEqc2qxS/18ORNBvDyZDWHorL1Dw/IKqcaubQCk
         +J6sF5B508LFRRDLe3BIrKvf8MdCLGfxK53ljlbI=
Date:   Thu, 16 Apr 2020 21:41:45 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 4/8] khugepaged: Drain LRU add pagevec after swapin
Message-Id: <20200416214145.bfbb1afcc7a632e8cafdf203@linux-foundation.org>
In-Reply-To: <20200416160026.16538-5-kirill.shutemov@linux.intel.com>
References: <20200416160026.16538-1-kirill.shutemov@linux.intel.com>
        <20200416160026.16538-5-kirill.shutemov@linux.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Apr 2020 19:00:22 +0300 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:

> __collapse_huge_page_isolate() may fail due to extra pin in the LRU add
> pagevec. It's pretty common for swapin case: we swap in pages just to
> fail due to the extra pin.
> 
> Drain LRU add pagevec on successful swapin.

I don't see how this patch can do anything to prevent
__collapse_huge_page_isolate() from failing, which is what the
changelog implies.

Can we have a more detailed changelog, please?
