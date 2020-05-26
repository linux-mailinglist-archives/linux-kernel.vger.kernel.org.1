Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A3E1E0746
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 08:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388910AbgEYGuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 02:50:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388487AbgEYGuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 02:50:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC3C8206B6;
        Mon, 25 May 2020 06:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590389425;
        bh=vepi29L8xECw5cOAnl/gvGmG8/ppufRGsRSVfQXE6lY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TvF6gphGg1uFONlusq+LEA9nAmStZXptnZZR+LQydYLhOvCR2loi5Qx6Kom4zTmCc
         LoOWAmHvI9W4oHGlgAX+d00BH6hw4dzx1elZk45IES8wtwpIbcNkJLTyAndwebgKde
         Ei5tnlQWYYdSLUb8pyTwGTd9zLuqtGnX/7qpny2I=
Date:   Mon, 25 May 2020 08:50:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs second pull request for kernel 5.8
Message-ID: <20200525065015.GA61627@kroah.com>
References: <20200525052819.GA19318@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525052819.GA19318@ogabbay-VM>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 08:28:19AM +0300, Oded Gabbay wrote:
> Hello Greg,
> 
> This is the second pull request for habanalabs driver for kernel 5.8.
> 
> It contains important improvements to our MMU code and our ASIC reset code.
> 
> Please see the tag message for more details on what this pull request
> contains.
> 
> Thanks,
> Oded
> 
> The following changes since commit 709b41b56a16a5901a89dcaeb75d2233f80d9e55:
> 
>   misc: rtsx: Remove unnecessary rts5249_set_aspm(), rts5260_set_aspm() (2020-05-22 09:38:14 +0200)
> 
> are available in the Git repository at:
> 
>   git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-next-2020-05-25

Pulled and pushed out, thanks.

greg k-h
