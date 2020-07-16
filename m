Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2E82222FC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 14:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbgGPMzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 08:55:47 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:50895 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbgGPMzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:55:46 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4B6vPV6BmRz9sTX; Thu, 16 Jul 2020 22:55:42 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeremy Kerr <jk@ozlabs.org>, linuxppc-dev@lists.ozlabs.org,
        Paul Mackerras <paulus@samba.org>,
        kernel test robot <lkp@intel.com>
In-Reply-To: <20200706132302.3885935-1-arnd@arndb.de>
References: <20200706132302.3885935-1-arnd@arndb.de>
Subject: Re: [PATCH] powerpc/spufs: add CONFIG_COREDUMP dependency
Message-Id: <159490400659.3805857.11376912001537489857.b4-ty@ellerman.id.au>
Date:   Thu, 16 Jul 2020 22:55:42 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jul 2020 15:22:46 +0200, Arnd Bergmann wrote:
> The kernel test robot pointed out a slightly different error message
> after recent commit 5456ffdee666 ("powerpc/spufs: simplify spufs core
> dumping") to spufs for a configuration that never worked:
> 
>    powerpc64-linux-ld: arch/powerpc/platforms/cell/spufs/file.o: in function `.spufs_proxydma_info_dump':
> >> file.c:(.text+0x4c68): undefined reference to `.dump_emit'
>    powerpc64-linux-ld: arch/powerpc/platforms/cell/spufs/file.o: in function `.spufs_dma_info_dump':
>    file.c:(.text+0x4d70): undefined reference to `.dump_emit'
>    powerpc64-linux-ld: arch/powerpc/platforms/cell/spufs/file.o: in function `.spufs_wbox_info_dump':
>    file.c:(.text+0x4df4): undefined reference to `.dump_emit'
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/spufs: add CONFIG_COREDUMP dependency
      https://git.kernel.org/powerpc/c/b648a5132ca3237a0f1ce5d871fff342b0efcf8a

cheers
