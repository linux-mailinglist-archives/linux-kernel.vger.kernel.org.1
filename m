Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9234B28DD3F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgJNJXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730637AbgJNJXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:23:13 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB1BC0613D8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 02:20:42 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id h24so3777894ejg.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 02:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=/WnbvhyGcptPPBaNZxdAo4mg51wxanwUK78khnzdGus=;
        b=wzFripj/9LraAMEmzYAkjL1sotjg/tzxIUOn+3rAhgYLrFGhBppxP58Fj8lJk3Gn6f
         QxLE5MOpTScSC67rQ7Y+wNjc6xZaYQ9QPsCqwz0rO1XIwgM+0wXdDQlLbNfLAo/aDtwN
         8hhmK9wr8/zE8x05W8XeZ6xBYiKnxtZ9qgrbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=/WnbvhyGcptPPBaNZxdAo4mg51wxanwUK78khnzdGus=;
        b=KZNSBKTGp4UkN56D2LxKkPBczRfwIpWiAzHet3OSCGThKg6pPjxvpqO2oOCEECjG6e
         VMbfVmJDLF61hCh8JOlQGAvHdkPPoSd6GTirv0VkhRCU5KVB8ft9p2fWygOnwniliE2J
         MAR1uogBMUITQbwePF1z64105+ByDjUAX25q5ZTeGiTT4B9ayU/E5Hk1+vEbYGG5AkXp
         IS/xX1FSUM9VcaM4iSTELtvFD0qWAC9BPqwO4PbgO2SaoUF41qu/2R/lJ5JUBFmcDWTH
         jIY/v9FeSXWOKg9c2GOdG23oR8pJyC5+0QW68b3bc3V9KJXZTPK88VsahJVWrCGlSwHp
         U+sQ==
X-Gm-Message-State: AOAM530c/teQJd4drijR37+7p82cIvhnhJLM3l3zfqmanbEl60ugDudF
        gGtS+1WVfzOpEnMLf+Lh6vxI+g==
X-Google-Smtp-Source: ABdhPJxUvxlmotUTKMITZb02Wylkh1sw157EQWmBLNMnqJxc/0hczSTt/IE/DTObQL8sz0hci2Atmg==
X-Received: by 2002:a17:906:c015:: with SMTP id e21mr4156437ejz.432.1602667241168;
        Wed, 14 Oct 2020 02:20:41 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id bw25sm1326231ejb.119.2020.10.14.02.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 02:20:40 -0700 (PDT)
References: <20201012170952.60750-1-alex.dewar90@gmail.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenz Bauer <lmb@cloudflare.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sockmap: Don't call bpf_prog_put() on NULL pointer
In-reply-to: <20201012170952.60750-1-alex.dewar90@gmail.com>
Date:   Wed, 14 Oct 2020 11:20:39 +0200
Message-ID: <878sc9qi3c.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 07:09 PM CEST, Alex Dewar wrote:
> If bpf_prog_inc_not_zero() fails for skb_parser, then bpf_prog_put() is
> called unconditionally on skb_verdict, even though it may be NULL. Fix
> and tidy up error path.
>
> Addresses-Coverity-ID: 1497799: Null pointer dereferences (FORWARD_NULL)
> Fixes: 743df8b7749f ("bpf, sockmap: Check skb_verdict and skb_parser programs explicitly")
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> ---

Acked-by: Jakub Sitnicki <jakub@cloudflare.com>
