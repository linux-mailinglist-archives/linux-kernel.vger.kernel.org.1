Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB772D4F6A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 01:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731046AbgLJAYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 19:24:54 -0500
Received: from ozlabs.org ([203.11.71.1]:51705 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbgLJAYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 19:24:40 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CrvmF6kJfz9sWL; Thu, 10 Dec 2020 11:23:57 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     akpm@linux-foundation.org, hch@lst.de,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        viro@zeniv.linux.org.uk,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <18bcb456d32a3e74f5ae241fd6f1580c092d07f5.1607360230.git.christophe.leroy@csgroup.eu>
References: <18bcb456d32a3e74f5ae241fd6f1580c092d07f5.1607360230.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] powerpc/mm: Fix KUAP warning by providing copy_from_kernel_nofault_allowed()
Message-Id: <160755982586.1285738.12667869391229651303.b4-ty@ellerman.id.au>
Date:   Thu, 10 Dec 2020 11:23:57 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Dec 2020 16:58:01 +0000 (UTC), Christophe Leroy wrote:
> Since commit c33165253492 ("powerpc: use non-set_fs based maccess
> routines"), userspace access is not granted anymore when using
> copy_from_kernel_nofault()
> 
> However, kthread_probe_data() uses copy_from_kernel_nofault()
> to check validity of pointers. When the pointer is NULL,
> it points to userspace, leading to a KUAP fault and triggering
> the following big hammer warning many times when you request
> a sysrq "show task":
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/mm: Fix KUAP warning by providing copy_from_kernel_nofault_allowed()
      https://git.kernel.org/powerpc/c/5eedf9fe8db23313df104576845cec5f481b9b60

cheers
