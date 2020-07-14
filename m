Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0977B21E63D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 05:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgGNDUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 23:20:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726432AbgGNDUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 23:20:36 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17F5721974;
        Tue, 14 Jul 2020 03:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594696836;
        bh=/RtfCPLE/q3BrKJDo0IszEDqhneMNbdLBjGXhB0nAZ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yGgOzIP8gPvw25Te7OyITpW/Brb68JrKdxsoAOO67DKxzo0vQhLoUFxVdUqh2RPPm
         RKEpJZQpw8LAxPts9yYT67Gdww7rNisjg5MU7xgeQhtCzUeACXz9CFiafPjbOEsfdP
         JWvBS5xgepowr4fXPLnmJXDdApSUwfHU2mLjdl98=
Date:   Mon, 13 Jul 2020 20:20:35 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: mmap: Merge vma after call_mmap() if possible
Message-Id: <20200713202035.55ea84d08a1c39423603f592@linux-foundation.org>
In-Reply-To: <1594696064-1409-1-git-send-email-linmiaohe@huawei.com>
References: <1594696064-1409-1-git-send-email-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020 11:07:44 +0800 linmiaohe <linmiaohe@huawei.com> wrote:

> The vm_flags may be changed after call_mmap() because drivers may set some
> flags for their own purpose. As a result, we failed to merge the adjacent
> vma due to the different vm_flags as userspace can't pass in the same one.
> Try to merge vma after call_mmap() to fix this issue.

Which drivers do this?
