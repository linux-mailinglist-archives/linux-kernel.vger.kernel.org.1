Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256002FED84
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 15:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbhAUOwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 09:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731020AbhAUOvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 09:51:03 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91058C061756
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 06:50:23 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id 31so1391159plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 06:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A6/bA1MgplZUG26J8G5Fe59NQfim1BcuRy5CK9gZx1U=;
        b=Fy4+3Ag3HLw5h41R0aJPqvEEDeIBHVKxNIYfA7ZgLQcBVuTi/skbW1/6nyy+eMsI1b
         PbiNvWBLFObZH6xgWZbEcLgOih+Dfiqg/2wco7WZuJ0zJqdUauaWQfGGclFPPGgd1DMW
         jImQv9/vqz1i7+0lYNsKNXjlspGE2HLu2BaF099X9T66EOeeYYYTMSUbP9hFTfaIjahx
         Qr6iv8p/N4O6y4Mh9vFwenhn/yhpV/SUo1p9brFpAplLvTDtrvJHuRx2V502FBkzGi6A
         WJKMWy2fy1x6dtcqSIeI4eHLqHvm+mTdMxYREKtokwNVaGVyq27uMAaDM75yMeO7yM3g
         QlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A6/bA1MgplZUG26J8G5Fe59NQfim1BcuRy5CK9gZx1U=;
        b=at/zx42O3c446wiMd4LsjDFArJevjN/Of3v7QLOd9+A/7M+4ZHLnkXk3maN2sPSJM4
         qbjieXPU6+jTR8nECTZDACgoM6cds8A3miEoueU0inYjce7akjhlez6Jmk1gbQhdgUHK
         9VabuMmkosPEoc41ZfUbtD0B3ch0bqkHFM1ZfOrq3cVBzw6RexmiZ5AOSUXpsJrtL5Qc
         GzDhfM2YZhxYwkzjTQ0iEHQe/SmTsaambMCaUETLuwmZpia2CoczNLHMYLPbAEfZ6rK/
         6NaRldBlAvogyQ9SmAGB9ewComr9xpG3RFfk1U6WXAKcAHoVx7ruM+7QtP8UqFlkL+c+
         7jkg==
X-Gm-Message-State: AOAM531vz5ZKpPMNWGHJ+7eyNcyewXX6RZABDEAleg5Xj3RCek9T7FQZ
        qFKVyBo1a+8HUw3uU7+K3JKm
X-Google-Smtp-Source: ABdhPJxNYAJ9GhFAWoHDUq/s5lhwjbtg58T00xGm5r0pJVsZWTtt+NuJ4fCgvN9vovCU/LKam1xLuQ==
X-Received: by 2002:a17:90b:182:: with SMTP id t2mr12712899pjs.50.1611240623014;
        Thu, 21 Jan 2021 06:50:23 -0800 (PST)
Received: from work ([103.77.37.184])
        by smtp.gmail.com with ESMTPSA id c85sm5787366pfb.37.2021.01.21.06.50.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jan 2021 06:50:21 -0800 (PST)
Date:   Thu, 21 Jan 2021 20:20:18 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org
Subject: Re: [PATCH v5 5/9] bus: mhi: core: Add support to stop or start
 channel data transfers
Message-ID: <20210121145018.GC5473@work>
References: <1610139297-36435-1-git-send-email-bbhatt@codeaurora.org>
 <1610139297-36435-6-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610139297-36435-6-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 12:54:53PM -0800, Bhaumik Bhatt wrote:
> Some MHI client drivers may want to request a pause or halt of
> data transfer activity on their channels. Support for this does
> not exist and must be introduced, wherein the channel context is
> not reset or cleared but only the STOP channel command is issued.
> This would need to be paired with an API that allows resuming the
> data transfer activity on channels by use of the START channel
> command. This API assumes that the context information is already
> setup. Enable this using two new APIs, mhi_start_transfer() and
> mhi_stop_transfer().
> 

Do you have any user for these APIs? If not then please post it when one
is available.

Thanks,
Mani
