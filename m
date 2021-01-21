Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131602FE6B0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 10:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbhAUJrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 04:47:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:45106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728854AbhAUJqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 04:46:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8EA702054F;
        Thu, 21 Jan 2021 09:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611222352;
        bh=aHwQE6iUR0Op4CjVqIv6lsDnD0HvuGdjXhVdM/X5gl8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ttla0ylG4jD/oQH9pBW2G4tu5n8gIcxpdS0IpK77ZZxl4EeOvx/hfFkVwoGo5HRUo
         tecU8lOV2X68hUtYSFjmJA+G1nG7O7L9j9931vWqXC6VvP1zqE8wtGm1QycVqMjIy2
         rMv09nAlEGasnZNQ0YZgss1Ea3Y5KZKHBLYM0QiA=
Date:   Thu, 21 Jan 2021 10:45:49 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zhou Wang <wangzhou1@hisilicon.com>
Cc:     Zhangfei Gao <zhangfei.gao@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Sihang Chen <chensihang1@hisilicon.com>
Subject: Re: [PATCH] uacce: Add uacce_ctrl misc device
Message-ID: <YAlNTSOMmsFPFAhk@kroah.com>
References: <1611220154-90232-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611220154-90232-1-git-send-email-wangzhou1@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 05:09:14PM +0800, Zhou Wang wrote:
> When IO page fault happens, DMA performance will be affected. Pin user page
> can avoid IO page fault, this patch introduces a new char device named
> /dev/uacce_ctrl to help to maintain pin/unpin pages. User space can do
> pin/unpin pages by ioctls of an open file of /dev/uacce_ctrl, all pinned
> pages under one file will be unpinned in file release process.

Also, what are you really trying to do here?  If you need to mess with
memory pages, why can't the existing memory apis work properly for you?
Please work with the linux-mm developers to resolve the issue using the
standard apis and not creating a one-off char device node for this type
of thing.

thanks,

greg k-h
