Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A151C03BE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 19:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgD3RU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 13:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726355AbgD3RUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 13:20:55 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3527C035495
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 10:20:54 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z1so110106pfn.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 10:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OaoWzWV5VQdkXlx1W0mhM139g1iUDLV+um1kY+EVRdA=;
        b=mX/VUhlD5Z5dC1P65kSuNUE7hIcr4Kh/o+uBhm/q690m4TF+Ot8HGqz3wlGXLRZx1w
         GaII4K+11fo2JiO8nGIhZ45BA6l3W9HEoT6/BC+7k7ggmAeCMolqx7zjtjtg1LWMyU4Q
         8mGUONSEyM0r3moVIl7UB55iDJAmoo9a0cbix0IX7l8RJsdjZgjA5MMQgZ/cTL++yFjH
         WvAEL8s02KL3f+Hg2apCdJ7UEdGB3jj5YobUiV0V9/bfCntWnmjzY+fFpsJlr7XbAD4L
         OKDZu4xoh3+RjQZX3kSAUT0D8Fmd26ZIzt3joXLJIR0au3J7iuyClHxzfWIpQEze2XVC
         UTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OaoWzWV5VQdkXlx1W0mhM139g1iUDLV+um1kY+EVRdA=;
        b=Dw5zX4rStEreqNJCDEfYzyaV3FhZUvQkdQguEN/bUre6Rftxjg9jKzUZgRZJmP0zic
         5lX6HdKaXKGPlPvvMV091uHXaIkq7TgNPDbHcMwEd/dLzs6kFxh3zzmdGvvORFxgzgkG
         TFPN2nGx14NKw+jBAnpo7t31v+ogpT2fqmlorz6md/aPqJCusNATp4TaYMJw7mwO7qQ4
         5Y6C4puUJYt+0QA0hxFhlahx4IycXVxP/2FZqJnIB+SeG8yqdlUjJ5E+pG233xX5ulaA
         b82t8vEZ1xN+CtWMM66J4Bs6ZFKBsjySTKvwQ7rPMc1fnrphf2Ar68Jys4YNljdOFKAV
         fDBQ==
X-Gm-Message-State: AGi0PubVOLuEL8jIQy1tVFg/MUs8iGEfPU4PP3U5hwVnqzdHqoZvZsQh
        Dq17DJSbHaxj4i2IiX96Ab0S
X-Google-Smtp-Source: APiQypIFGoYKRmXCKaIropj/Nb4pYx44aEvNe68yMeW1wIRAxBHaoAvIr159kwiS4aSfJ9JlX1R0KQ==
X-Received: by 2002:a63:6f82:: with SMTP id k124mr1258152pgc.278.1588267253330;
        Thu, 30 Apr 2020 10:20:53 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6081:946c:419e:a71:7237:1613])
        by smtp.gmail.com with ESMTPSA id k4sm290920pgg.88.2020.04.30.10.20.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Apr 2020 10:20:52 -0700 (PDT)
Date:   Thu, 30 Apr 2020 22:50:47 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] Misc MHI fixes
Message-ID: <20200430172047.GI9449@Mani-XPS-13-9360>
References: <1588003153-13139-1-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588003153-13139-1-git-send-email-jhugo@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On Mon, Apr 27, 2020 at 09:59:07AM -0600, Jeffrey Hugo wrote:
> A few (independent) fixes to the MHI bus for issues that I have come across
> while developing against the mainline code.
> 
> v3:
> -reorder series to put changes which are ready, based on reviews, in front
> -change error from EIO to ETIMEDOUT when sync_power_up fails
> -add change to correct a conflict of channel device names
> 
> v2:
> -fix syserr reset log message
> -fix power up error check code style
> -add change to remove pci assumptions for register accesses
> -add comment typo fix
> 
> 
> Jeffrey Hugo (6):
>   bus: mhi: core: Make sure to powerdown if mhi_sync_power_up fails
>   bus: mhi: core: Remove link_status() callback
>   bus: mhi: core: Offload register accesses to the controller
>   bus: mhi: core: Fix typo in comment
>   bus: mhi: core: Handle syserr during power_up
>   bus: mhi: core: Fix channel device name conflict
> 

I'll queue all these patches except [5/6] to mhi-next branch and also send
them along with one of my fix to Greg to be included in upcoming RC.

Thanks,
Mani

>  drivers/bus/mhi/core/init.c     |  7 +++----
>  drivers/bus/mhi/core/internal.h |  3 ---
>  drivers/bus/mhi/core/main.c     | 16 ++++------------
>  drivers/bus/mhi/core/pm.c       | 26 +++++++++++++++++++++++++-
>  include/linux/mhi.h             | 10 +++++++---
>  5 files changed, 39 insertions(+), 23 deletions(-)
> 
> -- 
> Qualcomm Technologies, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.
