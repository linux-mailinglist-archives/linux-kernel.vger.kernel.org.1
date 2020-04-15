Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54331A9465
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 09:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635219AbgDOHj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 03:39:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:59284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2635193AbgDOHjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 03:39:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5072206D9;
        Wed, 15 Apr 2020 07:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586935766;
        bh=QD/5tPs+ChlJ56eVrDh+1CHroT+IPaTXWzMyS60slZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RAiWKiydc1SG98P049kAyz6tmtVMjuPNavZyO2vhfoJ4GocCOn5xx5cmXRc2WPVaB
         3kYwCWHm1kcXV39EOyDFjrlM6YwkC3L38U7Vt+B7TcdbOFUgVTzEOj4Z9HtFFWqcWK
         n9z2XDqHuaRrxBgqDOnXQJlZC6St9+EM1tzl6H24=
Date:   Wed, 15 Apr 2020 09:29:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Bovensiepen <daniel@bovensiepen.net>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: tools: string.c doc fix
Message-ID: <20200415072923.GA2560564@kroah.com>
References: <20200414185430.GA14496@daboVM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414185430.GA14496@daboVM>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 08:54:30PM +0200, Daniel Bovensiepen wrote:
> Fix spelling error in the comment.
> 
> Signed-off-by: Daniel Bovensiepen <daniel@bovensiepen.net>
> ---
>  tools/lib/string.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Your subject does not match the patch (hint, this is not a
drivers/staging patch...)
