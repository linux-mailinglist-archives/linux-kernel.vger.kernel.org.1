Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6D62F4CF5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbhAMORt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:17:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:44334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726113AbhAMORs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:17:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 004C6233FB;
        Wed, 13 Jan 2021 14:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610547428;
        bh=tOH8kHK8wpkxTpaX7CJMRISBw5TdZpXf3lahBNTxc+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HhJhDkIEmgqdedPmBY3qh/I92a06ubSXYAB2qrJYju40o/Liqc0xjbPsJ1dI1sIWQ
         mryjkz6VcCzhsQSv64FOg6xClzu2lJCnFff4HklLt9MfzNggzakFdGiIiEzNe0eu1g
         OSCxKkUc0o7jpYcI5e9lfQ02IBc5lWr0mfTLgWml5g+fMfXaDXGDLnYhcGEm8x13Xu
         yFL5XJu+128TbQTNLifhE+yPQZ4/WQRdBuv9K3DZ9yTXrl7yHdL8V5Ubz2i4DlwUBT
         ktvoxFcdrIjgmKTOhGGJPcbFlL3KiUIEzJdhmKyhq+KW0T4kABRTW96rtrzj8P4hec
         KHwme0oZmco6Q==
Date:   Wed, 13 Jan 2021 19:47:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/24] dt-bindings: phy: update phy-cadence-sierra.yaml
 reference
Message-ID: <20210113141703.GT2771@vkoul-mobl>
References: <cover.1610535349.git.mchehab+huawei@kernel.org>
 <3550b08d4e8312e7d4a247a3515a93a5f0fd04c5.1610535350.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3550b08d4e8312e7d4a247a3515a93a5f0fd04c5.1610535350.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-01-21, 11:59, Mauro Carvalho Chehab wrote:
> Changeset ba2bf1f090eb ("dt-bindings: phy: Add Cadence Sierra PHY bindings in YAML format")
> renamed: Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
> to: Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml.
> 
> Update its cross-reference accordingly.

Applied, thanks

-- 
~Vinod
