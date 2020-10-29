Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C0429EA8E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 12:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbgJ2Laj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 07:30:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbgJ2Lai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 07:30:38 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 300112076E;
        Thu, 29 Oct 2020 11:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603971037;
        bh=CrB69QBgt2+YqGF73196C3vUUw+lxRnYk6sYJrxjLJk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MQsdSRMnn4X7uFC+C8QtLwJt9E+dXcbdunFaa6JKZc9v4Zr04IdaKkcSmOdItvKuP
         boqbuYvDcukFuSvg40BIHNwBI3i2bL1vbZ/E7JaVKPUnFliRjwLEhMFuLPiemq6Tq6
         nW+yrvOsxpN8uA3eyrEYrFJnYEBRWu/6wLlIrUf8=
Date:   Thu, 29 Oct 2020 12:31:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: staging: rtl8188eu: Fix spelling in two
 comments i.e defalut to default
Message-ID: <20201029113127.GB3850079@kroah.com>
References: <20201029110600.3091-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029110600.3091-1-unixbhaskar@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 04:36:00PM +0530, Bhaskar Chowdhury wrote:
> Fixed two spelling in two different comments.
> 
> s/defalut/default/p
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  Greg, I have included the driver name as you suggested.

Suggested when, is this a v2 patch?

Remember, kernel maintainers have the short-term memory of a squirrel...

Please resend and properly version your patch as the Documentation asks
you to.

thanks,

greg k-h
