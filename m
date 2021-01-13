Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0322F4AB0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbhAMLuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:50:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:50832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbhAMLub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:50:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67DB5233ED;
        Wed, 13 Jan 2021 11:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610538591;
        bh=+S0tzqjMh0ZwiuGG6yUIeAgxYJd7e/XUIrh4pdYISfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mfDZ21d1SRBkJt5eo3mICWuARqMGAJPu0FLRUvtRdqyBymBOcD4iXxP5A46Z9COYK
         da2HAsXcGvLSTvWRqAV4Psr3thuSMStDm0UE8mwC5qzK4aL+3x2CU/ipSE8LyTslvB
         Wtye7VubiqwzirkwzUX+71QdzoR4MdbdT/YRrexTvPSwJagSjMkbz/Rtpjmbwq/bLU
         MHGySri9V2xoHrwItMpwkkFb4wYo/j9FcH+LcXwf15FPS8BL79ejCPkAwPZ+2/4OGi
         6FNhI8Tm9IXud8G0CE+XN5MSC32SMsiXpaUZk9uJgu+qU3UT09lTftDcJGQI2iIHcE
         HRxKIH5qckVMg==
Date:   Wed, 13 Jan 2021 17:19:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     geert@linux-m68k.org, kishon@ti.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/1] phy: tusb1210: use bitmasks to set
 VENDOR_SPECIFIC2
Message-ID: <20210113114941.GD2771@vkoul-mobl>
References: <20201211191241.21306-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211191241.21306-1-liambeguin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-12-20, 14:12, Liam Beguin wrote:
> From: Liam Beguin <lvb@xiphos.com>
> 
> Start by reading the content of the VENDOR_SPECIFIC2 register and update
> each bit field based on device properties when defined.
> 
> The use of bit masks prevents fields from overriding each other and
> enables users to clear bits which are set by default, like datapolarity
> in this instance.

Applied, thanks

-- 
~Vinod
