Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3870E1D47D2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 10:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgEOILC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 04:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726714AbgEOILB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 04:11:01 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1634C05BD09
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 01:11:01 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id j21so628423pgb.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 01:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xOrE5zGn6uPvmnJr7dBeSUQ5HqdT7v+oxYQZGlXnk+k=;
        b=aQuQ7L7Kspm6klbOPbMp85wrVBOSaFLGPXT2ylm2Afy/8IpK0mPfvSEdSe0lS8gV9F
         lSbC2KcZQLcUd+RalxmvtSoHOKNH5H3GUoyNArCaRmplNtS71CZGR+49REu1kZmATNj0
         ek0PqLhGJ97mwudkzZ3IV8oV6tboH+V8sy1Rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xOrE5zGn6uPvmnJr7dBeSUQ5HqdT7v+oxYQZGlXnk+k=;
        b=Asfo7qI3JliRAE0+aMeKn9/qD1to0vEOsvsh+klvGw/8YpW0bgZ9WcN0B/Sx5nl0AF
         UVfimauaoKOFY2oG3+rSBpF7/14OtQJNESNRuyJAIxI9OSz9B61eQH8BSWI1+WwYaMPQ
         MHrb13c8nIvmbaUAq510Yo4pA7vT/HqQvp1NQqGfKIlgbsr9b0fjsT6cREEFB0+S4nKi
         mqG9s7VQ3Qg1hYVyhKwSTRYWcv90/2SwxH7zb2mdQEbAKq9d3bQcr65kfCBjdMJmDH38
         /8TeqhrCgEEDRkZWCritn3byqkDXOjWzOmhItHfTDG9XyRNe2pXOxCOiEw+wokM/a46j
         fIBw==
X-Gm-Message-State: AOAM531Mvt/TJqqxYg5+G8ccCxqnekAnpfjwXLxjzPLvBUTPJ1KcvW2Q
        giPWYZnNNo+BrqqmSuBa0kk50g==
X-Google-Smtp-Source: ABdhPJyP3BeKXl/GD0/wS+1lUTuYpFPeJVCT1f8Nl02MY/sGyaBt5ioRr7b1dUWMy5lSsevjMtp1ew==
X-Received: by 2002:a63:211b:: with SMTP id h27mr2033439pgh.207.1589530261328;
        Fri, 15 May 2020 01:11:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i9sm1262581pfk.199.2020.05.15.01.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 01:11:00 -0700 (PDT)
Date:   Fri, 15 May 2020 01:10:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     mcgrof@kernel.org, yzaikin@google.com, adobriyan@gmail.com,
        mingo@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
        yamada.masahiro@socionext.com, bauerman@linux.ibm.com,
        gregkh@linuxfoundation.org, skhan@linuxfoundation.org,
        dvyukov@google.com, svens@stackframe.org, joel@joelfernandes.org,
        tglx@linutronix.de, Jisheng.Zhang@synaptics.com, pmladek@suse.com,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, wangle6@huawei.com
Subject: Re: [PATCH 4/4] sysctl: Add register_sysctl_init() interface
Message-ID: <202005150110.988A691@keescook>
References: <1589517224-123928-1-git-send-email-nixiaoming@huawei.com>
 <1589517224-123928-5-git-send-email-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589517224-123928-5-git-send-email-nixiaoming@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 12:33:44PM +0800, Xiaoming Ni wrote:
> In order to eliminate the duplicate code for registering the sysctl
> interface during the initialization of each feature, add the
> register_sysctl_init() interface

I think this should come before the code relocations.

-- 
Kees Cook
