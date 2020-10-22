Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55EB296482
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 20:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2902375AbgJVSSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 14:18:00 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:54984 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2902233AbgJVSSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 14:18:00 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4CHFw52WVPz1qt40;
        Thu, 22 Oct 2020 20:17:57 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4CHFw50f7hz1qwTD;
        Thu, 22 Oct 2020 20:17:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id icf2kLNtl5DU; Thu, 22 Oct 2020 20:17:55 +0200 (CEST)
X-Auth-Info: RUmro/dEAEi+oohcMGVmxeQKXt8YDWDpUqOoq1zGqk4=
Received: from [IPv6:::1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 22 Oct 2020 20:17:55 +0200 (CEST)
Subject: Re: [PATCH] arm64: dts: imx8mm: Add GPU node
To:     Adam Ford <aford173@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, l.stach@pengutronix.de,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201022171639.773702-1-aford173@gmail.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <5d17f3de-6864-c8fb-6413-24de943df1fd@denx.de>
Date:   Thu, 22 Oct 2020 20:17:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201022171639.773702-1-aford173@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/20 7:16 PM, Adam Ford wrote:
> According to the documentation from NXP, the i.MX8M Nano has a
> Vivante GC7000 Ultra Lite as its GPU core.
> 
> With this patch, the Etnaviv driver presents the GPU as:
>    etnaviv-gpu 38000000.gpu: model: GC7000, revision: 6203
> 
> It uses the GPCV2 controller to enable the power domain for the GPU.

Subject should say 8mn , not 8mm .

Are the assigned-clock-rates correct ?
