Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C2B29D3DE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbgJ1Vr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:47:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727686AbgJ1VrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:47:23 -0400
Received: from localhost (unknown [122.171.163.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4895A247E0;
        Wed, 28 Oct 2020 16:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603901886;
        bh=HOU/dc8gv2uoND3ngAYda0o8nj47mGvrro84Mcv6v9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QD9BtAlszKYO5HEyhP9dzlYsy+qcY1yBssWKSgn/c2PNGJKpwp0ji4JChfQzAV+A5
         YTyVDTmINtYyyj/Z60RsILBdNeU/mL97lVa5vH4wPYtIrxXNqoTavNLzSUNZous+fV
         nIA+wvT6r+gnPRylHMLYTgenNaMgWxESh2fwzSk4=
Date:   Wed, 28 Oct 2020 21:48:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] phy: qcom-qmp: Initialize another pointer to NULL
Message-ID: <20201028161801.GU3550@vkoul-mobl>
References: <20201026205942.2861828-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026205942.2861828-1-swboyd@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-10-20, 13:59, Stephen Boyd wrote:
> This probe function is too complicated and should be refactored. For now
> let's just set this variable to NULL and keep the static analysis tools
> happy.

Applied, thanks

-- 
~Vinod
