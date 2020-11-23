Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D7B2C1902
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 23:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387933AbgKWWzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 17:55:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:52102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387931AbgKWWyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 17:54:53 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED069206D8;
        Mon, 23 Nov 2020 22:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606172093;
        bh=uARlE3HGl1j9/UX0OJKYVTZCltQTUxKUiwJyZRg1SIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aZq2EBpPIX0eaFLbDRguDSSsAkAJxuRKD3mIuP9JbWVz5H/s5cA+wymagAi+vNYaf
         89SvwLKs0LJnsJwtEOlEZmDfr2aoYslWDUg3Nm/asGswyrdwK0VMPzBcZ7VW7wrwn2
         2+wWuM/J6t3kZQQi2fuTi6TF0oMPq575ogXK3fFg=
Date:   Mon, 23 Nov 2020 16:55:07 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     op-tee@lists.trustedfirmware.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 061/141] tee: Fix fall-through warnings for Clang
Message-ID: <20201123225507.GR21644@embeddedor>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <c505109fe0c02f648e16caa83d8a9773afd696b1.1605896059.git.gustavoars@kernel.org>
 <CAHUa44G1B8_CSahTJ1uOUMLcDfpVKHUaoN+u87BywkVwyhjnRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHUa44G1B8_CSahTJ1uOUMLcDfpVKHUaoN+u87BywkVwyhjnRw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 22, 2020 at 10:26:09AM +0100, Jens Wiklander wrote:
> On Fri, Nov 20, 2020 at 7:33 PM Gustavo A. R. Silva
> <gustavoars@kernel.org> wrote:
> >
> > In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> > by explicitly adding a break statement instead of letting the code fall
> > through to the next case.
> >
> > Link: https://github.com/KSPP/linux/issues/115
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >  drivers/tee/tee_core.c | 1 +
> >  1 file changed, 1 insertion(+)
> 
> Acked-by: Jens Wiklander <jens.wiklander@linaro.org>

Thanks, Jens.
--
Gustavo
