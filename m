Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D192B16A5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 08:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgKMHom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 02:44:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:46956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbgKMHol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 02:44:41 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AA98208D5;
        Fri, 13 Nov 2020 07:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605253481;
        bh=HsvXe7iGCQcUXJwGgfM5sQFPMyfm6rO5evBIGLSL41o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pFQnhOevpwTnpyuhfosti2Axiti+Sxw/8XLAzYdMOEmM9OhbLx5OWYJWlNfWGKNyA
         UMuC8Cds+7eGHZIdP/AzBuyUln6q3+cevseKzyUiATyW8c9ozZ7L+L1b8+7PDbYlFC
         N2eYbw//MSl3McFSzYarcS6r8cmUIzgxcRlmAKGg=
Date:   Fri, 13 Nov 2020 08:45:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     rkir@google.com
Cc:     linux-kernel@vger.kernel.org, lfy@google.com
Subject: Re: [PATCH] drivers: staging: retire drivers/staging/goldfish
Message-ID: <X645op2c70msQ+o3@kroah.com>
References: <20201112234907.3761694-1-rkir@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112234907.3761694-1-rkir@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 03:49:07PM -0800, rkir@google.com wrote:
> From: Roman Kiryanov <rkir@google.com>
> 
> Android Studio Emulator (goldfish) migrated
> to Intel HDA.

When was that?

> 
> Signed-off-by: Roman Kiryanov <rkir@google.com>
> ---
>  arch/mips/configs/generic/board-ranchu.config |   1 -
>  drivers/staging/Kconfig                       |   2 -
>  drivers/staging/Makefile                      |   1 -
>  drivers/staging/goldfish/Kconfig              |   7 -
>  drivers/staging/goldfish/Makefile             |   6 -
>  drivers/staging/goldfish/README               |   5 -
>  drivers/staging/goldfish/goldfish_audio.c     | 383 ------------------

What about the other goldfish drivers?

thanks,

greg k-h
