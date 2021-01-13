Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C492F4B28
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 13:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbhAMMRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 07:17:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:55074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727017AbhAMMRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 07:17:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A82BC233F8;
        Wed, 13 Jan 2021 12:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610540233;
        bh=EetDhceVyRYSodjwPMvyxHiuSOEYYgQHfCQh6lMSVbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vO14hTCRaHdnMkgSaNnKygKD6MEFTQl754TYP2anQoT8FRsp2j+AscNYI5hF7rvVf
         bj85nzgj4Y3yMUPPvq2aGIHI7a2mPARvqVdzMNC/JNc7LzAfNczx8lhwGfTesYhcYK
         aBniXIFiek7nsuVpOkykguOsEny65rGK7lL1ExDVeLcV/diM9atm2/gB+kzyd9h3D8
         EmiDWcu0Z0sweYX6djL3z+ZsSmGWaPgl7i+D4gI9dFzUi1BVQ8aIomNhvW0PdEVA4K
         I5PHwc2+77y1JANbTDfurvOE2Kx0TgBv8chPvtbfFK7f8DnLD8xQLFcue2gmXcaEaB
         a8kVMrLRHG+Hg==
Date:   Wed, 13 Jan 2021 17:47:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        =?utf-8?B?5ryG6bmP5oyv?= <aric.pzqi@ingenic.com>,
        =?utf-8?B?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: ingenic: Remove useless field .version
Message-ID: <20210113121708.GH2771@vkoul-mobl>
References: <20201223124505.40792-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201223124505.40792-1-paul@crapouillou.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-12-20, 12:45, Paul Cercueil wrote:
> Remove the useless field .version from the private structure, which is
> set but never read.

Applied, thanks

-- 
~Vinod
