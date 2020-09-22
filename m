Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F794274952
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 21:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgIVTkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 15:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgIVTko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 15:40:44 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48E1C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 12:40:44 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 7so12797102pgm.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 12:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2BLOzorBaeMlVA6pN2kcbxJVGruVZzdD42GOXHQAwXs=;
        b=QF/L4AUzghb8cbfbsn5C54l9EjVtyQlMBHw5DBOgg702StUFumc+dQnYDzxOVBLvXW
         M4U1Mc3JjnACeI3kX2ghKWxBYt8Uq94PfCZm39zZ98KItafpCVjviJoAeCBOG3IFdh9A
         X2N5hMxWBBIjm9bwj8dz5X7orXiGp8WJZDqrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2BLOzorBaeMlVA6pN2kcbxJVGruVZzdD42GOXHQAwXs=;
        b=PBkOCV/v5yXN3jxYvBRCDfNytBqUb9Z0mK4gL2KgnX8jyy2k0XXYJI+bZNj+k9/u2j
         hjPw4laWceGNhtvD1hEToNBFnVlWC28s4qycwXwJ5ka1dWw0G9pEql26UU8gHZnWxpdz
         rPvrnohAeqHF97nAPJU+bp/38QQTI77LKTG3o/4YDVBQQUGk++8kgi6Ww69SOCgHh7MI
         df2U6kUFtUzzn8A4wq2i9z2BzuMB6GX0St2OrD1DRXxG7SptSs7KhOwRniCJyLJkL+cS
         tnsIf/7DBg9dUMfk3q3FlNMROny44nnzwf7Jtd+dmuxC/NF5x+nAtJRdTqgoXC+9cQRq
         ynIQ==
X-Gm-Message-State: AOAM531I+vpHSkUfHr8ieAuZszVNTTBhlckNGSeysllejvtw3gjX3Q9W
        mA6v6qWt40VaJs3tHPx4FJ1NeA==
X-Google-Smtp-Source: ABdhPJwvYT+NFhGms3dCbMaV9tf8Dw4PMzNnCfSDO3kcJYCAgiqqgfJQsGvvKNmk9TA+xIVl2/U5ug==
X-Received: by 2002:a63:c20b:: with SMTP id b11mr1483828pgd.421.1600803644339;
        Tue, 22 Sep 2020 12:40:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m5sm3003272pjn.19.2020.09.22.12.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 12:40:43 -0700 (PDT)
Date:   Tue, 22 Sep 2020 12:40:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     luto@kernel.org, tglx@linutronix.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        willy@infradead.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, kernel@collabora.com
Subject: Re: [PATCH v6 3/9] x86: vdso: Expose sigreturn address on vdso to
 the kernel
Message-ID: <202009221240.D7B051D3@keescook>
References: <20200904203147.2908430-1-krisman@collabora.com>
 <20200904203147.2908430-4-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904203147.2908430-4-krisman@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 04:31:41PM -0400, Gabriel Krisman Bertazi wrote:
> Syscall user redirection requires the signal trampoline code to not be
> captured, in order to support returning with a locked selector while
> avoiding recursion back into the signal handler.  For ia-32, which has
> the trampoline in the vDSO, expose the entry points to the kernel, such
> that it can avoid dispatching syscalls from that region to userspace.
> 
> Changes since V1
>   - Change return address to bool (Andy)
> 
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Acked-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Look good to me; would anything else benefit from this information?

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
