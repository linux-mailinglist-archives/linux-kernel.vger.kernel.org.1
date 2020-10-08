Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4807287CDB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 22:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbgJHUGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 16:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729998AbgJHUGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 16:06:20 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8413C0613D3
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 13:06:20 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g29so5273913pgl.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 13:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dqDMGKDPXWEL3s+Lkoign4mpB+eJXnkZnlQvVOX0XM8=;
        b=A6iIp0QO1JadVLCV2aLMTv6djq+eW/MVZ9vR8BoFTkolbuRRaX5VAlVUWUkLa+ruzE
         ApLg4o8J8+1NCvkeajV8gbXbN7Tvh9hlUXhNoUNP+1f9UWSrCptKLodXqNJ1vFI9epbv
         Luikqx4OsLQepRsPGu4tl5gN7gfZ9ajqRn5PA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dqDMGKDPXWEL3s+Lkoign4mpB+eJXnkZnlQvVOX0XM8=;
        b=QZKhw2JurvHcYbTA7HxsCcm2hNrJ7VFZm2iZCEfoC0fQKux8tZ0Urz7gjDnPcOHZ2E
         GocnIVOKKvq9Efu7JCrSuhKj6QWg0Zdouy0M8wptSnbb0GyVHUnjLns3P26VlhtBsOjY
         xZysdWaWm4oYmfi3ZGWfu9IvmlkIoAwr/eO33/KSW42XgTTvcsrlD+B25Lc6inz4bFi5
         7qg/O8p/ufjRxlg5kQSRqghyfxj0rg0TDaTGQTQ+lvaGKCWyQbdQpK3ZhEr+p4Mc+/9a
         tN1vtim/GuObjS71H6AF+ZT1d2rXwP/S+BPzkoTyjHfjYfX/LNXYwJEKOqn94t9OWHjA
         D3gg==
X-Gm-Message-State: AOAM5322lSThj7MP/weakltCypbQ7TDU/CE6guDSHX/GGClFoC1DOC4j
        6zKpiG/bgpis7/XkMjdTG71PfQ==
X-Google-Smtp-Source: ABdhPJwX8e486E/dOh8H206wcTmba4Et7SJ2p+N9U28QP6b8IRdQ2zeZH4E8rhZJ+tzOC5Jr+DGXzg==
X-Received: by 2002:a62:6044:0:b029:151:1a04:895 with SMTP id u65-20020a6260440000b02901511a040895mr8874226pfb.34.1602187580280;
        Thu, 08 Oct 2020 13:06:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id in6sm7207281pjb.42.2020.10.08.13.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 13:06:19 -0700 (PDT)
Date:   Thu, 8 Oct 2020 13:06:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tommi Rantala <tommi.t.rantala@nokia.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH 04/13] selftests/harness: prettify SKIP message
 whitespace again
Message-ID: <202010081306.4365BBF7A@keescook>
References: <20201008122633.687877-1-tommi.t.rantala@nokia.com>
 <20201008122633.687877-5-tommi.t.rantala@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008122633.687877-5-tommi.t.rantala@nokia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 03:26:24PM +0300, Tommi Rantala wrote:
> Commit 9847d24af95c ("selftests/harness: Refactor XFAIL into SKIP")
> replaced XFAIL with SKIP in the output. Add one more space to make the
> output aligned and pretty again.
> 
> Fixes: 9847d24af95c ("selftests/harness: Refactor XFAIL into SKIP")
> Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>

Nice catch!

Acked-by: Kees Cook <keescook@chromium.org>


-- 
Kees Cook
