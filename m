Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4198A2F1E1B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 19:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390418AbhAKSeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 13:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbhAKSeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 13:34:20 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504BBC061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 10:33:40 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id m6so466404pfk.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 10:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4GdBSUrpm58ToHKTls9IOMw+i4c1oYKehuTuyvH6rXI=;
        b=bpYEjWwAhYDf6NfLaHwrtedqGAyLGuBu3WdELiQ1qCHr74NrZzUqZLmSkttMy+B3+n
         M/QpiKzcciLYrNQsryiRWzORjy+5YkIaF1CGoSzWqv3VlZXeTbXJg4ayVyuOj43VhfnY
         W2Iw2hu4K6DrZwgLEcDWCmh5b34LnhLNP5kaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4GdBSUrpm58ToHKTls9IOMw+i4c1oYKehuTuyvH6rXI=;
        b=XdWV/wEuUmuzl1sCjZoImVWAynuRsEn85bTKv3QwJjPI2WTsijsoV1k2h8dVhy+IIY
         2XINhUPQnfDApikR/Pu7dgmiRRbjdsLKkhQVTL6HUm+aXjB/l1FjOXCf2t/UrmNMpVq7
         ERi9uuTz+z0LVmmIDwCsdnSuYY9YEbbUJZFwZhblI3NpJazvJld8n1KH19WlvY364Xtg
         Bs7CSL1S1WLtFecwevhV96VH0/oUITk+ZmdOWSzVJmoTKHgvWt9CP2poXdKGYg/uYuWB
         5onhNECIq7tsp+ukWbxkz9J1KdWQ5R2FT/5QAx7xJTaj/03hMclpZXkwKJNFrRVqkjaQ
         bi2w==
X-Gm-Message-State: AOAM530JVZRYLeeDmSx+A9wscDbbrrGEmkyVNup+LP+EED2RtdxnFbcQ
        CAPpMxz281zJG1VoTlMKresroA==
X-Google-Smtp-Source: ABdhPJxBUI2A5mx/iY8L145Q0BSNqSwTzgAZ5iooolMHwOeCXonZx+LVUJVTzVLH1G2jzvrr6+kk5Q==
X-Received: by 2002:a63:5942:: with SMTP id j2mr810948pgm.33.1610390019873;
        Mon, 11 Jan 2021 10:33:39 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id fs12sm77488pjb.49.2021.01.11.10.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 10:33:39 -0800 (PST)
Date:   Mon, 11 Jan 2021 10:33:38 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, jannh@google.com, jeffv@google.com,
        minchan@kernel.org, mhocko@suse.com, shakeelb@google.com,
        rientjes@google.com, edgararriaga@google.com, timmurray@google.com,
        linux-mm@kvack.org, selinux@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 1/1] mm/madvise: replace ptrace attach requirement for
 process_madvise
Message-ID: <202101111033.2D03EA97@keescook>
References: <20210111170622.2613577-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111170622.2613577-1-surenb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 09:06:22AM -0800, Suren Baghdasaryan wrote:
> process_madvise currently requires ptrace attach capability.
> PTRACE_MODE_ATTACH gives one process complete control over another
> process. It effectively removes the security boundary between the
> two processes (in one direction). Granting ptrace attach capability
> even to a system process is considered dangerous since it creates an
> attack surface. This severely limits the usage of this API.
> The operations process_madvise can perform do not affect the correctness
> of the operation of the target process; they only affect where the data
> is physically located (and therefore, how fast it can be accessed).
> What we want is the ability for one process to influence another process
> in order to optimize performance across the entire system while leaving
> the security boundary intact.
> Replace PTRACE_MODE_ATTACH with a combination of PTRACE_MODE_READ
> and CAP_SYS_NICE. PTRACE_MODE_READ to prevent leaking ASLR metadata
> and CAP_SYS_NICE for influencing process performance.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
