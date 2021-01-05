Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C93F2EA384
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 04:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbhAEC6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 21:58:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:59816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbhAEC6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 21:58:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D0D122582;
        Tue,  5 Jan 2021 02:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609815462;
        bh=iIxOybH4txmVNt5TLTxosq66eW604Yi4bTT6bIQWyvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nm1RAEeiaomtOLajWbViSPOxqlGlyNcAqSq4INcYv27fMC1d3o1aP6HJqmTlLlqzE
         ofq8IADf4T/q86Xa8uGZ4fwInj0QfQgmUfif5K7dWqmamj1iJBDQPQd8Oqd8D9T/BF
         h9DpNbJPhhx++4kXrrB5E4k5aSWSuhUH0Lp2oPysaFrzRo3qY21SvXswp5If1DCPE7
         /GqiOZsHDrhDXDJFQ5esllY9iwhjtr7wH7QiobQBdLdd0rwuf/Kb4dxQN0mrDwx422
         yJqCnM+7FACbZpI+BRUNkp9jeqbmBaDPmiZywGpLlcA2p2pb6tfLznkuczPa+0I/V4
         rLEPVnekWfBww==
Date:   Tue, 5 Jan 2021 10:57:37 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, peng.fan@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: imx_v6_v7_defconfig: enable power driver of RN5T618
 PMIC family
Message-ID: <20210105025736.GJ4142@dragon>
References: <20201202073739.9619-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202073739.9619-1-andreas@kemnade.info>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 08:37:39AM +0100, Andreas Kemnade wrote:
> There is a driver now for the power supply and fuel gauge functionality
> of that chip family, so enable them, since they are used by various
> i.MX6 boards, especially ebook-readers.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Applied, thanks.
