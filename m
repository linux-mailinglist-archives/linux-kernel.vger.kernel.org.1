Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C35521D181
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 10:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgGMISr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 04:18:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgGMISr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:18:47 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A6E9206F0;
        Mon, 13 Jul 2020 08:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594628327;
        bh=o46nuPGueRaSz/G+51+rKoHZPhJdLt40f1tfv8R5V68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rfczztn1QKP0+j56ueC+rTgS0upViPY7Q8hKF3ln/DMSlCiP5avNOayMaNLr8T/6c
         OUb47lFeuWhi/fLIprxbXVYUOtYbr6R/cRhVNeHIXoc5CBcqm0pdx8FJsIRtqqwiTI
         vV8obawvcxkxQE7q7K2IwIfd3KuVgIT7SEkjA5ts=
Date:   Mon, 13 Jul 2020 16:18:41 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Chris Healy <cphealy@gmail.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, andrew.smirnov@gmail.com,
        l.stach@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch
Subject: Re: [PATCH v3] arm64: dts: zii-ultra: update MDIO speed and preamble
Message-ID: <20200713081841.GM12113@dragon>
References: <20200708010005.6366-1-cphealy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708010005.6366-1-cphealy@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 06:00:05PM -0700, Chris Healy wrote:
> Update MDIO configuration with zii-ultra device to fully utilize
> MDIO endpoint capabilities.  Device supports 12.5MHz clock and
> doesn't require MDIO preamble.
> 
> Signed-off-by: Chris Healy <cphealy@gmail.com>

Applied, thanks.
