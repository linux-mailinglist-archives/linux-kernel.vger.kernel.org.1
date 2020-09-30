Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71E927E501
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 11:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbgI3JV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 05:21:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727746AbgI3JV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 05:21:27 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEE3820754;
        Wed, 30 Sep 2020 09:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601457687;
        bh=zywPpSwWaP6wK2pmrgA7OhCg1Alk+yI6mCT5zTybZjE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EWB+nOPrkURQtSy1/lM0KgGE2oAt5IfeQVBHlG1eqkg7YmFHjIxTDj2RTg22aL60J
         Q51BYCLrW1+DQxQ9RRfKl6NHOClhFun4m5NwOSBn2YKKAHzG3XBJ4jpZ5Ryd77bGVM
         rCc+FU50TnAFLetQzegzrlPip1xgEPNBxNTXiDgM=
Date:   Wed, 30 Sep 2020 11:21:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pujin Shi <shipujin.t@gmail.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, hankinsea@gmail.com
Subject: Re: [PATCH] tty: serial: mvebu-uart: Remove unused variable 'ret'
Message-ID: <20200930092131.GC1580803@kroah.com>
References: <20200930081459.1269-1-shipujin.t@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200930081459.1269-1-shipujin.t@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 04:14:59PM +0800, Pujin Shi wrote:
> 'ret' variable is now defined but not used in mvebu_uart_probe(),
> causing this warning:
> 
>   drivers/tty/serial/mvebu-uart.c: In function ‘mvebu_uart_probe’:
>   drivers/tty/serial/mvebu-uart.c:806:6: warning: unused variable ‘ret’ [-Wunused-variable]
> 
> Signed-off-by: Pujin Shi <shipujin.t@gmail.com>

What commit caused this problem?

And are you sure it's not already fixed by:
	https://lore.kernel.org/r/20200929085651.158283-1-miaoqinglang@huawei.com

thanks,

greg k-h
