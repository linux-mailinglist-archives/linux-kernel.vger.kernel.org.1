Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84EDF225996
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 10:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgGTIC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 04:02:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbgGTIC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:02:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E38720702;
        Mon, 20 Jul 2020 08:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595232148;
        bh=YWX0T0Km4CQxwzthmPHWk15E4G6K+rvEZicBswWqlQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D0bBpJQWLUxeHEAVfDX+zZpddkA4SunlFzeU/0fuL0MYB9iyTUdVGZ+vUm3WAgMRT
         xTmYH5Tnsk7YwS1TNQvrmAUnSEBq6ln51Msby80CNavikEZAKqA9OZ8BZXX4zo4n/5
         YEw4xguk25vhBiwL3xW7YK8Cr8YiwFgXT6HkAUZg=
Date:   Mon, 20 Jul 2020 10:02:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs fixes pull request for kernel 5.8-rc7
Message-ID: <20200720080238.GB553171@kroah.com>
References: <20200719061322.GA31592@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719061322.GA31592@ogabbay-VM>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 19, 2020 at 09:13:22AM +0300, Oded Gabbay wrote:
> Hello Greg,
> 
> This pull request is for 5.8-rc7 and it contains an important bug fix for
> possible out-of-bounds access error.
> 
> Details are in the tag message below.
> 
> Thanks,
> Oded
> 
> The following changes since commit b279b1fe5799cf653de3822ca253f5d21639d90a:
> 
>   Merge tag 'misc-habanalabs-fixes-2020-07-10' of git://people.freedesktop.org/~gabbayo/linux into char-misc-linus (2020-07-17 11:56:58 +0200)
> 
> are available in the Git repository at:
> 
>   git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-fixes-2020-07-19

Pulled and pushed out, thanks.

greg k-h
