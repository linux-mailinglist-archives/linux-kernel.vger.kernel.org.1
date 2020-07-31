Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D000234C5E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 22:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgGaUig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 16:38:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728664AbgGaUif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 16:38:35 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A64D21744;
        Fri, 31 Jul 2020 20:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596227915;
        bh=UiAvZEfW3ClxCu672wov0jKI+ccwVPoNvJXKh0xHAJo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lUcEV892FuJYWdVHY3viR2kP5fT2UK8Ok7pZf/aOtcjX3Q8Zrah2XJKol5BQvNAv1
         LwOj1KJ0/MPNsKDfSMxuEXql/HeNFCOF43vAa7L5HZOQn5a9ShHvC9omyWTbpX+XQl
         +u/k6UkMv7PkY0+ebx24Y4uZh6N+nW0WLI6U4Ijg=
Date:   Fri, 31 Jul 2020 13:38:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     paulmck@kernel.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, hannes@cmpxchg.org, willy@infradead.org,
        urezki@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Raw spinlocks and memory allocation
Message-Id: <20200731133834.517fdfee99b7ed2239f576aa@linux-foundation.org>
In-Reply-To: <20200730231205.GA11265@paulmck-ThinkPad-P72>
References: <20200730231205.GA11265@paulmck-ThinkPad-P72>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jul 2020 16:12:05 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:

> So, may we add a GFP_ flag that will cause kmalloc() and friends to return
> NULL when they would otherwise need to acquire their non-raw spinlock?
> This avoids adding any overhead to the slab-allocator fastpaths, but
> allows callback invocation to reduce cache misses without having to
> restructure some existing callers of call_rcu() and potential future
> callers of kfree_rcu().

We have eight free gfp_t bits so that isn't a problem.

Adding a test-n-branch to the kmalloc() fastpath may well be a concern.

Which of mm/sl?b.c are affected?

A doesnt-need-to-really-work protopatch would help us understand the
potential cost?
