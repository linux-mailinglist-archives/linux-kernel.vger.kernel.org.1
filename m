Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D540328C7C7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 06:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731505AbgJMERg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 00:17:36 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:34139 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbgJMERf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 00:17:35 -0400
Received: by mail-pg1-f182.google.com with SMTP id u24so16657642pgi.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 21:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CrQSUKXJJMSMcm6ECc55Mfv3GGC11E3NxL+vhthD52o=;
        b=royjhJ5D2xUT9kRF2P+fZE8jBmTf/YtqnXe4U06oMWsc3cKQ4Ja9nKoLo8a0hrhdBZ
         N35Mx4XnAsCjVBDXbGRM/OGyo6gdUqDQkXiHEFALrWcVxWfyCw+z3RWzmLnl+py8VUhD
         YTQBh3vINwus/T0HRuosPZxgcJyZsqYB5n8OhFrVMRwrbrnDSxTdHkEh4z8K+RP+9bPH
         6/CGFKPR7+pbA+8okXfAlkS5/DkuZ+VLn7uYXzMOILNbu4jww6do9yw3fw6s/AzMq2DL
         HB/JWmB+dlrz/OZmyEo8gp69hypZfyhqI3q+xgVEfj3AJyRc1CjRRpcTAxZy5jB1l5o8
         VVHA==
X-Gm-Message-State: AOAM532AOCFjO4i1MYWmUeAcegf9CO0g0xc8/vhvN51JOz342tOR1snn
        yByVwDbZ2iuwVruLciNx/1Y=
X-Google-Smtp-Source: ABdhPJyRuE9ZHSzYleBVkdfpIie+P8DihPvBUtDeTw5V+gnCj4DGasr8P4Opt9ESsvlfgvpRl9J2fQ==
X-Received: by 2002:a17:90a:8c17:: with SMTP id a23mr23304823pjo.112.1602562654595;
        Mon, 12 Oct 2020 21:17:34 -0700 (PDT)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id w205sm21568816pfc.78.2020.10.12.21.17.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 21:17:33 -0700 (PDT)
Subject: Re: WARNING in udf_truncate_extents
To:     syzbot <syzbot+43fc5ba6dcb33e3261ca@syzkaller.appspotmail.com>,
        axboe@kernel.dk, chaitanya.kulkarni@wdc.com, jack@suse.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000b9fad405b179289b@google.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <2765fd98-7101-832e-2b34-72bd8c5ecf22@acm.org>
Date:   Mon, 12 Oct 2020 21:17:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <000000000000b9fad405b179289b@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/20 6:20 AM, syzbot wrote:
> dashboard link: https://syzkaller.appspot.com/bug?extid=43fc5ba6dcb33e3261ca
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10ce0a8b900000
> 
> The issue was bisected to:
> 
> commit 2004bfdef945fe55196db6b9cdf321fbc75bb0de
> Author: Bart Van Assche <bvanassche@acm.org>
> Date:   Tue Mar 10 04:26:21 2020 +0000
> 
>     null_blk: Fix the null_add_dev() error path

#syz wrong-bisect
