Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9162D1DE0E8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 May 2020 09:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgEVH2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 May 2020 03:28:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbgEVH2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 03:28:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94223206DD;
        Fri, 22 May 2020 07:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590132514;
        bh=a+GWZTXoEmAqJ588Ld4QrK6+dfifuM37WVBYkefXSgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=quDWI+OJ7MZQgBlI9ukwhi9CNgoNFN6Y9tPAex3fnyo7GLU8VnsHkTa7ArhP2vU4v
         6Gul75XflD0bDuPoiv4fGUh+EGcWwuDr8oQkFpY/ulcP2N4/GKtIGR0A2xqdIdA8lG
         j+IdQd3iTsR9e3UpBG8Zzoaljfcvwbw7+g0fvjZ8=
Date:   Fri, 22 May 2020 09:27:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] soundwire updates for v5.8-rc1
Message-ID: <20200522072751.GA853066@kroah.com>
References: <20200521142739.GB374218@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521142739.GB374218@vkoul-mobl.Dlink>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 07:57:39PM +0530, Vinod Koul wrote:
> Hi Greg,
> 
> Please pull to receive updates for soundwire. The big news the
> sdw_master_device getting completed along with sysfs attributes for
> master and slave devices. That closes the long cleanup work done by
> Pierre and Bard for the devices.
> 
> The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:
> 
>   Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-5.8-rc1

Pulled and pushed out, thanks.

greg k-h
