Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840772C86EF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgK3OjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:39:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:48234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgK3OjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:39:11 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9F3220725;
        Mon, 30 Nov 2020 14:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606747110;
        bh=UdYWDlDhyBEqjccYjCCMZVyow28VX175mqftw1fJDyU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dpCF+KIoTIaSJQK1vmCmo9EKhH5iUSgkYUXF816294Vq3Ds49BFgbjOcaDxDI+8Dr
         dmd6jPuBl8hzbcMj3zCjiw8PzVg/vZMkTWxbvUceELELTlK0+V+kgxRWUZsH2ibzny
         RXW8kt0CNvjABJUeXomIdGAvz19qG5zk9yHRX7xs=
Date:   Mon, 30 Nov 2020 15:38:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs pull request for kernel 5.11-rc1
Message-ID: <X8UEApaLx+yw+JK4@kroah.com>
References: <20201130091304.GA17912@ogabbay-VM.habana-labs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130091304.GA17912@ogabbay-VM.habana-labs.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 11:13:04AM +0200, Oded Gabbay wrote:
> Hello Greg,
> 
> This is habanalabs pull request for the merge window of kernel 5.11.
> It contains many changes, new features, support for new firmware.
> Details are in the tag.
> 
> Thanks,
> Oded
> 
> The following changes since commit 3473065927a877e0a15c4d4b64f245ccaba24e3f:
> 
>   Merge 5.10-rc6 into char-misc-next (2020-11-30 08:33:06 +0100)
> 
> are available in the Git repository at:
> 
>   ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-next-2020-11-30

Pulled and pushed out, thanks.

greg k-h
