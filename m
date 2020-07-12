Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E8F21CB39
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jul 2020 21:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbgGLT7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jul 2020 15:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729249AbgGLT7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 15:59:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55758C061794;
        Sun, 12 Jul 2020 12:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gAqVhOnFwwCoIwU0i8eoCwnixeJorp0605sJj8HaFrE=; b=fqn0+zLg0MWuNz1ruzQvb1SjSF
        JvoK9nbA2CPYK59PJQE6Jbf+EM4PA8TYlwkvQBcBc+HMzmlauqQagGIhFkmj6HFDdJZ8RqAyqAkce
        eh9cWyUkZZvBIG2xZsrR35q65hDDO3CSobrEe4dj/gnX7Ke2/ObLuIDEcVhe+ujRNGLeOWPQiW2kc
        zhgP7BhA8m1se0hYNeK2/6WMQumM3QKI3EDWyOs4glfbaR101UrwlX1izT4Zbf07ZmwDsJ/ZWJTde
        fLqgDYC/RkC+2Jt/XVpZaN2ltC+uL/Agdnl8cp43plRkuzwiAk9PuXi2u1ieWoT6BzDJZIxzdUC9N
        L8EfKrzg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jui8K-0008N0-UE; Sun, 12 Jul 2020 19:59:33 +0000
Date:   Sun, 12 Jul 2020 20:59:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Austin Chang <austin880625@gmail.com>
Cc:     dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dm-cache: document zeroing metadata device step
Message-ID: <20200712195932.GV12769@casper.infradead.org>
References: <20200712194039.329035-1-austin880625@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200712194039.329035-1-austin880625@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 03:40:39AM +0800, Austin Chang wrote:
> +  # When using dmsetup directly instead of volume manager like lvm2,
> +  # the first 4k of the metadata device should be zeroed to indicate
> +  # empty metadata.
> +  dd if=/dev/zero of=/dev/mapper/metadata bs=4k conv=notrunc

... don't you need 'count=1' or you'll zero the entire device?

>    dmsetup create my_cache --table '0 41943040 cache /dev/mapper/metadata \
>  	  /dev/mapper/ssd /dev/mapper/origin 512 1 writeback default 0'
>    dmsetup create my_cache --table '0 41943040 cache /dev/mapper/metadata \
> -- 
> 2.26.2
> 
