Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E5F2E7BB4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 18:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgL3R5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 12:57:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:38962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgL3R5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 12:57:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B04B52220B;
        Wed, 30 Dec 2020 17:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609350984;
        bh=v2vDZj7jq1Mssp1pb0X2MgJcwWHSKlcMLv0ogo1wJTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mBlT8Je8oIWdTvRooGTBJZuS8q5X1UeXbjjT7jy0rWGz1TrveQwUlUDdmN4hvVF5t
         37JavBSd41Z8W9UnCIHDj16S+yqgDUYpJ2kMWAEaP/IZOFCm+oo2Vaql9rIOX+SoZp
         t9sOeElxLd1fHBITiglyAacwy5pPxYu6qtp8HM9g=
Date:   Wed, 30 Dec 2020 18:57:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs fixes for 5.11-rc2
Message-ID: <X+y/gKijNgZrMF4b@kroah.com>
References: <20201230173306.GA12162@CORE.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230173306.GA12162@CORE.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 30, 2020 at 07:33:06PM +0200, Oded Gabbay wrote:
> Hi Greg,
> 
> This pull request contains a number of important fixes for 5.11-rc2.
> Mainly fixes to support our new F/W with enhanced security features,
> but also additional bugs.
> See details in the tag message below.
> 
> Thanks,
> Oded
> 
> The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:
> 
>   Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-fixes-2020-12-30

Pulled and pushed out, thanks.

greg k-h
