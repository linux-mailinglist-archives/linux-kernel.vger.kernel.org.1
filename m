Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6151F4086
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 18:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgFIQTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 12:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbgFIQTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 12:19:19 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0085EC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 09:19:18 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b201so10303484pfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 09:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ueyMjrt+cVmVw+FUtBmPoU2yNggdKKN+3InYLsTempU=;
        b=RZa4k0gdX/BrdYRuu5UbU3mCtRg5M7tITfvtIafMhGK1/7W6JOMfDwmDndeL2mMC31
         yNzF44u98E7F1ppN0a4sYDU8qBATLfUt2Vty8tAEUAUccnACIfrgaxemDDEGfchcknaB
         393Rn4PtQDLfi9We9ITW6jDW26mZCgdYJxzh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ueyMjrt+cVmVw+FUtBmPoU2yNggdKKN+3InYLsTempU=;
        b=WNqaRl4IEpAI8WBCfvZNjJ2m/d4bIsgH+eQLfXtUHBLdE5B/YwXH+8qpN/Da5BGd9A
         EaMSfC4Ed3LLHws/CmBnOxszP5SoZGfHjzJ0kvqtAXdI0iEer4I33nf6oJLKF71FgkFB
         /C6qDgQNuM/BQD/FStHjLQoE9UppIZMKzM112ExVWweowDTnRC+dDO2YVp6PLVnPoAeX
         +5ZRTOvqc1uuh/kTAek3G7CdsHdchP0uDOW/WIikKY7Yt1sKqqOU/XWdIZCPoGBl5Iqg
         MrbJESwqmg/AanHMDkwGvKguUET4xX5kwkLvqRsv6q5BkUfGSk6ZSNgVMqZAH6r42oQl
         Tpmg==
X-Gm-Message-State: AOAM5309QpsxsoL0Z7/e2RzrWBFlriAJv7y47xnHMioTfSCRlzsW4T+B
        TJCaRLQ2Pz7YfkeHyINRHOEcCw==
X-Google-Smtp-Source: ABdhPJzE6yGQaAHR9+5KrWHmMMPB2+bwupzZamf+a74907NKzb6ugUkxgWCFch7ofwWEXhGReam42Q==
X-Received: by 2002:a63:cc12:: with SMTP id x18mr24710834pgf.140.1591719558589;
        Tue, 09 Jun 2020 09:19:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j2sm10367405pfb.73.2020.06.09.09.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 09:19:17 -0700 (PDT)
Date:   Tue, 9 Jun 2020 09:19:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] afs: Fix use of BUG()
Message-ID: <202006090919.3FAC6C7A@keescook>
References: <159171918506.3038039.10915051218779105094.stgit@warthog.procyon.org.uk>
 <159171920664.3038039.18059422273265286162.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159171920664.3038039.18059422273265286162.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 05:13:26PM +0100, David Howells wrote:
> Fix afs_compare_addrs() to use WARN_ON(1) instead of BUG() and return 1
> (ie. srx_a > srx_b).
> 
> There's no point trying to put actual error handling in as this should not
> occur unless a new transport address type is allowed by AFS.  And even if
> it does, in this particular case, it'll just never match unknown types of
> addresses.  This BUG() was more of a 'you need to add a case here'
> indicator.
> 
> Reported-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: David Howells <dhowells@redhat.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!

-- 
Kees Cook
