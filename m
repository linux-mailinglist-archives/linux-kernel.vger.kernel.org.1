Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE142B1243
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 23:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgKLW5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 17:57:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:50692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726611AbgKLW5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 17:57:10 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80B1C20872;
        Thu, 12 Nov 2020 22:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605221811;
        bh=qyrksHKsDkON9A2dFh/FzxMGbEbdaxKiptmd9uwhFpQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ydfDKZRoTdcGhT8pZExOdxMueL888zbl3NizoJH4yLQf9340UTy2ShCMV74dYist9
         sGvAYW5RMq+nyQ3d9Pzt/YdChvaHcctBj7WmE6B3KpLmNJNMQVhf9UZvrjq3jfMnJR
         +KX0QnTPyihu5GQt30d5bLOUuVCDIZIPgr59H/g0=
Date:   Thu, 12 Nov 2020 14:56:49 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vijayanand Jitta <vjitta@codeaurora.org>
Cc:     Minchan Kim <minchan@kernel.org>, linux-mm <linux-mm@kvack.org>,
        glider@google.com, Dan Williams <dan.j.williams@intel.com>,
        broonie@kernel.org, mhiramat@kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Lal <ylal@codeaurora.org>,
        Vinayak Menon <vinmenon@codeaurora.org>
Subject: Re: [PATCH] lib: stackdepot: Add support to configure
 STACK_HASH_SIZE
Message-Id: <20201112145649.3fcd9dc4d6d3db4bd26245bb@linux-foundation.org>
In-Reply-To: <ed4a1e75-3e3a-4950-7bb5-3d83db7bf054@codeaurora.org>
References: <1603372546-27118-1-git-send-email-vjitta@codeaurora.org>
        <CAEwNFnBvxu7+oNkcO9D70OFrxQXswcJG4OvDPyzNf7kpXfpSuw@mail.gmail.com>
        <282d7028-498d-50b3-37d4-2381571f9f9e@codeaurora.org>
        <ed4a1e75-3e3a-4950-7bb5-3d83db7bf054@codeaurora.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Nov 2020 18:26:24 +0530 Vijayanand Jitta <vjitta@codeaurora.org> wrote:

> >> 1. page_owner=off, stackdepot_stack_hash=0 -> no more wasted memory
> >> when we don't use page_owner
> >> 2. page_owner=on, stackdepot_stack_hash=8M -> reasonable hash size
> >> when we use page_owner.
> >>
> >>
> > 
> > This idea looks fine to me. Andrew and others would like to hear your
> > comments as well on this before implementing.
> > 
> > Thanks,
> > Vijay
> > 
> 
> Awaiting for comments from Andrew and others.

I don't actually understand the problem.

What is it about page-owner that causes stackdepot to consume
additional memory?  As far as I can tell, sizeof(struct stack_record)
isn't affected by page-owner?

