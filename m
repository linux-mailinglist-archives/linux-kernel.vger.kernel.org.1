Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8887301C48
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 14:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbhAXNhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 08:37:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:45394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726993AbhAXNhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 08:37:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B17F522DD6;
        Sun, 24 Jan 2021 13:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611495422;
        bh=N5oMPbzb4SoRG0bkDCgFkxwkfJP8IM3lBBHC07nCeww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sk6YGCZ3IyDjUavH3FEnJBFgUtujQ6jNzzg62AGAUAJuHxVQ570dSB5gkaREu5Zxe
         X5ZCFyuWiJgoLLQXEA0q7Huft2Vz7NP+qfWKIUhZjBQ/j2de1DunO/NHIL/xWKKJ5c
         6+g4rTxVvIxJHfc7Fbiu6znKnFnPO2wIUvnL9Ujo=
Date:   Sun, 24 Jan 2021 14:36:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     angkery <angkery@163.com>
Cc:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Junlin Yang <yangjunlin@yulong.com>
Subject: Re: [PATCH v2] usb: typec: tcpci_maxim: remove redundant assignment
Message-ID: <YA134dhtrYpt5R/J@kroah.com>
References: <20210124133137.1468-1-angkery@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210124133137.1468-1-angkery@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 24, 2021 at 09:31:37PM +0800, angkery wrote:
> From: Junlin Yang <yangjunlin@yulong.com>
> 
> PTR_ERR(chip->tcpci) has been used as a return value,
> it is not necessary to assign it to ret, so remove it.
> And add terminating '\n' to the formats where missed too.
> 
> Signed-off-by: Junlin Yang <yangjunlin@yulong.com>
> ---
> v2: add terminating '\n' to the formats where missed too.

Don't mix different things in the same patch, this should be a patch
series of 2 patches.

thanks,

greg k-h
