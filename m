Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8992C1907
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 23:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388047AbgKWW4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 17:56:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:52328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388027AbgKWWz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 17:55:59 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32899206D8;
        Mon, 23 Nov 2020 22:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606172158;
        bh=mRUHitJaOyqn1hd4wDmZgomWCwCAIRHpMKchRTpPFnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q51XUV+dg9wSR9NSWw2KoZZQL6dKg42MZtT+VMZ66i3WiJRBwat6oH7XFG9kFHAw8
         JJ3lBz/BP4XgyK6FmV7Rch5PjWkCKTCtSpNsNNS+afCE+ONTdvlEjSaxdN6c/ks3UT
         BmjTfErre0pc7trImuHF7wYf5ncLPCEzFTpbAhl8=
Date:   Mon, 23 Nov 2020 16:56:12 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 066/141] ALSA: hdspm: Fix fall-through warnings for Clang
Message-ID: <20201123225612.GS21644@embeddedor>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <3f70182b366fca7e085a3b57cb2eb193be04eed8.1605896059.git.gustavoars@kernel.org>
 <s5hr1ondsdz.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hr1ondsdz.wl-tiwai@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 21, 2020 at 09:30:00AM +0100, Takashi Iwai wrote:
> On Fri, 20 Nov 2020 19:33:52 +0100,
> Gustavo A. R. Silva wrote:
> > 
> > In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> > by explicitly adding a break statement instead of letting the code fall
> > through to the next case.
> > 
> > Link: https://github.com/KSPP/linux/issues/115
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Thanks, applied.

Thanks for all you've taken, Takashi.
--
Gustavo
