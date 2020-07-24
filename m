Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6874022CE22
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 20:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgGXSqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 14:46:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:40828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726573AbgGXSqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 14:46:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93F07206F0;
        Fri, 24 Jul 2020 18:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595616368;
        bh=MYcAQXEa4VceX0pTKt2U1UgGzvKQjRUYYXqqXsImERY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QRMPCDt/GBR6gpDSebOZL78AJrZUJUKYY6NSQza0HKzSwkmtbXkdL/7shKWp/MOle
         Mq2kiVwZiLF5kC4V9Ka8EA9tdlBvV2st248DoUBWT4+SyhDsk2BnEQTPAbWPKEmcnw
         CSEUJ6UvilOU8JXjKEOXO3gNhmrW3DixDFWzrdzg=
Date:   Fri, 24 Jul 2020 20:45:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs pull request for kernel 5.9-rc1 (resend
 again)
Message-ID: <20200724184523.GB566472@kroah.com>
References: <20200724174924.GA20186@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724174924.GA20186@ogabbay-VM>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 08:49:24PM +0300, Oded Gabbay wrote:
> Hello Greg,
> 
> (Re-sending again this pull request)
> 
> This is habanalabs pull request for the merge window of kernel 5.9. It
> contains many small improvements to common and GAUDI code. Details are in
> the tag.
> 
> Thanks,
> Oded
> 
> The following changes since commit 92ca3dd4867bafbfd026b06d53737d61ded1bd27:
> 
>   mei: hw: don't use one element arrays (2020-07-23 19:33:09 +0200)
> 
> are available in the Git repository at:
> 
>   git://people.freedesktop.org/~gabbayo/linux misc-habanalabs-next-2020-07-24

That one worked, thanks for the fixes, pulled and pushed out now.

greg k-h
