Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48E3304E69
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390850AbhA0Aa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 19:30:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:34364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729419AbhAZRQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 12:16:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 115A8230FD;
        Tue, 26 Jan 2021 17:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611681368;
        bh=ZlMjWTDue1boFQPXRJs+qaamE0yY7UzDgg4PLAB1LAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qC1CerS4hbhJLOPVLo7DQADgwFjYNmxnwM3yop9BM3tj0quYYv/joaUvrZVyRKHSZ
         LKBqSRTSgl/2nUeXiVcGjQBIN+LYoyeN/gVYE6dy3meYywpUf1kQTwPQTpTuU7TH8t
         r6sIdWD95qo8u7lPvc3uY9yzUgXlLJlrlQ8sorIec+Nm8WGBWTxMI9Jw15upzQBQG2
         p0Mixp307Px8FPwgppi5bOw1pwr/Y5c4Z+OSlwnHR2foVoAvfcdf/9B1JuXDYJdJ7A
         4MlnNmVuDZpGwzb5sv5IcC4IugZMhS9yrL9GFYGFWuTp4YM65ghOnUwePRld/1tpRj
         5NrgKQY+PAgvA==
Date:   Tue, 26 Jan 2021 22:46:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>, od@zcrc.me,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH 2/2] dma: jz4780: Add support for the JZ4760(B)
Message-ID: <20210126171601.GS2771@vkoul-mobl>
References: <20210120105322.16116-1-paul@crapouillou.net>
 <20210120105322.16116-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120105322.16116-2-paul@crapouillou.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-01-21, 10:53, Paul Cercueil wrote:
> Add support for the JZ4760 and JZ4760B SoCs.
> 
> Both SoCs have only 5 DMA channels per chip. The JZ4760B introduced the
> DCKES/DCKEC registers.

Applied after fixing subsystem name, thanks

-- 
~Vinod
