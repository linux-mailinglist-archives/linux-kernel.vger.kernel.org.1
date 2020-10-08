Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3BC1287CDE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 22:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbgJHUG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 16:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730024AbgJHUG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 16:06:26 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A512C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 13:06:26 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id h6so5255446pgk.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 13:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=36J5G6VBDcWw3ES7s2faoLFy25WU74AAjbKcAfCw4+0=;
        b=PwbcZkOcBEd481wZvMsqBSKXgi8z58qwTrkILNbUu8dQ+hdMPo3Y/EribY4Sa0Ejk0
         OkITNZX5OzL6lsmL6TuCGGwdSVpPuQ4ixrKjCm9RyUyC1k/39YzyKsJ+7L+fVWFC5u2p
         M9Sfua+UnPilxjO2hz8IkWgc76PM5bemaRGNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=36J5G6VBDcWw3ES7s2faoLFy25WU74AAjbKcAfCw4+0=;
        b=ZFJtgFOXRCMrBMuXHx+G+IFQI0cPTZs79piIO17rkg9P+XY3fK3xArs+odm/uByWua
         vOHpFMRQqfC5PhAc5EEut/UXVdCdbfYKn7uV9swbuZnrFTPRAkRFLeYT73vCjUxKh6uC
         +Ak+bByD8gzIkO7eMloSh6uSSCAqgPT3ozyaFHkVfvnZYLKJktVh3lPvk0QPzM2zMci6
         bKO3kmgRwbTe3WQ2lp0y7+6CSWNV6yBeO7k/wNsfM0GFoi+kuLb/+tZ/k46sOvfe5LV6
         vt81QxXjoZvOP+8UWVaK3lpr/NGmkFbq8xbmbQLT4E5wpPFBpMvEbuWv3tA7F7GEpK2P
         ODAA==
X-Gm-Message-State: AOAM531vkyKYj7Uj7Ha8zk7JsHqI/kVa9qnjRdpu5QIu7K2TUDZeIQ7B
        ufXmssJsdkFdnUSd4J+ElmfyRw==
X-Google-Smtp-Source: ABdhPJxUkyad2+mHSjZ47QT2EaP5Tl2b1+ny6n6NKAGLtZVO4bnYrAu1OAbWbOX8WtviQBU/6isQpg==
X-Received: by 2002:a63:191b:: with SMTP id z27mr455061pgl.373.1602187586081;
        Thu, 08 Oct 2020 13:06:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m6sm7820887pjn.47.2020.10.08.13.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 13:06:25 -0700 (PDT)
Date:   Thu, 8 Oct 2020 13:06:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tommi Rantala <tommi.t.rantala@nokia.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 11/13] selftests: core: use SKIP instead of XFAIL in
 close_range_test.c
Message-ID: <202010081306.04CAF5E6@keescook>
References: <20201008122633.687877-1-tommi.t.rantala@nokia.com>
 <20201008122633.687877-12-tommi.t.rantala@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008122633.687877-12-tommi.t.rantala@nokia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 03:26:31PM +0300, Tommi Rantala wrote:
> XFAIL is gone since 9847d24af95c ("selftests/harness: Refactor XFAIL
> into SKIP"), use SKIP instead.
> 
> Fixes: 9847d24af95c ("selftests/harness: Refactor XFAIL into SKIP")
> Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
