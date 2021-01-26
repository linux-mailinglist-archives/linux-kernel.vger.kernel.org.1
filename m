Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A754B303A4A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403955AbhAZKaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730742AbhAZBeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 20:34:10 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C21C061D73
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 17:17:07 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id d85so14546593qkg.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 17:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iTavl0VgMJvSYqDsCHP0wBBio9EmuwiZWD/zN+VknWM=;
        b=HzjqTdtVEGo6W3GrGsERqrtVZB0WSso8NuaqTqthaqxWbDJ0ekSKFKhFmS/QNCciln
         OXzbSMAPY08eLErJk+yDH8Dg8ku5hz0xmlt93lHMP8/V2TUhFwtIOE+vR1R7O4qJPW8u
         53gRhEgugf6xAVhXvSKMU9a4FMoX64XxclVUXJoh0CRRBRdZ5CxNdFg5TsH70iINLn0y
         gOKKhsRMglBqGzuLyZmCNxWawb67lP27fHQ0yOLRqcxTncuzg+hnA4iCyF0BiYhppiDo
         jxTc+pqrATQu3DcAfhCdn0LHcBJIJS6HN3E2AA1+6ZbvuJxFLm5ohXmJdUfb69DGO24p
         UBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=iTavl0VgMJvSYqDsCHP0wBBio9EmuwiZWD/zN+VknWM=;
        b=uJzSCLUwetd3kD1OcfSf0FJ7wB914A6DdJ42QZ7wZ9FYH2KSM5SgWfOI+N12KN14l2
         MmItZEiBTwuWVuRPLPKXnvpv8k5sefW7rhOOJSOpsXdcLuJADzQ7DHBgk86lrSJnjp1X
         iDkSVqKJ+EmkFEeOMLSykkjMRHVXkQurVWFzw0RzZ2LKX2D0wGDahwR1GgGEvtTFfx43
         L3L7EL7Wyp/mu41iWAiFQ0dRYXwO2W+QsGwN8v80ktWXjL7KSaF64qoNaZ0RBZJ3kNqA
         HHU8dKdmwPiAJM4fXqnr+F7qEdwCDS9YqOIfNg7sbOtSdxHklTrRUVLWSonnxzHWc9x6
         DIXQ==
X-Gm-Message-State: AOAM532aCKWKSypm+FgWxDQRQDrC3o/meRlbiCHL4YFvbj5NjRx/Ixnu
        +76bJYABS7iKMKIrfi6/lzk=
X-Google-Smtp-Source: ABdhPJwzlmGDq2tFydYTNaMJa/ZoMqmET9HNbp0b/2nJELqJXzGNTdqWkwmQbTYEUTkad2+dJyFttQ==
X-Received: by 2002:a05:620a:2ed:: with SMTP id a13mr3703744qko.226.1611623826752;
        Mon, 25 Jan 2021 17:17:06 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id j11sm2671469qkm.47.2021.01.25.17.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 17:17:05 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 25 Jan 2021 20:17:07 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Saravanan D <saravanand@outlook.com>, x86@kernel.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] x86/mm: Tracking linear mapping split events since boot
Message-ID: <YA9tk7Tnp2AEEcCU@slm.duckdns.org>
References: <BYAPR01MB40856478D5BE74CB6A7D5578CFBD9@BYAPR01MB4085.prod.exchangelabs.com>
 <30752f8e-16e9-d093-e6ec-31fd45715e9d@intel.com>
 <YA8q3eSTuIrUmPeM@slm.duckdns.org>
 <0d402da9-d7a2-a3b4-eb6f-bd1b768b3a85@intel.com>
 <YA9oD2djENLo4975@slm.duckdns.org>
 <bd157a11-8e6b-5f44-4d91-d99adb9f8686@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd157a11-8e6b-5f44-4d91-d99adb9f8686@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Jan 25, 2021 at 05:04:00PM -0800, Dave Hansen wrote:
> Which part?  Large production environments don't trust data from
> debugfs?  Or don't trust it if it might have been reset?

When the last reset was. Not saying it's impossible or anything but in
general it's a lot better to have the counters to be monotonically
increasing with time/event stamped markers than the counters themselves
getting reset or modified in other ways because the ownership of a specific
counter might not be obvious to everyone and accidents and mistakes happen.

Note that the "time/event stamped markers" above don't need to and shouldn't
be in the kernel. It can be managed by whoever that wants to monitor a given
time period and there can be any number of them.

> You could stick the "reset" switch in debugfs, and dump something out in
> dmesg like we do for /proc/sys/vm/drop_caches so it's not a surprise
> that it happened.

Processing dmesgs can work too but isn't particularly reliable or scalable.

> BTW, counts of *events* don't really belong in meminfo.  These really do
> belong in /proc/vmstat if anything.

Oh yeah, I don't have a strong opinion on where the counters should go.

Thanks.

-- 
tejun
