Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6231B2FEA47
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 13:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731282AbhAUMju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 07:39:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:58210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731250AbhAUMjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 07:39:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E243E239EF;
        Thu, 21 Jan 2021 12:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611232706;
        bh=vD37R9im2OHs/NpkZUbIKY5N2nWJvNZHR+ED+esZr9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cqfCIRqTsRgbI482IaG43PgqsFk0txDWKayo2/oKUBrR9FRvMqzMXsBaHSBYIpWDc
         m7NfD8XUFIJ9Oc5c4U+d7calPSLS7t7leBFG1MuhgCZpe/M96/NbooAhPVlo3DoUIW
         xdks6ldKr3jM0pEpsEuMVol+2HVIM4QgjbxopfKY=
Date:   Thu, 21 Jan 2021 13:38:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     ricky_wu@realtek.com
Cc:     arnd@arndb.de, bhelgaas@google.com, vaibhavgupta40@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] misc: rtsx: init value of aspm_enabled
Message-ID: <YAl1v66vwULD33bb@kroah.com>
References: <20210121110704.2981-1-ricky_wu@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121110704.2981-1-ricky_wu@realtek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 07:07:04PM +0800, ricky_wu@realtek.com wrote:
> From: Ricky Wu <ricky_wu@realtek.com>
> 
> make sure ASPM state sync with pcr->aspm_enabled
> init value pcr->aspm_enabled
> 
> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> ---
>  drivers/misc/cardreader/rtsx_pcr.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

What changed from v1?

THat always goes below the --- line, as the documentation asks for.  Can
you please do that and resend?

And if this is a fix, can you provide a "Fixes:" line, and if it should
go to stable kernels, please provide the needed "cc: stable..." line in
the signed off by area as well.

Please fix up and send a v3.

thanks,

greg k-h
