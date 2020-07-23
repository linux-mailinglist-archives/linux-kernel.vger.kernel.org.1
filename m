Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5819E22B63F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 20:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgGWS73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 14:59:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726425AbgGWS72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 14:59:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0DA3206F4;
        Thu, 23 Jul 2020 18:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595530768;
        bh=8vbG20awn8KNpkhjnzQc1miCHWUCbrmIEj1rZZ3dr3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=083T7vXqCCTQqNq8eFr+N7rLF9tqNCFrOj2so8SUtuZz/aS8Gd3D/vtQ7KKxckAay
         gkRbFYIWqb+F4ZeW9esJmJwLgys+5PUmXlGmTU2XK9xZdZOYcZwvg+dTNsaQKPowAu
         oCrm7L+W+DX7WxYlGMuXlmTUtyT8iaAPOzk6/hHk=
Date:   Thu, 23 Jul 2020 20:59:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs pull request for kernel 5.9-rc1
Message-ID: <20200723185931.GC3768907@kroah.com>
References: <20200723152938.GA17799@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723152938.GA17799@ogabbay-VM>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 06:29:38PM +0300, Oded Gabbay wrote:
> Hello Greg,
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

My scripts spit out the following error when I tried to push this out:

 Commit: fc83dc9787ce ("habanalabs: Fix memory leak in error flow of context init")
	Fixes tag: Fixes: "habanalabs: Use pending cs amount per asic"
	Has these problem(s):
	        - No SHA1 recognised


Your line:
	Fixes: "habanalabs: Use pending cs amount per asic"

should have a sha1 in it :(

And use the proper format as well.

Can you fix this up and resend the pull request?

thanks,

greg k-h
