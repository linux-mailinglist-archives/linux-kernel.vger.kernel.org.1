Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706C02A605F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 10:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgKDJPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 04:15:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:33680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgKDJPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 04:15:50 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06FF62225B;
        Wed,  4 Nov 2020 09:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604481349;
        bh=N+KQ3BtxICyHpD34Ph9UwQE4Sa2F+ASu5tyf+dLtnog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oWFF7rC/DiIkvnOxjJBdjwkINIg5wqneG0x3WCDGn8EDYJ6vPF9JzZ6L0CAYVaVmE
         Z0EORkj8gKoyTvauk3dxnskdgmhjI/m0pvmd/2bof5h/tZYueJYSBvCO8Kw+4hFJjh
         5pyR/46V8P+PKtDde3pNi70QXxl6OsvGqjaDg9vQ=
Date:   Wed, 4 Nov 2020 10:16:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs fixes for 5.10-rc3
Message-ID: <20201104091635.GA1648092@kroah.com>
References: <20201104073701.GA9683@ogabbay-VM.habana-labs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104073701.GA9683@ogabbay-VM.habana-labs.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 09:37:01AM +0200, Oded Gabbay wrote:
> Hello Greg,
> 
> This pull request contains three small fixes for 5.10-rc3. Details are in
> the tag.
> 
> Thanks,
> Oded
> 
> The following changes since commit bcbc0b2e275f0a797de11a10eff495b4571863fc:
> 
>   mei: protect mei_cl_mtu from null dereference (2020-11-03 10:13:48 +0100)
> 
> are available in the Git repository at:
> 
>   ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-fixes-2020-11-04

Pulled and pushed out, thanks!

greg k-h
