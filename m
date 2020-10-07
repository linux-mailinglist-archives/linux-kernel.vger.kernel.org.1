Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E2C2866BC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 20:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgJGSQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 14:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgJGSQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 14:16:47 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9624DC0613D2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 11:16:47 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id l126so1779992pfd.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 11:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vOFdnKB1JXikRCLpRzw2yGA5niJmjzaKwReW7FX315s=;
        b=ErMtWdHNzkEH8Pg3difs1tc0ziKw/u65Fw8mDVNdFOq1F+9tUfpITaL5ERgWVgxWJp
         lPiDbvLc+tH9wwTWtjfk/92GTXs26nLCw+LhvRoOSV3tbD/UOUwsnUgKplb459n/QlHO
         4k8wNLji7c+BiNxoWj4epSnzPmOTIzDvWvWQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vOFdnKB1JXikRCLpRzw2yGA5niJmjzaKwReW7FX315s=;
        b=QP1CqCkk4uJD+b9xV4PGSP4w6FTpMHmb+lScQ4Kt/81d2GVJahzoVhvWKAa1gtVruq
         faygKQWKsk3dS5GlXArk8vQiqe2uHZYw/bDeI/s7HbH/xYWhMg79C1MFxMmuCD+h4wql
         a/d/5/kVS6tvWrErRfSa/dsbHXhmFCWz188qaCdBLS1pcSOx8PbnUgoF2Tzcxsd3htUW
         p8faWO+8a6UVnBs1M3C5N4P+nxZdP+7ciEnp3hgE7HDH0nJBdsebaA+D/ht9mBMiPpSi
         z5sifvum/bhIo5KYOr77gFI/zvxiob8A1Ovn8aIq0Uf6Dg9j3c62CEDoFOpb+cB/6905
         OoDg==
X-Gm-Message-State: AOAM530VRlYt8mm5jxfh/Dlwi4OBqqgelxS72mOS7UthnIpfC18+vfbK
        g+PjENEpY9NfvJq43G8raX3EBg==
X-Google-Smtp-Source: ABdhPJymvbLaezKnkLUsdmNTJWxEGV/pvwbNDX0Nmsu8tkZzH82w1SnyLUoM3cyIuh1GW0pUnrMA5w==
X-Received: by 2002:a63:5446:: with SMTP id e6mr3974234pgm.415.1602094607201;
        Wed, 07 Oct 2020 11:16:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x26sm3967255pfn.178.2020.10.07.11.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 11:16:46 -0700 (PDT)
Date:   Wed, 7 Oct 2020 11:16:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     rafael@kernel.org, lenb@kernel.org, gregkh@linuxfoundation.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/11] drivers/acpi: convert seqno counter_atomic32
Message-ID: <202010071116.9D9A5C1416@keescook>
References: <cover.1602011710.git.skhan@linuxfoundation.org>
 <c6d405511bef3413156a2b38bad22dff624bff0c.1602011710.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6d405511bef3413156a2b38bad22dff624bff0c.1602011710.git.skhan@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 02:44:36PM -0600, Shuah Khan wrote:
> counter_atomic* is introduced to be used when a variable is used as
> a simple counter and doesn't guard object lifetimes. This clearly
> differentiates atomic_t usages that guard object lifetimes.
> 
> counter_atomic* variables will wrap around to 0 when it overflows and
> should not be used to guard resource lifetimes, device usage and
> open counts that control state changes, and pm states.
> 
> seqno is a sequence number counter for logging. This counter gets
> incremented. Unsure if there is a chance of this overflowing. It
> doesn't look like overflowing causes any problems since it is used
> to tag the log messages and nothing more.
> 
> Convert it to use counter_atomic32.
> 
> This conversion doesn't change the overflow wrap around behavior.
> 
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

Agreed: this looks like logging only.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
