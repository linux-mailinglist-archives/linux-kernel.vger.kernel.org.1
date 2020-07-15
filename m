Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93182202B5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 05:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgGODHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 23:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgGODHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 23:07:10 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774F6C061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 20:07:10 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ch3so1735846pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 20:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0035V8bnG3whIAu8f7LLUznLFIPtedBFd2Vvyt7nBVE=;
        b=T6AbBGKLFGiO0rMZSPzPGLvnhapccenwdvNWp3pzTj2roNEx6srIAWKTBvrEsL/hBA
         IZkPg8mUeuKB1PT4pOTI4RjF5htA4bxX6dyCndlvlQe4G3ODxC2ZOvhPWx+05HCv9rDZ
         va/MRhxP+3uW57aWLqjD3o2VwG34nmWoW4VDWWaVLnO2XyVSQ6mxJiYqPIYyBouwaDte
         gFQTXx4zqagvxCcyT8kLl6jPMhLAi7mmed0AH0wF+KddDCiP8oCCatuOk/jTqvTazoK2
         EjDKeUpPihFzsLsxEaEe6MTwtmRnr+fQ9s2ka4YKgYXJJjwdcjX1AxKMspjlcbaQ/Gx8
         Vajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0035V8bnG3whIAu8f7LLUznLFIPtedBFd2Vvyt7nBVE=;
        b=nwzZBbfAU5X5r5gYKheHkaygZ5MxkWiwi1PwytaN+pyzp2ChfTYaQ3W1px4cDNo/JO
         v+fVc00B5MNLPOoUpTiBzKnoYA0maWeXg/Lp8bTZcNDMT2eeDzuilUhNkqixw2N6dgkS
         LE06YV1REdu/qjrpFshbxyovLX/UKyO2dkjMrWNtjB5P0MGS4OFyVam+8HB6Rczmu0Sy
         l8RAxjL91VlpMycnHUTmPUlF7HLXbT4XkMJzWAawCwbrKOixvzIpUdPVeEQ6bE9kB1xi
         JXoU37taPa0FmD3+CeugCTS76jMQYM0yUvxuGmxW9K3XNce3eifY09p0WM+GI4qlurYu
         rtnQ==
X-Gm-Message-State: AOAM531E61hfvF8T3o2dCzav3YSw5fDSMjZGTXpvR1OMLSm85IFx3KBG
        D/0JMQSytcW+PdDA49wHUuaqCw==
X-Google-Smtp-Source: ABdhPJy2AmTOb51BDdwUOYzF95HLQmIbML6+9DPgV2vlmfNf/gS+QQumkK0XzVQ3zBHzkUs41mvn/g==
X-Received: by 2002:a17:902:8bc7:: with SMTP id r7mr6673755plo.57.1594782428813;
        Tue, 14 Jul 2020 20:07:08 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id h100sm388981pjb.46.2020.07.14.20.07.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2020 20:07:07 -0700 (PDT)
Date:   Wed, 15 Jul 2020 08:37:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Olof Johansson <olof@lixom.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 05/13] cpufreq/arch: powerpc: pasemi: Move prototypes to
 shared header
Message-ID: <20200715030706.prxya7fyylscoy25@vireshk-i7>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-6-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200714145049.2496163-6-lee.jones@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-07-20, 15:50, Lee Jones wrote:
> If function callers and providers do not share the same prototypes the
> compiler complains of missing prototypes.  Fix this by moving the
> already existing prototypes out to a mutually convenient location.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/cpufreq/pasemi-cpufreq.c:109:5: warning: no previous prototype for ‘check_astate’ [-Wmissing-prototypes]
>  109 | int check_astate(void)
>  | ^~~~~~~~~~~~
>  drivers/cpufreq/pasemi-cpufreq.c:114:6: warning: no previous prototype for ‘restore_astate’ [-Wmissing-prototypes]
>  114 | void restore_astate(int cpu)
>  | ^~~~~~~~~~~~~~
> 
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/powerpc/platforms/pasemi/pasemi.h    | 15 ------------

Is there no sane way we can include this file directly to the cpufreq
file ?

>  arch/powerpc/platforms/pasemi/powersave.S |  2 ++
>  drivers/cpufreq/pasemi-cpufreq.c          |  1 +
>  include/linux/platform_data/pasemi.h      | 28 +++++++++++++++++++++++
>  4 files changed, 31 insertions(+), 15 deletions(-)
>  create mode 100644 include/linux/platform_data/pasemi.h

-- 
viresh
