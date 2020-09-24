Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D71A27728C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 15:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgIXNhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 09:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbgIXNhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 09:37:33 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5016BC0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 06:37:33 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e2so3649525wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 06:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tnbVYVydzTndZjHx54L+pKVp5ROdQOJCG9ZC1h7UrbQ=;
        b=wR16WBUvPW96FpFtNzjiQzudOIawwDkmbPXXQ2ZfBCOvV+OQ0LL26RP3gMyMs3Ulik
         rAT4HnKQy0XijG3Ov8PnZ3IzN02enYl40WUrUr7LPjbUu1wcViOPWbIsHZCq6B4mco+l
         Zqk79ET7GhMre4uK959OlDNxJ31fRHLVICBfdmn9nQT2Ra4UDMhfNdeAI28pV+LJFH8g
         6+iADeDCPC55ZtVpJBALUHviKDXjKW93owC3+D32VYsjTdL2ictDyLVs12o+e0pr3mFU
         0+LLcBsUQlhVJW5gTocCENwGrZM5hCURgpLMU2Zw06tVErESPgv6t8/qvuyLXhF9Mnnf
         6s1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tnbVYVydzTndZjHx54L+pKVp5ROdQOJCG9ZC1h7UrbQ=;
        b=Rx6tM13GRH8WAI7RZjK5AzSI7cerUOrojeHCnjEkamG1IMqgGO2RSwdCyv5aLVx9J2
         vWlfdT8wG3iOpPeglOLpVtL8wJ9Kd9CvjfN/OcPXRFku2Hd91O1cuWqnp9aztfTG0OVC
         JVP4Su9Q8JkFslig9NE1vOix6wdZWW/y2hkWMhE4PeGwXPin/HSVKbGXJlkKa2pmpbB/
         199fgXetSGIO6jynxNOznrGt/Ad1f/16uN4fOScLrrn7+oPj8EuNsE1VLxloOb1FjOgM
         S+tP1n6uqMVUd3EPk6mDnP//ePkTUXPdo4XU1+6qYR2Ks4Hx15hb0WFyDZfUMciWz9t3
         4LQQ==
X-Gm-Message-State: AOAM531JEcVhEywkhKA+Chkxgo83/9h+nLk7n7XG+OFbJd7QZP9VYlo9
        hByZwLHnIcWW9mQP3HGOTiOU+Q==
X-Google-Smtp-Source: ABdhPJyeiAxCwP3APzpEwu31OqsdL0w0TL03OQ5W9+90C2WYE080DSWXdPSO/EIHJ4vPJaAwLMSNIA==
X-Received: by 2002:a1c:19c1:: with SMTP id 184mr5103148wmz.114.1600954651863;
        Thu, 24 Sep 2020 06:37:31 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id o15sm3423479wmh.29.2020.09.24.06.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 06:37:31 -0700 (PDT)
Date:   Thu, 24 Sep 2020 14:37:27 +0100
From:   Quentin Perret <qperret@google.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, dietmar.eggemann@arm.com,
        valentin.schneider@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] condition EAS enablement on FI support
Message-ID: <20200924133727.GB3920949@google.com>
References: <20200924123937.20938-1-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924123937.20938-1-ionela.voinescu@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 Sep 2020 at 13:39:34 (+0100), Ionela Voinescu wrote:
> Given the maturity gained by cpufreq-based Frequency Invariance (FI)
> support following the patches at [1], this series conditions Energy
> Aware Scheduling (EAS) enablement on a frequency invariant system.
> 
> Currently, EAS can be enabled on a system without FI support, leading
> to incorrect (energy-wise) task placements. As no warning is emitted,
> it could take some debugging effort to track the behavior back to the
> lack of FI support; this series changes that by disabling EAS
> (and advertising it) when FI support is missing.
> 
> The series is structured as follows:
>  - 1/3 - create function that can rebuild the scheduling and EAS'
>    performance domains if EAS' initial conditions change
>  - 2/3 - condition EAS enablement on FI support
>  - 3/3 - arm64: rebuild scheduling and performance domains in the
>          case of late, counter-driven FI initialisation.

I'm still reading through this, but shouldn't patch 2 and 3 be swapped?
Otherwise we have a weird state at patch 2 where EAS will fail to start
(IIUC), which might not be ideal for bisection.

Thoughts?

Cheers,
Quentin
