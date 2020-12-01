Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789102CA89E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 17:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387985AbgLAQr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 11:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729064AbgLAQr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:47:57 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2BEC0617A7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 08:47:17 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id i2so3667893wrs.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 08:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b3U69nUvkDMdtMVIGjWBzkR9SwVXqGD3Tu55Q8FU570=;
        b=ES2LsJeN4b0KdLMrJORmEDNP6wnEDr7va1Jxsg16QsZi8lUxZR/BNcayu3OVMi7wab
         Tg26PrvyAfYvjlYRJg9Wn++WQzxb4aKzS5dvdw+zrJuIvQQROqq1393zVNBQKvq3Dqfj
         5iqpYWgvresWpw0g+qEYfDKAiuc9BleffYPanKqAyJbJoj583Z4jLQnbI8OluyrEmRWD
         HOk04zKgVoY6B/zai+Ck6liEfJeZH+oKYJOS3Be6qnwIEuFVwbQBncDnC+4fsiD45KJ1
         tLeirtFfL7HJ7s+hRuQ3np9ZH4i99WgfFK7tKd/ErtgQ2SsP/ExQOhKqUfemiVAYGAo4
         SWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b3U69nUvkDMdtMVIGjWBzkR9SwVXqGD3Tu55Q8FU570=;
        b=JPVtLdXwupokaCvRwq+bFYbXez3Az53NzgiK8O+ohC+gMQ//j014TVZoZMurQxHum8
         pH1o07kh0FyR4AcHYFWRSiJCY3gnr+OmA24lWbRtFQyeCR5cdjZECF4kh5rlbp6jRGRR
         pXWMW6fBbxzebZnlvnDBMQmuG2M8XYrWYg1xOpjWqCg+DXzJ7pu4u/zEx41yuc9aTyO0
         PCFEUIRHrBfC2Jd7cEA0DqCfXY9IkH2BTVwf3pqMdAIx8Ww7rWeG/NYgBbnHc3Oo1LQo
         7Q7zFXPUaDH+I9T58VmWEj2en8pNlBVVs8JnkDc9zarqTiJ+mjinrUeODj3sg1x7SoUv
         QPYA==
X-Gm-Message-State: AOAM533nWxT45nNE6UCX+c+nWTIjkq73nxB6uMg0hxJFJbzF49aqqHvt
        Lvv3qLpYRs3EPHTp0fNzEZms2A==
X-Google-Smtp-Source: ABdhPJxcGjMMi+603REgpYabEtKbjHcizw6XeTvxEK1iGsCiJh/2CtHdhzKfbszIdqHbC7uNowZB2w==
X-Received: by 2002:a5d:6852:: with SMTP id o18mr5005694wrw.336.1606841235753;
        Tue, 01 Dec 2020 08:47:15 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id a144sm652871wmd.47.2020.12.01.08.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 08:47:15 -0800 (PST)
Date:   Tue, 1 Dec 2020 16:47:12 +0000
From:   Quentin Perret <qperret@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] modpost: refactor error handling and clarify
 error/fatal difference
Message-ID: <20201201164712.GA1949321@google.com>
References: <20201201103418.675850-1-masahiroy@kernel.org>
 <20201201103418.675850-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201103418.675850-2-masahiroy@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 Dec 2020 at 19:34:15 (+0900), Masahiro Yamada wrote:
> We have 3 log functions. fatal() is special because it lets modpost bail
> out immediately. The difference between warn() and error() is the only
> prefix parts ("WARNING:" vs "ERROR:").
> 
> The intended usage of error() is probably to propagate the return code
> from the function to the exit code of modpost, as check_exports() etc.
> already does. This is a good manner because we should display as many
> issues as possible in a single run of modpost.
> 
> What is annoying about fatal() is that it kills modpost at the first
> error. People would need to run Kbuild again and again until they fix
> all errors.
> 
> But, unfortunately, people tend to do:
> "This case should not be allowed. Let's replace warn() with fatal()."

Indeed :-)

> One of the reasons is probably it is tedious to manually carry the error
> code back to the main() function.

And yes, that was the reason.

> This commit refactors error() so any single call for it automatically
> makes modpost return the error code.
> 
> I also added comments in modpost.h for warn(), error(), and fatal().
> 
> Again, please use fatal() only when you have a strong reason to do so.
> For example:
> 
>   - Memory shortage (i.e. malloc() etc. has failed)
>   - The ELF file is broken, and there is no point to continue parsing
>   - Something really odd has happened
> 
> For general coding errors, please use error().
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

I gave it a go and the error is propagated correctly, so FWIW:

Tested-by: Quentin Perret <qperret@google.com>

Thanks,
Quentin
