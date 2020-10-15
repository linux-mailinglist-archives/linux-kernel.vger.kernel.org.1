Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8EAD28F57D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 17:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389433AbgJOPFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 11:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389051AbgJOPFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 11:05:22 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A923C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 08:05:22 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id 1so1778400ple.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 08:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8gjumdRh/ocuMSA9Qid4QCLcPTRKn0xY4g+6dquJoPQ=;
        b=nbFtZ+Ud7NDrMP223mQMGu4RVSAjeQvVQ42Ysok3HILl2rDGo5WZrJIRYFTkHI1YTU
         EXOWhc7pfwnGXA4Vb/zY0/zqHyORENCIEoz0QPoTeM5XOP4L2SnSFnnrXfAx+AfnR9Q6
         dU8gUrbGSzKmwU+Vd2FuGBiABvnDmG/M1ba8ZBFH9ebkS09F8fU0w0thg7dr++rwT1VZ
         EksPM+dRVj8w11571QA5v0Y64z8kGT22fPcqzcf5xGFXK83G93/9vht1ltcdfgMRL0dG
         GiJOI2QQggSQtwcaoRFe+uyWxxklTeUNZrDfLaVDSGJ12gq2KT+P1eDpGJikfy5Bu6IC
         o8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8gjumdRh/ocuMSA9Qid4QCLcPTRKn0xY4g+6dquJoPQ=;
        b=oRNB+91hZxMuZzRhPSBeGFrjBwAAKleZbwVsrdTY5aDa65/eu4F+R3Gibgz5/Nlvc5
         rDfpBp5wugEbCXmVpOWh2Img1Qh+rUBOVwKmulU0SHpHfy7ATpi3ys3HQ8HerzHrpopI
         gtLmV3gYKNC2YVmFmo4MjA2639MXSQiFoS54A9BI5YcNEbpjw4u79OWXDG1IDqdBX1sM
         8jfTqU+gdjZJi6yyTDr+S9KEyXtOaoRRX/0LRQOwGk+rcFzCyXc1Qdeb7PmAEOp0ToAU
         C2A2PTJXk6O4uYZY+47UNaG9TUz/MMOecgSEhaIKUnhOiPqfSPBsuk+aGZpON+ha9NgH
         heOg==
X-Gm-Message-State: AOAM532GUj2dCGTpp/V2NILKxcFa9FAODdc/ZwnF4ah6kzYzItmM4Tva
        0faXqxOjPVFWWLcPBjxGWJv7Hg==
X-Google-Smtp-Source: ABdhPJwj6R6f/mJKRA7obHS7YZqgn2fO+uSNOL3vmjTIWDQGLxfasMzhykghDFQRIIztCOyUcr5fHA==
X-Received: by 2002:a17:90a:a81:: with SMTP id 1mr4957171pjw.174.1602774300823;
        Thu, 15 Oct 2020 08:05:00 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([64.120.119.108])
        by smtp.gmail.com with ESMTPSA id p14sm3639345pjo.46.2020.10.15.08.04.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Oct 2020 08:04:58 -0700 (PDT)
Date:   Thu, 15 Oct 2020 23:04:48 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Joe Mario <jmario@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Al Grant <Al.Grant@arm.com>,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/8] perf c2c: Refine the organization of metrics
Message-ID: <20201015150448.GB462@leoy-ThinkPad-X240s>
References: <20201014050921.5591-1-leo.yan@linaro.org>
 <79f2db37-a03f-c01f-0b3b-4e2d3ed429f4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79f2db37-a03f-c01f-0b3b-4e2d3ed429f4@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Wed, Oct 14, 2020 at 02:38:19PM -0400, Joe Mario wrote:

[...]

> > This patch set is to refine metrics output organization.

[...]

> Hi Leo:
> I ran your patches through some perf c2c tests and it all looks good.  
> I agree the new format of the "Shared Data Cache Line Table" makes more sense now.  And it still holds together nicely when sorted on local HitMs (-d lcl).
> 
> Thank you for doing this.
> Joe
> 
> Tested-by: Joe Mario <jmario@redhat.com>

Thank you for quick response and testing.

I share the same thinking with Jiri that we should respect the existed
usages and habits of the tool, I was also a bit concern that my changes
might introduce inconvinence for others.  But it's great that receive
your agreement for the changes!

I have respinned the patch set v2 [1] with adding your test tag and
updated documentation; furthermore, I sent out another patch set for
enhancement perf c2c with sorting on LLC load hit, you are welcome to
reivew and comment on it [2].

Thanks,
Leo

[1] https://lore.kernel.org/patchwork/cover/1321499/
[2] https://lore.kernel.org/patchwork/cover/1321514/
