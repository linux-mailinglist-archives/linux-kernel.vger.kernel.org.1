Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F0C2CFA93
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 09:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbgLEIUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 03:20:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:49678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728975AbgLEIRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 03:17:20 -0500
Date:   Sat, 5 Dec 2020 13:46:44 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607156208;
        bh=+d2SAkMSduylIv/svczlhrewKcbHqCZU+34VdL9PsGc=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=GMSYoXI6B76YwxcPEkt4Uvo3TuM/CdZ6fuwK8+wFdm/Jau5FPlsCsW2+eHAOlFGfU
         KdoZEuwWt7CXZ8GeOvPBSg25SDyurbXABBusZLpF12u+FkDQKfl+0j5uHn64APy9Rj
         eFFiOPz3pyReP+lxG/yw+eu/3akbWzoy72zVlwWElTvtfvv/S8XwG2eaeJ3dut86H3
         hgIF78Px9nF2+wJAO497x1CwucQWJl3cWdtsYIXDwhgqsl2IjemX+r5wQO/SZVXgAe
         sUtDq1nk5CLlFOEz6DqyBpddrlEEsKCPA3Ka7ApULNfpkayy7OdVsL/8d2hLoC9I+6
         g8HVjgas6/6oA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2] dt-bindings: phy: Convert Broadcom SATA PHY to YAML
Message-ID: <20201205081644.GZ8403@vkoul-mobl>
References: <20201204193532.1934108-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204193532.1934108-1-f.fainelli@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-12-20, 11:35, Florian Fainelli wrote:
> Update the Broadcom SATA PHY Device Tree binding to a YAML format.
> 

Applied, thanks

-- 
~Vinod
