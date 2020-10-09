Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF7B28811B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 06:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730401AbgJIEWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 00:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbgJIEWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 00:22:40 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22965C0613D4
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 21:22:40 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f19so5763670pfj.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 21:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PjnOonUUls/Q3sJVeGfY8/b+Yqks6A+Nf0QuNi4LvIg=;
        b=VllFt2pYHjS/E3CftH/OakusB6TnaiSugFj3gJ+Fd4ek6LLLulCehIIUGatwl8tExU
         7GGLuKWBRWZnSlbLXaZGY8MI+o06p0aILZJIkB3jwrzyYaz2bmo4Xrr3aa4Fp6XjPKRa
         xvMDvKedgoNA3g1JHIjtCtwSM4or8q4b9dvDiylSlerzhfg8TfYGKTXGsn/HJLj/ADn4
         u9s9i92rn9juXWg1H/r+31ip+dQEWP7cloXYyhbw9kmVITfzMRIiB/RrrryXvidNpbFv
         fu8jov7pEkNzfjZAAzJCivdc6TLESq0yrMO/aG0nnjmKOwHorf2SBhoTUlvfEESFY0S3
         eU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PjnOonUUls/Q3sJVeGfY8/b+Yqks6A+Nf0QuNi4LvIg=;
        b=F52zRqJ173xFVmtejUaMvg1U4wlTFDPki54DZFsXlCdyWdJJB3MFPDnCX/C2hyO83f
         av9rpKUDZ8k4SKtaLQ4iPghCCR/wshfJYfi1c1rS2Tbwqs/WEksJez5qKVBFmbKgZniy
         vktL7o3oU50sGdXBmM3fguoZdCvu1PkGDJOPHZzMXqad0q8lPXHKvnL3YLJ7V1ZKf2ct
         n8V0UkQ7o7kjFOf3H7XY7xzz6iU6dWa1vJC7qhfHG1/Rj0IqjitkshiSeYYwO3fQi4U9
         Z4Wnj4WJFeo1HdBx+HViEJNOLI6+m7NCGfxquO2YJsv7JiZ0mLMnszBPnArVNGhjKROd
         YBFg==
X-Gm-Message-State: AOAM532Nik09I7cyB1xqhQdOyovQvH7V/kVYCE/4w5z3k2rYi3Nh9rcn
        Ojp1/1BJl4g9CBz27/vzdPgtkQ==
X-Google-Smtp-Source: ABdhPJy6McBtpukPKmm2AnigAAC0Ed7LOfuVXSJ/3tCuWNZI+ahlAfo4Xcuo7BjSMvCZ3t/wqbd6cA==
X-Received: by 2002:a63:3747:: with SMTP id g7mr1971709pgn.190.1602217359558;
        Thu, 08 Oct 2020 21:22:39 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id z7sm8938226pgc.35.2020.10.08.21.22.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Oct 2020 21:22:38 -0700 (PDT)
Date:   Fri, 9 Oct 2020 09:52:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        ALKML <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh@kernel.org>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 0/4] mailbox: arm_mhu: Add ARM MHU doorbell controller
 driver
Message-ID: <20201009042237.yuumlyoiougygoqs@vireshk-i7>
References: <20201008191452.38672-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008191452.38672-1-sudeep.holla@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-10-20, 20:14, Sudeep Holla wrote:
> Hi,
> 
> These series adds ARM MHU doorbell controller driver based on the
> discussion[1]. The DT patches are just repost from Viresh's last posting[2]
> 
> Regards,
> Sudeep
> 
> v1[3]->v2:
> 	- No updates to binding patches(1-2)
> 	- Fixed memory leak and improved logic to find free channel reusing
> 	  mhu_db_mbox_to_channel as suggested by Jassi
> 
> [1] https://lore.kernel.org/r/20200909044618.deyx37pzocxiga7u@vireshk-i7
> [2] https://lore.kernel.org/r/3874de094d193a08624a00a35067a3237e0b42b1.1600249102.git.viresh.kumar@linaro.org
> [3] https://lore.kernel.org/r/20200928114445.19689-1-sudeep.holla@arm.com
> 
> Sudeep Holla (3):
>   dt-bindings: mailbox: add doorbell support to ARM MHU
>   mailbox: arm_mhu: Match only if compatible is "arm,mhu"
>   mailbox: arm_mhu: Add ARM MHU doorbell driver
> 
> Viresh Kumar (1):
>   dt-bindings: mailbox : arm,mhu: Convert to Json-schema
> 
>  .../devicetree/bindings/mailbox/arm,mhu.yaml  | 135 +++++++
>  .../devicetree/bindings/mailbox/arm-mhu.txt   |  43 ---
>  drivers/mailbox/Makefile                      |   2 +-
>  drivers/mailbox/arm_mhu.c                     |   3 +
>  drivers/mailbox/arm_mhu_db.c                  | 354 ++++++++++++++++++
>  5 files changed, 493 insertions(+), 44 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mailbox/arm-mhu.txt
>  create mode 100644 drivers/mailbox/arm_mhu_db.c

MAINTAINERS ?

-- 
viresh
