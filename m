Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F05E2808F4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 23:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732912AbgJAVBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 17:01:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbgJAVBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 17:01:13 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A75E21481;
        Thu,  1 Oct 2020 21:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601586072;
        bh=bRR9E3n3ewOZtvqzdn98GC1DDkhGGIC/wnBre8FVApY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iMOLBnsf6fuiwhx25baz0onkU30iUmgnmb81IMwrZzJ/mfY3Y9roKbjDukjSTCQiZ
         UmfAgOa18VYJE0g12n2OMKB0UX3eZL6WB9jrTkc/Pwa+/c3bzlhJ23vlkeCo52oYjm
         2NXOj2xqpKmkw7YiDQmlI5UwjZL4tqWaf7Lv8GH4=
Date:   Thu, 1 Oct 2020 23:00:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL]: soundwire updates for v5.10-rc1
Message-ID: <20201001210045.GA1060924@kroah.com>
References: <20201001055632.GQ2968@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001055632.GQ2968@vkoul-mobl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 11:26:32AM +0530, Vinod Koul wrote:
> Hi Greg,
> 
> Please pull to receive updates for soundwire subsystem.
> 
> The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:
> 
>   Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-5.10-rc1

Pulled and pushed out, thanks.

greg k-h
