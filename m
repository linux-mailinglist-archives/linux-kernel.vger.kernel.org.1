Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8249B295627
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 03:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894800AbgJVBsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 21:48:03 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:57055 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437488AbgJVBsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 21:48:03 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 0EEE45C0228;
        Wed, 21 Oct 2020 21:48:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 21 Oct 2020 21:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=O9lDv5OWZQ9ZorV5ZEY25cHFR2
        J69+bUbzPGXmqfECQ=; b=mlvltDkGrwDgVZh4cGnjBtmkbjlvLO2ySHEs/WrBd+
        9MiqqhPgBIrPfBFm6jSMat1z676wvTJ9t7IAWJelOBdmjNP7OY6feKINGI3XHBtO
        DR77f2nkxZuAJLI2G5PaLvGp+IQ93VunXhNePu2Vsphg+RbQGtvVYY3w2W5E4TpZ
        DP+Ut3izUEs5RQuaQ/HKC9qeL8MU/JwJo2cqftNMJwhq24iv/AwBJvvvJSKeHVn1
        yO8HCIFU5vPPUxsGJaBMP63IVMmy04fPWjUZOpHjkQzu/drzkt0eXHPmSW0aYbQr
        1i1IgStGL22uRdYmpfZRQqGHmu7f7Hn2IADi34IReRrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=O9lDv5OWZQ9ZorV5Z
        EY25cHFR2J69+bUbzPGXmqfECQ=; b=YLEYUMCMb+C1Gcv3iR5G6VtvMwLHCyH0r
        +24bIC2MeNr7PLtOhRAkGfPd9uVNqYD6nUNMFxaiS76UTBj0Q4LM9CP7DHP1HgG0
        sXBLOnpW4Cdr3BGPUJTm2VaiKWsVO6cWmbGzcOIzKyMcq1k+Vm4jfUFNL2+wUNpJ
        yCVDLpbgwHb7VkJRPfHtwXNj14Lg8XRtVQWTYRIEYKsrCu/eTsrl0v6Sk5t6uV4h
        A8tITgMcqkiGqTICtm2kAEIhVIu5PHnljmYPQccUSDfn+tWR45leWNjqnKpVEX5T
        O06AvGpREzROUfS9iQiKJFycDUawtkLDW44uBGNjKbku9Y8nOFT3w==
X-ME-Sender: <xms:0OSQX7qkhNcIo5oGSvIXjoeMe2mLyfcNxY0meUgLG9Y_sz1uQFLD3A>
    <xme:0OSQX1pb514nLOYamvHHmU6MFZsQMZGKVaTqn6bR_OrIWU0uUnNnr43dO5IRVnI0T
    l9trk-BI3N6qcbycA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeeigdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghjrdhi
    ugdrrghuqeenucggtffrrghtthgvrhhnpeeiteehudevlefhvddvjeeluefhleetveehff
    fgiedtfeegkeejfeeivefgheehgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecu
    kfhppeduudekrddvuddtrdejrddukedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:0OSQX4MZ7X6NCCx5QX4aEvWtKqdQ9cAnIoFlApgdaRxH5S75XMZLmg>
    <xmx:0OSQX-76hnP2XSWPbQIysjRSMNJUhkCl8hHb4Vy900PWpqJ5nM-mww>
    <xmx:0OSQX65vlmmdrx-AMBirJYvE81IbVdPbWEQ7crvNqF895PAh0IBa0Q>
    <xmx:0uSQXwkolsYB1zEZh5aBRe33zzij12DkTlso_S4O6jLwZKIvL41LkQ>
Received: from localhost.localdomain (ppp118-210-7-180.adl-adc-lon-bras31.tpg.internode.on.net [118.210.7.180])
        by mail.messagingengine.com (Postfix) with ESMTPA id 22DE53280060;
        Wed, 21 Oct 2020 21:47:57 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     joel@jms.id.au
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] ARM: dts: Enable ramoops for Rainier and Tacoma
Date:   Thu, 22 Oct 2020 12:17:25 +1030
Message-Id: <20201022014731.2035438-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We're looking to improve our crash data capture for the BMC on some IBM
platforms. This small series enables ramoops for Rainier and Tacoma.

v2 fixes an address overlap bug for Tacoma in v1, which was caused by a node vs
reg mismatch of one of the other reserved memory regions. v2 contains a several
cosmetic cleanups for both the Tacoma and Rainier reserved memory regions
before enabling ramoops in the final two patches. The geometry of the rings has
changed from v1; the slot sizes have been doubled, reducing the captured crash
count from 32 to 16 (32 seemed like overkill and we could trade that for more
space in each slot).

v1 can be found here:

https://lore.kernel.org/linux-arm-kernel/20201016043513.119841-1-andrew@aj.id.au/

Please review.

Andrew

Andrew Jeffery (6):
  ARM: dts: tacoma: Fix node vs reg mismatch for flash memory
  ARM: dts: tacoma: Zero-pad flash memory region length
  ARM: dts: rainier,tacoma: Fix size comment whitespace
  ARM: dts: rainier,tacoma: Comment reserved memory regions
  ARM: dts: rainier: Add reserved memory for ramoops
  ARM: dts: tacoma: Add reserved memory for ramoops

 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 15 ++++++++++++++-
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts  | 19 ++++++++++++++++---
 2 files changed, 30 insertions(+), 4 deletions(-)

-- 
2.25.1

