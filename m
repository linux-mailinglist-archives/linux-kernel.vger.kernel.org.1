Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5631E81C8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 17:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgE2P1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 11:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbgE2P1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 11:27:54 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0192C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 08:27:54 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id u5so1634493pgn.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 08:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eYqsk8EYMXFjKbFUisk5DVXR1QCtW18pOaaV45Slo/A=;
        b=KivjD9nhmWtwYawxLYk6qBdQTHYXWp3zHndRv/HiMON9bOf5CJXXiXgDFGmXb/e4vo
         n4Ooi/YIOfdpbEtsfB1rn+rqMkinBihk8+V4IPqrQGTvssJqXXSBcn882MsV6T7+jqQq
         a9VMJ/IhObktca5zB2cjCgYnKLC83hTmh5oSCUWcTD8b6lBDX8wCRz0rJ4rK2wHR5d+2
         iXnbFfCduWqECx6Lku0nuSg8et4hBdtGKO7bW7Oc/ZLwETv2pNINI9lDmcN/2JJrdxZf
         XzgnUvmrXaC2SkHJpVIHAje2u5t+NTMsYpehkPdYldxb39etlhp1+h42/P84mg7YmjDX
         j+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eYqsk8EYMXFjKbFUisk5DVXR1QCtW18pOaaV45Slo/A=;
        b=bNnUHxNzuksQTkOj4xasb3m2L6OjQUhSwX/cf/tEF+T94wqsGyKcjz/vQuxmz05+xK
         QzPsTBQTyULTPp5Uh1zXFRCl4/H8EuItcO9iQThVjZ0NsTUiO1/0XOMCmO9PwAaDTbpx
         9vRtZaxH10Nu2kt2TB2g7LCq1kwNTAudDuuYqoHZvrDkp/g3COaI/JT27ORuc4p15WSq
         b2t3G7nwlufVtJrHMF2lHctdRuSd+2IQwHsVDuRdpWOkbraqHoUmsr/MO3YnzEiQ/eeA
         2NMSINUVngx0/66LPeX1jtggxsRSdyJ9uQV8FWu0hawTiip5e8b/lggT2GTRCZBAtwIl
         ZV2Q==
X-Gm-Message-State: AOAM53358SV/LwnqCraIVBdGEDnw/BXhrhYdQ5s7rNDvta0w7mm7BT5h
        SpZQ8/HZTguiO/BVUflr89a1gw==
X-Google-Smtp-Source: ABdhPJyy9xeZPRtpmoSn/oYS8ASvUkT0b87mayN7sK/FJBgTr8JXwM96p5G0EjaDIdup+fk2q1acCA==
X-Received: by 2002:a62:1c42:: with SMTP id c63mr8015263pfc.293.1590766074079;
        Fri, 29 May 2020 08:27:54 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id b4sm229186pfg.75.2020.05.29.08.27.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 May 2020 08:27:53 -0700 (PDT)
Date:   Fri, 29 May 2020 23:28:01 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Al Grant <al.grant@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH v7 0/3] perf arm-spe: Add support for synthetic events
Message-ID: <20200529152800.GB21552@leoy-ThinkPad-X240s>
References: <20200504115625.12589-1-leo.yan@linaro.org>
 <20200522030919.GE32389@leoy-ThinkPad-X240s>
 <20200526102602.GA27166@willie-the-truck>
 <20200526104337.GA7154@leoy-ThinkPad-X240s>
 <20200526195438.GC2206@willie-the-truck>
 <3a80a66f-b991-ec55-77a5-a8fc4fa69e5e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a80a66f-b991-ec55-77a5-a8fc4fa69e5e@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Fri, May 29, 2020 at 03:58:23PM +0100, James Clark wrote:
> Hi Will and Leo,
> 
> I've tested this on an Arm N1 machine and it looks good to me.

This is great!  Will respin the new patch set with adding your test tag
and send to ML.  Thanks a lot for the effort.

Hi Will, Arnaldo, sorry for late replying you due to other works and
thanks for suggestions in other emails.

Leo
