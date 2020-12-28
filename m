Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B622E420A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 16:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441328AbgL1PQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 10:16:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:59584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441203AbgL1PQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 10:16:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D08C207A1;
        Mon, 28 Dec 2020 15:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609168550;
        bh=iwZ8EackymjR876ZEz27R3Tkb8qshewzfpykT+9JELg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JIvuw/dx19QhTocOBgPlp+bGu7lGnk1BQdPFn1B9D43cL5O/ZOOcBkG9awoVQEovH
         5IU55h3Zy0ZUHjGXPdRr0ViOg0RAgqmuUzEtjZcnaHjUv5YlT2aodJxBSQ3YnbC+lb
         pwBI8hWmYhOKHoKX4f52JLkOAAvJU8+LURa8fRds=
Date:   Mon, 28 Dec 2020 16:17:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Erwan Le Ray <erwan.leray@foss.st.com>
Cc:     Jiri Slaby <jslaby@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>
Subject: Re: [PATCH 0/7] STM32 uart cleanup and improvements
Message-ID: <X+n297h2+zlhXKGV@kroah.com>
References: <20201218190020.1572-1-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201218190020.1572-1-erwan.leray@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 08:00:11PM +0100, Erwan Le Ray wrote:
> This series brings various fixes, cleanups and improvements to stm32-usart
> driver.

This patch series does not apply to 5.11-rc1.

Please fix up and resend.

thanks,

greg k-h
