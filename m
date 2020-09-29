Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D8727D645
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 20:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgI2S7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 14:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbgI2S7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 14:59:00 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76F9C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 11:59:00 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k13so5525279pfg.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 11:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dk1cTODLxYw48Etf8ZXYv1O0s0b1u8jvfbtZJWNF/FU=;
        b=iUYptqhO1Cb1oqT70B6OiYOEYPvUtMv6DmPRynZqXb0UsVj/WglJDwZUkMpyqS2El8
         Fd8UtabAKffredo2BSoKxIcFQbo25h/vpQ00kE9PoG5u9WEJ0ixa5dWISEAnpDqMzojB
         +00ID59hznF2RjXcFfPz2RjUs2bfCHrZQogjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dk1cTODLxYw48Etf8ZXYv1O0s0b1u8jvfbtZJWNF/FU=;
        b=GC0adJ78VZ/SlMBDzf5vxOWBNbia3qMnRWCfTKSLxH1tEQI85hX1KgNIwGoFswTgAt
         WAG3BJlKPcLgj3WNK46KwsQ6Nu9uf0s+caaV2cE+KiFawFlHWEbMwESjHqUSoKuU6+Zw
         uIyJxzMerIFg6H/1fz6dxMo5dAPUxU+YzKly3SUn9vhx3fPb0fzVnX6miSnjWplJlpgh
         5QRRwg2QYgVJNnOda8dckfvGGm8IeRSSCBgEGL+/v4CN4Xc8233YtAe/ppVPWWX8APfY
         QwWIkzW6QRORRMs9re5W1AFA3nc8i+83xNc1I6z6xsl8F6ZgyM1/2fFuslYoIgXIZHOZ
         2Fqw==
X-Gm-Message-State: AOAM53233MJWTh7vbHZYP6G77bqVdIwAXZ2wT6x4LS9EVRz5p/OeVBow
        QyAEM/iNL57+4Ixa5K6tgDQduB5Q2HiJPwUU
X-Google-Smtp-Source: ABdhPJzU/8kPj+74FsXi5Gk92Xw8EMgcTBYX8nGMWdrd6Q+OG2MvX/M1oO4s/mu3/8z3kZaxwqcXlA==
X-Received: by 2002:a62:1dc1:0:b029:13e:d13d:a051 with SMTP id d184-20020a621dc10000b029013ed13da051mr5198108pfd.23.1601405940393;
        Tue, 29 Sep 2020 11:59:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a15sm6170842pfi.119.2020.09.29.11.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 11:58:59 -0700 (PDT)
Date:   Tue, 29 Sep 2020 11:58:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        arjan@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        rick.p.edgecombe@intel.com
Subject: Re: [PATCH v5 00/10] Function Granular KASLR
Message-ID: <202009291156.075F4215@keescook>
References: <20200923173905.11219-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923173905.11219-1-kristen@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 10:38:54AM -0700, Kristen Carlson Accardi wrote:
> This patch set is an implementation of finer grained kernel address space
> randomization. It rearranges your kernel code at load time 
> on a per-function level granularity, with only around a second added to
> boot time.
> 
> Changes in v5:
> --------------
> [...]

Builds and boots; looks happy. Hopefully this can go into -tip after
the coming v5.10 merge window, for v5.11? Thoughts?

Tested-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
