Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B3F2F4809
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 10:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbhAMJvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 04:51:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:55066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727345AbhAMJvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 04:51:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DDA92339D;
        Wed, 13 Jan 2021 09:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610531458;
        bh=s+TQ8rts7lmiJdFM0O7RqCAnHpUbbxPN8CamKyMJOKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K5xW4Vsr7NUsaey8Me3rE69z6s9oEp2kv5U2f83ZNjCF+PWal990ejhGycHNJVuhn
         smhe2xVzSPuK9Y2AFLTKcklrDLq6TNpHO1DcaUoQatsh+qaqmRVg+q905QUwhGDh5i
         giYF7C7RP1LjAWNSXkW3D1ufYuvEPeG/rRoDKH68=
Date:   Wed, 13 Jan 2021 10:52:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs fixes for 5.11-rc4
Message-ID: <X/7CwKWCwmVoKW7h@kroah.com>
References: <20210113075253.GA27799@CORE.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113075253.GA27799@CORE.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 09:52:53AM +0200, Oded Gabbay wrote:
> Hi Greg,
> 
> This pull request contains three important bug fixes for 5.11-rc4.
> Basically the driver won't work without the dma address fix, and 
> IMO the two other fixes are also improtant enough to be included 
> at this stage.
> 
> Thanks,
> Oded
> 
> The following changes since commit f970d1d01af8606233f47901c1cf39f3ae21fd74:
> 
>   Merge tag 'phy-fixes-5.11' of git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy into char-misc-next (2021-01-11 15:37:40 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-fixes-2021-01-13

Pulled and pushed out, thanks.

greg k-h
