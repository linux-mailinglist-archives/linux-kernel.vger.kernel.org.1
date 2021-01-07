Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C43E2ED366
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 16:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbhAGPRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 10:17:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:58370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbhAGPRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 10:17:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 41FCB233FD;
        Thu,  7 Jan 2021 15:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610032625;
        bh=OEvqiP+gDwEWwvM3UqWJEjQhBLH3jpVEs1DYdZFggbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B1EwUH2arpyh/7/JvDquux0Pa/JnkFJ0Vm9eejLvMCHj/6lUaGKpDyEsBVtr/Aoqg
         +HWuyM/IZ1k8cQcB40zA3H6gYprE3/EBJ1csi8iZHb2HF35qqDNR5vkKfMvAlnpB+m
         6/a+eEXOpgHv9hDAAaIgYTiA6ojTJG2PNRMO5Dh8=
Date:   Thu, 7 Jan 2021 16:18:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] vt: move set_leds to keyboard.c
Message-ID: <X/cmQYLyPtfFqN8x@kroah.com>
References: <20210105120239.28031-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105120239.28031-1-jslaby@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 01:02:28PM +0100, Jiri Slaby wrote:
> set_leds and compute_shiftstate are called from a single place in vt.c.
> Let's combine these two into vt_set_leds_compute_shiftstate. This allows
> for making keyboard_tasklet local in the next patch.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Overall this was:
 29 files changed, 70 insertions(+), 333 deletions(-)

nice!

all now queued up, thanks for this work.

greg k-h

