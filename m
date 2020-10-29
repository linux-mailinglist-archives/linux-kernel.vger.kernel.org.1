Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334A529E3EC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgJ2HXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:23:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbgJ2HWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:22:23 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BF62214DB;
        Thu, 29 Oct 2020 07:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603955103;
        bh=+GsVlcCponVVw2JR2i/jaQBVzdusBh+IIymcibLgJQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1urbV+oQwoS8Pi9Zfv51eFjq6DEYgD8883CPg+NX7ha1nEWevpD75GpSQszw10SiU
         hjf50Ni6GFM3/aUGhcO7FJrwuT7NPBJAXiZUYCp3WJqw5bJBJ6zyh02ah7mDIZUoDd
         J1idpLCGrTitgiVHT+Bb31tpR0152XVta1ucseTY=
Date:   Thu, 29 Oct 2020 08:05:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sangmoon Kim <sangmoon.kim@samsung.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: misc: increase DYNAMIC_MINORS value
Message-ID: <20201029070552.GA3062343@kroah.com>
References: <CGME20201029063539epcas1p36375a73634374656654da00cbaf91531@epcas1p3.samsung.com>
 <20201029062855.19757-1-sangmoon.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029062855.19757-1-sangmoon.kim@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 03:28:55PM +0900, Sangmoon Kim wrote:
> DYNAMIC_MINORS value has been set to 64.
> Due to this reason, we are facing a module loading fail problem of
> device driver like below.
> 
>  [   45.712771] pdic_misc_init - return error : -16
> 
> We need to increase this value for registering more misc devices.

That's a lot of misc devices, nice to see it used more now :)

I'll go queue this up, thanks!

greg k-h
