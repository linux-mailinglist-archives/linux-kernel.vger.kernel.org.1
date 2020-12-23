Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818A82E1C07
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 13:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgLWMAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 07:00:18 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:32770 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgLWMAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 07:00:17 -0500
Received: by mail-wr1-f44.google.com with SMTP id t30so18413798wrb.0;
        Wed, 23 Dec 2020 04:00:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=62bka8Omg/e7p+t+haskw2IU9j22E/bTuc8T5s6JExI=;
        b=rP72wdRScOc2uHLpByXafR5TsBA3M0SlnHF+5s2rLqsn/vm5d1rUsnM3hX9ENGc0fY
         HNeF8IbUSAKYBJ8Q5zB1o8jkImkfq6yDFoyPqa76hwyfxP7St1vrMuSAfDmgX+6v4uAF
         jo5DlnqptLO7FzUj/jCAwk4iRLg94KG1BKpdPz7Vqp7Lfxdc4YJfnMnDLGz1SRkCn2qG
         m2SanH5keJhiX5gL13YoDQJnOAWet2Zq+uhP7Pta9OULpXw+aqKsFFuaYikrgZ0LUDRP
         jwnjKJo24gwQE07JDym6KjOubJ9g3IFw6JCUGMS426uYR4tMFlaWfHe2ZRafVSkBQcB7
         jnbQ==
X-Gm-Message-State: AOAM533rfhtOCDZ+a4rDICZtrSusmtp5BNcQ7TXY8pJ6O8p3QeKSBjvO
        5ACYKqXuFntoyOmYalK5MZk=
X-Google-Smtp-Source: ABdhPJy/m33cvCziqtrnIgkYaSrLNG8hoEwH8UvTfN5Enxj4ZeMrGxbVzUaCGrTKsfCPrCucViY+2Q==
X-Received: by 2002:a5d:508f:: with SMTP id a15mr29514500wrt.2.1608724775848;
        Wed, 23 Dec 2020 03:59:35 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id j13sm30001911wmi.36.2020.12.23.03.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 03:59:34 -0800 (PST)
Date:   Wed, 23 Dec 2020 12:59:33 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matteo Lisi <matteo.lisi@engicam.com>
Subject: Re: [PATCH v3 4/6] arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini
 C.TOUCH 2.0
Message-ID: <20201223115933.GC21091@kozik-lap>
References: <20201223110343.126638-1-jagan@amarulasolutions.com>
 <20201223110343.126638-5-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201223110343.126638-5-jagan@amarulasolutions.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 04:33:41PM +0530, Jagan Teki wrote:
> Engicam C.TOUCH 2.0 is an EDIMM compliant general purpose Carrier
> board.
> 
> Genaral features:
> - Ethernet 10/100
> - Wifi/BT
> - USB Type A/OTG
> - Audio Out
> - CAN
> - LVDS panel connector
> 
> i.Core MX8M Mini is an EDIMM SoM based on NXP i.MX8M Mini from Engicam.
> 
> i.Core MX8M Mini needs to mount on top of this Carrier board for
> creating complete i.Core MX8M Mini C.TOUCH 2.0 board.
> 
> Add support for it.
> 
> Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v3:
> - don't maintain common nodes and include it, if no feature diff
> Changes for v2:
> - enabled fec1 node
> - updated commit message
> - dropped engicam from filename since it aligned with imx6 engicam
>   dts files naming conventions.
> - add i2c nodes
> - fixed v1 comments
> 
>  arch/arm64/boot/dts/freescale/Makefile        |  1 +
>  .../dts/freescale/imx8mm-engicam-ctouch2.dtsi | 82 +++++++++++++++++++
>  .../freescale/imx8mm-icore-mx8mm-ctouch2.dts  | 21 +++++
>  3 files changed, 104 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-ctouch2.dtsi

You split some common part to ctouch2.dtsi so it can be reused in
multiple places. I saw so far only one usage, where are the others?

Best regards,
Krzysztof
