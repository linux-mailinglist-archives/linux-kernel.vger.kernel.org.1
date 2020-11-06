Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D8F2A8EA1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 06:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgKFFMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 00:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgKFFMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 00:12:44 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C1AC0613CF;
        Thu,  5 Nov 2020 21:12:43 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id j5so123580plk.7;
        Thu, 05 Nov 2020 21:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qaz5JfSXEexVzd3vu4/X1zvrfhtSmuN9aWiTUHv9SJA=;
        b=gH4mN2yOR56HxWAUwIJnrOftunZr9+x3k3rBsiRJpCEksBtaVdkAckIA/ShkL3YK2I
         mkGL3Hy4IUaQz762pvnkx4KwUGB3BGF80qajcWfFjd3npfm501lmjQmXotnZ6fWWFPTv
         HtGAsH4Nr6zqgcBut3cJLOkkA6HjcjzOeiBgQOQmGIkHpBIZk7SfvgFKzre4bD6er3ya
         gXaAFbMsf1CME3CF83weO8ROcpeFuEPeflYeITDaZa9G75buQ0cI5aO6IItXmjHRFbEM
         99PGhazX1x6zc9vZ5TEqTrOmrufIVnDJhwjCUGQym7gCog8MXh3QtEriERKx5ZABf9rB
         HpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qaz5JfSXEexVzd3vu4/X1zvrfhtSmuN9aWiTUHv9SJA=;
        b=E0+AataMUa682FCPcKRIc4KvhuaaCmYoq84qvddpsAneH0F7ANcc83+0z66qme/Nb0
         5P+AW45235aYe5+xvp/0pj7x9VHBQR0ohmUYunXOKP45K5kE/znJ3rGuVbdTAEV9Sjdj
         6Zl2VRteDgd7vk9oiqyM29mFNj9LpBnp/OEJ/AJsY4suAehQknJBzbndfNvpKbl3g7XI
         Ds6rHH7eILjQcfDbvUrMGUDC/h06piQzXkqOGLbTp33Beuz8hzzTjw477TvRbSmlVfIg
         Jdz6W3oU+F3AWXWjpDcfLLwIElfTxfkfVMTRRZMHi10e2N+L4dpunQZPoM6ohiQswYG+
         3SIg==
X-Gm-Message-State: AOAM5300m2CpRdfY0z3urnwXhd+zDPol8hAA3jVt4gRa3zgBoCl1vHqm
        HqBG+zXV9VKPMKDW3z2Z8V0=
X-Google-Smtp-Source: ABdhPJyn8OECd6Yk2g1TFuxtsKbYq4FLzAeVOngn/1xDW9/NSK6CjFcd/h0m9+vl0XlPDiPDXxLHrQ==
X-Received: by 2002:a17:902:d698:b029:d6:b974:13c5 with SMTP id v24-20020a170902d698b02900d6b97413c5mr339670ply.13.1604639563004;
        Thu, 05 Nov 2020 21:12:43 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id j184sm320461pfg.207.2020.11.05.21.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 21:12:42 -0800 (PST)
Date:   Fri, 6 Nov 2020 14:12:40 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-safety@lists.elisa.tech
Subject: Re: [PATCH] printk: remove unneeded dead-store assignment
Message-ID: <20201106051240.GC4718@jagdpanzerIV.localdomain>
References: <20201106034005.18822-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106034005.18822-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/11/06 04:40), Lukas Bulwahn wrote:
> make clang-analyzer on x86_64 defconfig caught my attention with:
> 
>   kernel/printk/printk_ringbuffer.c:885:3: warning:
>   Value stored to 'desc' is never read [clang-analyzer-deadcode.DeadStores]
>                 desc = to_desc(desc_ring, head_id);
>                 ^
> 
> Commit b6cf8b3f3312 ("printk: add lockless ringbuffer") introduced
> desc_reserve() with this unneeded dead-store assignment.
> 
> As discussed with John Ogness privately, this is probably just some minor
> left-over from previous iterations of the ringbuffer implementation. So,
> simply remove this unneeded dead assignment to make clang-analyzer happy.
> 
> As compilers will detect this unneeded assignment and optimize this anyway,
> the resulting object code is identical before and after this change.
> 
> No functional change. No change to object code.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
