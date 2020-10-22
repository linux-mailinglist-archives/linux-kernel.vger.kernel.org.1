Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31650296094
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 16:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900571AbgJVOAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 10:00:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2900552AbgJVOAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:00:11 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2063C22249;
        Thu, 22 Oct 2020 14:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603375210;
        bh=EpjEzi0uZt4us4Z9uIJpLLGSJQH1YL4LSnNVXHbFZ+Q=;
        h=Date:From:To:Subject:From;
        b=n2tpdzIQt3hOSt4sAx5CzmcY6Xm9ktgu4q1NNcCRoJ/JCvzQ3cTPneB0DRyBkkf8W
         aK/q0vtD1XwFoxRxBLT7SXvOBNfvM9SQPtLPzE9+eJ7jfRxqmloVPBjcxkLy8RzMcE
         37QAUEl3TxC84npB0ZE3n/9my5cZK/V60iRORTlA=
Received: by pali.im (Postfix)
        id 4E07BBFC; Thu, 22 Oct 2020 16:00:07 +0200 (CEST)
Date:   Thu, 22 Oct 2020 16:00:07 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Andre Heider <a.heider@gmail.com>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Reducing number of Espressobin DTS files
Message-ID: <20201022140007.hppmeyt34lubotbc@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

For Espressobin A3720 board there are currently 4 DTS files:

https://git.kernel.org/pub/scm/linux/kernel/git/gclement/mvebu.git/tree/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts?h=for-next
https://git.kernel.org/pub/scm/linux/kernel/git/gclement/mvebu.git/tree/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts?h=for-next
https://git.kernel.org/pub/scm/linux/kernel/git/gclement/mvebu.git/tree/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts?h=for-next
https://git.kernel.org/pub/scm/linux/kernel/git/gclement/mvebu.git/tree/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts?h=for-next

There are two board revisions (V5 and V7) and each has variant with and
without eMMC.

V5 and V7 DTS files differs order of ethernet switch ports and presence
of led2 (not in next branch yet).

I would like to ask, do we need two DTS files for eMMC and non-eMMC
variants? Is there any issue if we enable sdhci0 globally for all
Espressobin board and therefore reduce number of DTS variants?

For example, Turris MOX board which is also A3720 based has optional
SDIO module which can be plugged / unplugged, standard variant is sold
without it and in DTS file is this node always enabled:

https://git.kernel.org/pub/scm/linux/kernel/git/gclement/mvebu.git/tree/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts?h=for-next#n178

Could not we enable by default this node also on Espressobin? It is a
problem if node for eMMC is enabled also on board without eMMC? As it
would simplify configuration, compilation and setup of system for
Espressobin boards.
