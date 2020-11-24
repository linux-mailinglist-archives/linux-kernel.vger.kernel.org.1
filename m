Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C562C29EF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389221AbgKXOnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:43:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:57554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388162AbgKXOnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:43:53 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9105206F9;
        Tue, 24 Nov 2020 14:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606229032;
        bh=8+Oaa7bvZ05Y2HZFAnDkMV/oiZMjQ6zVl9gG9O4TVQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DLHFDVD4JFe0wJJJZiyfsxPA1CLFdIASTlSh88sa2UbiYHnT/8FEfnQO8E6pPdS+h
         jQJJFEzMeVLo6tIugMSFmH5vTL0uN8VVdS0ijgQNZWAEUuNszU2VtfHWeIvJP8BCo8
         sMuhFc27D3S1mYjpR3XaPky0bFlWab50KWn6Esx0=
Date:   Tue, 24 Nov 2020 08:44:07 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Andres Salomon <dilinger@queued.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-geode@lists.infradead.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 134/141] video: fbdev: lxfb_ops: Fix fall-through
 warnings for Clang
Message-ID: <20201124144407.GI16084@embeddedor>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <9c1dcb12aae7c7ff0907ffb99ffd227656cbe444.1605896060.git.gustavoars@kernel.org>
 <20201122220540.GC566387@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201122220540.GC566387@ravnborg.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On Sun, Nov 22, 2020 at 11:05:40PM +0100, Sam Ravnborg wrote:
> Hi Gustavo,
> On Fri, Nov 20, 2020 at 12:40:32PM -0600, Gustavo A. R. Silva wrote:
> > In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> > by explicitly adding a break statement instead of letting the code fall
> > through to the next case.
> > 
> > Link: https://github.com/KSPP/linux/issues/115
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Thanks, applied this and the following patch to drm-misc-next.
> Looks forward to have this warning enabled.
> 
> One can only wonder how many hours will be saved by lettting the
> compiler tell you a break is missing. This is the kind of bugs you can
> stare you blind at.

Absolutely. We'll never know how many bugs this will catch in the
future decades of kernel development, before the code is even
committed/submitted. :)

Thanks!
--
Gustavo
