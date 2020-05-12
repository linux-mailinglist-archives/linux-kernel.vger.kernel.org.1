Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC62C1CEBE1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 06:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgELEVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 00:21:53 -0400
Received: from verein.lst.de ([213.95.11.211]:39074 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgELEVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 00:21:53 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 28A6D68BEB; Tue, 12 May 2020 06:21:50 +0200 (CEST)
Date:   Tue, 12 May 2020 06:21:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dimitri Sivanich <sivanich@hpe.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Christoph Hellwig <hch@lst.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Russ Anderson <rja@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>
Subject: Re: [PATCH] x86/platform/uv: HUB RTC cleanup
Message-ID: <20200512042149.GA31507@lst.de>
References: <20200511223535.GA23676@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511223535.GA23676@hpe.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 05:35:35PM -0500, Dimitri Sivanich wrote:
> Remove unused event code and other cleanup for HUB RTC.

Can you explain how this is dead?  That's not entirely obvious
from the patch.  Also you probably want to split it the cleans
into one or several additional patches and aso document them in
the commit log(s).

> diff --git a/arch/x86/platform/uv/uv_time.c b/arch/x86/platform/uv/uv_time.c
> index 7af31b245636..1777b7164ff8 100644
> --- a/arch/x86/platform/uv/uv_time.c
> +++ b/arch/x86/platform/uv/uv_time.c
> @@ -1,25 +1,18 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - * SGI RTC clock/timer routines.
> + * HPE RTC clock routine.

Might be worth mentioning this is for the UV platform?  Both the
old SGI and thew new HPE are not very descriptive.
