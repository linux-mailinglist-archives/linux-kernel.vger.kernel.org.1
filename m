Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711891D993A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 16:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbgESOQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 10:16:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbgESOQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 10:16:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 273CA20829;
        Tue, 19 May 2020 14:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589897803;
        bh=8JZlRqRPkafvtKAvR/hAADRfoNdbOSTh6wdLLvrmELI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hCWTY0u2QZvaI0pFXX6Bc4kyh65U21v7F1Lnr7c5e+XPnVnkQr/F30t1igtUTLH9/
         DJRHmNIN5bAMdo5LAiRtt1KrIQNvs0WmK3DFRKQgxxj9Yz0+VRvtaTwHHgPtlaITOq
         A3J18dN5NGumYPLfU0PrdpGwRLCg46sCYh4/wC88=
Date:   Tue, 19 May 2020 16:16:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pascal Terjan <pterjan@google.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8192u: Merge almost duplicate code
Message-ID: <20200519141641.GA577903@kroah.com>
References: <202005180407.tRbGahKX%lkp@intel.com>
 <20200517204045.183223-1-pterjan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200517204045.183223-1-pterjan@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 17, 2020 at 09:40:45PM +0100, Pascal Terjan wrote:
> This causes a change in behaviour:
> - stats also get updated when reordering, this seems like it should be
>   the case but those lines were commented out.
> - sub_skb NULL check now happens early in both cases, previously it
>   happened only after dereferencing it 12 times, so it may not actually
>   be needed.
> 
> Signed-off-by: Pascal Terjan <pterjan@google.com>

This patch adds a new compiler warning, which no patch should do.

Please fix that up and resend.

thanks,

greg k-h
