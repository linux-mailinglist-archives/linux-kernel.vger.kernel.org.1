Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B7E2F9691
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 01:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbhARAYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 19:24:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:56920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729469AbhARAYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 19:24:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 337CB2151B;
        Mon, 18 Jan 2021 00:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610929405;
        bh=eEzW6zpYU95cgHowqJxUv00hnZZvO2jPd/Jm93AoAgE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y1CfDOxy9eaxXHAFn3U0K9WgSTHceDyJ3yCyu9GRMZLGIgJPUB78cpKHxnPfmBGxn
         qHi80ibZ7Zt+jZl2yFFkR18uXcu98o9CmS6RV4DFGX1d3M6hZgQ2SAxMlB55dlfAc7
         +14+2E7hNrCvHHBI3JxcPOZgDZRkvNE+QkEB8wRlrLl5/A7FY6psrs0xIFK9nMfnEQ
         G0tWYVuL8plDrRfumjCTbdidWEcS7jhnr/yXfHFkRl9POxoNfTzI7pkpeGcRqp+Yzb
         z9jSiIagET6wbGW4TKgaEujx+DyhPiILKi5ScHn2yVscHh5wJ/BGvLHsPcIXnTC+a5
         bjp8MMG9FMm2g==
Date:   Mon, 18 Jan 2021 08:23:20 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 0/2] arm64: small Kontron K-Box A-230-LS fixes
Message-ID: <20210118002320.GD28365@dragon>
References: <20210110195454.27808-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210110195454.27808-1-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 10, 2021 at 08:54:52PM +0100, Michael Walle wrote:
> This will enable the driver for the PHY found on this board as well as
> add SATA support.
> 
> Michael Walle (2):
>   arm64: defconfig: Enable Broadcom BCM54140 PHY
>   arm64: dts: freescale: sl28: enable SATA support

Applied both, thanks.
