Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FD72351AF
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Aug 2020 12:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgHAKbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Aug 2020 06:31:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:45124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbgHAKbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 06:31:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A83F220716;
        Sat,  1 Aug 2020 10:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596277915;
        bh=QpBU42NgfpQ7bb5qaIUu+g9i4zlA8tdC2WotrWRLN5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0ZMs7NKn/gWgSd2g7qE7LjJeRdnGJgnqe/QWojtRorUgKoE2anI8Z1hRAqtBiGTt3
         VJwbTbJ2x6usIMmza+hN1clNtbeVLkyrLvXc+S79RblLSrUkhE7qmdFXo5tQGxpFRA
         JkBjzziXnsXp+QLSQl8v6F6zbcmMsBbLQUgsMss8=
Date:   Sat, 1 Aug 2020 12:31:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     jaegeuk@kernel.org, stable-commits@vger.kernel.org
Subject: Re: Patch "f2fs: check memory boundary by insane namelen" has been
 added to the 4.4-stable tree
Message-ID: <20200801103140.GA3309560@kroah.com>
References: <20200801010838.337472076B@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200801010838.337472076B@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 09:08:37PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     f2fs: check memory boundary by insane namelen
> 
> to the 4.4-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      f2fs-check-memory-boundary-by-insane-namelen.patch
> and it can be found in the queue-4.4 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Breaks the build here, so now dropped :(
