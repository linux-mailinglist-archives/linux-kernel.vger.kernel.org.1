Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031D52351B3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Aug 2020 12:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgHAKe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Aug 2020 06:34:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728249AbgHAKe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 06:34:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D727820716;
        Sat,  1 Aug 2020 10:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596278068;
        bh=Bi3huejpw8NgGMyehxO6oNuEkeDNsr1fgsLXQR9lQGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S9C6S4POMKeArgRTn1RnQRXEDjeWlgJ7jUHYkSPEIkGGHs2l9BftopC5fFsM+ZQom
         JtdVS6QAnvgpL4qh4xMXK57/bschoP4FJP5zJYQQYuFhUCR1xNEoqPppC2d2P5Y/ac
         icLokWeiPYQ1YrUbVCEDOXW0KvYApHjY6PWT3nbg=
Date:   Sat, 1 Aug 2020 12:34:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     huangrandall@google.com, stable-commits@vger.kernel.org
Subject: Re: Patch "f2fs: fix to avoid memory leakage in f2fs_listxattr" has
 been added to the 4.9-stable tree
Message-ID: <20200801103413.GE3309560@kroah.com>
References: <20200801010828.34E412083B@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200801010828.34E412083B@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 09:08:27PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     f2fs: fix to avoid memory leakage in f2fs_listxattr
> 
> to the 4.9-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      f2fs-fix-to-avoid-memory-leakage-in-f2fs_listxattr.patch
> and it can be found in the queue-4.9 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Also breaks the build, so now dropped :(
