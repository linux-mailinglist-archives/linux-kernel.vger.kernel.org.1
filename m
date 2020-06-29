Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2606220D82E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 22:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733297AbgF2Tg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 15:36:59 -0400
Received: from gentwo.org ([3.19.106.255]:55698 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733210AbgF2Tgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:36:53 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id 51E033F03B; Mon, 29 Jun 2020 14:48:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 4F9923EA72;
        Mon, 29 Jun 2020 14:48:06 +0000 (UTC)
Date:   Mon, 29 Jun 2020 14:48:06 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Long Li <lonuxli.64@gmail.com>
cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm:free unused pages in kmalloc_order
In-Reply-To: <20200627045507.GA57675@lilong>
Message-ID: <alpine.DEB.2.22.394.2006291446560.27163@www.lameter.com>
References: <20200627045507.GA57675@lilong>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jun 2020, Long Li wrote:

> Environment using the slub allocator, 1G memory in my ARM32.
> kmalloc(1024, GFP_HIGHUSER) can allocate memory normally,
> kmalloc(64*1024, GFP_HIGHUSER) will cause a memory leak, because
> alloc_pages returns highmem physical pages, but it cannot be directly
> converted into a virtual address and return NULL, the pages has not
> been released. Usually driver developers will not use the
> GFP_HIGHUSER flag to allocate memory in kmalloc, but I think this
> memory leak is not perfect, it is best to be fixed. This is the
> first time I have posted a patch, there may be something wrong.

Highmem is not supported by the slab allocators. Please ensure that there
is a warning generated if someone attempts to do such an allocation. We
used to check for that.

In order to make such allocations possible one would have to create yet
another kmalloc array for high memory.
