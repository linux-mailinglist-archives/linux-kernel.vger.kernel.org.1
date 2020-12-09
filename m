Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34692D4E16
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 23:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389030AbgLIWiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 17:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388779AbgLIWhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 17:37:53 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE72CC0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 14:37:12 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id c12so1801066pgm.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 14:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nrxLdcl3wsizq7pZZrg/1JXYlLLqDsCOszWw99iRRjU=;
        b=naurhE36/fB0M2XuesmB/J+IagQviYVLh0EuRnH5J7Rrkt/kxFq69tpFR/r7AQrDaR
         84rYTtJUmHPG6LkeTvQwbJmrroKcvZg0VMNZd9ywZz/BTGW7ZB68JFAxg1NRLZyT0lWR
         42zqERaw/3RsiQLyJq+GQnC6b1XfQk7q0uWxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nrxLdcl3wsizq7pZZrg/1JXYlLLqDsCOszWw99iRRjU=;
        b=M5MPCHfMpD1ql7JRaSLRSP3kvn1cKFR0CFpWVZInZhKpfGquWr4Zw10juHy7DDmfDU
         oUQPbtIFRJAYmIILnW9A3dnFzOh3AnJ+t9IA1O09Khi8X48VYuShJQkr5SKYiRGibv/A
         f0w8u6KGYpUNb7/wnBIMWx8/j9cAQDnnA8HTdc1YkeauIJjyBn2E87Wpj2XbUR6JzBAh
         zjJs7k7aXIxQpBWwF+EbK0Vq1HT9xgWI0JFzHSxFsbzbQpG5DplesNzXfcO1uhhynciq
         TksI068ncULpqaJqbv14Z2W1yqBkJAx95789EhP4gus8SlOQXmLtJJvVbQXrgpRkLTAC
         2c8w==
X-Gm-Message-State: AOAM532vZesnCkG48xkw+0wYIuQ50XPAb9ggMAF3xlvKef00wWxjo1HE
        e170gMd5pAoQ17qUTZ9veHIY8A==
X-Google-Smtp-Source: ABdhPJz7nnGhsSPeg6rC2QtW2vzcTbAwcCTjtvRiGZUXMbiCMAyA+80bB6OYm3LTFUG7Ncm/wZSy6w==
X-Received: by 2002:a62:62c7:0:b029:18b:c7ae:934a with SMTP id w190-20020a6262c70000b029018bc7ae934amr4123549pfb.18.1607553432392;
        Wed, 09 Dec 2020 14:37:12 -0800 (PST)
Received: from google.com ([2620:15c:202:201:8edc:d4ff:fe53:350d])
        by smtp.gmail.com with ESMTPSA id t15sm3375324pja.4.2020.12.09.14.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 14:37:11 -0800 (PST)
Date:   Wed, 9 Dec 2020 14:37:09 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     Evan Benn <evanbenn@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 1/2] platform/chrome: cros_ec_proto: Use
 EC_HOST_EVENT_MASK not BIT
Message-ID: <X9FRlTDVXtj6uFQb@google.com>
References: <20201209220306.1.I6133572c0ab3c6b95426f804bac2d3833e24acb1@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209220306.1.I6133572c0ab3c6b95426f804bac2d3833e24acb1@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 10:03:54PM +0000, Evan Benn wrote:
> The host_event_code enum is 1-based, use EC_HOST_EVENT_MASK not BIT to
> generate the intended mask. This patch changes the behaviour of the
> mask, a following patch will restore the intended behaviour:
> 'Add LID and BATTERY to default mask'
> 
> Fixes: c214e564acb2ad9463293ab9c109bfdae91fbeaf

Normally the short hash + commit title are used here, so:

Fixes: c214e564acb2 ("platform/chrome: cros_ec_proto: ignore unnecessary wakeups on old ECs")

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-changes

With luck, maintainers can fix that up when applying, so you don't need
to resend.

Otherwise, both patches look good to me, thanks!

Reviewed-by: Brian Norris <briannorris@chromium.org>
