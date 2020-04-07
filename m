Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46CB61A1699
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 22:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgDGUNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 16:13:39 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:41546 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgDGUNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 16:13:39 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EAE581210A3E1;
        Tue,  7 Apr 2020 13:13:37 -0700 (PDT)
Date:   Tue, 07 Apr 2020 13:13:34 -0700 (PDT)
Message-Id: <20200407.131334.2124984497809190196.davem@davemloft.net>
To:     o.rempel@pengutronix.de
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        david@protonic.nl, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        philippe.schenker@toradex.com, linux@armlinux.org.uk
Subject: Re: [PATCH net-next v3] net: phy: micrel: add phy-mode support for
 the KSZ9031 PHY
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200407093654.26095-1-o.rempel@pengutronix.de>
References: <20200407093654.26095-1-o.rempel@pengutronix.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 07 Apr 2020 13:13:38 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Please resubmit when net-next opens back up, thank you.
