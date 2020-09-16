Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D436E26B8B0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgIPAtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:49:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:45392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbgIPAs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 20:48:59 -0400
Received: from X1 (unknown [67.22.170.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FC9420770;
        Wed, 16 Sep 2020 00:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600217336;
        bh=WyF3P7Aqu/5jOAe8bgWDIiaXqgmy/5Hi7Hqfi1YYGxM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bVYT1hmrZROX6bU3uwWE4x610xoug0ite08lGt2IcjKJ6EyBQJmob8oF/a7+334XQ
         70TOEGz0Btq6bzmP3GD+86mAZXStilE+tuTXtJArwowTBMTdNdU0NWgFPUAFg3s93/
         t07TYXV5YLomk2UW96M71H3gFsP6l2Ufvl5+iH6o=
Date:   Tue, 15 Sep 2020 17:48:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     <yanfei.xu@windriver.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/page_alloc.c: variable type of 'progress' should be
 'unsigned long'
Message-Id: <20200915174855.822d866316948aadb8193e9b@linux-foundation.org>
In-Reply-To: <20200915104620.20582-1-yanfei.xu@windriver.com>
References: <20200915104620.20582-1-yanfei.xu@windriver.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Sep 2020 18:46:20 +0800 <yanfei.xu@windriver.com> wrote:

> From: Yanfei Xu <yanfei.xu@windriver.com>
> 
> try_to_free_pages returns the number of pages reclaimed, and the type of
> returns is 'unsigned long'. So we should use a matched type for storing
> it.
> 

__perform_reclaim() returns an int, so this change is fairly pointless.

However __perform_reclaim()'s single caller expects it to return
unsigned long, so including that change in this patch would make more
sense.

