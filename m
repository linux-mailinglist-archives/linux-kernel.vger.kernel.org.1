Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1EFD2AA8A5
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 01:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgKHA4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 19:56:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:46080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgKHA4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 19:56:46 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2727520885;
        Sun,  8 Nov 2020 00:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604797006;
        bh=/261giqM3SGf4BphJk8rBUodxqpoAGphORKU+/3G2W0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xwxjPDl+XMKb88dppa9KT+Klv8aXbRwQ9UGlyqntIQflE109bvZuC45A7d+VPQSkP
         HlaRq/4a0y7UT/eq66pLNjY31kTs3c/Oe55Q7eIP0wyTXMGzGwyVV++cJEmvTutyvv
         hDDjFCRLopKIALYmz5iaDG/uEfbBN4f5SlzK+O/U=
Date:   Sat, 7 Nov 2020 16:56:45 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stefan Agner <stefan@agner.ch>
Cc:     minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, sjenning@linux.vnet.ibm.com,
        gregkh@linuxfoundation.org, arnd@arndb.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/zsmalloc: include sparsemem.h for MAX_PHYSMEM_BITS
Message-Id: <20201107165645.1b139b595b6b64feaca61bcb@linux-foundation.org>
In-Reply-To: <bdfa44bf1c570b05d6c70898e2bbb0acf234ecdf.1604762181.git.stefan@agner.ch>
References: <bdfa44bf1c570b05d6c70898e2bbb0acf234ecdf.1604762181.git.stefan@agner.ch>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  7 Nov 2020 16:22:06 +0100 Stefan Agner <stefan@agner.ch> wrote:

> Most architectures define MAX_PHYSMEM_BITS in asm/sparsemem.h and don't
> include it in asm/pgtable.h. Include asm/sparsemem.h directly to get
> the MAX_PHYSMEM_BITS define on all architectures.
> 
> This fixes a crash when accessing zram on 32-bit ARM platform with LPAE and
> more than 4GB of memory:
>   Unable to handle kernel NULL pointer dereference at virtual address 00000000

Mysterious.  Presumably without this include, some compilation unit is
picking up the wrong value of MAX_PHYSMEM_BITS?  But I couldn't
actually see where/how this occurs.  Can you please explain further?

