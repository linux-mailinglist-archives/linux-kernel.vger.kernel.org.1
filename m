Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F87E257892
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 13:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgHaLkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 07:40:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgHaLkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 07:40:47 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78A35207DA;
        Mon, 31 Aug 2020 11:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598874047;
        bh=3TkbvgYQYX4dzQg6VhKN6hryZ43zp0TDTvVQlxVccEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CWczNBiGmmKWPc+iGA5FcSHR5r+tAH0lq8c1kWBcVclrjU+Gdxf+eJCTC/U2CU35K
         s26lF+B3/5Ao0EhJu0yAaw+EDAPezQkrMakJznMX9JyRCKHO2COIs42j8R36yvwuYs
         tIfVvjLTNo2vqjZGKfpTJ485C44WiHdbcVix5chA=
Date:   Mon, 31 Aug 2020 17:10:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH v4 0/2] Add new UniPhier AHCI PHY driver
Message-ID: <20200831114043.GQ2639@vkoul-mobl>
References: <1598352071-26675-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598352071-26675-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-08-20, 19:41, Kunihiko Hayashi wrote:
> This series adds support for AHCI PHY interface implemented in Socionext
> UniPhier SoCs. This driver supports PXs2 and PXs3 SoCs.

Applied both, thanks

-- 
~Vinod
