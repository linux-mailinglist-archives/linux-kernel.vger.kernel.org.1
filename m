Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15321CB2B8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 17:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgEHPW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 11:22:58 -0400
Received: from muru.com ([72.249.23.125]:53614 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbgEHPW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 11:22:57 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9DDEB806C;
        Fri,  8 May 2020 15:23:46 +0000 (UTC)
Date:   Fri, 8 May 2020 08:22:54 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     kishon@ti.com, vkoul@kernel.org, pavel@ucw.cz,
        sebastian.reichel@collabora.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] phy: cpcap-usb: Remove some useless code
Message-ID: <20200508152254.GZ37466@atomide.com>
References: <20200507203127.202197-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507203127.202197-1-christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Christophe JAILLET <christophe.jaillet@wanadoo.fr> [200507 20:32]:
> Axe a clk that is unused in the driver.

Thanks for fixing it:

Acked-by: Tony Lindgren <tony@atomide.com>
