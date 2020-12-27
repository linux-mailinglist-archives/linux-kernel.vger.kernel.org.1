Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98AAF2E31B6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 16:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgL0Psa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 10:48:30 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:52309 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgL0Ps3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 10:48:29 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4D3lRt251Jz1qs0H;
        Sun, 27 Dec 2020 16:47:21 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4D3lRs3YGfz1qs5B;
        Sun, 27 Dec 2020 16:47:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id MaF-BA8HcyKT; Sun, 27 Dec 2020 16:47:20 +0100 (CET)
X-Auth-Info: wKiVj1aH/fhPcaBIDfQMhJdTKsNwHLBrLIuElT3Ea3nTGQdZmhhFzFJfZDSSgq0l
Received: from igel.home (ppp-46-244-172-159.dynamic.mnet-online.de [46.244.172.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 27 Dec 2020 16:47:20 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 3852E2C35D1; Sun, 27 Dec 2020 16:47:20 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Defang Bo <bodefang@126.com>
Cc:     gerg@linux-m68k.org, geert@linux-m68k.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] m68k: let clk_enable() return immediately if clk is
 NULL
References: <1609079753-4038536-1-git-send-email-bodefang@126.com>
X-Yow:  HELLO, everybody, I'm a HUMAN!!
Date:   Sun, 27 Dec 2020 16:47:20 +0100
In-Reply-To: <1609079753-4038536-1-git-send-email-bodefang@126.com> (Defang
        Bo's message of "Sun, 27 Dec 2020 22:35:53 +0800")
Message-ID: <87bleffdyv.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dez 27 2020, Defang Bo wrote:

> diff --git a/arch/m68k/coldfire/clk.c b/arch/m68k/coldfire/clk.c
> index 7bc666e..cf1ed97 100644
> --- a/arch/m68k/coldfire/clk.c
> +++ b/arch/m68k/coldfire/clk.c
> @@ -90,6 +90,9 @@ EXPORT_SYMBOL(clk_get);
>  int clk_enable(struct clk *clk)
>  {
>  	unsigned long flags;
> +	if (!clk)
> +		return;

That fails to return a value.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
