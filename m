Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D1826E9F5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 02:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgIRAcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 20:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgIRAcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 20:32:23 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080E9C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 17:32:22 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id bd2so2034881plb.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 17:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1/kfi2E3nenb9HO+wEapXw+2tJYGOOUMEBKUiJkUM4w=;
        b=RYw8dtrcrNqqjNgOEQE6G8Nf94ysTiU53kwId9MA9TBwyEx3E6KnyUEEp9tuOrRiEL
         uxIN8Oo5kOy9lc9yFnyHJAaUyeSrs6h+ffyjOvWSr6V4Yx/7uNqkemQv7ueLmeKf9LhS
         gEqLLYlHfcGFys/RM2P4ecG3yMbkQwL2KF/eivThbtdQZ19zvnkh+a0Ol9x6td+rZRbh
         +6gPz/lwuTCn2L4emyW7IquA92sg/Ah+RQs0jtEtAk8VgXDLP9z6QVGA3UoghYdzTp9Z
         HbZlnGKZLZUM//mD8PtP5Pbf7EmoVRb35l9Ore3gLQXM5s3Xa6mjYV0wbnKvkIFhhVaN
         nvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1/kfi2E3nenb9HO+wEapXw+2tJYGOOUMEBKUiJkUM4w=;
        b=ggLKUGfcupL+06uXwe/dcbZdG4iecW5DgiC4yNstYTLKF0juHX+5rud8HIMAp+WKGR
         y7t/PRGT7wKTo/O27ogh2E0VrRz4RmCFYVhPSFIlHRwk6ipX/d0MIpTqJ2Le9a37oa9s
         /Wi1GkE2vmVJjJ/mhLLjK/aE9VsUbZkrH169OfvsAgzTuxG0uoITr2LbNHDF2LqW6bfe
         Zbp3QVkxdnnTh4woEUHUiCkvFvNdBCzqFzNLpxCkAC2PisPgwfaLBU7DdGgs/Cbh6d9W
         kLVSsfBfhqINvJ2Z+dClvFW1Fa/7SNArDBkdpQx66/6NCkkWWBHeWSsJj7jtJl6+yHbK
         uClQ==
X-Gm-Message-State: AOAM533C7239AaYbZjSkvW/tdif+WT7ls4CjJtNxGGHO5bZqXtqLo8ff
        a5B9O75SLfJmLLgrfuxM5fA=
X-Google-Smtp-Source: ABdhPJwuNjsTejgWhMBUP5Bw+QzqBxqdPHyPl4gno5AOB06+jdW06Ehf61wM9opeMP8ZF2WdFB0Glw==
X-Received: by 2002:a17:902:aa91:b029:d1:f8be:ac74 with SMTP id d17-20020a170902aa91b02900d1f8beac74mr5467178plr.39.1600389142139;
        Thu, 17 Sep 2020 17:32:22 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id d128sm872680pfc.8.2020.09.17.17.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 17:32:20 -0700 (PDT)
Date:   Fri, 18 Sep 2020 09:32:19 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv3] perf kvm: add kvm-stat for arm64
Message-ID: <20200918003219.GC3049@jagdpanzerIV.localdomain>
References: <20200917003645.689665-1-sergey.senozhatsky@gmail.com>
 <20200917100950.GC12548@leoy-ThinkPad-X240s>
 <20200917101219.GD12548@leoy-ThinkPad-X240s>
 <652f10660f09bd608b825233713f775a@kernel.org>
 <20200917114231.GE12548@leoy-ThinkPad-X240s>
 <ca309fcda71944455a8c6c1b308886ba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca309fcda71944455a8c6c1b308886ba@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/09/17 12:53), Marc Zyngier wrote:
> Feel free to add a *new* tracepoint instead.

Wouldn't we want a whole bunch of new tracepoints in this case?
(almost all of the existing ones with the extra vcpu_id field).
Right now we have 3 types of events:
- events with no vcpu at all        // nil
- events with vcpu_pc               // "0x%016lx", __entry->vcpu_pc
- events with (void *)vcpu          // "vcpu: %p", __entry->vcpu

It might be helpful if we could filter out events by vcpu_id.
But this, basically, doubles the number of events in the ringbuffer.

	-ss
