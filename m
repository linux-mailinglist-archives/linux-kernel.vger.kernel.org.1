Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B7C26CA5F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgIPT6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:58:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727119AbgIPRfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:35:40 -0400
Received: from localhost (unknown [122.172.186.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9C1E22224;
        Wed, 16 Sep 2020 12:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600258428;
        bh=qIHPYfBqriTwYcGPPnUjFFpN3ScakiVkgdeJCIAMpLk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nBeMDdDTxM8ArWOumt7JWHUJ+tAYwRUySxyIkDpwx7Nq++F+N0iHkv3dMLWS6sYq+
         9xK6frsoX4sZruBhJzmesrk65QhDKb4eCKcY7wz0RzS/7OBxhWetUH4d1eXkRXcRKP
         7dVHnLtBxwG8SnXpPAFaPU8m4sbyY96ZvPhARlAQ=
Date:   Wed, 16 Sep 2020 17:43:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, Peter Chen <peter.chen@nxp.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Yuti Amonkar <yamonkar@cadence.com>,
        Sanket Parmar <sparmar@cadence.com>
Subject: Re: [PATCH 0/3] drivers/phy/cadence: Constify static structs
Message-ID: <20200916121340.GI2968@vkoul-mobl>
References: <20200912204639.501669-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200912204639.501669-1-rikard.falkeborn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-09-20, 22:46, Rikard Falkeborn wrote:
> Constify a number of static structs that are never changed to allow the
> compiler to put them in read-only memory.

Applied, thanks

-- 
~Vinod
