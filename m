Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53BF26C8E8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbgIPS7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:59:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:42046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727534AbgIPRvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:51:16 -0400
Received: from localhost (unknown [122.172.186.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9EC922210;
        Wed, 16 Sep 2020 13:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600261745;
        bh=KKdJY9BanQ+J7sRLowSC4IeOYIYzAqrwfNsRc9WeTGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ln1iHqWstGo4J1NHIKC2Xb+dtqWKHjJS8C0lEjQ6IpVPIZLMC/ngp531ylvh2HvmD
         YbhXvwX4BYFGDmCWepbBG2U7Rv52rHNlE0DE9muZP4p1rTH0HTFVmcTizqyiC3OnVt
         Qi99SBHLoYcEz+Qk4Oymqx3sWswgwgGttWk7+QKw=
Date:   Wed, 16 Sep 2020 18:38:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 RESEND 7/8] dt-bindings: phy: convert
 phy-kirin970-usb3.txt to yaml
Message-ID: <20200916130857.GQ2968@vkoul-mobl>
References: <cover.1599826421.git.mchehab+huawei@kernel.org>
 <7964c39084de5d2fd3dca30bf5abb5973eeec42b.1599826421.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7964c39084de5d2fd3dca30bf5abb5973eeec42b.1599826421.git.mchehab+huawei@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-09-20, 14:16, Mauro Carvalho Chehab wrote:
> Use the new YAML for this physical layer.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../bindings/phy/hisilicon,hi3670-usb3.yaml   | 72 +++++++++++++++++++
>  .../bindings/phy/phy-hi3670-usb3.txt          | 25 -------

Aha we have yaml here, why not squash this in and not add txt

I guess the whole series should be squashed into driver patch, binding
yaml and other stuff (if any)

-- 
~Vinod
