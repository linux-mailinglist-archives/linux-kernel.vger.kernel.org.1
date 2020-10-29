Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF17929E4D1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387678AbgJ2Hr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:47:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:52686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387639AbgJ2HrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:47:23 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F9362076B;
        Thu, 29 Oct 2020 05:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603948930;
        bh=TGoZjMo8QP/0JoGo1NmGUBmyKWs7VMqNFa8Iyu8aWtU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oE5xwZsnzuxr77Q3NfWStDdVXKPtnN9RqwowGyYrKvaKhNF61hELTcGGb+gjqsgcY
         K0KN/VWD/HQWHz5c9ZwbO2PAv8D7u75gWnnLfv+1V2NedHeAnM5W9WLmpgiL8VzxSa
         BEVb+oEs6eLTymlKMThmspnFFjVH88FZYsER+kEM=
Date:   Thu, 29 Oct 2020 06:22:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Manuel Palenzuela <manuelpalenzuelamerino@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: rtl8723bs: core: rtw_cmd: Fixed two
 if-statement coding style issues
Message-ID: <20201029052206.GB282324@kroah.com>
References: <20201028212837.28030-1-manuelpalenzuelamerino@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028212837.28030-1-manuelpalenzuelamerino@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 09:28:37PM +0000, Manuel Palenzuela wrote:
> Fixed two cases where the if-statement coding style wasn't following the guidelines. (rtw_cmd.c)
>

Please properly wrap your changelog comments at 72 columns like your
editor asked you to :)

And what is with the file name in ()?

thanks,

greg k-h
