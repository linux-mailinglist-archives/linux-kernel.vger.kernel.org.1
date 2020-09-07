Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6FC25FCD3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 17:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbgIGPR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 11:17:29 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:53487 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730120AbgIGPQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 11:16:31 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 1DD539F4;
        Mon,  7 Sep 2020 11:06:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 07 Sep 2020 11:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=L
        NZ9BDmmfmh8OGRK1OlhnYmyHiIUpzUacs8VOuZ8w04=; b=b4Lsgrtj1BefwDoze
        GoY+2YUuX9foRM6JEnPjjbbzW3QWu/bmUz7Y8VZC4vdfCNVhOUQiYrsxE/tjM15Z
        Dz64NKf4bO8eO2RwyKiQldZs/Uae1LIH4kuGpm0Grf56IJOGGLh0qooWon9sE726
        dg2PMCTq12IomJMDwyUYRfkUiaTD8dYE3dqupxdT5k1vcHp5HZMF34JjKOwvg8RR
        qlFRsdwzqpn7M4CXw3FXWJWT+w7qflADPCCxF37YVrC8M4D1QxqbrlD99nc+dewU
        R6XLlo2+gJRoXlokO3wjiJsxVtyO/ueqSt5A5n+xZhBWEjKAeFiI3WygY9yCoIvA
        8RYeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=LNZ9BDmmfmh8OGRK1OlhnYmyHiIUpzUacs8VOuZ8w
        04=; b=oit6HXSQwQ3Pc5j8CLHTcfTDtPuanq54o0vpR49cmF06zmWpqYYUm14wp
        R27+FUag2zO+7urGk+wkNjLto/xXB+MLX+i7a2750r/Z7IQKhnn2+RBp/UYsRTtw
        hEnnp49RKcfHKGmcc0VhMhW4u5gwFYxeO5N+EiD0LokC6RLILSFyo1UUOnmMBoDA
        6ghcZ3feLz13Pkcrq5W6KuklbwjnmYuLJUqToZGGjafxjFzD0PpedTWM531MPdSB
        VC7Uog1yTkJ9ShtAhICaubzvvWhhuxCyfT6+ZJcxOD9aFJDcUEjZb8eq1eyA0our
        9DpsB3HDTG2/DCx9Fwo/dgHRkDk2Q==
X-ME-Sender: <xms:bExWX5hvB2c1DXTApKg9kSFi8rcMFPEaFQSf7cgwA8l09xl8hei9kg>
    <xme:bExWX-Avg4SIZpEj2QHC8TJ4CiByNHtPQMuSKNUNMuQ2tHC4-GUKCM9g-Ohbmjvq8
    zqkujN-LfaYxK3zmWo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehtddgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjgesthhqredttddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpefgjeettdejgffgffdvteeutdehtdehgeehueetkeefgefhtdetjeekledu
    gedvudenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:bUxWX5H6vqLO6TSycubojKKngmIoVKgGlCxCk9NQg_-rQoIcb3dNUA>
    <xmx:bUxWX-Rh_uDvmu5v3LsrQmpThnnVvDA9u5fnXK-vEXEFGSN2z9aO0w>
    <xmx:bUxWX2xKtoq9D8FkMWi-ZJUHfZ5flWSVaDEo3i9ciggeuL2BhVHccQ>
    <xmx:bkxWXws13rGW-YmoakDpzmdVREQJx3esuT1q_JWn754Jk6pNqTiohA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id B5E35328005A;
        Mon,  7 Sep 2020 11:06:20 -0400 (EDT)
Date:   Mon, 7 Sep 2020 17:06:18 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iommu/sun50i: Fix set-but-not-used variable warning
Message-ID: <20200907150618.g6jbkmvosfh2ek73@gilmour.lan>
References: <20200904113906.3906-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200904113906.3906-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 01:39:06PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
>=20
> Fix the following warning the the SUN50I driver:
>=20
>    drivers/iommu/sun50i-iommu.c: In function 'sun50i_iommu_irq':
>    drivers/iommu/sun50i-iommu.c:890:14: warning: variable 'iova' set but =
not used [-Wunused-but-set-variable]
>      890 |  phys_addr_t iova;
>          |              ^~~~
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
