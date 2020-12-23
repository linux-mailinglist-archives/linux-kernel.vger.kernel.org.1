Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3962E17F9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 05:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgLWEGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 23:06:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:39836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726361AbgLWEGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 23:06:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3D4020684;
        Wed, 23 Dec 2020 04:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1608696366;
        bh=Ny8D8p97ZHDfQ5AI3YPIlIUzfxUr4dUlI1p+pMfgetA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RvnQ9UKDdFFeQnO/T+0wjYA0wYw1ttmhgHjZ/q708Av8c3iUKZqsdj/P7cREUXSEQ
         E7X13hbP9SPlDGfeRL9PkJtyZqhyTMp1fvhOIAqr/xn658HNJfGq1F0qK6pvVmMCUp
         ssF6N0P0j34NK7labb0gksYK8Izy9T9Dmzjsnwao=
Date:   Tue, 22 Dec 2020 20:06:06 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Mike Rapoport <rppt@kernel.org>, <linux-mm@kvack.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH v2 1/2] mm: cma: allocate cma areas bottom-up
Message-Id: <20201222200606.fe4444f1f0ba008ee9fda091@linux-foundation.org>
In-Reply-To: <20201221170551.GB3428478@carbon.DHCP.thefacebook.com>
References: <20201217201214.3414100-1-guro@fb.com>
        <20201220064848.GA392325@kernel.org>
        <20201221170551.GB3428478@carbon.DHCP.thefacebook.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Dec 2020 09:05:51 -0800 Roman Gushchin <guro@fb.com> wrote:

> Subject: [PATCH v3 1/2] mm: cma: allocate cma areas bottom-up

i386 allmodconfig:

In file included from ./include/vdso/const.h:5,
                 from ./include/linux/const.h:4,
                 from ./include/linux/bits.h:5,
                 from ./include/linux/bitops.h:6,
                 from ./include/linux/kernel.h:11,
                 from ./include/asm-generic/bug.h:20,
                 from ./arch/x86/include/asm/bug.h:93,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/mmdebug.h:5,
                 from ./include/linux/mm.h:9,
                 from ./include/linux/memblock.h:13,
                 from mm/cma.c:24:
mm/cma.c: In function ‘cma_declare_contiguous_nid’:
./include/uapi/linux/const.h:20:19: warning: conversion from ‘long long unsigned int’ to ‘phys_addr_t’ {aka ‘unsigned int’} changes value from ‘4294967296’ to ‘0’ [-Woverflow]
 #define __AC(X,Y) (X##Y)
                   ^~~~~~
./include/uapi/linux/const.h:21:18: note: in expansion of macro ‘__AC’
 #define _AC(X,Y) __AC(X,Y)
                  ^~~~
./include/linux/sizes.h:46:18: note: in expansion of macro ‘_AC’
 #define SZ_4G    _AC(0x100000000, ULL)
                  ^~~
mm/cma.c:349:53: note: in expansion of macro ‘SZ_4G’
    addr = memblock_alloc_range_nid(size, alignment, SZ_4G,
                                                     ^~~~~

