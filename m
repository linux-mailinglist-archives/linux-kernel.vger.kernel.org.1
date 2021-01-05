Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5948C2EAC89
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 15:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbhAEOAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 09:00:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:42186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbhAEOAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 09:00:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F7D8229C4;
        Tue,  5 Jan 2021 14:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609855209;
        bh=ocyrC6aP8OkRzam8KDcWaeRpT/tK4GJHmOiU+2CWX9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D0dqu7V+3IHgiRVGHUJsiJ68sxesEYcHui7b8NbjVCbyYoMbQ9BEYxTTD2isOGzno
         vC6zUCayJekf2uK5pLvHUufjNLlvnyk+H5hiRXPh4YBT64kK/kpacMctEbyNtxPI7u
         QWjbi/x/0g/R+H0gtFsfMCryXbsxuc+AG3q7cPow=
Date:   Tue, 5 Jan 2021 15:01:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Defang Bo <bodefang@126.com>
Cc:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        dianders@chromium.org, arnd@arndb.de,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kgdbts: Passing ekgdbts to command line causes panic
Message-ID: <X/RxPSR3iQRxH+/o@kroah.com>
References: <1609120738-202321-1-git-send-email-bodefang@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609120738-202321-1-git-send-email-bodefang@126.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 09:58:58AM +0800, Defang Bo wrote:
> Similar to commit<1bd54d851f50>("kgdboc: Passing ekgdboc to command line causes panic"),

Please wrap your lines, and use the correct way to reference a commit in
a changelog as documented.  It should look like:
	1bd54d851f50 ("kgdboc: Passing ekgdboc to command line causes panic")

> kgdbts_option_setup does not check input argument before passing it to strlen.
> The argument would be a NULL pointer.

What argument?

As others pointed out, your subject line does not make sense, please fix
up.

thanks,

greg k-h
