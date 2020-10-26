Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A90629874C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 08:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1768998AbgJZHSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 03:18:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1768984AbgJZHSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 03:18:48 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51EDB222EA;
        Mon, 26 Oct 2020 07:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603696728;
        bh=W/0gqb4JEqagpmYtsPUrh+JD68Qdepi7SPkmyZh6FHI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DMCXdNK0MC3Us/i5cpg3NzcLQaWJjUbPa0DBB+xLLuAMX2Fx6YNnAhwDfYPJ4I/ay
         LL57GL02j7+nWEBl3zMDkKguvLKzpWykyMuim77EvtsvdGuYURh2t54HK1vQ0MUxp2
         X581SdcSYl9WFOhQcK2OsGlUVL3IBB3c/4gHmIEA=
Date:   Mon, 26 Oct 2020 15:18:40 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Varun Sethi <V.Sethi@nxp.com>, Leo Li <leoyang.li@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: lx2160a: add device tree for
 lx2162aqds board
Message-ID: <20201026071839.GE9880@dragon>
References: <1599059610-7570-2-git-send-email-meenakshi.aggarwal@nxp.com>
 <1601373718-13218-1-git-send-email-meenakshi.aggarwal@nxp.com>
 <1601373718-13218-3-git-send-email-meenakshi.aggarwal@nxp.com>
 <AM7PR04MB6885980FC5B035B955D009BA8E1E0@AM7PR04MB6885.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM7PR04MB6885980FC5B035B955D009BA8E1E0@AM7PR04MB6885.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 09:00:33AM +0000, Meenakshi Aggarwal wrote:
> Hi,
> 
> Any further comments?

Please address the following checkpatch warnings.

WARNING: DT compatible string "nxp,lx2162a-qds" appears un-documented -- check ./Documentation/devicetree/bindings/
#49: FILE: arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts:13:
+	compatible = "nxp,lx2162a-qds", "fsl,lx2160a";

WARNING: DT compatible string "ethernet-phy-id001c.c916" appears un-documented -- check ./Documentation/devicetree/bindings/
#80: FILE: arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts:44:
+				compatible = "ethernet-phy-id001c.c916";

WARNING: DT compatible string "ethernet-phy-id001c.c916" appears un-documented -- check ./Documentation/devicetree/bindings/
#92: FILE: arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts:56:
+				compatible = "ethernet-phy-id001c.c916";


Shawn
