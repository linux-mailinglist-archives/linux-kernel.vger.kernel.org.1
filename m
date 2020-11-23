Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B512C13E5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 20:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbgKWSwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 13:52:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:46534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729304AbgKWSwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 13:52:35 -0500
Received: from localhost (82-217-20-185.cable.dynamic.v4.ziggo.nl [82.217.20.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57D8820657;
        Mon, 23 Nov 2020 18:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606157554;
        bh=iRBhluR2X0svl3UIY69k+hGod907Z7hAftqBlychYLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=alh/kMQVuo/4HVkh9zzR804+/+HoDnUHqlrV4hGtxC2SNce5wFcXtvlCew8/1HyOk
         JYSzmrEmM1bfb4T6wRZE/6HU+ixls4xFAvZ+/8rOs3X5g1YmoXIzfDU3cuP6c+9omR
         ysFX39DkbtOU8r93TESRs2ctsjorMZyZcVVfyta0=
Date:   Mon, 23 Nov 2020 19:52:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs fixes for 5.10-rc6
Message-ID: <X7wE8BWNeHXD0p7y@kroah.com>
References: <20201123181429.GA11733@ogabbay-VM.habana-labs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123181429.GA11733@ogabbay-VM.habana-labs.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 08:14:29PM +0200, Oded Gabbay wrote:
> Hello Greg,
> 
> This pull request contains a single small fix for 5.10-rc6. Details are in
> the tag.
> 
> Thanks,
> Oded
> 
> The following changes since commit ef3f0caf243075ac255b69054cbf48b65eadb0d4:
> 
>   Merge tag 'icc-5.10-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-linus (2020-11-23 17:35:57 +0100)
> 
> are available in the Git repository at:
> 
>   ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-fixes-2020-11-23

Pulled and pushed out, thanks.

greg k-h
