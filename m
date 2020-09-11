Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F6C2665B1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 19:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgIKRKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 13:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgIKRKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 13:10:37 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DB3C061757
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 10:10:33 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id m5so7074702pgj.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 10:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=i2W71MrrzMNYcyB/z7lfhjSe/syd2lqbfSWnk+mqe6k=;
        b=PJHJwRXr9q+ni6PIu74aQcOfM/Gl7Qd/RuGgGPBdnIh4ZmUSrOh9BEI/iTWgtvVFHl
         nRj+qkLuIElk8sldSasPp/NSKofad/GikGmmlQ+rQHDNxxLPJOQ5gQw/qJaAuFKtU+xS
         i/DW3GLj2V1MfalSaa3iJNvwxCWEmQReah/J3+C+VqFxbCQeD4pucFyb3WrDldANR8HA
         8YWWkFVg+7TTaPVL9ay2wrJZUZOeou50SMQDK5t7e4VqNWozSj0d+rT0unmUK2WfMgLw
         5UAQ8WT9x8QScwXmP5aPjOQdbP8FW2IVwvPfcIJi+KRFFcszbfBtvxo9jLlhRNsH1yi9
         KZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=i2W71MrrzMNYcyB/z7lfhjSe/syd2lqbfSWnk+mqe6k=;
        b=X1QK25dY3p5uZDtPTYgvYtMrqgtJpgYe5X1vOpJkOgZg871NeNk8inWhtra3QHKwJN
         Q4WlbtIHB34iNjvgSmTW1rJU/ki1ql+tBn2adqcyxqDA0de3V8q9flQDd0WCR9qNKdCB
         yWP1eo7A9aTyLnU6r+kh7YY3KH32Da+b7tZdn/szxgBVzKrO2D66Np0NV31u8VnoSwn6
         Y2PpKtfEB2ReP2PzX9ke+Zm39JIjbtpMO3cKRWRP+etjJyxGY5sBmU1Y/Zt/0eOWVj2N
         sChIMMT8vZbK2Y2ppM/E/xyWbCGkJQhMO1X6NWAITvSrrqQ9xMav0EGn9K0YJz3+2DAR
         Hlxw==
X-Gm-Message-State: AOAM533EjCp9ldseSijx5D/XsgRTU9EqbEZuy50vNaHrIoU0DqUNuddH
        4DGyihI4+M5ngoZHAzAUoGcbsQ==
X-Google-Smtp-Source: ABdhPJycx615a/xlcejhPU3i6TW6bxV5D53F0plZu7u8/oXnECZBgQgnYzPAAWChPwnxp/0WDO63qQ==
X-Received: by 2002:a63:ff06:: with SMTP id k6mr2295126pgi.321.1599844232413;
        Fri, 11 Sep 2020 10:10:32 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id z28sm3161139pfq.81.2020.09.11.10.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 10:10:31 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] clk: meson: axg: add Video Clocks
In-Reply-To: <6132edc1-0256-8eca-d5fd-8870aed5bb60@baylibre.com>
References: <20200907093810.6585-1-narmstrong@baylibre.com> <20200907093810.6585-4-narmstrong@baylibre.com> <1jy2li9bym.fsf@starbuckisacylon.baylibre.com> <6132edc1-0256-8eca-d5fd-8870aed5bb60@baylibre.com>
Date:   Fri, 11 Sep 2020 10:10:31 -0700
Message-ID: <7hr1r8xmrc.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 10/09/2020 12:13, Jerome Brunet wrote:

[...]

>> Why is NOCACHE ? Is there something poking behind CCF back ? if yes, why
>> is this required ?
>
> I'm surprised you ask this since the situation hasn't changed since I pushed the
> video clock for GXBB, then G12A.

Even if the situation hasn't changed, providing context is very helpful
for new reviewers or reviewers who might need a reminder of that
situation.  I for one had already forgotten the video clock context so I
had a similiar question as Jerome when I saw the NOCACHE and UNUSED
flags.

As you know, new usage of those flags is always highly scrutinized, so
providing the right context and explanation, even if it's repeating
stuff you've stated elsewhere, can help preempt any questions.  

> The switch to CCF for the VPU is still planned, but until now I was unable to allocate enough
> time for this huge rework.
>
> Since I'm the single DRM driver contributor and lacking any other reviewers, I must deal
> with new features & bugfixing before moving to CCF.

Not at all a blocker for this patch, but just curious do you have a TODO
list someplace for this driver in case others might have some time to
help you with the migration?

> The clock situation is far from perfect, and I'd also like it to be solved at some point.
>
> I'll add the same explanation I gave for GXBB in https://lkml.kernel.org/r/1541516257-16157-5-git-send-email-narmstrong@baylibre.com

Yes, that's perfect.

Thanks,

Kevin
