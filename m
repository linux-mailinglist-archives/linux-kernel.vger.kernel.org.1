Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C94E2866A1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 20:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbgJGSNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 14:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgJGSNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 14:13:31 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01CDC061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 11:13:30 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id i2so1877483pgh.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 11:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=spK9GFsIYGa6atpdpML8aH9cujgaSnQ/L2GvsbDckRo=;
        b=QWrw/gFjpjs0OXqT5bYWGnl0uyxn2bq14eTH3xXGNMDtS3NWm9BCW/pRVlGbdQtOWA
         M42P+6zNtXoH8RWgNn+LHdYGRoqVUggHeVNCGOPBVgCmZerSohiM9Sl4fWSv6THdi8eZ
         uvL9P3ltzJiy/VTiC3WjYG0psqr9s/8NZ4Ayw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=spK9GFsIYGa6atpdpML8aH9cujgaSnQ/L2GvsbDckRo=;
        b=pIBCKI4mLpIvvo9+CJKTTJHy8EMoEEfBjr3NrDkDQmiWZuD7mm/qj4Y+uVbmrpTWIb
         yYEEuzk3yVG7wiWdbcNNUmI28I2FElReDiW+FxYrB5xuq7pzQxoQ9FF9UT/3+W/uwW7w
         F3GOStwRb9eSgJRQmOh4a0iLMouI1rz5RD7GxJBeCmHPI/emkrQWGRsOGJvtGOSsEioN
         4KyCINjTnl/x5oK6nOO1404Vym70vW38M2Ed1u8ed8P98vwv4jHfAqfzBZaM2T9oZ0z7
         lq36TqCubkgFdUqP7Xuh6d24LkdlTQEv7BcUn3xxRWLPClPC/kS2qTlFVPD1XwZeaxHs
         /bxA==
X-Gm-Message-State: AOAM531czZAh4GhI0s/eCWGgSYH97FgAx1w+63v6yAwX78TtqwKZKs6Y
        1U0TjVNhzgsAxdk0meVFnhgKwg==
X-Google-Smtp-Source: ABdhPJxZZRd+jtUw6BtcGjxvHTliLyeNM0bMH+oIS6wbTrAVCon+Se2X10WcCg4ZljGPjaDH3SkxIQ==
X-Received: by 2002:a63:24c2:: with SMTP id k185mr4168945pgk.421.1602094409209;
        Wed, 07 Oct 2020 11:13:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m5sm3122038pjn.19.2020.10.07.11.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 11:13:28 -0700 (PDT)
Date:   Wed, 7 Oct 2020 11:13:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/11] drivers/base: convert deferred_trigger_count
 and probe_count to counter_atomic32
Message-ID: <202010071112.E76FC61D24@keescook>
References: <cover.1602011710.git.skhan@linuxfoundation.org>
 <6cc888406ceed410bd3abd22ba956daaf7d7b1d8.1602011710.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cc888406ceed410bd3abd22ba956daaf7d7b1d8.1602011710.git.skhan@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 02:44:34PM -0600, Shuah Khan wrote:
> counter_atomic* is introduced to be used when a variable is used as
> a simple counter and doesn't guard object lifetimes. This clearly
> differentiates atomic_t usages that guard object lifetimes.
> 
> counter_atomic* variables will wrap around to 0 when it overflows and
> should not be used to guard resource lifetimes, device usage and
> open counts that control state changes, and pm states.
> 
> deferred_trigger_count gets incremented and read. It doesn't guard
> object lifetimes, device usage counts, device open counts, and pm
> states. There is very little chance of this counter overflowing.
> Convert it to use counter_atomic32.
> 
> This conversion doesn't change the overflow wrap around behavior.
> 
> probe_count gets incremented, decremented, read. It doesn't guard
> object lifetimes, device usage counts, device open counts, and pm
> states. There is very little chance of this counter overflowing.
> This counter controls the wait for known devices to complete their
> probing, and probe_count == 0 ends the wait. Other than that it
> meets the other criteria to be converted. Convert it to use
> counter_atomic32.
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

With the "wrap around to 0" commit log detail fixed, look good:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
