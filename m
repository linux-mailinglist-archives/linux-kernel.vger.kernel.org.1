Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA48202267
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jun 2020 09:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgFTHpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Jun 2020 03:45:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbgFTHpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 03:45:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B120C2098B;
        Sat, 20 Jun 2020 07:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592639146;
        bh=cyiTE/KzPJSAeOM4IeYBB4emZmFtBxQ7E/Dcy3ohlp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VmdLE+NESAl68OplTAW64vq9q/2Qaw4oQ1s7/ALP0J2b4Ekh8v5eETEHlUhs4HFHX
         Y2isltbU4t2yZHnIAZnoc8HfcAhaWujgaFOr1RfjtwdbENUDKms9sgq8k2AHHWUByl
         pBqt/Xl0dns4IQV6gwQ3tX4G10wIWin0gIx7BQvo=
Date:   Sat, 20 Jun 2020 09:45:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ronald =?iso-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>,
        Nicolai Stange <nicstange@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: debugfs_create_u32_array() memory leaks
Message-ID: <20200620074542.GA2298609@kroah.com>
References: <20200619161734.25e99fa4@kicinski-fedora-PC1C0HJN>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619161734.25e99fa4@kicinski-fedora-PC1C0HJN>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 04:17:34PM -0700, Jakub Kicinski wrote:
> Hi!
> 
> I'm trying to use debugfs_create_u32_array() in drivers/net/netdevsim
> and it causes memory leaks:
> 
> unreferenced object 0xffff8880546642a0 (size 16):
>   comm "test_udp_tuns.s", pid 2146, jiffies 4294928368 (age 3772.435s)
>   hex dump (first 16 bytes):
>     84 52 6a 4d 80 88 ff ff 04 00 00 00 f3 78 7e 89  .RjM.........x~.
>   backtrace:
>     [<000000006962a447>] debugfs_create_u32_array+0x3f/0x90
> 
> I can see that debugfs_create_u32_array() allocates a structure at
> create time that ends up assigned to inode->i_private, but I don't 
> see it freed anywhere.
> 
> Am I missing something? I'm pretty sure files get removed, cause the
> driver calls debugfs_remove_recursive() and no other file types leaks.

Yeah, that's a bug, nice catch.  The debugfs_create*() functions should
not allocate local memory as we can't know to free that memory when the
file is removed.

Can you fix this up, or do you want me to?  I only see one in-kernel
user of this, so it shouldn't be that tough to do so.  The one user
never removes that file so that's why no one noticed this before.

thanks,

greg k-h
