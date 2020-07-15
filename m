Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01C222053E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 08:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgGOGje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 02:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbgGOGjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 02:39:33 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B844C061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 23:39:32 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id o22so2494777pjw.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 23:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K1kqfp/kSgMwqPN12bKZZ//tfp2BxSTq1mD1swS+LDI=;
        b=WTpGJqyvZjouFkCmi9zC/0IzuJwZoNFGlTzKYuYnoDp3GznjB6msDkhLTTTBu81Esi
         VaiNpYKxJmEPniJqqf09uJdBkXcLEIlWpbN9YChqtejiEx5VVXwlAWq9RvVYA9F10bOq
         Z4rxBdm44p8Cq8K/f5i74jWh1LV9csMsmEbFW+oFQ7/MxGBvm9QESsA11YtoP9tSC7bH
         x1n3ZtXcPmgWKB1GOyjfJWyZgff0uRvK/uNOG0z5TdlWF1Pg47pEK57j4UjItuoeS2h8
         JuwpEwZ9zcTL4k5YVHLs72Ty+YvrUQtNDOpdd243y3StSD5cGBZqDxK0RP+egFp0dBq6
         OIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K1kqfp/kSgMwqPN12bKZZ//tfp2BxSTq1mD1swS+LDI=;
        b=WePjddguEDEixVvRMi5mmdIYwi1P+CmMSTLOgV8Bmonp/wnw9Fvg3JxBD8xhbRRosg
         nE79nqGw9Mw9XHpF48SUD0Vn8/Lb2QNBc2taeZk92DuczSKDvbNaOmiLbfGefKDK7oqE
         QwtW6Xy0llEUkGCBTmXg86bDOAa2yVIxzYmNvzJ/0p43rJPwbSCboxoPuYleSG5+JUGQ
         hXf2qKXVISSHMjudt5lhtCJAJu0ovvYpg3+VrQaCdu1CJX2yK1k9fngeq/s12fAq/AMg
         iLWy0uflstie+bPUDYwPuS33ebWhKZ9s2uK5AdEJz43jA+KlqOc7rDpNq4MQ6TWTuDOl
         tuGA==
X-Gm-Message-State: AOAM533vXitwjBWDVQNBwbuSW1bfT4kibA2REw40b1mIstyGpipk+fF5
        +JgLe7y18oa5xivm8STUxuSIPA==
X-Google-Smtp-Source: ABdhPJxLbshzrCuRoNXOv/ZJi7ksi9A0wHLDGdlFvXgLu4FgBdgA0IgbBWVDw+UxdqJZWSCcNXm/wQ==
X-Received: by 2002:a17:90a:368c:: with SMTP id t12mr8639149pjb.90.1594795171879;
        Tue, 14 Jul 2020 23:39:31 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id d190sm1013466pfd.199.2020.07.14.23.39.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2020 23:39:31 -0700 (PDT)
Date:   Wed, 15 Jul 2020 12:09:29 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Olof Johansson <olof@lixom.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 05/13] cpufreq/arch: powerpc: pasemi: Move prototypes to
 shared header
Message-ID: <20200715063929.42p5ljlcuwie7pmz@vireshk-i7>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-6-lee.jones@linaro.org>
 <20200715030706.prxya7fyylscoy25@vireshk-i7>
 <CAOesGMi1dfqPbFJ8YoUoJ75NdU1=XiNoYx+6+JLu44a4LuuYGA@mail.gmail.com>
 <20200715063607.GQ1398296@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715063607.GQ1398296@dell>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-07-20, 07:36, Lee Jones wrote:
> I searched for "include.*platforms/" in drivers/, and was scared off
> this method since no one else does this.

Yeah its not right for generic drivers, but this is very much platform
specific so it is fine here.

-- 
viresh
