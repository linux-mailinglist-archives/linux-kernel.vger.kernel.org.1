Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6AF5209EF5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 14:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404840AbgFYM5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 08:57:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404723AbgFYM47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 08:56:59 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 057D12063A;
        Thu, 25 Jun 2020 12:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593089819;
        bh=kzaLKrREKLzRea6TUdWAoSQVtDNNj/8G/ZUDOabAD2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QJTtzwmwzWA2xKg8Z9TmfLY1vrj+do4O1oqiphD8lH5tUaCRftHhIB1DW5uZkgTVW
         QSGQMj+jJ2qKJZmBRB/L5QenTsKIDOLBGM7zFyLcL7ShSxbGIn673QHc04vZYebROp
         W6vxWtumIHBBRMLmNiKzQviCgSYoHz47THh8HGrk=
Date:   Thu, 25 Jun 2020 18:26:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: sun4i-usb: fix dereference of pointer phy0 before
 it is null checked
Message-ID: <20200625125655.GC6228@vkoul-mobl>
References: <20200625124428.83564-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625124428.83564-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-06-20, 13:44, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently pointer phy0 is being dereferenced via the assignment of
> phy on the call to phy_get_drvdata before phy0 is null checked, this
> can lead to a null pointer dereference. Fix this by performing the
> null check on phy0 before the call to phy_get_drvdata. Also replace
> the phy0 == NULL check with the more usual !phy0 idiom.

Applied, thanks
-- 
~Vinod
