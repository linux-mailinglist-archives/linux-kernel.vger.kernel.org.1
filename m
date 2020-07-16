Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2715B222E63
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 00:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgGPWGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 18:06:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbgGPWGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 18:06:14 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8762207CB;
        Thu, 16 Jul 2020 22:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594937174;
        bh=moGL5n6Z8qNj347wJeSs4eMD/PHnMpW529lR3Y4F1uE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OVmvdGLPhvlmBazeq6J3gJhP5oAoabUXsKw85EHnWtKNEGClJKUdixMpmWls4pxg5
         4g+Ti1WoMQslI8u02m1hcqF8GDrV4GmqGRkx3LW8nXG7zIsEh4kpH9gWjsqzWH44oZ
         WiM3JfBB7V7AJNwQ26pta5IffsKsDCLw3HJFbJ6w=
Date:   Thu, 16 Jul 2020 15:06:13 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Mark-PK Tsai <Mark-PK.Tsai@mediatek.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, LKP <lkp@lists.01.org>
Subject: Re: db57e98d87
 ("mm/sparse.c: fix ALIGN() without power of 2 in .."): BUG: kernel
 reboot-without-warning in early-boot stage, last printk: early console in
 setup code
Message-Id: <20200716150613.409103a2d1e4c3f5f63652b8@linux-foundation.org>
In-Reply-To: <20200716083159.GH3874@shao2-debian>
References: <20200716083159.GH3874@shao2-debian>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jul 2020 16:32:00 +0800 kernel test robot <lkp@intel.com> wrote:

> Greetings,
> 
> 0day kernel testing robot got the below dmesg and the first bad commit is
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> 
> commit db57e98d87908b8837352abe08515e42752270c1
> Author:     Lecopzer Chen <lecopzer.chen@mediatek.com>
> AuthorDate: Mon Sep 23 15:36:24 2019 -0700
> Commit:     Linus Torvalds <torvalds@linux-foundation.org>
> CommitDate: Tue Sep 24 15:54:09 2019 -0700
> 
>     mm/sparse.c: fix ALIGN() without power of 2 in sparse_buffer_alloc()

Are we sure about this?  That patch is a year old - has something
in the test setup changed to make it visible at this late stage?

