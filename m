Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF3422B99B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 00:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgGWWe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 18:34:26 -0400
Received: from kernel.crashing.org ([76.164.61.194]:43108 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgGWWe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 18:34:26 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 06NMXDcm005863
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 23 Jul 2020 17:33:16 -0500
Message-ID: <418d5f3d3f42bbc79c5cf30e18ec89edfe2dbd26.camel@kernel.crashing.org>
Subject: Re: [PATCH v5 1/4] riscv: Move kernel mapping to vmalloc zone
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Alex Ghiti <alex@ghiti.fr>, Palmer Dabbelt <palmer@dabbelt.com>
Cc:     mpe@ellerman.id.au, paulus@samba.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Anup Patel <Anup.Patel@wdc.com>,
        Atish Patra <Atish.Patra@wdc.com>, zong.li@sifive.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-mm@kvack.org
Date:   Fri, 24 Jul 2020 08:33:12 +1000
In-Reply-To: <cade70e2-0179-2650-41c5-036679aaf30c@ghiti.fr>
References: <mhng-831c4073-aefa-4aa0-a583-6a17f9aff9b7@palmerdabbelt-glaptop1>
         <d7e3cbb7-c12a-bce2-f1db-c336d15f74bd@ghiti.fr>
         <7cb2285e-68ba-6827-5e61-e33a4b65ac03@ghiti.fr>
         <54af168083aee9dbda1b531227521a26b77ba2c8.camel@kernel.crashing.org>
         <cade70e2-0179-2650-41c5-036679aaf30c@ghiti.fr>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-07-23 at 01:21 -0400, Alex Ghiti wrote:
> > works fine with huge pages, what is your problem there ? You rely on
> > punching small-page size holes in there ?
> > 
> 
> ARCH_HAS_STRICT_KERNEL_RWX prevents the use of a hugepage for the kernel 
> mapping in the direct mapping as it sets different permissions to 
> different part of the kernel (data, text..etc).

Ah ok, that can be solved in a couple of ways...

One is to use the linker script to ensure those sections are linked
HUGE_PAGE_SIZE appart and moved appropriately by early boot code. One
is to selectively degrade just those huge pages.

I'm not familiar with the RiscV MMU (I should probably go have a look)
but if it's a classic radix tree with huge pages at PUD/PMD level, then
you could just degrade the one(s) that cross those boundaries.

Cheers,
Ben.


