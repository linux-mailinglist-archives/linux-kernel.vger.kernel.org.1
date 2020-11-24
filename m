Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5CD2C270B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 14:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387984AbgKXNYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 08:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387678AbgKXNYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:24:34 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D35C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 05:24:33 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id d142so2395541wmd.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 05:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ew5UjgwDR2rSV8JRD0YIOUGSjGHB1P3leiwWv+eMgA8=;
        b=Xs9ybIksX75QOTkG6dpiwSAaVhoAvQ9VsVUeAQ61UDYlZKryDPnfeTTkOErBE+1Vw5
         a5i2BcnR3Zp1kcyYRw023JNokWRMT60ndfe40ADC79TMeq01TKQx7WxCrxmL6FYfEZ7Y
         dkjKPPE9R6yoZSB+83xr5ZH9jDG7lZ67rIyWS/ScSj51A82PFFRi15pDNRlv/N7fIiWz
         0POX5y3AH4R/zm96xjGvtRxmZqEHWVo0ZIzAJlJTMkAFe71cydDyI9B/erXBesxL7E1/
         NjpZiVnTzOvCS4QHxkVreb+zkt9OnCC9kSfDw/7dC3/TYVbImX4JBaRX1ZADAXe7lo7X
         XqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ew5UjgwDR2rSV8JRD0YIOUGSjGHB1P3leiwWv+eMgA8=;
        b=hlARQDawaF8MpxWYK31tQOdw3583eUEmhifM1n/mx4Py/7hVjbKRVvSb2cgLAfi97d
         kQ0c7wDAFVw+gxl0mMWKJXFcIcCs5GudCLtguYNON0hjO+8hvzx3ufA2B6j+R/2EMBTz
         tqvrtq9mz2lH9ZCoAOhbABKP1Eywm9GXTKOeDKl6LJi9m4PxMgIg6BN1gP5OWWRX4xPj
         cUwX9JazIQzWn3aKOAqwlhUc4rag1INlt7drC9T7lL8bYvKXiqnZB4sXw5MTC0H9NrZc
         UN6Y6Ua+/RaBKaQCrZuOODX+DIbkOgh2FEoTGQES+5gn8aiUwjSA5MwUUO2CmLdonC4N
         nsyw==
X-Gm-Message-State: AOAM530ydgT65869c6vv1f8Y3tiWhcONURXGYYt6p7VOhTi7m86i9SS+
        bBVJefcKC/Niljw8dtmv4fo5BQ==
X-Google-Smtp-Source: ABdhPJwfJv4c7rWVNvL+UfuTmyOWH07CnVwHTVWdVfm/I9LTzMsbyZQUiy81aOgUB8+SKq6QM86t9A==
X-Received: by 2002:a1c:56c4:: with SMTP id k187mr4477222wmb.92.1606224272126;
        Tue, 24 Nov 2020 05:24:32 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id t7sm26508475wrp.26.2020.11.24.05.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 05:24:31 -0800 (PST)
Date:   Tue, 24 Nov 2020 13:24:28 +0000
From:   Quentin Perret <qperret@google.com>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] sched/topology: Mark some symbols with static
 keyword
Message-ID: <20201124132428.GA1067355@google.com>
References: <1606218731-3999-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606218731-3999-1-git-send-email-zou_wei@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 Nov 2020 at 19:52:11 (+0800), Zou Wei wrote:
> Fix the following sparse warnings:
> 
> kernel/sched/topology.c:211:1: warning: symbol 'sched_energy_mutex' was not declared. Should it be static?
> kernel/sched/topology.c:212:6: warning: symbol 'sched_energy_update' was not declared. Should it be static?
> 
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

I think this wants:

Fixes: 31f6a8c0a471 ("sched/topology,schedutil: Wrap sched domains rebuild")

But, with that:

Reviewed-by: Quentin Perret <qperret@google.com>

Thanks,
Quentin
