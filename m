Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D342F072D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 13:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbhAJMZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 07:25:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:53278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbhAJMZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 07:25:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC932224F9;
        Sun, 10 Jan 2021 12:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610281508;
        bh=Gn1LvGArAAlGwNnj8TUXm0Q21OfY9n0Al1RbgzikwKE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zk8FPpm/64O9ZPOfnpHMdlXDaMAG+6QlMb95fNOWiOewmDxvDU9kpdVALdzHCr0IP
         df4ExZ4RnXycxX9aeL06Wr2CHMNCnBat6lTxxmDE+VYHuQ48IoXWo7sin5E7TFztgX
         CAslog2KG18tGV+VQaG/zqizamyP+0p4Q9pAjWr3oGs4sMU6Hlz2HHLplXNhB3PlY+
         CiS2TCjIu2tua4U+Hd2gdQ6Z5sM0Dq82SxVjtsJLfQTJhed9b49FYyIhUgOmsFE3zO
         dOe/SQwOi95f96AOCIT7poBMzixaVhnyxDHxOFilowFs0/N8qukwM1Ic8mcROLqFeL
         r5c5BjDjnSCqw==
Date:   Sun, 10 Jan 2021 20:25:01 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        Angus Ainslie <angus@akkea.ca>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Li Yang <leoyang.li@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] arm64: dts: imx8mq-librem5-devkit: Disable
 snvs_rtc
Message-ID: <20210110122500.GK28365@dragon>
References: <cover.1608216796.git.agx@sigxcpu.org>
 <01df90b39a0cb05e3abb3a16d150043a85cf0b23.1608216796.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01df90b39a0cb05e3abb3a16d150043a85cf0b23.1608216796.git.agx@sigxcpu.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 04:13:14PM +0100, Guido Günther wrote:
> The board has it's own RTC chip which is backed by the (optional)
> battery and hence preserves data/time on poweroff when that is inserted.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>

Applied, thanks.
