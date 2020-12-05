Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4232CFA4B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 08:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgLEHm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 02:42:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:41836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726031AbgLEHmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 02:42:55 -0500
Date:   Sat, 5 Dec 2020 13:12:10 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607154135;
        bh=vgr/4zhYo/GWjvLrs9SuBftzWso6XJWiC5KcvOZQpWM=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=M+XlDxUCUyHicUEQPaEnt984FrcxJwSotwmcfDASKG9IYW/0Lc0S50KYVvBT6CXTZ
         TO7ML80/0zLXsboLG1YHmP9lZ50dvkVtmGrTU15WKNDN/sy7f0RD26tZS12oWdUA/G
         SE6WMafdtcFxiBzowAPwT7ipuBhBDZcFo0yIZe+U1na95TcKjajZxxHEoHCggSC+Ry
         DsJLGaDbpU1xHnVTypacHWsYTC4v0RoHc3+qzuxauN1LCwABTnOMlvdRUzg1TpxrZI
         T/E2pUU1D/GgIJrwIciqvgNX8y2cBpaS5xgukCxWht/Xosu2d0HyB+sd8M4uCUm6KB
         CmNNFNTN4pTXg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Rander Wang <rander.wang@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soundwire: intel: fix another unused-function warning
Message-ID: <20201205074210.GP8403@vkoul-mobl>
References: <20201203230502.1480063-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203230502.1480063-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-12-20, 00:04, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Without CONFIG_PM, there is another warning about an unused function:
> 
> drivers/soundwire/intel.c:530:12: error: 'intel_link_power_down' defined but not used [-Werror=unused-function]

Applied, thanks

-- 
~Vinod
