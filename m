Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79D72D5F06
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 16:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389954AbgLJPHV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Dec 2020 10:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390038AbgLJPHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 10:07:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE433C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 07:06:28 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1knNWM-0006bB-1w; Thu, 10 Dec 2020 16:06:18 +0100
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1knNWI-0005Ab-IF; Thu, 10 Dec 2020 16:06:14 +0100
Message-ID: <3dec6a922df318a65647d7a1d3e9ed711564075f.camel@pengutronix.de>
Subject: Re: [PATCH v3 0/4] dt-bindings: reset: convert Hisilicon reset
 controller bindings to json-schema
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Zhangfei Gao <zhangfei.gao@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date:   Thu, 10 Dec 2020 16:06:14 +0100
In-Reply-To: <20201208124641.1787-1-thunder.leizhen@huawei.com>
References: <20201208124641.1787-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-12-08 at 20:46 +0800, Zhen Lei wrote:
> v2 --> v3:
> 1. Keep device tree patches and reset driver patch separate, as they were in v1.
>    That is, revert v2.
> 2. When the new compatible match failed, fall back to the deprecated compatible.
> 3. Fix a typo, correct "hi3660,rst-syscon" to "hisilicon,rst-syscon".
> 
> v1 --> v2:
> Merge the driver and DT modification(correct vendor prefix hisi to hisilicon) into one patch.
> 
> v1:
> Patch 1-3 change the vendor prefix from "hisi" to "hisilicon", to eliminate below warnings:
>   crg_rst_controller: 'hisi,rst-syscon' does not match any of the regexes: '^#.*', ... , '^hisilicon,.*', ...
>   From schema: /root/leizhen/linux-next/Documentation/devicetree/bindings/vendor-prefixes.yaml
> 
> Patch 4 does the json-schema conversion.

Thank you, I've applied patches 1, 3, and 4 to the reset/next branch.

regards
Philipp
