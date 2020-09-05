Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83DB25E4FA
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Sep 2020 03:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgIEBjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 21:39:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgIEBjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 21:39:39 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9AF9206E7;
        Sat,  5 Sep 2020 01:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599269978;
        bh=YLcfKDMIfDKsAykdz3VG/vaVezYa4SesQFaJQpF5rZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v0tK/RDm/t1lT4uN68c6lIgkz4L/Z2O6K31+bdOypofP6qfvDzxh+V5fnoQ3iSjMt
         iD7Lo53NTz3k8egQWp8/NXHinuwXj1HDfQVZsw9lZAzjBfwao3fzWdT82Ilb9jUfWi
         pjaw0x9DLaV0MDyyW4W/2PmqY9bKfrc1aPcro3kU=
Date:   Sat, 5 Sep 2020 09:39:31 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, Anson.Huang@nxp.com,
        marcel.ziswiler@toradex.com, sebastien.szymanski@armadeus.com,
        michael@walle.cc, rjones@gateworks.com, leoyang.li@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, j.neuschaefer@gmx.net,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH v2 0/2] ARM: dts: add Tolino Shine 2 HD
Message-ID: <20200905013931.GC7508@dragon>
References: <20200826204251.5082-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826204251.5082-1-andreas@kemnade.info>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 10:42:49PM +0200, Andreas Kemnade wrote:
> This adds a device tree for the Tolino Shine 2 HD Ebook reader.
> 
> It is equipped with an i.MX6SL SoC. Except for backlight (via an EC) and
> the EPD, drivers are available and therefore things are defined in the
> dts.
> 
> Andreas Kemnade (2):
>   dt-bindings: arm: fsl: add compatible string for Tolino Shine 2 HD
>   ARM: dts: imx: add devicetree for Tolino Shine 2 HD

Applied both, thanks.
