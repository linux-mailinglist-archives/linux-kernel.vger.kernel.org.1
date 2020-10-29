Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3B429EC08
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 13:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgJ2Mme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 08:42:34 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:52022 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgJ2Mmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 08:42:32 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kY7Fg-0049fs-Le; Thu, 29 Oct 2020 13:42:00 +0100
Date:   Thu, 29 Oct 2020 13:42:00 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pavana Sharma <pavana.sharma@digi.com>
Cc:     davem@davemloft.net, f.fainelli@gmail.com,
        gregkh@linuxfoundation.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        vivien.didelot@gmail.com, marek.behun@nic.cz,
        ashkan.boldaji@digi.com
Subject: Re: [PATCH v6 2/4] net: phy: Add 5GBASER interface mode
Message-ID: <20201029124200.GJ933237@lunn.ch>
References: <cover.1603944740.git.pavana.sharma@digi.com>
 <9b93cc79d7cc07ee77808150ca76c9d243c8ca60.1603944740.git.pavana.sharma@digi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b93cc79d7cc07ee77808150ca76c9d243c8ca60.1603944740.git.pavana.sharma@digi.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 03:42:00PM +1000, Pavana Sharma wrote:
> Add new mode supported by MV88E6393 family.

Hi Pavana

I asked you to add kerneldoc for this new value, but you have not
added it. Please compile your code with W=1, and you should see the
warning.

	Andrew
