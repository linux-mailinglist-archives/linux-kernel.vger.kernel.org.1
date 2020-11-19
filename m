Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8AEB2B8F7A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 10:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgKSJyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 04:54:13 -0500
Received: from muru.com ([72.249.23.125]:48774 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbgKSJyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 04:54:12 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 0F4DB80C1;
        Thu, 19 Nov 2020 09:54:18 +0000 (UTC)
Date:   Thu, 19 Nov 2020 11:54:09 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Youling Tang <tangyouling@loongson.cn>
Cc:     Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm: Fix memleak in omap2xxx_clkt_vps_init
Message-ID: <20201119095409.GN26857@atomide.com>
References: <1605326818-13823-1-git-send-email-tangyouling@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605326818-13823-1-git-send-email-tangyouling@loongson.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Youling Tang <tangyouling@loongson.cn> [201114 04:07]:
> If the clk_register fails, we should free hw before function returns to
> prevent memleak.

Thanks applying both into omap-for-v5.11/soc.

Tony
