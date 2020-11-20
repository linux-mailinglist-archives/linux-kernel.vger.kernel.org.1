Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFC12BB515
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 20:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732307AbgKTTSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 14:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730586AbgKTTSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 14:18:20 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504CBC061A47
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 11:18:20 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id 81so8137779pgf.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 11:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/i9Wp3NyJ2XAt6V6C9rMEOf56CSMVPqB9lvPKpuPC6o=;
        b=A6bz8MoKhMEpf6tg+2HvalqvDlw1xmOxSg1SO4BbPffCb035fRyi6HeSG7U7LvQT7l
         xYU+VK7bi8OvfoYUaobXKHp+XtF4j5Voevd9nX72QgtS+cF68Aox8idwsVnML4uYmsyb
         SZCSt5TLA33olgVKwrlwIfeZ9z5z8JQ/GSR2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/i9Wp3NyJ2XAt6V6C9rMEOf56CSMVPqB9lvPKpuPC6o=;
        b=l6Asg+BPdc5SUPfDG8WboR158HslVQ+Fm2ztTacDx3psvqMsxzJvBqM279MLX3BjR/
         qe1iqrsfv092aFWBmjKjBKetTyejTPtM1RJzlfOfrvbycOTE5P45+T26Er4kawkYUE5f
         8qKRAa26XrTmzi9vsQY51eSHFOd+spQBB20SdTBsKIg5P96QnthWDi9YK0oBB92l/XRg
         m5rm+s46DaIfjyjYxGdXuOsV7mSg2FX3WgzPC27SSh9dOqSESZQwvUN0ZTSUDJXQmrUQ
         m466TyTDeooOkN2vtHwJVffXgC1HbwEp8YBgetd20xexGr2Lb4KNWvdQbB1MiTezkeNb
         DoFg==
X-Gm-Message-State: AOAM530hVs8BOiFTDyrHo5+GWHAlOeSUIMk9lAww54sF/c/M9Fj3UFR1
        dDyCo6xP3QAfX8jYbSV3Wb7wVQ==
X-Google-Smtp-Source: ABdhPJznhQs1XspFf53XI5p/EZOAG/c4T0kD/aTaNNbMtCtrqvJ764hFSBr91h1gUzYPJVGuU5VyXQ==
X-Received: by 2002:a63:e41:: with SMTP id 1mr17848400pgo.195.1605899899003;
        Fri, 20 Nov 2020 11:18:19 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f6sm3933626pgi.70.2020.11.20.11.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 11:18:17 -0800 (PST)
Date:   Fri, 20 Nov 2020 11:18:17 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH net] cfg80211: fix callback type mismatches in wext-compat
Message-ID: <202011201118.8F1A488@keescook>
References: <20201117205902.405316-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117205902.405316-1-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 12:59:02PM -0800, Sami Tolvanen wrote:
> Instead of casting callback functions to type iw_handler, which trips
> indirect call checking with Clang's Control-Flow Integrity (CFI), add
> stub functions with the correct function type for the callbacks.
> 
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
