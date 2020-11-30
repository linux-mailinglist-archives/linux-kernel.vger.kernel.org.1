Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C082C887D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 16:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgK3Pny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 10:43:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:45330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728455AbgK3Pnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:43:52 -0500
Received: from localhost (unknown [122.171.214.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9CED20725;
        Mon, 30 Nov 2020 15:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606750992;
        bh=bXyTTEbbEZrr4Pg23j1ZeCv2m3U/Ab3rYvT/oLQvdoQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oNwOJscch61NJJzgEvlhU3wSn6rptkAGOWHBXDG5CuplhCG+ePVciFQ9COLgWVbXn
         qT4sqR6YwczZ4CL4gqb4/Fs2NprEpLkudK2nGCtBzSb1yCVUr00DxUKtB4rYZzzBFC
         lpC/8W36GRChvdq4kBinx7iKVcQ1GuOYmC1l+hFY=
Date:   Mon, 30 Nov 2020 21:13:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] dt-bindings: phy: bcm-ns-usb3-phy: convert to yaml
Message-ID: <20201130154307.GW8403@vkoul-mobl>
References: <20201116074650.16070-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201116074650.16070-1-zajec5@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-11-20, 08:46, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> 1. Change syntax from txt to yaml
> 2. Drop "Driver for" from the title
> 3. Drop "reg = <0x0>;" from example (noticed by dt_binding_check)
> 4. Specify license
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> I think this should go through linux-phy tree. Kishon, Vinod, can you
> take this patch?
> 
> This patch generates a false positive checkpatch.pl warning [0].
> Please ignore:
> WARNING: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst

I am seeing warnings for indentation:

Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml:19:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml:20:12: [warning] wrong indentation: expected 12 but found 11 (indentation)
Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml:26:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml:28:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml:30:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml:51:6: [warning] wrong indentation: expected 4 but found 5 (indentation)
Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml:71:11: [warning] wrong indentation: expected 9 but found 10 (indentation)
Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml:80:11: [warning] wrong indentation: expected 9 but found 10 (indentation)
Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml:88:11: [warning] wrong indentation: expected 9 but found 10 (indentation)

Can you pls fix those as well

-- 
~Vinod
