Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE872D05CE
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 17:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgLFQCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 11:02:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:35202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbgLFQCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 11:02:49 -0500
Date:   Sun, 6 Dec 2020 17:03:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607270529;
        bh=0FflSmA1v4GBMAOc9xGQoPxFOoHKt02TbpXBi/lcBQ8=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=HIEO3vF1i5k8ZMDuGRuv3JLNbFlBk0XiWyj7B0PwkfnwfD3ftNm7sTgvob83IgdU4
         39JRSxKg2lyEmyffzPaGh5zEtFVPup0OZbI7sxZZ8f2B3zd8EWX8ww5jz8NfTvUvR5
         /Vg50nrVpa8DVew7zSYfw0iJSF30mU+wWQhqSdA4=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     shaojie.dong@isrc.iscas.ac.cn
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: check register_netdev() return value
Message-ID: <X80AySpyP3fxhRmb@kroah.com>
References: <20201206155907.7991-1-shaojie.dong@isrc.iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201206155907.7991-1-shaojie.dong@isrc.iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 06, 2020 at 11:59:07PM +0800, shaojie.dong@isrc.iscas.ac.cn wrote:
> From: "shaojie.dong" <shaojie.dong@isrc.iscas.ac.cn>
> 
> Function register_netdev() can fail, so we should check it's return value

You just check it, you are not doing anything with it, which is just the
same as not checking this.

Please fix this properly.

thanks,

greg k-h
