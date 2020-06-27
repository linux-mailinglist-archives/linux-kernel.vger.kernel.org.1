Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C53920C01C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jun 2020 10:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgF0ITz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Jun 2020 04:19:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgF0ITz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 04:19:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8497B2080C;
        Sat, 27 Jun 2020 08:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593245995;
        bh=4Y3XV82XAfOtPpLYFpPvrfTCFvNM0uZmqgZ2kY8PyMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f6PfUVZByYBOMyFI3n2tZQ83/m0MQKsl4NpXG4jaOkBhVpYLGwIKs8orBHS0Hp94z
         zDBHi15ocEsw5pSVqNKL8pivEoLLLQr3LAsANAb8T8+Z1QlkcX+TX1i9DVEnotK/ej
         ZlOOGs1tpxZl0OZEfxpn7f+G/id3yKBUR4z78yaI=
Date:   Sat, 27 Jun 2020 10:19:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     B K Karthik <bkkarthik@pesu.pes.edu>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: rtl8712_recv.h: Removing unnecessary
 blank line
Message-ID: <20200627081948.GB1550330@kroah.com>
References: <20200627080356.6xn3ycyl3zgaddmw@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200627080356.6xn3ycyl3zgaddmw@pesu-pes-edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 04:03:56AM -0400, B K Karthik wrote:
> Removing unnecessary blank line

That says what you are doing, but not why you are doing it...

Stop, take a day or so, relax, and come back after reading a bunch about
how to write a good changelog text (link has been provided to you many
times already).

There's no rush here.  Take the time to get it right so you don't waste
other people's time.

thanks,

greg k-h
