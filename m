Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C146F2C29BD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388854AbgKXOeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:34:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:55896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbgKXOeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:34:16 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E065320715;
        Tue, 24 Nov 2020 14:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606228455;
        bh=8k269Qcdv5UUAVcceDs5T05sKdirRXOqjrBQoQgDGaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JN3QfTBUxweHPY4wtxuCt7B4eA9HtSkXS20Gq0NSmwH4kkuK1QSuqMPZdov3wEg75
         3csJanZk5yW1EJxBNsz8Tp7aKJ+uhEeQVg40AYai2PSse5toFMFg+i3WSzbcIbLjUH
         JVq/f0yzarua+6VTnlUJJb675AhuffGbBnP4mYtI=
Date:   Tue, 24 Nov 2020 08:34:31 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 084/141] drm/via: Fix fall-through warnings for Clang
Message-ID: <20201124143431.GC16084@embeddedor>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <c21a588bf9e222826f6b138db91de26a2b21df33.1605896060.git.gustavoars@kernel.org>
 <20201122220358.GB566387@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201122220358.GB566387@ravnborg.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 22, 2020 at 11:03:58PM +0100, Sam Ravnborg wrote:
> On Fri, Nov 20, 2020 at 12:35:54PM -0600, Gustavo A. R. Silva wrote:
> > In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> > by explicitly adding a break statement instead of letting the code fall
> > through to the next case.
> > 
> > Link: https://github.com/KSPP/linux/issues/115
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Thanks, also applied to drm-misc-next.

Thank you, Sam.
--
Gustavo
