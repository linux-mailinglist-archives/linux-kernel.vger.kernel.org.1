Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97BEE1E773F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 09:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgE2Hlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 03:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgE2Hly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 03:41:54 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CD0C08C5C6
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 00:41:53 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id u5so1022653pgn.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 00:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D/FCxX5pB5cDe1przyEmHXhlMth++c0s0oXQmAAAst0=;
        b=SZ2XDhXdgXF9gXa/YYaV8xv05/2ugn/MAJInuUPW3bNWxSpgl99DiDHX3uqJ9/IEgG
         rlSAfgiizw5nE2fdqm8w2juC5/lcr/siNIujuHB3G+/e/78SuC+6SevpOWq32R/aIrb4
         Fwa+S3DY6L7F82nZS+3T7szgNlQ5DjcQOsP2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D/FCxX5pB5cDe1przyEmHXhlMth++c0s0oXQmAAAst0=;
        b=f15ToMtcror+O8H1+M7FPSSwvGRG6+jrc2S1G47OsXJ1z4ahkWQJIYrI4skFIwTEfh
         uoJw1W2B+B5LiR7PkuB/K++ULljYxNZmBohp46fHIC5bahDLo+cfcsVfJqTPEtYOoPvH
         XFAHyPUiEnY6B5p5NGqeLnmDI0yxB5XQ0B3YQ4TPKN+4eh40Nc+HQjjlbaj2hmJL0wpW
         +dmjZF79QcZ9s8BqswsejujVJBq40hdAlnp7o+PVQH+c4fCJxoUAOjH/3lBSogavMnbE
         6IPm5SGgRvXn+Vmj1bC3wsrF5HbplPEj45qV8pyS/gRRv7aL1FTlgP0x1GT2zCZ6aKYa
         1Skg==
X-Gm-Message-State: AOAM5322RVULpEtKm4epdVq/UkvP8p5dY+Ab08Ig12hqcidPxsgBB4/g
        0BVhlf4yIWQvlNGy9QqDF2RrIw==
X-Google-Smtp-Source: ABdhPJyXTrb2Wfs+ZscuyVmfsjlwaoPtnFGd2l48sxq08vNJtLnBj5nzpKzKmnmEoGxTnKsO27ywhg==
X-Received: by 2002:a63:4563:: with SMTP id u35mr7129481pgk.163.1590738113369;
        Fri, 29 May 2020 00:41:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t201sm3705620pfc.104.2020.05.29.00.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 00:41:52 -0700 (PDT)
Date:   Fri, 29 May 2020 00:41:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     christian.brauner@ubuntu.com,
        containers@lists.linux-foundation.org, cyphar@cyphar.com,
        jannh@google.com, jeffv@google.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, palmer@google.com, rsesek@google.com,
        tycho@tycho.ws, Matt Denton <mpdenton@google.com>
Subject: Re: [PATCH v2 3/3] selftests/seccomp: Test SECCOMP_IOCTL_NOTIF_ADDFD
Message-ID: <202005290036.3FEFFDA@keescook>
References: <20200528110858.3265-1-sargun@sargun.me>
 <20200528110858.3265-4-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528110858.3265-4-sargun@sargun.me>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 04:08:58AM -0700, Sargun Dhillon wrote:
> +	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);
> +
> +	nextid = req.id + 1;
> +
> +	/* Wait for getppid to be called for the second time */
> +	sleep(1);

I always rebel at finding "sleep" in tests. ;) Is this needed? IIUC,
userspace will immediately see EINPROGRESS after the NOTIF_SEND
finishes, yes?

Otherwise, yes, this looks good.

-- 
Kees Cook
