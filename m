Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8748A2F1866
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730420AbhAKOiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:38:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:41732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727984AbhAKOiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:38:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 82FEA21744;
        Mon, 11 Jan 2021 14:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610375841;
        bh=2IffNZEoiDaM707stj+ReweggDD8VxNZb/61Uf+Gh2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KTML5m/3hGBs8COhDI6C+BoUz3++RHzajHdelCqV2uErmkjU3/h0F8xn4Sy5bkw6P
         06evFrEode19wRXRGbTLGFyOMvdu8tu1aFGmj964yaR45prZPtffi30F3mArPZPBH9
         0FPx8kApg7eI4Oj4gBTthidcUu9hsSJFOvD3SelA=
Date:   Mon, 11 Jan 2021 15:38:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [GIT PULL]: Generic phy fixes for v5.11
Message-ID: <X/xi6GVwZzWtS2nF@kroah.com>
References: <20210109085423.GX2771@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210109085423.GX2771@vkoul-mobl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 09, 2021 at 02:24:23PM +0530, Vinod Koul wrote:
> Hi Greg,
> 
> Please pull to receive couple of driver fixes for generic phy subsystem.
> All these are in linux-next
> 
> The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:
> 
>   Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes-5.11

pulled and pushed out, thanks.

greg k-h
