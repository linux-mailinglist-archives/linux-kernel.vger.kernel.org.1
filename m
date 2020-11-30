Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272BB2C82D3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 12:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbgK3LDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 06:03:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:39332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbgK3LDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 06:03:46 -0500
Received: from localhost (unknown [122.171.214.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84683207F7;
        Mon, 30 Nov 2020 11:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606734185;
        bh=hjIcZHlqjoAO8SFOaLc53+G8xg4yeUu0vni/0Fqn0Bc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kmCxKGIwQI+T2Mo2rkjWWy4eQRdp4boF9WE2CHq6fg3sGfLZBof9qpQFMJJ1YqMi+
         yYGfyTHmJT/Deiw0WdiTFmTCgpxH7s7H314Q1YT/7t0x8B2LSbEwe/Ix4ewBolpAbB
         vTmnjqsmU1QuaWoTpBOpi9gnD0ChEfwZogdISwWE=
Date:   Mon, 30 Nov 2020 16:32:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yejune Deng <yejune.deng@gmail.com>
Cc:     kishon@ti.com, khilman@baylibre.com, narmstrong@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        p.zabel@pengutronix.de, lorenzo.pieralisi@arm.com,
        repk@triplefau.lt, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH] phy: amlogic: replace devm_reset_control_array_get()
Message-ID: <20201130110251.GS8403@vkoul-mobl>
References: <1605666995-16462-1-git-send-email-yejune.deng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605666995-16462-1-git-send-email-yejune.deng@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-11-20, 10:36, Yejune Deng wrote:
> devm_reset_control_array_get_exclusive() looks more readable

Applied, thanks

-- 
~Vinod
