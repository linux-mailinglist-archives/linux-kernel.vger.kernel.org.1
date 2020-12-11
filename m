Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FDB2D7DE9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 19:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392169AbgLKSTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 13:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390274AbgLKSSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 13:18:40 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6935C0617A6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 10:17:27 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id x24so1827280pgf.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 10:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8YKH8lK0Ftp/s46PsvGESW0EJErn9Owh6lZRtwj0uaQ=;
        b=Jq7q0kGut4O4GKUlDdKjcJvyGptTrQ/BtYXgc0fwG8rHhxqNtU/c9YDApmuhO3QSfR
         WHfDtHgrWJA/2LK/W5+1SPqz9VgqKZXqyVBE7mxgyaDIoZowR7IVt5vs+13X2HiFW0Pt
         46+kDeB4eZ6Mpbe758NDr4pkMrGkLwdJdpfdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8YKH8lK0Ftp/s46PsvGESW0EJErn9Owh6lZRtwj0uaQ=;
        b=G9y85xAZE2hlOn9KPP8U6aiWFxCfBp12v4jWKFgkUi71nnpT8AZ/rjz/zZF4sX2fc/
         srXYDZT+HR+Jxlk2XHrKhMhFrynAyx3R4azRBCl1gSz0KW/TcYv5nRlIZjaM77ZM+q2U
         e+ux5qBO/LOaBHwZY3c0Tj6pntoBV49F8ZaKE8nYcKgYBIZp31Ni/ua8upJ5bdnURXzX
         ysl49SFwsz25xp0pnbOuDDHDRy9oCTPiU/whlCWcJt+nTmb3hFnXqMmtb55zTkdf6JsA
         MlCI6aydO5V1jPGyiIQ9OOJyP3XacpeT4s/dCekYbJlznI0cYMdG+Zb8rVv1TJopxFBz
         X7gw==
X-Gm-Message-State: AOAM533whpEYAoicDyzd2vppdgR/IsHLi1FsbA0zxpuv2Ozl10th9n/k
        8xazeH/FRluP4yuNAWTIoRi+WQ==
X-Google-Smtp-Source: ABdhPJzOMS7rfXXEC4FeKPGZb54WaiRjmgy0WLgP1JJ2n7IwJQKTSW2ui8F/w5ced0qGHRb2WeusMA==
X-Received: by 2002:a65:4809:: with SMTP id h9mr13060878pgs.194.1607710647306;
        Fri, 11 Dec 2020 10:17:27 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m14sm10573452pgu.0.2020.12.11.10.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 10:17:26 -0800 (PST)
Date:   Fri, 11 Dec 2020 10:17:25 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     akpm@linux-foundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] lib/ubsan.c: Mark type_check_kinds with static
 keyword
Message-ID: <202012111017.E58CBF6@keescook>
References: <1607602638-79584-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607602638-79584-1-git-send-email-zou_wei@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 08:17:18PM +0800, Zou Wei wrote:
> Fix the following sparse warning:
> 
> lib/ubsan.c:20:12: warning: symbol 'type_check_kinds' was not declared. Should it be static?
> 
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
