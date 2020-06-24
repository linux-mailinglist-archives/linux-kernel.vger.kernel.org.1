Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8BC2073DC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 14:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390842AbgFXM5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 08:57:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:44714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389124AbgFXM5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 08:57:40 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46DCE20706;
        Wed, 24 Jun 2020 12:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593003460;
        bh=PjpQgEdsFZfWlRdSOwe2EoqiAFGYWK81Zu3hprmm6GA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d4fm2AlBdLKrbJbHCfPpmCLeZCgWCCFmfjsYa+mHc6J73RRApJM0cqR0LJrQ52jUT
         37qc5JHmnnmMm3HPaWKg/LIONIB4YpQLYG9U0k1PE7Lp0KauVBfthw2nsrhFpV+5Yk
         xtCWRnW4EmXxvjIBUV5/Ry4PblttOoZCcRvkj8E0=
Date:   Wed, 24 Jun 2020 18:27:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>,
        YueHaibing <yuehaibing@huawei.com>, Jyri Sarha <jsarha@ti.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 0/2] drivers/phy/ti: Constify structs
Message-ID: <20200624125735.GD2324254@vkoul-mobl>
References: <20200524095516.25227-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524095516.25227-1-rikard.falkeborn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-05-20, 11:55, Rikard Falkeborn wrote:
> Constify some static structs that are not modified in order to allow the
> compiler to put them in read-only memory.

Applied both, thanks

-- 
~Vinod
