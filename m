Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59791D9977
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 16:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbgESO0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 10:26:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbgESO0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 10:26:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF11020825;
        Tue, 19 May 2020 14:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589898363;
        bh=boYqNgFwlXUKiPwvvJJXpwr400FQfOFd/ekPF0S0brI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sv5z+OUiRKIG6nUlqWKNXJUpCm3oZCfGCKKBfHFoyshjC7PRLEDjtd7yoPL5KxGxr
         71mVHieKEVAI7R5yW4uNkF4NNX+eGpshVV9vN7KhljityIlohmIR0x0gcELQEQzN4+
         Va1B7L9568Tvu56mbbseukJ/Pu+rSG46U9vvQ/qk=
Date:   Tue, 19 May 2020 16:24:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs pull request for kernel 5.8
Message-ID: <20200519142448.GA635386@kroah.com>
References: <20200519130924.GA27366@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519130924.GA27366@ogabbay-VM>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 04:09:24PM +0300, Oded Gabbay wrote:
> Hello Greg,
> 
> This is the pull request for habanalabs driver for kernel 5.8.
> 
> This pull-request finally contains the code to handle the GAUDI ASIC. It
> contains both minor changes to the common code of the driver and of course
> the GAUDI-specific code, which is similar to the GOYA-specific code.
> 
> In addition, there is a new feature for command submission of signals and
> wait for signals through the driver. And of course other improvements.
> 
> Please see the tag message for more details on what this pull request
> contains.

Wow, 90k more new lines, not much sharing between the different ASICs :(

Anyway, now pulled and pushed out, thanks.

greg k-h
