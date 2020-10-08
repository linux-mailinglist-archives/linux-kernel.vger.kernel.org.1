Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35E4287CD1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 22:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbgJHUF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 16:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729940AbgJHUF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 16:05:27 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8D6C0613D3
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 13:05:26 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 34so5223379pgo.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 13:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=93JQ+JLc0yckcqi1wx5SeqMY9gpHm2kXfjzacFF6blI=;
        b=FOLUK4b35PWh5Ro9bJayzyOVpS7tSGEPExhFUAteAscwYffgF70lCLq14h+qz35ptp
         B8Y4TpyTrsLxwIy9FWh2VqYaSkEwnPU65LiMyUDn9UxaDhhHHr/w6AZ3yjIStbYoooXR
         DZ4iBMjCGUpFjIzLdu8T9ujQOWpuIdcXrCj5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=93JQ+JLc0yckcqi1wx5SeqMY9gpHm2kXfjzacFF6blI=;
        b=cUaXgQ4ap8odyG0KjP09aiZEDBmGwHrWvB20c/XME54NVHMlZ1UuyjEWHU/CS/Wdah
         7Bo3Rr1K/4+E2u/Y21wj616IAubj+jtIpmTShZdDDgYIaZsBbxQ2XAh6CmacoslJqDLP
         TLK4qEvFel9wFidn5d/zdZjshSxx2pa7CpFtIaDwxF59Hui9FvDSGjBJQwomV3IJBWuh
         szSh2KwIjv7VGqzE8DgcuTKvU3kZYMyi/JIiW5FfcBybP9GEoGtnX7/7IqmFxx6m2fcR
         Rc5lXee9m9cRaNE9cmiU4ypQkX4hZXMveZmYc2vM75wFe0DiSd32TdJaymtQxkMSCn/C
         DDmQ==
X-Gm-Message-State: AOAM531X5+5A3zkGpVhUVlgGIBzXTUWIe6MnG9wQZfTJt3mUITxQK6aO
        MITvQFGTSMT4Y5A7UHJdamK6QA==
X-Google-Smtp-Source: ABdhPJzmeLzoos4SYTsQSvOcpUTmvS0KDhMdGwzlt5Ew10q6pakguh0zADu4OcYq5N/eHdKL3wlYOQ==
X-Received: by 2002:a63:705c:: with SMTP id a28mr514682pgn.266.1602187525979;
        Thu, 08 Oct 2020 13:05:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r8sm9568499pgn.30.2020.10.08.13.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 13:05:25 -0700 (PDT)
Date:   Thu, 8 Oct 2020 13:05:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tommi Rantala <tommi.t.rantala@nokia.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 03/13] selftests: add vmaccess to .gitignore
Message-ID: <202010081305.3EC7F53@keescook>
References: <20201008122633.687877-1-tommi.t.rantala@nokia.com>
 <20201008122633.687877-4-tommi.t.rantala@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008122633.687877-4-tommi.t.rantala@nokia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 03:26:23PM +0300, Tommi Rantala wrote:
> Commit 2de4e82318c7 ("selftests/ptrace: add test cases for dead-locks")
> added vmaccess testcase, add the binary to .gitignore
> 
> Fixes: 2de4e82318c7 ("selftests/ptrace: add test cases for dead-locks")
> Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
