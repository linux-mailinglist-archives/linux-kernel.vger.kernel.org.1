Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4B928C10C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 21:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391557AbgJLTIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 15:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391699AbgJLTI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 15:08:26 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3196EC0613D7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 12:08:22 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id 1so3294254ple.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 12:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zW/ankKb/VemIvdGEdb5qHcmtQbdYR++io0wzUbX+nA=;
        b=b9GVLTZcD8hI5Pa0lYQpQysftTjixmM5ALJCTVZvP5J6ZHy41IBA9DS+ExAop9sM59
         /LI3g52m0l+5VzqiQoyp/GweRshZlzeOPSbmksxJs4frRcBz563P7Hec6N+xDpK8wq+d
         8xnCF3fbAxMWBnCbEkJvn0BBQoFar7dwIhn8ikDQXXO6Vm48qVc2p2zBMDfvrYB1pBvd
         8PHewJl4Z3+FanYnqYBnnSJSz8LkIn2FLP6yvyON8BXeiu/kOnbn/7M7p8zzIz3APhND
         KQDqJ4CgOxP2NtEakj4BLHA+jT1Fo6XhGwquEEKFbUb19sahC8pEf5jRxYeEzDJSBFqt
         SoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zW/ankKb/VemIvdGEdb5qHcmtQbdYR++io0wzUbX+nA=;
        b=iyGIvsH7+0rsB4hcCheDlJ8zPBIhmJNkpXcxTB/FnhXYkWynADWE+FF+x/Gt1D9yYd
         fFkCrVthnyTW7TMUakBG3CYkWa9vpbxmvaX2FrexAtDW9KJ2CgOLf4cOkB5f8CQ1Htlw
         bgVubO4jLPXaWoDwjpiLZXaqOY7CtlUCGt/yCQpG/g+8bC2wW/jJPUwQNyqkyJ7jBuQC
         Q4C+0qpsmfqobglZwm7DX9FGNo7g7nG+SNpmR4UU2NSgANdbQtLwu3G5g0UG0V2C1VWj
         0d+ln8RBWOxnwD7+jd7oyT7WkxS2qS5OfakplHlbjKc8LRVAANc7ukolB41caNDQA+Dl
         eF5Q==
X-Gm-Message-State: AOAM532het1C4+rUDn6tSQoJzT5Kt4boZC36nqy2vDTPtLR+1Zq49N6a
        S3HupEyKzWXKt3iAxQ1eir0=
X-Google-Smtp-Source: ABdhPJz+f2A+tX5w9xGTOqmWei3lNZIF6S21G/3LO8dmNxWD06QmSquO6fSjKsvwO4qBcjZBFkHdiw==
X-Received: by 2002:a17:902:6845:b029:d4:d1d5:2139 with SMTP id f5-20020a1709026845b02900d4d1d52139mr9524779pln.53.1602529701706;
        Mon, 12 Oct 2020 12:08:21 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id r6sm16945719pfg.85.2020.10.12.12.08.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Oct 2020 12:08:21 -0700 (PDT)
Date:   Mon, 12 Oct 2020 12:00:38 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_spdif: Add support for higher sample rates
Message-ID: <20201012190037.GB17643@Asurada-Nvidia>
References: <1602492582-3558-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602492582-3558-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shengjiu,

On Mon, Oct 12, 2020 at 04:49:42PM +0800, Shengjiu Wang wrote:
> Add 88200Hz and 176400Hz sample rates support for TX.
> Add 88200Hz, 176400Hz, 192000Hz sample rates support for RX.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>

Probably should put your own Signed-off at the bottom?

Anyway:
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
