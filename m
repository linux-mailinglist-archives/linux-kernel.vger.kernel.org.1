Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255741CD1E5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 08:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgEKGfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 02:35:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:44410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbgEKGfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 02:35:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0470207FF;
        Mon, 11 May 2020 06:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589178909;
        bh=KyuIUdXk6ImejpwWHr2XizXxJ+jflrS5vzjvNVBqFxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UtWJ6/xGSfPjH6JPV/9VxGIshATPf5///EAYYdQBYYYnG0C8sbtuVDizax08o7rCT
         MF3wSZ9LHqNYtAWmUgXddB3aqqc8587oB0/K/4CQ2E84a425NHHP+i4nyZue8q6lqY
         hU9RiFlFpOQHYDaEqnW/YNXyIz93EjWtrdszk8p0=
Date:   Mon, 11 May 2020 08:35:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kyungtae Kim <kt0755@gmail.com>
Cc:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Tian <dave.jing.tian@gmail.com>
Subject: Re: KASAN: use-after-free Write in config_item_get
Message-ID: <20200511063507.GA1275674@kroah.com>
References: <20200511055200.GA31686@pizza01>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511055200.GA31686@pizza01>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 05:52:16AM +0000, Kyungtae Kim wrote:
> We report a bug (in linux-5.6.8) found by FuzzUSB (a modified version
> of syzkaller)
> 
> kernel config: https://kt0755.github.io/etc/config_v5.6.8
> 
> 
> This bug happened when accessing a configfs_item instance right after being
> deallocated.
> Specifically, config_item_get() tries to access ci_kref element in a config_item instance. 
> But this led to memory access violation because that instance (held by a fsg_opts structure) 
> had been freed by fsg_free_inst() in another thread (PID: 2603).
> 
> To fix, it needs to check if the config_item instance is still in use 
> when trying to deallocate it.

Great, can you create a patch to fix this now that you have a solid test
for it?

thanks,

greg k-h
