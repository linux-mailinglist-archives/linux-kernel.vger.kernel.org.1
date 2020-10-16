Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536FA28FF09
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 09:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404570AbgJPHYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 03:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404529AbgJPHYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 03:24:08 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F74EC061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 00:24:07 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id j18so983526pfa.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 00:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6rJmZWsTC3tZunlzMkeAL6DveINrC2rCniEtmBwJZXY=;
        b=QJSTV0vmxfvJQ+ezN1zSW/4ZDFdXSn2/+t4oCXg78Y1zZrCuNGLvyPvs9iYf5Qvx/i
         XMcFDmFUdD72lSwDB+vrYJlCQ1+m2nqMPTMJtWGnSmHs4kmyOqARDhMCz3LZ7kj0ceyH
         61aR5GkEGi8OxyNjWNiGLyrooObfSzr4GflwEZfLibA1wtZSb/muQx7Ps6I50NdiDTzp
         aUCWio+mlTbSbDIZdjOTg7Qzf6N8CrYvhxJDkn34SvbIAO1CKnlDyCb8dHLwECrp0to7
         Iibo76lGBXZyYe9WQMixuMZo6TqOAqA3+EOlzrPzrcCIEEPmhjUUUS2A9iHctYSmMD7o
         k6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6rJmZWsTC3tZunlzMkeAL6DveINrC2rCniEtmBwJZXY=;
        b=ENCXHmciiJVDGfUHlsgRxig3ustb8+NZV8MwATe/rpQ3vwVwNJuBhnk3QDR5ZGOYn3
         HiMJ/m7NsRh/5VGTSX7vDrVm6n9z+3TIeKSvO3TzTzsSVteYuJ374zIkwUzfe9KNkafa
         oOzVXvFdRnJpFCqfZlfZ5NI3D2we0v7aBSglj6pa+E/0eWxAsIjXi1nrcpZTQlnKlfU2
         7ITNMPGHSC+loTb8uc6VT33dgacJc4h+x9txtSS15LCYMTxqvIZ6nCVN4Ra0tq5+FZSn
         JA4Jhw/68wXku/quNjQHLVRZV76lkGh7iRLlzTFEs/OFxwmeOMqd2+cRDkZho5gX6Qvr
         dXew==
X-Gm-Message-State: AOAM5314R2i5PCA/9gP6uTmYKJUtyWFvds6hPVAMVPiEYiQcgb6j/tUZ
        HV+7fPmHNaFDFWvEopfK33SFt1vDmCW+ULHk
X-Google-Smtp-Source: ABdhPJwUWPGICoFq9SFicWYImHXUPoyuhFpWAGUJwIWPJ+ED/XYFz6/H/JF/bR5CuhfixOWgV5UDqw==
X-Received: by 2002:a62:37c4:0:b029:155:ebd8:304c with SMTP id e187-20020a6237c40000b0290155ebd8304cmr2585815pfa.73.1602833046302;
        Fri, 16 Oct 2020 00:24:06 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([64.120.119.108])
        by smtp.gmail.com with ESMTPSA id c15sm1586586pgg.77.2020.10.16.00.24.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Oct 2020 00:24:05 -0700 (PDT)
Date:   Fri, 16 Oct 2020 15:24:01 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Denis Nikitin <denik@chromium.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH] coresight: etm4x: Add config to exclude kernel mode
 tracing
Message-ID: <20201016072401.GC4646@leoy-ThinkPad-X240s>
References: <20201015124522.1876-1-saiprakash.ranjan@codeaurora.org>
 <20201015160257.GA1450102@xps15>
 <CADDJ8CXS8gGuXL45vR6xiHwJhZNcUJPvHMVYSGR6LDETRPJFiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADDJ8CXS8gGuXL45vR6xiHwJhZNcUJPvHMVYSGR6LDETRPJFiQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 11:40:05PM -0700, Denis Nikitin wrote:
> Hi Mathieu,
> 
> I think one of the use cases could be VMs.
> Is there isolation between EL1 guest kernels which we can control from perf
> in a system wide mode?

Sorry for suddenly jumping in.

For KVM, I think we need to implement mechanism for saving/restoring
CoreSight context for every guest OS, the CPU PMUs has implemented
related features [1].

Thanks,
Leo

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/kvm/pmu.c
