Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172F729D47D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgJ1Vw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:52:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728308AbgJ1VwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:52:23 -0400
Received: from localhost (unknown [122.171.163.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9963C247E5;
        Wed, 28 Oct 2020 16:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603902243;
        bh=/CNRthWv/zqqaUuU7fdYfu5jNxgF5m/g8C7Co0cWMvU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=16AV3U8Hb7SUV3i+mcnM23pDnnc7jd6AOpWeDSBxKcbAR02X+YBLLVLPYq+yLT9f2
         nipDQEh7jvObnCsNt+c2ATCu4eX1h2WBQJjuIJZjWQttoxkfeHoC6em10rOcpy6chc
         umIR+Ouu2roUPkEGHReQci20Vpqwoxkus7EspWkY=
Date:   Wed, 28 Oct 2020 21:53:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] phy: cpcap-usb: Use IRQF_ONESHOT
Message-ID: <20201028162358.GV3550@vkoul-mobl>
References: <1603875549-107500-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603875549-107500-1-git-send-email-zou_wei@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-10-20, 16:59, Zou Wei wrote:
> Fixes coccicheck error:
> 
> ./drivers/phy/motorola/phy-cpcap-usb.c:365:9-34: ERROR:
> Threaded IRQ with no primary handler requested without IRQF_ONESHOT

Applied, thanks

-- 
~Vinod
