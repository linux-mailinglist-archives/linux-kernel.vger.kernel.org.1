Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE08E3001F3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 12:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbhAVLtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 06:49:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:35160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbhAVLsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 06:48:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71ECD235F7;
        Fri, 22 Jan 2021 11:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611316089;
        bh=S1JhtbLSFiWA6bHtpOnMVBLBi6L31L8JmoSJUtICauI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WQvSH9vYgdM42Nq9H3Ks+qe5bqPwv+Zh98KtaQSqz+SnHcmVje5+FOrwdvguCTOD1
         tGJiizOAVeBh/iCiduM9R3uZYwLG/0B+Pd02bDBcMuAqbhXe1WYWlXkxfQWFYNnM8I
         DdIKmuz+EkvwcOpo/cJj8xsylzz3uxEXPal2Z2l0=
Date:   Fri, 22 Jan 2021 12:48:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1] misc: pti: Remove driver for deprecated platform
Message-ID: <YAq7duW1yE08mSja@kroah.com>
References: <20210122114358.39299-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122114358.39299-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 01:43:58PM +0200, Andy Shevchenko wrote:
> Intel Moorestown and Medfield are quite old Intel Atom based
> 32-bit platforms, which were in limited use in some Android phones,
> tablets and consumer electronics more than eight years ago.
> 
> There are no bugs or problems ever reported outside from Intel
> for breaking any of that platforms for years. It seems no real
> users exists who run more or less fresh kernel on it. The commit
> 05f4434bc130 ("ASoC: Intel: remove mfld_machine") also in align
> with this theory.
> 
> Due to above and to reduce a burden of supporting outdated drivers
> we remove the support of outdated platforms completely.
> 
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Nice, I'll gladly take patches to remove code, especially tty line
disciplines!  :)

thanks,

greg k-h
