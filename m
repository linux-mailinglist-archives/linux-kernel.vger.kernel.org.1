Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06DB2CFA8B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 09:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbgLEIMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 03:12:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:47410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbgLEII6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 03:08:58 -0500
Date:   Sat, 5 Dec 2020 13:38:13 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607155697;
        bh=EbXucN/nfm+MLQLvn5FrM2JRv6Qb5nUz2N1QK+to69c=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=DOZFXvI9azl0MI7U7ryC9VuQVsZjuk++HpD8dKuYbmBzw3WN3r3NSL5g7NVHcjIcf
         r3kIj+0lV3SN99apf+cVQhvIXXCETuHOZlSve2oM5KBLQgUzuB0IESfli4H4IK0vYO
         2Oc+Doj3V7scDeNzcE2uI9Ap7SsqiaZlfhkb6pHfFAiSzHWzf4K3kDLByXZIDAPXw/
         uol59ALzEjpmw6254mby3zP8De7h5AwQD3LWTpqjiyrMXI4lOvGgzbrIsWMOjmq8Do
         HvQTANcdacOzc9u2dfmOklvxB5BC7GJi7mWbZMC5SXCh13AAoOOZGC4gZrueRLiA7f
         f4X/C4m1AGT1g==
From:   Vinod Koul <vkoul@kernel.org>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] phy: rockchip: set pulldown for strobe line in dts
Message-ID: <20201205080813.GW8403@vkoul-mobl>
References: <20201129054416.3980-1-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201129054416.3980-1-chris.ruehl@gtsys.com.hk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-11-20, 13:44, Chris Ruehl wrote:
> This patchset add support to set the strobe line pulldown via dt property

Applied, thanks

-- 
~Vinod
