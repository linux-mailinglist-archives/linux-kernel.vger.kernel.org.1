Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6091220F115
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 11:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731882AbgF3JBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 05:01:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:58060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731591AbgF3JBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 05:01:01 -0400
Received: from localhost (unknown [84.241.197.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15CCC206C3;
        Tue, 30 Jun 2020 09:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593507660;
        bh=JcF8qvU8w2KHZowpHoHgAHPE8do02qsOarLkPLKejdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pOPIoThJ9cnFewrARtPtEO4OILc92Zvg+2hVVlBwENeL5KPwQ3RCm5NWChQ2okHfX
         F9q3iSZ919056i8uQPrhCIhP1mPEbZzz6JCEqkGnfKafizFUEYnkEr/7cwqyTOv4Lj
         ZeCWgvx4NXT5UYv7NJamBf1SDPbEYLREc0rPoy9I=
Date:   Tue, 30 Jun 2020 11:00:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Gutson <daniel.gutson@eclypsium.com>
Cc:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>
Subject: Re: [PATCH] SPI LPC information kernel module
Message-ID: <20200630090057.GG637809@kroah.com>
References: <20200629225932.5036-1-daniel.gutson@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629225932.5036-1-daniel.gutson@eclypsium.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 07:59:32PM -0300, Daniel Gutson wrote:
> +EXPORT_SYMBOL_GPL(spi_read_sbase);

Why are you exporting symbols?  Nothing in this patch uses them.

And that's the spi_* namespace for the SPI core, not your tiny driver,
why pollute the global namespace in a confusing way like this?

thanks,

greg k-h
