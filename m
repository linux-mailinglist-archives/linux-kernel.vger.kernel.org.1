Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D77B27B6F6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 23:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgI1VVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 17:21:19 -0400
Received: from ms.lwn.net ([45.79.88.28]:48272 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbgI1VVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 17:21:18 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 537D24A2;
        Mon, 28 Sep 2020 21:21:18 +0000 (UTC)
Date:   Mon, 28 Sep 2020 15:21:16 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mark Starovoytov <mstarovo@pm.me>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mailmap: add entry for <mstarovoitov@marvell.com>
Message-ID: <20200928152116.4ea75b13@lwn.net>
In-Reply-To: <20200928183948.589-1-mstarovo@pm.me>
References: <20200928183948.589-1-mstarovo@pm.me>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Sep 2020 18:39:59 +0000
Mark Starovoytov <mstarovo@pm.me> wrote:

> Map the address to my private mail, because my Marvell account has been suspended.
> 
> Signed-off-by: Mark Starovoytov <mstarovo@pm.me>
> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.mailmap b/.mailmap
> index a780211468e4..f7bd4ee8c4b9 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -195,6 +195,7 @@ Maciej W. Rozycki <macro@mips.com> <macro@imgtec.com>
>  Marcin Nowakowski <marcin.nowakowski@mips.com> <marcin.nowakowski@imgtec.com>
>  Marc Zyngier <maz@kernel.org> <marc.zyngier@arm.com>
>  Mark Brown <broonie@sirena.org.uk>
> +Mark Starovoytov <mstarovo@pm.me> <mstarovoitov@marvell.com>

Applied, thanks.

jon
