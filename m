Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5B92F1FB5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388997AbhAKTpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:45:51 -0500
Received: from ms.lwn.net ([45.79.88.28]:58558 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730411AbhAKTpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:45:50 -0500
Received: from lwn.net (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C00D09A8;
        Mon, 11 Jan 2021 19:45:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C00D09A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1610394310; bh=7TmXEknUcAlmtbHUglEqhDvsunxbo1+equLlj15wZRc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OLtkSmzV7gUwAYyEPu8SNG1dobLmpodw5HfBkKUiFspzwIr4hFAa+VNRbpDHr+pe1
         hTKiyF5pjveM9agl1gcEaL3+6Un05bA6bBMhVZ8kpUOH4stiS7W/1ms9q1SpRRwHBn
         Rmfrf4KRwgmi8FH0p3jGCmAD6Jet54LF/2OuujxmoNtHLuEmL56sidX6rYno3zc6ic
         /uPF+xklQ/FrCG2MK7c90kmQ5UXWJgnUCmCYAHopwLfTnBGgEyOuBUim1NrcxZlM96
         EIgHnPSiiXs4hOm/r9Fz9Kf70zMwAZZxodKrfbFWwcuClxK5bEossHnZPzTbaqplOp
         VFQPdDsIJaglg==
Date:   Mon, 11 Jan 2021 12:45:08 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Joe Pater <02joepater06@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: kernel-hacking: change 'current()' to
 'current'
Message-ID: <20210111124508.0434a8a9@lwn.net>
In-Reply-To: <20210111103240.7445-1-02joepater06@gmail.com>
References: <20210111103240.7445-1-02joepater06@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jan 2021 10:32:41 +0000
Joe Pater <02joepater06@gmail.com> wrote:

> Change 'current()' heading to 'current' to reflect usage.
> 
> Signed-off-by: Joe Pater <02joepater06@gmail.com>
> ---
>  Documentation/kernel-hacking/hacking.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/kernel-hacking/hacking.rst b/Documentation/kernel-hacking/hacking.rst
> index eed2136d847f..451523424942 100644
> --- a/Documentation/kernel-hacking/hacking.rst
> +++ b/Documentation/kernel-hacking/hacking.rst
> @@ -346,8 +346,8 @@ routine.
>  Before inventing your own cache of often-used objects consider using a
>  slab cache in ``include/linux/slab.h``
>  
> -:c:func:`current()`
> --------------------
> +:c:macro:`current`
> +------------------

Applied, thanks.

jon
