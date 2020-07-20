Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2B72272A1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 01:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgGTXOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 19:14:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgGTXOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 19:14:05 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E9D0208E4;
        Mon, 20 Jul 2020 23:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595286844;
        bh=Cp16k7Wc92Ppe/2CQspapK5SPF4JM2qVE09ioyCdbwg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pPjPEhTNM3NC8uYRQxLQciU+ByEWOMRUsMMl73rU1hir+vIucZ3HYL8M6c/nr54oN
         VlBDgaEWPC3LPSGKk+/z6xfOzVLnrWOARZOtU/fQade44Ldk8eHJgTRfRKlXgNni2y
         gfjyoQXVdJYx5VHNKap6QhWL3KPnQZLoZElZKoFQ=
Date:   Mon, 20 Jul 2020 16:14:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmstat: don't do count if no needs
Message-Id: <20200720161404.bd0c24560114bf48d6acbaff@linux-foundation.org>
In-Reply-To: <1ef9baa0-9788-5917-2590-a8c3fc593b81@linux.alibaba.com>
References: <20200720052348.428564-1-alex.shi@linux.alibaba.com>
        <1ef9baa0-9788-5917-2590-a8c3fc593b81@linux.alibaba.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jul 2020 13:42:45 +0800 Alex Shi <alex.shi@linux.alibaba.com> wrote:

> 
> For couple of vmstat account funcs, the caller usually doesn't check the
> delta value, if delta == 0, irq or atomic operator is a waste. That's
> better to be skipped, also add unlikey() since !delta is less happened.
> 
> ...
>
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -321,6 +321,9 @@ void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
>  	long x;
>  	long t;
>  
> +	if (unlikely(!delta))
> +		return;
> +

Do we know that delta==0 is frequent enough to make the change a net
benefit?

