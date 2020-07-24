Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD9222C254
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 11:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgGXJc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 05:32:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbgGXJc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:32:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C29820674;
        Fri, 24 Jul 2020 09:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595583177;
        bh=BWljmyhe1oKdQN+9o1Vf9fFAye3Mnk0hkz4TaEYkzmk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2dVMsq4QTbxkuQYORkEyw8mmcfhU9qF+zHQixmTNi/JGD5Zk4MSaloe+vIS4S01ZJ
         G6peVN8YZ+N62KWhMPQMxPFt+puP12bhpjEpkxPDpe2Hh1dg6g04L2ae2cHoUyBwqo
         vKJs6kv7yfyIL5u25md0/vxmcUIqhby9s1uoX/4U=
Date:   Fri, 24 Jul 2020 11:32:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs pull request for kernel 5.9-rc1 (resend)
Message-ID: <20200724093259.GB4116407@kroah.com>
References: <20200723191525.GA24516@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723191525.GA24516@ogabbay-VM>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 10:15:25PM +0300, Oded Gabbay wrote:
> Hello Greg,
> 
> (Re-sending this pull request)
> 
> This is habanalabs pull request for the merge window of kernel 5.9. It
> contains many small improvements to common and GAUDI code. Details are in
> the tag.
> 
> Thanks,
> Oded
> 
> The following changes since commit 7a4462a96777b64b22412f782de226c90290bf75:
> 
>   misc: rtsx: Use standard PCI definitions (2020-07-22 13:39:31 +0200)
> 
> are available in the Git repository at:
> 
>   git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-next-2020-07-23

{sigh}

Commit: 961a7325e670 ("habanalabs: Fix memory leak in error flow of context init")
	Fixes tag: Fixes: 786c94810698 ("habanalabs: Use pending cs amount per asic")
	Has these problem(s):
	        - Subject does not match target commit subject
	          Just use
		                git log -1 --format='Fixes: %h ("%s")'

The scripts I use to check this are here:
	https://github.com/gregkh/gregkh-linux/blob/master/work/verify_fixes.sh
	https://github.com/gregkh/gregkh-linux/blob/master/work/verify_signedoff.sh

And note, if I ignore these errors, you will just get the same response
from Stephen when it hits linux-next :(

thanks,

greg k-h
