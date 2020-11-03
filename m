Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D75A2A3CE1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 07:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbgKCGiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 01:38:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:35918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbgKCGiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 01:38:21 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6F312227F;
        Tue,  3 Nov 2020 06:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604385500;
        bh=FPjzF3WG+1nROwjRngPTor3p1eCnrBE7BR72hTI2w7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QYX6otrUkHFU+rucDzM/Nxle+mYTrKRd0prpk7SwSKhrszIMEYDxMc1jBaFBY/SIH
         5UgIk6ojDVZ2GD5M5kqGDgjSnEDYMyzCGejWBeIFBJwL0zzPPWoCLFR8CY4Wn7d5lm
         zrQt0KY7097addDiwDgkJoogd3DYqAMHRkO/8sdw=
Date:   Tue, 3 Nov 2020 07:38:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     rui_feng@realsil.com.cn
Cc:     arnd@arndb.de, ulf.hansson@linaro.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH] misc: rtsx: Fix some bugs and add test mode for rts5261
Message-ID: <20201103063816.GA74830@kroah.com>
References: <1604374035-2945-1-git-send-email-rui_feng@realsil.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604374035-2945-1-git-send-email-rui_feng@realsil.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 11:27:15AM +0800, rui_feng@realsil.com.cn wrote:
> From: Rui Feng <rui_feng@realsil.com.cn>
> 
> 1.Add force test mode
> 2.Fix OCP function
> 3.Use aspm in way of backdoor
> 4.Fix PAD driving
> 5.Not support MMC default
> 6.Support CD&WP reverse
> 7.Add hardware auto power down when unplug card

When you have to list the different things you are doing in a single
patch, that is a huge sign that you need to break this up into much
smaller patches.  Please turn this patch into a patch series, each patch
only doing one logical thing.

thanks,

greg k-h
