Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3D4285310
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 22:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbgJFU0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 16:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgJFU0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 16:26:44 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C9CC0613D2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 13:26:44 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 144so9708239pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 13:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FLtRXByKp9+5Dg5zm+HtjjP7VdwGyvWoNTaqHuD+Iek=;
        b=PMTFpJmktM2y+80xAhEY2qscCXN0OkQwO2aWowPP4oBrtk5GNM433AxXucgeqCd1en
         GNimloI8v2m/27/SBPwHVZJQOpzT1M51WoLCz5VHPqHUg9M3SUjBmHgMEj3fz2bq+D0d
         m6Ovz1YeGlqnCk8293sFPVkT3tYXI2uctPnlnoGCxgLX7xHsc3l2iZ0aqUmmfZO9Kecc
         xz1ipzOuFuymrg0NvA6UwWu8opx0gvSTN6hnqTbvB8ce1jR5QwJe9cVCVp9LS5wNYTLC
         AROWhfoKSKzgVEfFAcLLJkOpTSeHDIoLieRxzlUWELQgF4wUb+v/Gzm3SeNBf8WJ3Jy/
         ZZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FLtRXByKp9+5Dg5zm+HtjjP7VdwGyvWoNTaqHuD+Iek=;
        b=B/ZpRAcKLzF1BzM1WEqFwNOxUW9iPWF5l/0CFdUaj34AnC85e7PxkvzcG9OXcSTXyG
         chRLmozw3Xe8vqaAlL2cO+Gf+wXRkD65Y4XpAjODmfAaWKC3XKoIXgcn+PS96bcZFLO3
         wqjyJoYBR5Up8ul4zGEeoBa9xzJ6LKoHzjjHtnOaNvpsTygSKBss36guzs8KzPoYzJXB
         bBUkWkop7vsPbQESIDvpgYnWh04d2Lu+KIIPYTgVx7k9zurBWFC7q4GmLlYOFBNKQbEk
         JxbendxL1lyeMSrodzlzvZY5Q7iJbPLSP6co0bxRKhyLaXL2TchgKLFcX9N+yByDpwGp
         995w==
X-Gm-Message-State: AOAM532+f7aDbLyJMMc/kmZu7lhHZPzjwHtrwvayUyDG9fYwm5ZbWMcJ
        clPs/37T1N3XGwlg4JhjrBrV2A==
X-Google-Smtp-Source: ABdhPJzNF0T5J5Q+RDFMijq5u0hZO3I68498NE+0aFOep3We9kKjbIyRBx5C+TFOYA73D0g+GcLpig==
X-Received: by 2002:aa7:9427:0:b029:142:2501:35df with SMTP id y7-20020aa794270000b0290142250135dfmr6377421pfo.63.1602016003917;
        Tue, 06 Oct 2020 13:26:43 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id r14sm7640pgm.7.2020.10.06.13.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2020 13:26:43 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] io_uring: Fix async workqueue is not canceled on
 some corner case
To:     Muchun Song <songmuchun@bytedance.com>, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Yinyin Zhu <zhuyinyin@bytedance.com>
References: <20200923114419.71218-1-songmuchun@bytedance.com>
 <CAMZfGtUFacR9GFfmySEN6EfdxVi7ZKdwTs17HrJmOL9A38J8sg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a1488045-afd0-39c5-0b56-079fc51723d4@kernel.dk>
Date:   Tue, 6 Oct 2020 14:26:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMZfGtUFacR9GFfmySEN6EfdxVi7ZKdwTs17HrJmOL9A38J8sg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/20 6:50 AM, Muchun Song wrote:
> Ping guys. This is worth fixing.

Agree - can you respin with the suggested change?

-- 
Jens Axboe

