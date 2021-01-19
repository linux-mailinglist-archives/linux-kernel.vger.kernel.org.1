Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634D92FBB5E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 16:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391546AbhASPiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 10:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389869AbhASPhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 10:37:09 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF77DC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 07:36:00 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id a9so16707303wrt.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 07:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YXO92p6LLsj/rO1rdVlgY8L8ta2o0mwtBBy/FTduO/8=;
        b=kWgqgntHOcSZF1eJJmyElYmGNhwK22bP/zEm9ekbz6bhoAKJaWelRaP968R/q16YbT
         TwpnzNYqZOu3soAfufWPQEMxjM7UDdnXdnDMRP8H1BN7FxCrMdve4V6bLlcr3uO6Lljg
         FiAER9G5cvHlD9prUx4QwtBZh8dSkL/UBpAt2W0S37eKAwZ4ZovPcGPwwRJQOSeLsX9K
         n+sTtwdVVypT3ozZhQw8UXiTeLmdoit6MqedXybCRDEGddUrJxaC9BbeJ/x/S54Sp1io
         6ymE6olcWkfL0ZCgNQrJ5TunfzymFSysMvvdj45IXhdBb40QGfjzOt/Sh0aVmopyXjNV
         Lp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YXO92p6LLsj/rO1rdVlgY8L8ta2o0mwtBBy/FTduO/8=;
        b=dh0+QwKBWcwTD2boEy3IW7m92JE15XKe8W1sICbhuSGyvGGCsXTXLf1CGydzBUR09/
         T/G0FfWt3998oXj0PGxb5ke4tgrgcGnu46ywWlUR5EapUAm0mzqf6VM+zrE/EfAvjZUM
         FBmgsNrOV0UwLd0jsXCr4Zc1sMOKpSo9whRNyuvuacD6ZU6p/drhHtzzBne+oGC9tJps
         2uqEKipZv/qYJyo3iq05/uZhusdm7iVUmrxoa0Vn3xR51nObgTltkA/gDGOpKi7UCq0I
         8Dd2pLsXYOLgG4jugrKa+SgUN5kJ+g1AFvF8zYy5wEOmEGlCS28S19N4CBzjbTjgS/ym
         TEcQ==
X-Gm-Message-State: AOAM532HxFcYD9q0jpbMJOjEHxTcRQEtAczDJl1/EUGLgT3686yCRrN2
        2dDejlcva/UJSNdAYF8cpfPdo0N89ivz1g==
X-Google-Smtp-Source: ABdhPJyqu9oCc2mJe28sttBQwEdUIFLSOUBQQ9TaLQZCg/EoCdZ/KaRDTbK/zPx/c6Fga6sDXtAFOw==
X-Received: by 2002:adf:edc8:: with SMTP id v8mr1053653wro.374.1611070559615;
        Tue, 19 Jan 2021 07:35:59 -0800 (PST)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id x17sm36492668wro.40.2021.01.19.07.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 07:35:59 -0800 (PST)
Date:   Tue, 19 Jan 2021 15:35:56 +0000
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
Message-ID: <YAb8XGyp3NtrHl+U@google.com>
References: <20210119120755.2425264-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119120755.2425264-1-qais.yousef@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 Jan 2021 at 12:07:55 (+0000), Qais Yousef wrote:
> If the task is pinned to a cpu, setting the misfit status means that
> we'll unnecessarily continuously attempt to migrate the task but fail.
> 
> This continuous failure will cause the balance_interval to increase to
> a high value, and eventually cause unnecessary significant delays in
> balancing the system when real imbalance happens.
> 
> Caught while testing uclamp where rt-app calibration loop was pinned to
> cpu 0, shortly after which we spawn another task with high util_clamp
> value. The task was failing to migrate after over 40ms of runtime due to
> balance_interval unnecessary expanded to a very high value from the
> calibration loop.
> 
> Not done here, but it could be useful to extend the check for pinning to
> verify that the affinity of the task has a cpu that fits. We could end
> up in a similar situation otherwise.

Do you mean failing the sched_setaffinity syscall if e.g. the task
has a min clamp that is higher than the capacity of the CPUs to which it
will be pinned? If so, I'm not sure if we really want that.

But this patch makes sense on its own for sure, so:

Reviewed-by: Quentin Perret <qperret@google.com>

Thanks,
Quentin
