Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57DD52250E1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 11:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgGSJ0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 05:26:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbgGSJ0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 05:26:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4250C20734;
        Sun, 19 Jul 2020 09:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595150799;
        bh=ljG4z8NQkx6r+tRv9xzPgjIxxQyH5H2eGUpv+e4PoUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FlyBSpXbBM3PAHhf+jsjtFA6+6DKvsw5kLZCKzdoKWl9OUvLDebwtQdZuAHx06Hg0
         Mev5VuqbW566XyoHmE4CKA3hglj2WG7zVDGIVvkiZ+LmbCpJ/SIcaYt6UtJI1SOfC2
         PyNiuWsqMkQH3HWD75sGMiEQwnA//qhaYYW4n2mw=
Date:   Sun, 19 Jul 2020 11:26:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     B K Karthik <bkkarthik@pesu.pes.edu>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] staging: rtl8188eu: include: fixed multiple
 parentheses coding style issues
Message-ID: <20200719092652.GA257887@kroah.com>
References: <20200718091626.uflhdcgkmhqij5b7@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718091626.uflhdcgkmhqij5b7@pesu-pes-edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 05:16:26AM -0400, B K Karthik wrote:
> fixed multiple parentheses coding style issues reported by checkpatch.
> 
> Signed-off-by: B K Karthik <karthik.bk2000@live.com>
> ---
>  drivers/staging/rtl8188eu/include/ieee80211.h |  4 +--
>  .../staging/rtl8188eu/include/osdep_service.h |  4 +--
>  drivers/staging/rtl8188eu/include/wifi.h      | 34 +++++++++----------
>  3 files changed, 21 insertions(+), 21 deletions(-)

You can never add warnings to the build, like this patch did.  Always
test-build your patches at the very least...

greg k-h
