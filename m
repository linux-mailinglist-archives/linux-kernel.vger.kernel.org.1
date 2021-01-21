Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A777F2FF2AE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 19:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389555AbhAUSAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 13:00:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:54200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389266AbhAURzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:55:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CAC4F23A24;
        Thu, 21 Jan 2021 17:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611251714;
        bh=d5j8obV98TmUvGdId9A2nG5y8IOFR1oWdFBqzunCXJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IdFAWVb/SlPxZ/maUPQKHPYBB0TYcni/BiwzFXjsbsOypFcHHf4Rp6wXT1WXktxn5
         AHA2CzzqwBrA9vdgjEzJe800hq4ibo2zU3or807ELILYPa54WPgXHZe+ITNQHyyFW7
         f3yOqQwDBtLnoXigFCZdhAYSAqpHbWA87wRR99RY=
Date:   Thu, 21 Jan 2021 18:55:08 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] stm class/intel_th: Fixes for v5.11
Message-ID: <YAm//GgQE3yNV8nn@kroah.com>
References: <20210115195917.3184-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115195917.3184-1-alexander.shishkin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 10:59:15PM +0300, Alexander Shishkin wrote:
> Hi Greg,
> 
> Here are updates that I have for v5.11. These are: one minor bugfix and
> a new PCI ID.
> 
> Alexander Shishkin (1):
>   intel_th: pci: Add Alder Lake-P support
> 
> Wang Hui (1):
>   stm class: Fix module init return on allocation failure
> 
>  drivers/hwtracing/intel_th/pci.c  | 5 +++++
>  drivers/hwtracing/stm/heartbeat.c | 6 ++++--
>  2 files changed, 9 insertions(+), 2 deletions(-)

Now applied, thanks.

greg k-h
