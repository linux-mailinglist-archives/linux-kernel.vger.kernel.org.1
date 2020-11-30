Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86DAB2C86CC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbgK3ObT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:31:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:42228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727128AbgK3ObS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:31:18 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8B6120684;
        Mon, 30 Nov 2020 14:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606746632;
        bh=D27Gu95pKAGcM93pByJ39JqV0fJdydejjyTqygfl11A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2FaF+pnCkjJB4QT86z2bm8s/5F9NCIlIoZf9fRQs9F4flFaQR58ONy+wIel1o+kT/
         P7D8cMoTRwBHEiawHQ9jlnqXfbac0yA0jyKkqQ14hUHCc2zEJgFfAKkJO/TiUV+Ntj
         0zf2LgZxe0Y5zBuB8q6flDkQX4fZqKP5SFMsQO9M=
Date:   Mon, 30 Nov 2020 15:31:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs fixes for 5.10-rc7
Message-ID: <X8UCUn5MrsUYvdZm@kroah.com>
References: <20201130083830.GA9154@ogabbay-VM.habana-labs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130083830.GA9154@ogabbay-VM.habana-labs.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 10:38:30AM +0200, Oded Gabbay wrote:
> Hello Greg,
> 
> This pull request contains two memory leak bug fixes for 5.10-rc7.
> Details are in the tag.
> 
> Thanks,
> Oded
> 
> The following changes since commit f0992098cadb4c9c6a00703b66cafe604e178fea:
> 
>   speakup: Reject setting the speakup line discipline outside of speakup (2020-11-30 09:20:32 +0100)
> 
> are available in the Git repository at:
> 
>   ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-fixes-2020-11-30

Pulled and pushed out, thanks.

greg k-h
