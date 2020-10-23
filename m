Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C0F296877
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 04:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374547AbgJWCWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 22:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374540AbgJWCWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 22:22:34 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370E6C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 19:22:34 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id t4so49296plq.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 19:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eRN4VvkSMjUAVDmvFO/IncAAF1JRwx57SYil1mK0hAM=;
        b=slXWMhQxek5pnsMwGTEvDRG4YA6tDbAOYvEjfIC8RRGgXggbmO/g/RencIIRqT6PCH
         lR2d3JcOdabY70CuW/ydgjEEgTTwRBHXnArQk/gCyp0N5WoHYZKEzWc1nrNLkB2qChD3
         bf/qf07/zzgoveQ+AZbBQ8I2DsHCkxHDhD4uGAnMOPE/GXYIN7aev4kKIVlUzJJk0/sm
         yKscOn+UlK4wfXhd8w3qFUPU3GF1sH2HnJcegEEFt4YrB7WDAKubaJ1uFQjqEtx+f7rG
         ycKCnNf1Dy7LCEe+vKWIt9cuRf1ivCYf8q0Xg3QGW2JSbHFG7BMaD90RI+m4lt5wZDoX
         H+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eRN4VvkSMjUAVDmvFO/IncAAF1JRwx57SYil1mK0hAM=;
        b=TqwhDRycGOz3DwcKp19IGhcezp+rToh2owcrSsvfzvqL/orpg061cfMoTyEMJgiZJg
         U/pr+12W5hwzIpvaDeqKXM01McLidTXU9SrWb1wNwFecILzVMZha87Q/2ofqu8JaI5iZ
         PwoowqHrvKShnPLHcMxjBVz9VuUK73hHupm8qIlN+LEzoF7GWkjsU+kX2sXWLcGLVGhj
         CIcp9KTQFOtQI8nUwYa4moZSyIe3geS2zc8N1N8IGwHLlKtA4oarYw2R9CywlQTpkDRT
         ERN2HjzQyzObekMen3wjdC2O53VMxX6sUVypPLuQKwOmMR7zzkDvitMmzeoiFBNoqbhH
         coMw==
X-Gm-Message-State: AOAM533oGsEYveBYg0NHjB27aBP+gHCT52bXiSiPKpVdyD3FkwgA+hSp
        ZiHalP9hKSMR+0mIY/m2sEJbn1h+LDtmuA==
X-Google-Smtp-Source: ABdhPJzgfYFUQi8ELACtuNjezZ830A5139WU+lqteVcVKP9/8bjfccP89Stp1zFoRmnIZEw68D1vYg==
X-Received: by 2002:a17:902:708a:b029:d4:cf7c:6c59 with SMTP id z10-20020a170902708ab02900d4cf7c6c59mr83549plk.52.1603419753508;
        Thu, 22 Oct 2020 19:22:33 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id il17sm138073pjb.39.2020.10.22.19.22.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2020 19:22:32 -0700 (PDT)
Subject: Re: [PATCHSET v6] Add support for TIF_NOTIFY_SIGNAL
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Cc:     peterz@infradead.org, oleg@redhat.com, tglx@linutronix.de
References: <20201016154547.1573096-1-axboe@kernel.dk>
Message-ID: <bf373428-bbc2-be66-db6b-0fa6352fa4ef@kernel.dk>
Date:   Thu, 22 Oct 2020 20:22:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201016154547.1573096-1-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/20 9:45 AM, Jens Axboe wrote:
> Hi,
> 
> The goal is this patch series is to decouple TWA_SIGNAL based task_work
> from real signals and signal delivery. The motivation is speeding up
> TWA_SIGNAL based task_work, particularly for threaded setups where
> ->sighand is shared across threads. See the last patch for numbers.
> 
> Cleanups in this series, see changelog. But the arch and cleanup
> series that goes after this series is much simpler now that we handle
> TIF_NOTIFY_SIGNAL generically for !CONFIG_GENERIC_ENTRY.

Any objections to this one? I just rebased this one and the full arch
series that sits on top for -git, but apart from that, no changes.

Thomas, would be nice to know if you're good with patch 2+3 at this
point. Once we get outside of the merge window next week, I'll post
the updated series since we get a few conflicts at this point, and
would be great if you could carry this for 5.11.

-- 
Jens Axboe

