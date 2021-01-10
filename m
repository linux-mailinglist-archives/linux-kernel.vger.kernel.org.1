Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0562F0898
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 18:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbhAJRQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 12:16:31 -0500
Received: from mga07.intel.com ([134.134.136.100]:21408 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726394AbhAJRQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 12:16:30 -0500
IronPort-SDR: 2lyx9gwrdE4bWJHIQjxFECCjlIQ0zTxDeMpCmgCtiCDtyFx/8hPBj3mYvBfLmlKHBPrhXuHNFM
 4kdDcw0RCJkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9860"; a="241844248"
X-IronPort-AV: E=Sophos;i="5.79,336,1602572400"; 
   d="scan'208";a="241844248"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2021 09:14:44 -0800
IronPort-SDR: Vog1mt6Z4Cdv/XDvprHlf+yzui3rRnu0gvMuFiSyqVuHjx+8KP3/21TgU/TQ7oPoR1S1ETaSO0
 E0nhVTVtMfAw==
X-IronPort-AV: E=Sophos;i="5.79,336,1602572400"; 
   d="scan'208";a="351359207"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2021 09:14:44 -0800
Date:   Sun, 10 Jan 2021 09:14:43 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, tglx@linutronix.de,
        dave.hansen@intel.com, jpoimboe@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Fix potential pte_unmap_unlock pte error
Message-ID: <20210110171443.GC1914459@tassilo.jf.intel.com>
References: <20210109080118.20885-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210109080118.20885-1-linmiaohe@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 09, 2021 at 03:01:18AM -0500, Miaohe Lin wrote:
> Since commit 42e4089c7890 ("x86/speculation/l1tf: Disallow non privileged
> high MMIO PROT_NONE mappings"), when the first pfn modify is not allowed,
> we would break the loop with pte unchanged. Then the wrong pte - 1 would
> be passed to pte_unmap_unlock.

Thanks.

While the fix is correct, I'm not sure if it actually is a real bug. Is there
any architecture that would do something else than unlocking the underlying
page?  If it's just the underlying page then it should be always the same
page, so no bug.

That said of course the change is the right thing for main line, but probably doesn't
need to be backported.

-Andi
