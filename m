Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC7F2FAB5D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 21:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437893AbhARUYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 15:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbhARUYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 15:24:37 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D558C061574
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 12:23:57 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id h10so10837533pfo.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 12:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PRwPVFLZbO3DnAQ42ccV130KeMHAu1TzeUayWROwv/U=;
        b=D2VzllMwI2rSMF3fX1njbMFiKbfDpQ3IXRCYQgDbNGdf1yPZ150jNDDBeTZ+3rw+P2
         5FnicS/fv346tnbPPjPFrElvpO4GK/EpxP39jG8NBTLBAGGP/hPE33tHcwGdcEesVXlt
         G8liJ4Y7tDRNrqjMdNcP4RQoQ5Oytb2eoShFWME3gd1RaE8PrsGULM+jnSEOK3HIZce4
         JmbvAKFS56TNaJj6y6eUWun9j6i2uLH9fusqwr9RscqhgmF5FGkyhquxgXrAaDb8k6y4
         MAuYwzp0Myr0wGHUZzPbT4Nb1OU3+szJhcUoaMr+09LjodIERu1H1iPD84VKmY8eg4gN
         lTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PRwPVFLZbO3DnAQ42ccV130KeMHAu1TzeUayWROwv/U=;
        b=YFke1H/sAqgIrAvwNGBR19XpHcci6oO4FyMSDZO/xjRNAcQo/yPjhfOHW11kS/xYOD
         R0mhVS1OZvZxpA7BXHEpnEmrluuS2BWTjq0hDYORTxOq42ddDopt05BJSF5zaKZ+Kd7G
         DL+SYg0QaS6rUUaS2SCUD4Hu0McmbNDDGCQT0/lCHnz1ncUJxAUP508O+irSO3+eZ3Oi
         pgikogUI1JYgR5E8VKJykzeJDe4LMZeb6BdRk9SJcPy4q6AB8K655tUs6nP6Acn9INCw
         ufox3JAjjumwmwPJj2Dr8ZvgbSGADvqma3tfmDbFcw+E26qtd+YoCTH5Tkb7lXkp7mha
         zM0g==
X-Gm-Message-State: AOAM530dy2tK7tKuUfUPgz1uIK7u+N5bL6zKcJhWAYyufpmuVagTeICb
        xHuZJi+zCILrEEIM7cs0p7nhJQ==
X-Google-Smtp-Source: ABdhPJy+XiAne7fTflPqmQNXkPVAJW9nmT50Uu+iH1IjIiuVrMWcUoQzrZt24boa3WoZAdDT6VX/dg==
X-Received: by 2002:a63:c441:: with SMTP id m1mr1233168pgg.353.1611001437058;
        Mon, 18 Jan 2021 12:23:57 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id br21sm259184pjb.9.2021.01.18.12.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 12:23:56 -0800 (PST)
Date:   Mon, 18 Jan 2021 13:23:54 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        Stephen Boyd <swboyd@chromium.org>,
        Denis Nikitin <denik@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Al Grant <al.grant@arm.com>,
        leo.yan@linaro.org, mnissler@google.com
Subject: Re: [PATCH] coresight: etm4x: Add config to exclude kernel mode
 tracing
Message-ID: <20210118202354.GC464579@xps15>
References: <20201015124522.1876-1-saiprakash.ranjan@codeaurora.org>
 <20201015160257.GA1450102@xps15>
 <dd400fd7017a5d92b55880cf28378267@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd400fd7017a5d92b55880cf28378267@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 11:16:24AM +0530, Sai Prakash Ranjan wrote:
> Hello Mathieu, Suzuki
> 
> On 2020-10-15 21:32, Mathieu Poirier wrote:
> > On Thu, Oct 15, 2020 at 06:15:22PM +0530, Sai Prakash Ranjan wrote:
> > > On production systems with ETMs enabled, it is preferred to
> > > exclude kernel mode(NS EL1) tracing for security concerns and
> > > support only userspace(NS EL0) tracing. So provide an option
> > > via kconfig to exclude kernel mode tracing if it is required.
> > > This config is disabled by default and would not affect the
> > > current configuration which has both kernel and userspace
> > > tracing enabled by default.
> > > 
> > 
> > One requires root access (or be part of a special trace group) to be
> > able to use
> > the cs_etm PMU.  With this kind of elevated access restricting tracing
> > at EL1
> > provides little in terms of security.
> > 
> 
> Apart from the VM usecase discussed, I am told there are other
> security concerns here regarding need to exclude kernel mode tracing
> even for the privileged users/root. One such case being the ability
> to analyze cryptographic code execution since ETMs can record all
> branch instructions including timestamps in the kernel and there may
> be other cases as well which I may not be aware of and hence have
> added Denis and Mattias. Please let us know if you have any questions
> further regarding this not being a security concern.

Even if we were to apply this patch there are many ways to compromise a system
or get the kernel to reveal important information using the perf subsystem.  I
would perfer to tackle the problem at that level rather than concentrating on
coresight.

> 
> After this discussion, I would like to post a v2 based on Suzuki's
> feedback earlier. @Suzuki, I have a common config for ETM3 and ETM4
> but couldn't get much idea on how to implement it for Intel PTs, if
> you have any suggestions there, please do share or we can have this
> only for Coresight ETMs.
> 
> Thanks,
> Sai
> 
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
