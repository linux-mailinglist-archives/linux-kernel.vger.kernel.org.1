Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5EEC2575EF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 11:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgHaJBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 05:01:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:32960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbgHaJBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 05:01:47 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BC29208CA;
        Mon, 31 Aug 2020 09:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598864507;
        bh=V1Kdqp3MpKk7bBynwA3RtEMJuXa5+xTQus1ipqhPoSA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OaIMR658zsshmyKulJQyWNx9Mh0wDURnx4zzh7O387ZirDRF4I9i1LWdmgk0VdPWj
         urCCWeXhhPn98Hfyi+edpmF2PTQqcKvnYtSDwXP9Jb1zr/mTWTnjGVXwhcpM4wozbQ
         ierAPM9gnDejouvYdvBOO3f+fKUbc5a+o7OcaYLE=
Date:   Mon, 31 Aug 2020 14:31:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Roger Quadros <rogerq@ti.com>
Cc:     kishon@ti.com, nsekhar@ti.com, vigneshr@ti.com,
        jan.kiszka@siemens.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] phy: omap-usb2-phy: Errata and coding style fix
Message-ID: <20200831090142.GI2639@vkoul-mobl>
References: <20200824075127.14902-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824075127.14902-1-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-08-20, 10:51, Roger Quadros wrote:
> Hi,
> 
> This series addresses silicon errata
> i2075 - "USB2PHY: USB2PHY Charger Detect is Enabled by Default
> Without VBUS Presence"
> 
> It also fixes coding style issues.

Applied, thanks

-- 
~Vinod
