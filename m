Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A1B2FCA5C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 06:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbhATFN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 00:13:29 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:58435 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730654AbhATFMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 00:12:23 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 94268580655;
        Wed, 20 Jan 2021 00:11:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 20 Jan 2021 00:11:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=ZZ+Isl3JErTgV
        YzHxSVJeJQJkE/efLPrQzoT7Tl5B4g=; b=Wv0+9VATtvODiO3qBH20SgMuFIRd+
        SnkoQopJ4jVTvH7dMgCCJNK7QNFkU/7R6tYsQ8OO9lpFM1VwNTATe7JXFS+cADbQ
        F9lk9hielYRT6zZFsZNGizoH99rc/PYkyVUwfoN0RlUAQL/Rn7BAFxY45zvbZM/u
        ZjCciRMBm4z5irbaIxCaMXs8Rw194GA9ru4GEf+eK3dkMyuBO4sbGLMRD7rNen7m
        lmQNlcpvg8GelSdtfPMOqPcIS1t8ns/DhEXXB/7H/8ptEOjcCSPi/7xDIZ88j3+X
        Pj/yz26dkURlJJ7L9by6dZEqtHZInjh5l7b557c9xulqLYbvMOFZYPBlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=ZZ+Isl3JErTgVYzHxSVJeJQJkE/efLPrQzoT7Tl5B4g=; b=WPZH20IU
        Qoj04uldMWmsW8AyTxqhEICyVTxbyHmxvI41XwOg27ZSu61j9WVQkzUPsmVTbCmg
        LWHd7TR1YqHV/vlb1GpO3WOTbzUFMcT/STFflkdIVxekjC4a09P4jxi+xKHcZYvs
        ve6Rh6u2EZsxx8TvbHsrEep1Qao4MRAQJlC+xoG89cGl2gmpoUpckgEmWyC6irzR
        GvG40jWKdNQOtP4AAR8e53lci42fy70lK4UjLB9DTuG+bFOUEb+m3Rpct3mQdVj0
        snEqrewmLENA9FgrLl/awPIcNe8Hf9WtgmEgttVd54i2VysF5GggK9y6792Hr4Rr
        xOQX6mfl6B/21A==
X-ME-Sender: <xms:dLsHYKYjiezCTpPIKiQvgqlvY66QZuDabMpEnZqbI_aWM9Ole_10FA>
    <xme:dLsHYNZtaQXADo_Yxq3X2lk1w4-oK7aCQiDWJ0i_XbevULFjeki8z3jmQsr-y9VW6
    CdNBQt5n28IHsv9qQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddugdekudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghj
    rdhiugdrrghuqeenucggtffrrghtthgvrhhnpeejgfdvveehteekveeggeellefgleette
    ejffelffdvudduveeiffegteelvefhteenucfkphepudegrddvrddutdejrdeggeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfi
    esrghjrdhiugdrrghu
X-ME-Proxy: <xmx:dLsHYE9gOtMm22JjnNNl3XXotQkd6ZiY_V17HidNlgGRwmUwQvJg3Q>
    <xmx:dLsHYMpnGfLeInrQHf23Y6JF_TC9GhaSR18ryDOZ20l1rZaB_Ux3YA>
    <xmx:dLsHYFpxjP7zTb2DdetPbiIsnCZjUcl_T8ED-p2jSSVGpxotWPg3JQ>
    <xmx:dbsHYG6IiDOIFLQ_6Be9kCEJ23p4l7STJR7If9dG0qx3pZj-SvDGAA>
Received: from localhost.localdomain (ppp14-2-107-44.adl-apt-pir-bras32.tpg.internode.on.net [14.2.107.44])
        by mail.messagingengine.com (Postfix) with ESMTPA id 04FBF1080063;
        Wed, 20 Jan 2021 00:11:10 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     chiawei_wang@aspeedtech.com
Cc:     BMC-SW@aspeedtech.com, andrew@aj.id.au, cyrilbur@gmail.com,
        devicetree@vger.kernel.org, haiyue.wang@linux.intel.com,
        joel@jms.id.au, lee.jones@linaro.org, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        minyard@acm.org, openbmc@lists.ozlabs.org, rlippert@google.com,
        robh+dt@kernel.org
Subject: [PATCH v5 5/5] soc: aspeed: Adapt to new LPC device tree layout
Date:   Wed, 20 Jan 2021 15:40:56 +1030
Message-Id: <20210120051056.712222-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210114131622.8951-6-chiawei_wang@aspeedtech.com>
References: <20210114131622.8951-6-chiawei_wang@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Add check against LPC device v2 compatible string to
> ensure that the fixed device tree layout is adopted.
> The LPC register offsets are also fixed accordingly.
> 
> Signed-off-by: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>
> ---
>  drivers/soc/aspeed/aspeed-lpc-ctrl.c  | 20 ++++++++++++++------
>  drivers/soc/aspeed/aspeed-lpc-snoop.c | 23 +++++++++++++++--------

In the future please do separate patches for separate drivers, but for now:

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
