Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF792D432A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 14:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732221AbgLIN0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 08:26:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:38794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729522AbgLIN0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 08:26:41 -0500
Date:   Wed, 9 Dec 2020 14:27:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607520360;
        bh=hfCAFgAscbBHHuTCqzEilu+YaxYRxryN/zjfb0r0vpU=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=dpWqYmsBGB2u5PDJQE4gOpfAWdZOTEdQlSXVR3Esmi4ZtWXUzlgYvdAz5df3jw9dn
         8+SfbfdMpV0n2KqTfFV9tAi6Wat1jwS6vRxvGhM5Qe21yibmLIcxHznTrdSrjOj7Ki
         7SAnXfuqtC4mkwU9BcgJ6kVL/3t4jjawEHFoMO7I=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [GIT PULL]: Generic phy updates for v5.11
Message-ID: <X9DQtKoB2mItgvjw@kroah.com>
References: <20201209125657.GJ8403@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209125657.GJ8403@vkoul-mobl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 06:26:57PM +0530, Vinod Koul wrote:
> Hello Greg,
> 
> Here is the pull request for phy susbsystem. All the changes are already
> in linux-next, sorry for delayed request this time.
> 
> The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:
> 
>   Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-5.11

Pulled and pushed out, thanks.

greg k-h
