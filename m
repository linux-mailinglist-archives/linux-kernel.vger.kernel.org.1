Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682662EEF6E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 10:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbhAHJWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 04:22:42 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:37433 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728257AbhAHJWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 04:22:41 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id C01D31B55;
        Fri,  8 Jan 2021 04:21:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 08 Jan 2021 04:21:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=aTbOXuiszOWK+PVLT36NcDavTc+
        N+zlBAaGYmMKAq8g=; b=oeHXY06LDa29KyrOMRC7of/X4CfczAgDO2S0DgNPcQ/
        BIF1C1I+sgk38sTGknI19b09qK1+MVVjJEEovL2WcFMh0A0vKXZncC15Oa9vzaEX
        jxZO5uEASWFfY8230XDfGMB3qNXB8mAGDh87qPkpODLZ41ivUqr+5dRNqOFMqi8o
        LGr1O/cIgp/LaUI/XUCzxK8IPGwb+qVlr768zNKapUv7qmeX9+f3gdHRp3I4k/IB
        Q6sLpL1nJ5caHPB+kZNQKf3Zudo9cl88Dj99clVAC4Mzm7wtpMEq9YFyJTo2r5fu
        Q9RGYFYNTXQHQ7+U9rBuwdqYgIp13n28TNm3hs/3IFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=aTbOXu
        iszOWK+PVLT36NcDavTc+N+zlBAaGYmMKAq8g=; b=bkdD/WHqLTimi1e2eVLLaj
        NZv403UCxbP1208GcKMN6ncs+Pw5bjbFQAeULXQ7MuLxd271BwHrIfeLUhJ8YTks
        1wxbTYZXWm4CXlzUMjP6x+2L4sdSP2l4E2trqhdHSCaKr8ZqTyF3KQfYBgQh9+5K
        kN/uo9SwGwnXq//3dh7Bq06PQLz2itmmCxUO6yHuJbPCMGS0nMtQb+19WcT5vSQy
        ij3vlojmtu0hf1qMVNghb1iUCX3OuLoXMBwJFu/2ee/M9CyHtMLa5W3L7wwWRSsi
        HWZTSoPYUiQf5kDnbbmGZWt5KsNCGvDaat8RoJ7pfA9og4vUROnuAMBjPw2owEbw
        ==
X-ME-Sender: <xms:HST4XxZZEyJqxYRaQjO80QIgxRhy6HkIkjsnSkFgTI5JZxz2nbd8ww>
    <xme:HST4X4bOhGD09-oBbQohhN6Xy5BPWgdMqL1VR4j2xK21pFw_F4EZJY06qRCprAxID
    Hv4xBl4FsqLapIaauk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeggedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepueejgfeivdfgieefueevgeejhedttdehgeelgeehvdeghfdtvdfgvdejkedv
    feeunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:HST4Xz-rAPncyjE3NMrLXvHIM08LK7oiElDH0EPrLk4xnxE2QmN-bQ>
    <xmx:HST4X_rvGmRYnzRPy9J96aVhAoTj75bAx1qMNoUq9FZ4FJVUJOJifA>
    <xmx:HST4X8qNzhW9Z-cxS7Vju6gynTSkawIXKN8vhoXJg1Yh2c_-NVfljA>
    <xmx:HiT4X1lmDkpjnmxYfHwhoNchgGaM3Dy0EoNKbs3r1AxE6WVgFIrWSw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0B0FC108005B;
        Fri,  8 Jan 2021 04:21:32 -0500 (EST)
Date:   Fri, 8 Jan 2021 10:21:31 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Sergio Sota <sergiosota@fanamoel.com>
Cc:     robh+dt@kernel.org, wens@csie.org, jernej.skrabec@siol.net,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sun5i: add A10s/A13 mali gpu support fallback
Message-ID: <20210108092131.2jxfazj65usfhlu3@gilmour>
References: <20210107110035.2815260-1-sergiosota@fanamoel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107110035.2815260-1-sergiosota@fanamoel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 12:00:35PM +0100, Sergio Sota wrote:
> The A10s/A13 mali gpu was not defined in device tree
> Add A10 mali gpu as a fallback for A10s/A13
> Tested with Olimex-A13-SOM / Olimex-A13-OlinuXino-MICRO
> "kmscube" 3d cube on screen (60fps / 10%cpu)

With Lima or the ARM blob, if so which version?

Thanks!
Maxime
