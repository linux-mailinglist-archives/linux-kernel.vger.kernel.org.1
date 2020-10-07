Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A6328670B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 20:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgJGS2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 14:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbgJGS2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 14:28:13 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B228C0613D2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 11:28:13 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g29so1944022pgl.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 11:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pY5hr+pXTC2KC1mU7MvG9oZqJC33WL0b/W2uStaywT0=;
        b=PEdEINzkK5L++9wOyUJFODwU4LWNchEyEBoCRw9uHdvrv9nrUaYMs8iDEojGTrKCwM
         hvlgqC2UgIfYOTZvi8/GUROQHIknxKH1ye0hapkFkB/N2zS037sxKozSW60g64/IYKJG
         Y5XONtkr/Ln3rSupKkoTKOOVSZOEk3xUTLd7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pY5hr+pXTC2KC1mU7MvG9oZqJC33WL0b/W2uStaywT0=;
        b=ZUUv2UHf3hpzmF3M0Va/vb9uPQlG4Kp9SJp3gfR0PFPiefjz0svN6DUU2sTRu1HHdh
         c0VgMiGI8gOned+UeXPYPlw7+cvr8X18joHcw2jJYnLY+kwPYboC8P92NOyOCrAYP1R4
         cz+pcQqLlcqlnTn4L2Jn77ZyJ7CsWHIuwwOTxsx+jaynvTwfaYL4+aK0SLtl9+/sfYVc
         RGrVGLUi7TRJIUdS3jgiqo3KyAl/HG7QLaBMWnWN/WIHvo3UD73p2s1fNOQ8uxFbq8J1
         4iZj/2or59x3H/5XsUqzrtYc5OGhh7OlMD1Ysjjj6Gac4cIkplNwwQfJpbvxlZ0H0+i1
         JxkQ==
X-Gm-Message-State: AOAM5331/gkYT6e+FIU+Pyx/AATHtUmDx6m9gsTsauP0kqy2q5b47l23
        wXOziiZhv0QR/7IV7sH1uqL1lQ==
X-Google-Smtp-Source: ABdhPJwjPWHKF7HK4HTgHROxi6zwV4+yjRIZbxF2dS26VaZNfHtB9eZPB9TAjZ8/wKYaCnVVSxRuRQ==
X-Received: by 2002:a17:90a:1690:: with SMTP id o16mr4029165pja.148.1602095292959;
        Wed, 07 Oct 2020 11:28:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id in6sm2521351pjb.42.2020.10.07.11.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 11:28:11 -0700 (PDT)
Date:   Wed, 7 Oct 2020 11:28:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org, gregkh@linuxfoundation.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v2 11/11] drivers/edac: convert pci counters to
 counter_atomic32
Message-ID: <202010071128.BBAF7138C6@keescook>
References: <cover.1602011710.git.skhan@linuxfoundation.org>
 <03dc29c130e6522448a4328b1cfa8fbf7c9a8c97.1602011710.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03dc29c130e6522448a4328b1cfa8fbf7c9a8c97.1602011710.git.skhan@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 02:44:42PM -0600, Shuah Khan wrote:
> counter_atomic* is introduced to be used when a variable is used as
> a simple counter and doesn't guard object lifetimes. This clearly
> differentiates atomic_t usages that guard object lifetimes.
> 
> counter_atomic* variables will wrap around to 0 when it overflows and
> should not be used to guard resource lifetimes, device usage and
> open counts that control state changes, and pm states.
> 
> atomic_t variables used for pci counters keep track of pci parity and
> non-parity errors. Convert them to use counter_atomic32.
> 
> Overflow will wrap around and reset the counts as was the case prior to
> the conversion.
> 
> Acked-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

Looks like pure logging. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
