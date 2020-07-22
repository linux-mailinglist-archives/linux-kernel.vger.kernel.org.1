Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E12228DF0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 04:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731754AbgGVCWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 22:22:15 -0400
Received: from kernel.crashing.org ([76.164.61.194]:41780 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731595AbgGVCWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 22:22:15 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 06M2LIGX018560
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 21 Jul 2020 21:21:25 -0500
Message-ID: <bb461dde0df3eaf0bed949eebf0657b227431bb3.camel@kernel.crashing.org>
Subject: Re: [PATCH v5 1/4] riscv: Move kernel mapping to vmalloc zone
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     alex@ghiti.fr, mpe@ellerman.id.au, paulus@samba.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Anup Patel <Anup.Patel@wdc.com>,
        Atish Patra <Atish.Patra@wdc.com>, zong.li@sifive.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-mm@kvack.org
Date:   Wed, 22 Jul 2020 12:21:16 +1000
In-Reply-To: <mhng-cd9a74ea-2edf-47e4-aade-b090f1a069f1@palmerdabbelt-glaptop1>
References: <mhng-cd9a74ea-2edf-47e4-aade-b090f1a069f1@palmerdabbelt-glaptop1>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-07-21 at 16:48 -0700, Palmer Dabbelt wrote:
> > Why ? Branch distance limits ? You can't use trampolines ?
> 
> Nothing fundamental, it's just that we don't have a large code model in the C
> compiler.  As a result all the global symbols are resolved as 32-bit
> PC-relative accesses.  We could fix this with a fast large code model, but then
> the kernel would need to relax global symbol references in modules and we don't
> even do that for the simple code models we have now.  FWIW, some of the
> proposed large code models are essentially just split-PLT/GOT and therefor
> don't require relaxation, but at that point we're essentially PIC until we
> have more that 2GiB of kernel text -- and even then, we keep all the
> performance issues.

My memory might be out of date but I *think* we do it on powerpc
without going to a large code model, but just having the in-kernel
linker insert trampolines.

Cheers,
Ben.


