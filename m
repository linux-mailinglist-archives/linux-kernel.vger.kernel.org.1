Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A034271A4E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 07:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgIUFJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 01:09:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:35388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbgIUFJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 01:09:51 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9949920739;
        Mon, 21 Sep 2020 05:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600664991;
        bh=3mouzdzDe+zIdAUI84appaTKfzTrfev8XyD553QgtYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U6T38ru6jDtUOT64Ei2bWqc+OG9tY4u0edA8H98XSkwdfR3Si8ghY1kGCpuVbS8Aj
         MwvpOfYSKcS8jBkUbQZO7xzbMxZZ+d1Uqk6JdctgtvJHAr8BG/8nSDgaFX8Wvsa14S
         wLnNhuwAF1Xibei7mqXYlvgx6CRA4N4N0hhnhfg4=
Date:   Mon, 21 Sep 2020 07:09:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     James Browning <jamesbrowning137@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ian Abbott <abbotti@mev.co.uk>
Subject: Re: [PATCH 2/2] drivers:staging:comedi:comedi.h Fixed typo in comment
Message-ID: <20200921050946.GB537189@kroah.com>
References: <20200921041452.7293-1-jamesbrowning137@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921041452.7293-1-jamesbrowning137@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 20, 2020 at 09:14:49PM -0700, James Browning wrote:
> Removed repeated word "in"
> 
> Signed-off-by: James Browning <jamesbrowning137@gmail.com>
> ---
>  drivers/staging/comedi/comedi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

You sent two different patches that did different things, yet had the
same exact subject line, which isn't ok.

Why not just merge them into the same patch?

thanks,

greg k-h
