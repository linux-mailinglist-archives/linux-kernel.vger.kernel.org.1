Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886262866BA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 20:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgJGSPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 14:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbgJGSPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 14:15:46 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5D8C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 11:15:46 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id s19so1413446plp.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 11:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iGplyq5FPmCw+Lpr69IdMl7iAFHaTT6J99h/le9p4vc=;
        b=XRaf/mF3LE6zV+UCAgaNyLByT8UmSV56mJk78qyV0iYspr0QbFs1ZDWWB2Mn7YUJ8O
         oUkSVlsQFOvuOjxN3+2M9+KaIIBuJDME8rB0ljKuOH8CgV6DyfuEABWjYYJEq3CxgG4C
         +pHIKLgDteBXoDSyh7qQmVPZJNamDYZvhMqHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iGplyq5FPmCw+Lpr69IdMl7iAFHaTT6J99h/le9p4vc=;
        b=EygmdQYLLLRQGW8MYopGDswgQ5x7DsMA1BHhQL7n3k/Z1s+BCEvwEU8SrwgMK3g0UB
         0EUXGrgwg+vwA5HCXkrFTCTCtW027u6VZQiZQKpKigmj26ImY87rfMQuvrSjtS/LJvEu
         PXSywbAPMTDjmxrzyBH4CIdyXoHiAMYHsST6ItZnIgMdMQnemFAskg+NrqqP+cCquYK7
         r6v8d2qt3pzbiKBHc9XcB9UR7+4ZjjClAp6UsxwC4fZCj6ilPEpZO6/NuF2Lcnwr1Gbe
         0NS7vLZTZWFB229v+hYP9JiK+cx7D2ZT/Dj5wr05PYsnCbKfwmHhyF3wGSPs5m7Jvj8h
         cCSA==
X-Gm-Message-State: AOAM533+yan6dagkUQwGxNUb4v0mxv1bq+ZJ8G1/bYzgInsfW7ADkaHs
        A7Vwlzqe8iD1E278hmZAq9Vlv0A4JfVD7/b+
X-Google-Smtp-Source: ABdhPJwFNjuzbAG6Nr59MPbeStO3zq1UKOOP+8h5gazzTkUVTrOy3qCXZEleMwdJhXp3dyM+V4fItQ==
X-Received: by 2002:a17:902:9a87:b029:d2:1ec0:4373 with SMTP id w7-20020a1709029a87b02900d21ec04373mr4056193plp.40.1602094545783;
        Wed, 07 Oct 2020 11:15:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q8sm3864689pfk.207.2020.10.07.11.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 11:15:44 -0700 (PDT)
Date:   Wed, 7 Oct 2020 11:15:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     johannes@sipsolutions.net, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/11] drivers/base/devcoredump: convert devcd_count
 to counter_atomic32
Message-ID: <202010071114.EE9A2A47C@keescook>
References: <cover.1602011710.git.skhan@linuxfoundation.org>
 <462fd514dfe2afbb8faa1dea4cdb4b0e75d8e8da.1602011710.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <462fd514dfe2afbb8faa1dea4cdb4b0e75d8e8da.1602011710.git.skhan@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 02:44:35PM -0600, Shuah Khan wrote:
> counter_atomic* is introduced to be used when a variable is used as
> a simple counter and doesn't guard object lifetimes. This clearly
> differentiates atomic_t usages that guard object lifetimes.
> 
> counter_atomic* variables will wrap around to 0 when it overflows and
> should not be used to guard resource lifetimes, device usage and
> open counts that control state changes, and pm states.
> 
> devcd_count is used to track dev_coredumpm device count and used in
> device name string. It doesn't guard object lifetimes, device usage
> counts, device open counts, and pm states. There is very little chance
> of this counter overflowing. Convert it to use counter_atomic32.
> 
> This conversion doesn't change the overflow wrap around behavior.
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

I actually wonder if this should use refcount_t just because it is
designed to be an alway-unique value. It is hard to imagine ever causing
this to overflow, but why not let it be protected?

-- 
Kees Cook
