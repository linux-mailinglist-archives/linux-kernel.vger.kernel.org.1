Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0476244F11
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 22:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgHNUKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 16:10:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgHNUKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 16:10:35 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 601C2206B2;
        Fri, 14 Aug 2020 20:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597435835;
        bh=V1LBnLR6GD/H9lBrBNExcAJGbLLMmg8AfmNutpx8vGA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XubzUq1kxjyC5SQygeG3LR9yJ8DHHjdN1/M3aSrVHWlCJtG+SSfQyWOM8RzGMwgpa
         jb0rRWtCr9/lIactA/ZevYNzPnoeK+pl6wOpiQmtcg83y5wcJCcB+zpDmRuuq58m8V
         oK0vXvWx3EjM51MLhf4amqoc+oh3gST4/TgjbTqY=
Date:   Fri, 14 Aug 2020 13:10:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Roman Gushchin <klamm@yandex-team.ru>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm : sync ra->ra_pages with bdi->ra_pages
Message-Id: <20200814131034.f71a91c6827904e12a629e04@linux-foundation.org>
In-Reply-To: <1597395824-3325-1-git-send-email-zhaoyang.huang@unisoc.com>
References: <1597395824-3325-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Aug 2020 17:03:44 +0800 Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:

> Some system(like android) will turbo read during startup via expanding the
> readahead window and then set it back to normal(128kb as usual). However, some
> files in the system process context will keep to be opened since it is opened
> up and has no chance to sync with the updated value as it is almost impossible
> to change the files attached to the inode(processes are unaware of these things)

How about making VM_READAHEAD_PAGES a variable?  Provide a kernel boot
parameter to alter the default setting.  Userspace can then restore the
usual value later in boot?

