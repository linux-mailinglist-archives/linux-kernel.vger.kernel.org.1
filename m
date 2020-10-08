Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF57287CE2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 22:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbgJHUGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 16:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730053AbgJHUGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 16:06:35 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3538CC0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 13:06:35 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t18so3310052plo.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 13:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IcbhrWsYAuVUulfDMTbYq/YLCWQUkON2gvNGZ7mgp58=;
        b=J/RdF2uUoB7b1oF/MYm7U3aKk0CwR0dskwGjaR9GO/2ngbiAgu2fHeYRhMImin+7QS
         nEGm9Hrc5IuBOp0HUZIMs7946/cCgh0+sOqAmmTrvw4KKHFOcmQSrKQGs7KjqL65bV5J
         370ahFYXPknsihmy8hTDGPxZrqX84UEMmdB3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IcbhrWsYAuVUulfDMTbYq/YLCWQUkON2gvNGZ7mgp58=;
        b=N7fiOCbmjNUtLrHaMXFaL42uo0OYVmKxYPYPBRhUWJCCjiSF1HMfhyNa9APiYniM4I
         40/J4Y/w7nHiSHDHTwcd9Ur3g5HyVK0KfJb0k0Rl+wHXlwTZzFcaFR5OyUXzfSyCgOO3
         A4W4Iv9qCvvZdF7QuVwz4TqkHvl/04pqEmL0gXhV+dYrPYKz7du3GuCsBO0L/gl1EFdH
         d4/jv8mACV5ASMSZoPykFsLqNS7QY5diTUt5BYkhOkK2imUx9yzpbaUcMM2oBMEN/4kv
         J+KU7myhhT1yg3QEjsTu4KqHfCcpcM8cjL5OU6zdbBaNbn4l1v5NiC+E7TmXrU7eSXjd
         FSpg==
X-Gm-Message-State: AOAM531zpfkeb8xQIdO5/si8vBLzYvpYL5bJzbMjbMM+F+NBuggert1o
        9+b7m0WDCXCRvs3wDDunN1qtvg==
X-Google-Smtp-Source: ABdhPJw4w0PUx+/4kHjnytsAXqS8EQn014tH78UWeCG2OSBpCSkMcF5VTowqJDnjhcFh4mnd5Dr1MA==
X-Received: by 2002:a17:902:7d8d:b029:d3:95b9:68ed with SMTP id a13-20020a1709027d8db02900d395b968edmr9006705plm.28.1602187594761;
        Thu, 08 Oct 2020 13:06:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e5sm9164460pjd.0.2020.10.08.13.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 13:06:33 -0700 (PDT)
Date:   Thu, 8 Oct 2020 13:06:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tommi Rantala <tommi.t.rantala@nokia.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 13/13] selftests: binderfs: use SKIP instead of XFAIL
Message-ID: <202010081306.0EB0DBA47@keescook>
References: <20201008122633.687877-1-tommi.t.rantala@nokia.com>
 <20201008122633.687877-14-tommi.t.rantala@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008122633.687877-14-tommi.t.rantala@nokia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 03:26:33PM +0300, Tommi Rantala wrote:
> XFAIL is gone since 9847d24af95c ("selftests/harness: Refactor XFAIL
> into SKIP"), use SKIP instead.
> 
> Fixes: 9847d24af95c ("selftests/harness: Refactor XFAIL into SKIP")
> Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
