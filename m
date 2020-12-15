Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D32B2DAB92
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 12:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbgLOK7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 05:59:36 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:54695 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbgLOK6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 05:58:47 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CwFbd6xzDz9sRR; Tue, 15 Dec 2020 21:58:05 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        aneesh.kumar@linux.ibm.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <0d37490a067840f53fc5b118869917c0aec9ab87.1607491747.git.christophe.leroy@csgroup.eu>
References: <0d37490a067840f53fc5b118869917c0aec9ab87.1607491747.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v4 1/6] powerpc/book3s64/kuap: Improve error reporting with KUAP
Message-Id: <160802974007.512611.9989753415773028301.b4-ty@ellerman.id.au>
Date:   Tue, 15 Dec 2020 21:58:05 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Dec 2020 05:29:20 +0000 (UTC), Christophe Leroy wrote:
> This partially reverts commit eb232b162446 ("powerpc/book3s64/kuap: Improve
> error reporting with KUAP") and update the fault handler to print
> 
> [   55.022514] Kernel attempted to access user page (7e6725b70000) - exploit attempt? (uid: 0)
> [   55.022528] BUG: Unable to handle kernel data access on read at 0x7e6725b70000
> [   55.022533] Faulting instruction address: 0xc000000000e8b9bc
> [   55.022540] Oops: Kernel access of bad area, sig: 11 [#1]
> ....
> 
> [...]

Patches 2-6 applied to powerpc/next.

[2/6] powerpc/mm: sanity_check_fault() should work for all, not only BOOK3S
      https://git.kernel.org/powerpc/c/7ceb40027e19567a0a066e3b380cc034cdd9a124
[3/6] powerpc/fault: Unnest definition of page_fault_is_write() and page_fault_is_bad()
      https://git.kernel.org/powerpc/c/5250d026d241febfaf226d26cabe528fc478e225
[4/6] powerpc/mm: Move the WARN() out of bad_kuap_fault()
      https://git.kernel.org/powerpc/c/3dc12dfe74300febc568c3b530c0f9bee01f2821
[5/6] powerpc/fault: Avoid heavy search_exception_tables() verification
      https://git.kernel.org/powerpc/c/cbd7e6ca0210db05c315a27bb5db5a482f2772ce
[6/6] powerpc/fault: Perform exception fixup in do_page_fault()
      https://git.kernel.org/powerpc/c/5f1888a077069988218805534f56b983b6d5710c

cheers
