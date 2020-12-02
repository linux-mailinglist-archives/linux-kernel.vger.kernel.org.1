Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A42F2CC680
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 20:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387991AbgLBTWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 14:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731073AbgLBTWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 14:22:50 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B621C0617A6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 11:22:10 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id e23so1678515pgk.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 11:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lco0DNINSJGCQ5gz1Wd3KwpB8K+/NQbPQIeZ40wYkCw=;
        b=Wy0VvcbNtqLND79KrDefD9/V/OLUYIZMVAvegDWaWpdoDQR6TlJjpoa3k6XlzHjexr
         mWlby7ZaJu+1oKDm5/AfkJp4PREEEqe50qDN/4buQ2mMCfr4kF0BQ31XobFU7lE73LG4
         0VxWF6/ytrBbdPGcRct/QUJBSHC7jH7Kj1ZE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lco0DNINSJGCQ5gz1Wd3KwpB8K+/NQbPQIeZ40wYkCw=;
        b=CdkFE6uOVV5xxC+Lgm0/0lXyQDrMVajyk50GCC/I/ldX1NAmMW3kjkZrSqnTgHbzKi
         bRQq1hD0C0Va6belj27kR2wT/aV5Z/rw+G0B8GCz+Jss/xNLp2rUQ58SLarV7RNzAYKO
         jxI0qWU0Epy37OKo5IyttdKy5Z8c1vvdTZ8DZV/lxGVUH10MuMCxFDEFImZuG7O2rbxm
         pFWEgxRQx1wg9xMtkklv3FpHfoB26syZ35wumrIXb5YfoGBcDx6AVCQzXuf/FqYnUHY+
         IBGEc2iz8PajRUJsJWw9+0hxU3A7M+VUpMq98F10rCOQ6dwRT61S3MA9LEsoHoBiTnho
         GZig==
X-Gm-Message-State: AOAM530ZGSXdn2TZnkhNeRWBoXbHG20FSs9DMXRJPgBP1ewhhfieJLH2
        3fYhTZV7FEe8Exbp4Tp0rOhVAg==
X-Google-Smtp-Source: ABdhPJw4hfo3kX936t+nd257OgXcpWmVtUgDAoXoz+9XRIsSbiZu6wmJ9NWC/BEKJPb+u6DZlwkZQw==
X-Received: by 2002:a63:ca0a:: with SMTP id n10mr1257583pgi.326.1606936930001;
        Wed, 02 Dec 2020 11:22:10 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id gz2sm392210pjb.2.2020.12.02.11.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:22:09 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tycho Andersen <tycho@tycho.pizza>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: Re: [PATCH] selftests/seccomp: Update kernel config
Date:   Wed,  2 Dec 2020 11:22:01 -0800
Message-Id: <160693691416.385374.12450510623933031006.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202162643.249276-1-mic@digikod.net>
References: <20201202162643.249276-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Dec 2020 17:26:43 +0100, Mickaël Salaün wrote:
> seccomp_bpf.c uses unshare(CLONE_NEWPID), which requires CONFIG_PID_NS
> to be set.

Applied to for-next/seccomp, thanks!

[1/1] selftests/seccomp: Update kernel config
      https://git.kernel.org/kees/c/2c07343abd89

-- 
Kees Cook

