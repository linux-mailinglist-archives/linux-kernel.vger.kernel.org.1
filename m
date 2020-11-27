Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64AD82C6241
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 10:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgK0Jy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 04:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgK0Jy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 04:54:58 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0087DC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 01:54:57 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id r3so4940524wrt.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 01:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JjE5v+XtmXi4bhjUhwczYi8qu3IElsPJc6z70wBzRWs=;
        b=sfYOdVjRyzcbYRH/Ekm8wSub6oWEzdjbW2nDTAMnh+6ng+DbEs+mHTZUhXoUXiM0G/
         6hwWE5ZB2yeEMyCagbn48ngqnVd/Y5klQdMiAfN4mVSz+nY3HGFLtKuBtYX2clhCpvIG
         IuMvX40k0Uea4kH/0bOWOe35Y2bAVJs9VJ3/XgrZZsEVzh5EmsUsIr9iBr1J9hIIpQDR
         VvDvVN51IOVbbbe2X/suG6Ry3Slx41rPnME1ldpGZ+vwcCoSp4U8fYOSjwtj9jIHVz9v
         QCd6icNy7782CsjPEAlFmgSBNUV3YZN26AsSirMGaHi1jQF+cbbTSiArlLUnRo9sY/Z5
         tARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JjE5v+XtmXi4bhjUhwczYi8qu3IElsPJc6z70wBzRWs=;
        b=PTSEYIn+ySnqTEPkeO4cj8YL5sXs9GRzVXe9g4wvwiIWY4zzMd16pX7c8t2LntB3Pw
         NvUNwNLZCG0oeSTvQxX94Ua5jdY7S8Hqb1SODT6NDXA4JBrnX4s9U70ByB+CBDmXYog/
         1D6M05x8K/p2W058eBVyWYDi26A45eL3lAWAQ8F6B+vYyc2eX+IV+4w+yknZ2Xp4fwZn
         i9nw+hx0m5bg9i8YgsZSVuq1p3cn/3OIaSdTiEFCPFmxFpgVEZ5LZKhcefPEUxc739c1
         JC2RQ3CJZZSgtKuhFJvpHwKf1s9cMRM1yA+6f8szFFdol7hHizB4DANeCkFdQ1/I6+7/
         ITNw==
X-Gm-Message-State: AOAM532Wl10P5q1CkdKJSpz1c/nbHTH10/tgFKyRUAldXrpszTmiJC/m
        AGXWYMhy+b2r+gt7m3UfEVR0tqvmqq2gl7qG
X-Google-Smtp-Source: ABdhPJy8MKyha3Xk7UYSRiRLy3TVGJobBhb4KefTjlDXAMCo/TeSUVelqvExxjIfnbZXHjD1GJxklw==
X-Received: by 2002:adf:dd52:: with SMTP id u18mr9079635wrm.44.1606470896481;
        Fri, 27 Nov 2020 01:54:56 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id j127sm14205428wma.31.2020.11.27.01.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 01:54:56 -0800 (PST)
Date:   Fri, 27 Nov 2020 09:54:52 +0000
From:   Quentin Perret <qperret@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v4 11/14] sched: Reject CPU affinity changes based on
 arch_task_cpu_possible_mask()
Message-ID: <20201127095452.GB906877@google.com>
References: <20201124155039.13804-1-will@kernel.org>
 <20201124155039.13804-12-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124155039.13804-12-will@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 Nov 2020 at 15:50:36 (+0000), Will Deacon wrote:
> Reject explicit requests to change the affinity mask of a task via
> set_cpus_allowed_ptr() if the requested mask is not a subset of the
> mask returned by arch_task_cpu_possible_mask(). This ensures that the
> 'cpus_mask' for a given task cannot contain CPUs which are incapable of
> executing it, except in cases where the affinity is forced.

I guess mentioning here (or as a comment) the 'funny' behaviour we get
with cpusets wouldn't hurt. But this is a sensible patch nonetheless so:

Reviewed-by: Quentin Perret <qperret@google.com>

Thanks,
Quentin
