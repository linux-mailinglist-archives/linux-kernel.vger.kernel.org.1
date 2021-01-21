Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CC62FF201
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388152AbhAURcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:32:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:49676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732242AbhAURbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:31:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74ED22054F;
        Thu, 21 Jan 2021 17:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611250252;
        bh=SOgum53YV48jvAnAaDp7oScrIl6PGd5DiPeAfit2NaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IB/xGPq3GS0MPSd5LIq8SRAXP9FTC7DeJ0m179MKbjhCNsKzU0ZE4zHrB9O7feHtb
         wlfvdJQTS4OZgIkcTFXMfahVqi0RU7gbrrkZskm59TDuMqOINty0RX66GzUlXEke99
         N8XGRIn2pRlPF3T/7H1BCjEfYv0FhpNeqW7jMSu0=
Date:   Thu, 21 Jan 2021 18:30:49 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tejun Heo <tj@kernel.org>, Siddharth Gupta <sidgup@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: restore splice and sendfile support on kernfs
Message-ID: <YAm6Sexrpralbf8D@kroah.com>
References: <20210120204631.274206-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120204631.274206-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 09:46:28PM +0100, Christoph Hellwig wrote:
> Hi Greg and Tejun,
> 
> this fixes a regression in Linux 5.10 that stopped sendfile and splice
> from working on kernfs/sysfs files.
> 
> Diffstt:
>  file.c |   65 ++++++++++++++++++++++++-----------------------------------------
>  1 file changed, 24 insertions(+), 41 deletions(-)

Thanks for these, now queued up!

greg k-h
