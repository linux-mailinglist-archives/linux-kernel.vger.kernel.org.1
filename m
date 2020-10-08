Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C182286F9C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 09:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgJHHhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 03:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727424AbgJHHhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:37:05 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8388C061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 00:37:04 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g9so3541662pgh.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 00:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IMu0Crr/pj4B3MUHg7Vj9+8fc+3Dft22w+G6926fIp0=;
        b=RKnE6q1+BJC9ZB79GG4ediRJDy7pAysrMIcFGVFdPAl3QYh8pierxr0lxRSWGEr2y3
         2Ex4K1rjpsU3YFTGJ+9c5mbd0oIosvDnfGk998fsUlgH4cZ/AfcAfoemguDmWoEhP8JS
         BcSx68wAKamnEaKtKKzcI/yAPGvh6U5GQ4Ges=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IMu0Crr/pj4B3MUHg7Vj9+8fc+3Dft22w+G6926fIp0=;
        b=q6dUgZCzuhAlIGlU7WWRJ0iaXpLOj5EQymgAbfbkGNBHD0ItIyAO+EkEfuHVvBhPy3
         TLG+xG9m17NrFPOMLgDNuGcZzDl+mOxOhlJtvLbF+5SQE6mnyNDZeMtpHQ5/D3n/804n
         PS3SNqZ7yDVTICugDzMOihx5e+iufmI1akJcYyMRgiJdtM9++R4Cf+5f9MDgAlvlWrZo
         syWAEsRLE9pfsMv0I+WD4m7amZ8XRnQErrKeEgnWvIJWa4WSK2ysNXlm2UNIryAbozTU
         TaJuW8EYy8upNYm0qTG19flyMIizaSZwvDJc1npluJK5xKxyOYqaCaIAPeoXtxkYTPS5
         hyGw==
X-Gm-Message-State: AOAM533HVPxy9uIgLd8EGJGEa1rG8lOL+f3CEOfZLw4pEAbpME4VmxW5
        yhrUTJ+LHqr/ksm5VQOA2yimOQ==
X-Google-Smtp-Source: ABdhPJz2J+5oYtHsMOH5qZrhRO70+NsuJrhz2jDD4jfE/NiNvFD01kVdJsw0r4+mt/BlPO+ns/mZLA==
X-Received: by 2002:a63:e47:: with SMTP id 7mr6234736pgo.13.1602142624574;
        Thu, 08 Oct 2020 00:37:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g4sm6176638pgg.75.2020.10.08.00.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 00:37:03 -0700 (PDT)
Date:   Thu, 8 Oct 2020 00:37:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/11] drivers/base/devcoredump: convert devcd_count
 to counter_atomic32
Message-ID: <202010080036.A3BEFB0BE@keescook>
References: <cover.1602011710.git.skhan@linuxfoundation.org>
 <462fd514dfe2afbb8faa1dea4cdb4b0e75d8e8da.1602011710.git.skhan@linuxfoundation.org>
 <202010071114.EE9A2A47C@keescook>
 <cb86761a-5531-cbb2-3987-0897771949b8@linuxfoundation.org>
 <f27149d6b9b781ccf9c2fa041082c134abccd925.camel@sipsolutions.net>
 <202010071334.8298F3FA7@keescook>
 <1545e7c77675c9a0574a7582ee5f0c969c01419e.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545e7c77675c9a0574a7582ee5f0c969c01419e.camel@sipsolutions.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 08:42:22AM +0200, Johannes Berg wrote:
>  1) each value that we derive from this ever-incrementing (modulo 2^32)
>     variable only get used for a limited amount of time (max. 5 minutes)

Ah! That's what I misunderstood, the resulting value is only used for 5
minutes. Got it; thanks!

> IOW, I disagree with you, and think that counter_atomic_32 is more
> appropriate here than refcount_t.

I agree now! :)

-- 
Kees Cook
