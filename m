Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1217B300590
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 15:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbhAVOfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 09:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbhAVObk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 09:31:40 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85207C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 06:31:00 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id s15so3255913plr.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 06:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=16Oq6hPfzYZOD2QSyxynAI/FEQLP+ZGXA1M3xH+bIqU=;
        b=uM5MCnfMgg3zSLWTyrtzBr/G3pvddXBY97152WnUTtXPdz2WvCDHVjBSQZvAlc7H/8
         A2EdlJPisiWHWYhBim2xikw+7GHCESkDCxg2gazoSN99GkH5+nGCYU9ESeFpC8uFzxPT
         M2U/awVJYzK9D1KoB7nHqP0NUiHRlFAAPj3+12yed0wdY2PjnAO8IClM/5F0p+I3h+4i
         8joO3UVEJGBAeiMJb/6kujZzegz94gPbNAjyBefjChsnLzhlujqEfDrwH7nH0tbbhmNb
         U/Wu3vkVeRbDIJJmQtCky7xg/4EfVYNMig3taFxyA8PyFYBp4MscsomhUB7FDhTHYlmO
         TB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=16Oq6hPfzYZOD2QSyxynAI/FEQLP+ZGXA1M3xH+bIqU=;
        b=pUI4cGqxNE+KetPABSOL3FEQTXROzYtG7XeoLIPZiaE5DYrllnOPGAe/RlyYzrooV7
         F2G3m6E8tSAYXTSGXegs2r/dJV6/DoH+zhGui2+v0r8PpKRjduNolP1SlmqS+os2HZ4V
         CNkGBReGlCfwaE+Dm1W3PTaDSKbiz+OEcfg7eOSZFMv7VL+MikTVAmCwcKip+VPFdEtP
         2nHkgLSd5S4yRnUKESBFBdaXhOqfzIRUhCzInYyEvweVu9w4A2Fk8b4A3PXtV0lzQHmb
         pOH72pY07Rlxu1sKy+IfvrnnlsOoddZ++qNxs55fKdSwTz0u3RDjdutDQexrrOcJy7hd
         pYCQ==
X-Gm-Message-State: AOAM532HixU4B9pgCSoco0BVu4KSpmnJj7C3i0d7IFQkZEs5Ei+HInlW
        tgPnCVAjResBNAgAXo2rP+Bo+g==
X-Google-Smtp-Source: ABdhPJy992uyk/UUaI8AYSj1lvx5f7pPzprAAT6xcNbEGxC7l7N+halNfhBizULxbJbvCfQhIHYjWw==
X-Received: by 2002:a17:90a:6809:: with SMTP id p9mr5591523pjj.112.1611325859427;
        Fri, 22 Jan 2021 06:30:59 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([64.120.119.108])
        by smtp.gmail.com with ESMTPSA id kr9sm9836616pjb.0.2021.01.22.06.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 06:30:58 -0800 (PST)
Date:   Fri, 22 Jan 2021 22:30:52 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Al Grant <al.grant@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Wei Li <liwei391@huawei.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/8] perf arm-spe: Enable sample type PERF_SAMPLE_DATA_SRC
Message-ID: <20210122143052.GD4976@leoy-ThinkPad-X240s>
References: <20210119144658.793-1-james.clark@arm.com>
 <20210122125157.GG356537@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122125157.GG356537@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Fri, Jan 22, 2021 at 09:51:57AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jan 19, 2021 at 04:46:51PM +0200, James Clark escreveu:
> > From: Leo Yan <leo.yan@linaro.org>
> > 
> > This patch is to enable sample type PERF_SAMPLE_DATA_SRC for Arm SPE in
> > the perf data, when output the tracing data, it tells tools that it
> > contains data source in the memory event.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > Signed-off-by: James Clark <james.clark@arm.com>
> 
> I see two Signed-off-by, ok, any Reviewed-by?

I had no confidence for some changes in the patch series, since James
is more easier to reach out hardware persons, so James kindly took over
and refined the patches (Thanks a lot!).

I hope Al could take a look for the patches, and myself also will give
a review and test for this series.

P.s. @James, I think some patches have been refactored, so it's good
to add "Co-developed-by:" tag or changing the author name for you.
Will comment on this when I review patches.

Thanks,
Leo
