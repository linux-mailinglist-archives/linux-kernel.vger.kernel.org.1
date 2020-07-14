Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2EA21F71D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 18:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgGNQTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 12:19:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:47552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgGNQTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 12:19:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0986B2251F;
        Tue, 14 Jul 2020 16:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594743590;
        bh=lRSE/4hSn1v2fMwF9n46EsTDKUbMg56aFEA+qhfcP9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qBzwb4f8LW3UEB7F8Jb8cf9IX+qFNOmLeiKzIa9Ooq7h2pRN0jLasD7vbnkiTCo/q
         wjHoMBpMbmzqq+OQ3phhpUMCmvPlNUQwszES7Sk742Aib0XNuqeTtSLBC6W8UxWVDx
         Ri9c7y6iJQduP16H88phMTHeLSvH4Z4kS08Ag0NY=
Date:   Tue, 14 Jul 2020 18:19:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] hpilo: Replace one-element array with
 flexible-array member
Message-ID: <20200714161948.GA2092551@kroah.com>
References: <20200714154449.GA26153@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200714154449.GA26153@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 10:44:49AM -0500, Gustavo A. R. Silva wrote:
> There is a regular need in the kernel to provide a way to declare
> having a dynamically sized set of trailing elements in a structure.
> Kernel code should always use “flexible array members”[1] for these
> cases. The older style of one-element or zero-length arrays should
> no longer be used[2].
> 
> For this particular case, it is important to notice that the cachelines
> change from 7 to 6 after the flexible-array conversion:

That's really funny to see.  Nice work, I'll go queue this up.  I doubt
anyone will notice as this is a very old driver :)

thanks,

greg k-h
