Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05AEF28F55D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389501AbgJOOzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388086AbgJOOzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:55:47 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E19AC061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:55:46 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id j8so2211213pjy.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jKGNDvBuOCdT1yr1OAnStWIR39+3aQIsDj8WBAcZsDg=;
        b=RzBbuNX55AkV0knsLOkGF9hT+iQ6TA9uXEJvnoqlxSSxOGJJ89WDKDAAO/jjsyKqhO
         dixblUBWb8TfhnvOqW34Y5eI9bGggdwLzUABQftNtDgmuF8PgS96F1ziXoIU1GB+0Cl1
         y82qBiLhx26ZU/QaA24dFeqHNwDouXb+36dCjHeQyLWXB41F1zY11G5wzpWF8NJtuolP
         kZAOVxzer+TG9oFMfEZm5WITRtTRWe7OCofMGGqG2HN3X/xS8pnHznpClq5YSU7GXlTf
         PJrg9cElpgG48eyYGNOgJkxPu0C04BgciMmsIzBVJFqx6hh+i1jRWc72mejrslWBwuDK
         KEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jKGNDvBuOCdT1yr1OAnStWIR39+3aQIsDj8WBAcZsDg=;
        b=ORMnEYkGTdKGMd1wRDp57gTmszgHcvjyOCXtNPE23X4Y+nhYpuqLdID9UjgmFByFJ2
         hcLMFj9sxFxElYuXaOKjOEEl4X2zNQtg/JCC4J89AOs+S7C6wfIhOEizY4vx6laIP8OY
         xN1KUc2ceW7mbvTpr1QwckksJ3orNiFGWduRUwO4vTdo7bim08TSHSanD3RiSbGjygHm
         W386AC1PYLacAjX/Bl06Zn7otdOsm2cFzsdoLc0AmyJ/LMU5oU5xwVWN5WnLXztB4MR4
         w5O13XxCjCN6NcspLLUk9GYpk/kz1TlQAkkBLhBZFTBAuLir+fG+1Qqzu/XTqjXxtogF
         A7gg==
X-Gm-Message-State: AOAM533WYMbrp9FjqVRTiO1+9VdAp3zgbH1Gzi0Mi344CX0SdWtalRxi
        cL2CY5LfBoLqmhuKUBoJ2A==
X-Google-Smtp-Source: ABdhPJzG/yJAmivQvWbT3J44c3W+PvWfg/FLqG8LS60pD3/iqP34CghyZ4gJrChbSxgQnEnvf7AzJQ==
X-Received: by 2002:a17:90a:d146:: with SMTP id t6mr4749223pjw.76.1602773745761;
        Thu, 15 Oct 2020 07:55:45 -0700 (PDT)
Received: from PWN ([161.117.80.159])
        by smtp.gmail.com with ESMTPSA id x30sm4390288pge.59.2020.10.15.07.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 07:55:45 -0700 (PDT)
Date:   Thu, 15 Oct 2020 10:55:38 -0400
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [git pull] drm next pull for 5.10-rc1
Message-ID: <20201015145538.GA277615@PWN>
References: <CAPM=9txyMmW1DWhS--SuYQu4qDK1GPzgHJwxbAfhHT=hUsPODA@mail.gmail.com>
 <20201015135932.GA277152@PWN>
 <CADnq5_PqhJFRDofb0pNsgrp7O8M_D9o3gz5_Nt8KL=0cgMWoKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnq5_PqhJFRDofb0pNsgrp7O8M_D9o3gz5_Nt8KL=0cgMWoKA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 10:53:28AM -0400, Alex Deucher wrote:
> On Thu, Oct 15, 2020 at 9:59 AM Peilin Ye <yepeilin.cs@gmail.com> wrote:
> > It has been applied to linux-next twice, for unknown reasons. Thank you!
> 
> The patch was already in drm-next, but since it was a bug fix it was
> applied it to 5.9 as well.

Ah, I see. Thank you for the explanation!

Peilin Ye

