Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD952595BA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 17:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732093AbgIAPzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 11:55:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732029AbgIAPzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:55:02 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A6F520767;
        Tue,  1 Sep 2020 15:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598975702;
        bh=c72suyWJTM1eYoxx7QLiNfPBmiXGbRlTMglmLBFCYXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b+BCiaQCdhLoQd8WoHRmzLOuGFVrquwVacZHjDmOwPkQpdOlYpjRKv5NUAIxCr6gp
         mF2GgyjFFo9AAJTcGAX8+aj8qP095+8aRF404LqDwCCgrkLhsgsDk6mndUCbgcj3e9
         1gRaQn4iWnvdPoFo450gtR/NDTh/HXTBHIfONsTU=
Date:   Tue, 1 Sep 2020 17:31:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs fixes pull request for kernel 5.9-rc4
Message-ID: <20200901153103.GK1399403@kroah.com>
References: <20200831125829.GA29862@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831125829.GA29862@ogabbay-VM>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 03:58:29PM +0300, Oded Gabbay wrote:
> Hello Greg,
> 
> This is the pull request for habanalabs driver fixes for 5.9-rc4.
> Two small fixes, details are in the tag.
> 
> Thanks,
> Oded
> 
> The following changes since commit f75aef392f869018f78cfedf3c320a6b3fcfda6b:
> 
>   Linux 5.9-rc3 (2020-08-30 16:01:54 -0700)
> 
> are available in the Git repository at:
> 
>   git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-fixes-2020-08-31

Pulled and pushed out, thanks.

greg k-h
