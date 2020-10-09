Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7B7288510
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 10:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732701AbgJIIRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 04:17:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732337AbgJIIRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 04:17:54 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F4D822245;
        Fri,  9 Oct 2020 08:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602231474;
        bh=iLlGeNJ5wJEEQS6fni9Dzt2e3j/H8qHfnL6OgyYAI7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ylDT/qvFvb3AuIMNgAs3i2kDruDZvk2tPfzu9W3Q0CEVLZUoSpz+gHY1Kr1FpPOkP
         5/JBEXPLlPv+Zt7Lxkx2Pi4qlW7UPKZiw+9B5d17dpS6Jlszcalj2u461bp5RClg5P
         CpYP0FmHBAPcFX62nJQtry9IyhND/iBeDKey0F5U=
Date:   Fri, 9 Oct 2020 10:18:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tabot Kevin <tabot.kevin@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixed coding style issues raised by checkpatch.
Message-ID: <20201009081840.GB401030@kroah.com>
References: <20201009080038.GA1439@tabot>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009080038.GA1439@tabot>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 09:00:38AM +0100, Tabot Kevin wrote:
> This patch fixes the following:
> - Made sure alignment matched open parenthesis.
> 
> Signed-off-by: Tabot Kevin <tabot.kevin@gmail.com>
> ---
>  drivers/staging/greybus/audio_module.c | 8 ++++----

As my bot asked you to, please use scripts/get_maintainer.pl to
determine who, and what mailing lists, to send patches to.

Also, I think this patch has been rejected many times in the past,
please check the archives first before sending it again.

thanks,

greg k-h
