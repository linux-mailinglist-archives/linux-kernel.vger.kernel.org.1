Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F762FBD09
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 17:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389414AbhASQ5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 11:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391123AbhASQ4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 11:56:03 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CA8C061575
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 08:55:20 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id j18so410471wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 08:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M1s/++mXdMLvNe4dZQ7XRaGkTkWJbV1fdaKKOWF5MxU=;
        b=jRjZENiS0Iv14+JXtBpPK7jm3rowqG23vo+Q5o9q2+RTDGdVS6iyH1ehkZh8OMn49S
         o+N/c7in+6FOaFhN24NuRlbzZHFdF/OEIdkP+E3Virz7ry6DhLm7c2AwUdGWjbwGJD+b
         1uf8bJDy68fshA63n4Q8psN8CCP18zbvzJMEIRvc2P8u5wudsBUDaolEGNnFnZhfHW1t
         vUOdnqDKP/0a5Ne2ooLsGo+6x0DBXkQNLGdN7w/MRjtHPaPwcONuXJ8QlJm6KxCxNxRa
         wYjvQF8Tr8qMl4vJxVUw+bGSN5RqiHxLOPN4Vkd2vQjRU9/wG+fNFfoissmsAt/zdt7V
         v7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M1s/++mXdMLvNe4dZQ7XRaGkTkWJbV1fdaKKOWF5MxU=;
        b=M3dRTGuEcTJQpPP4foCnMFka2DukAYiSFOFBaRIROwSK4uFyI89bZAKPcqPlVPMM4j
         ZzqNinLxN5V5tRUz+O3ifbPp8pgoBkCimsRqWtDGNCnAZ630WvabPAq+6G+lKxWFvL+R
         01Xq5M2xopIR7psef5rW+LGwCFshRvIZ9FLJxcpq9f91UxHnNovgJ0gsU+Fg7OYFJudm
         WKHnet4rU1pXyc1NQZaP75HahMkCIFn9W9xawHzoFSyMf2l9zvu56o1H52rUG4vNGsZl
         Q82mQvRbkshh+MwZ0Jn9HGX1c7sSqkriALLt0Y/GFU1Pw5CMvvhX1zGCb6cBDG7thNwf
         PQGA==
X-Gm-Message-State: AOAM5314B8oMIrWbJti6Lwqqyi518gt6/gKo4IG28YoP96WPXNT8ws1Y
        LV+fs7dHLkJ09JxRRIFDrjSqKQ==
X-Google-Smtp-Source: ABdhPJyiX9CbGDRV+ypQ878lBxhRymKF2dIL9gS/39sPat84wAwCi9YqT+lmDbua2YB6A8lVe4+NMg==
X-Received: by 2002:a1c:a501:: with SMTP id o1mr500863wme.21.1611075319349;
        Tue, 19 Jan 2021 08:55:19 -0800 (PST)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id g194sm5338792wme.39.2021.01.19.08.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 08:55:18 -0800 (PST)
Date:   Tue, 19 Jan 2021 16:55:16 +0000
From:   Quentin Perret <qperret@google.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH] sched/eas: Don't update misfit status if the task is
 pinned
Message-ID: <YAcO9HHHVBx7oBG/@google.com>
References: <20210119120755.2425264-1-qais.yousef@arm.com>
 <YAb8XGyp3NtrHl+U@google.com>
 <20210119164027.drfpmrol3xhf4ckc@e107158-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119164027.drfpmrol3xhf4ckc@e107158-lin>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 Jan 2021 at 16:40:27 (+0000), Qais Yousef wrote:
> On 01/19/21 15:35, Quentin Perret wrote:
> > Do you mean failing the sched_setaffinity syscall if e.g. the task
> > has a min clamp that is higher than the capacity of the CPUs to which it
> > will be pinned? If so, I'm not sure if we really want that.
> 
> No. In Android for instance, I'm worried a background task affined to little
> cores that has a utilization > capacity_of(little) will trigger the same
> problem. It'll be affined to more than just 1 cpu, but none of the little cpus
> will actually fit.
> 
> Makes sense?

Now yes.

I agree this may be a real problem, but capacity_of() very much is a
per-CPU thing, because of RT pressure and such, and that is not a static
thing by any mean. So, even if the task doesn't fit on any CPU _now_ we
might still want to mark it misfit, just so it can be picked up by a
potential idle balance on another CPU later on. Maybe capacity_orig_of
would be preferable?

Thanks,
Quentin
