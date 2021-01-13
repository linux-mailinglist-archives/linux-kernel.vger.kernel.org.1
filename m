Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90E92F4342
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 05:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbhAMEhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 23:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbhAMEhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 23:37:12 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705BDC061794
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 20:36:32 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id w2so444293pfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 20:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=ogtrVGZ6pAo0ADV9qwAesULOZDDOSRXRQwB1gmpCX8s=;
        b=JNhHVXk/UfFxEOuGHLDZxxdRz1GzMEbSz/1g2abyF+tnPs89EwF+oUHBl/iUnN2nB7
         ZBFIe+8+vaOSORcohr2CIiZgPS0JcspM7MA2KNFtlDMc7fROec2PxygF7aMY/4w4eDDD
         nCZV4Owfn2uRfJAPdDDUHOLJzbcVWmOUaN8S5OuwzYeYjvAIwMPuVXYfc9bapC35N54I
         EAhu8TUwqdg3MKG3P7ka9e69K9oxhoExLRsraaeuIWagPnh4UKhR1oBlq8Yr6hgXAiGs
         bvOsXbIMH8ob1IA1dzYdQNBSYnzfM6hD0GampWUI8HEHlIcETCUyVdf/JVbOazJq7n5R
         OpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=ogtrVGZ6pAo0ADV9qwAesULOZDDOSRXRQwB1gmpCX8s=;
        b=c4Ic0T9JNuFzy662IpmLlMgZxNXX7bznZveZRYD/6cg1G1mMeaNHQCEddicY8qSRZV
         Nj4dn2FQnyhtvfojlpfUyuNN/AY+vAl7jn0JvwnCLRmJ4sH5sABvBW3SjxgP5MTFZiCb
         e6ZVYoCCqrQlNhYO238gHhExTv4fy4H+LMNYNzdK9fJlCBpS6Uwz2fUBYivrs4eF8qo7
         bpCm8cYMU1sNONhxNAyjI9qVTx+oJGpuuKdbFmXpIrZ769W7NRdkNOLJDCkHJWE0fk45
         0BT+fzKwyQtQfka2dUuZYeSlYonpZS4yz+561axvsTncrASd0yXGNbJW1iBJEKzXDa0x
         al2Q==
X-Gm-Message-State: AOAM530P7RdiNHmJ6O37w/blVB5sRUZqycfHUZlN0/QKSpI6ZFVlW/3r
        E9FLONvvOfYDrZQXmmYU8Yq2eQ==
X-Google-Smtp-Source: ABdhPJyZQ4/PvLkpMLQMJw9Yk9cgwnCJD0Cvh1T6jj83SqfE84Pw82Sr82NFhWGF8VJvPwBXBeP7cA==
X-Received: by 2002:aa7:8209:0:b029:19f:3002:513 with SMTP id k9-20020aa782090000b029019f30020513mr257917pfi.49.1610512591844;
        Tue, 12 Jan 2021 20:36:31 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id a22sm747129pfa.215.2021.01.12.20.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 20:36:31 -0800 (PST)
Date:   Tue, 12 Jan 2021 20:36:31 -0800 (PST)
X-Google-Original-Date: Tue, 12 Jan 2021 20:36:21 PST (-0800)
Subject:     Re: [PATCH] riscv: Fixup CONFIG_GENERIC_TIME_VSYSCALL
In-Reply-To: <CAOJsxLGwdrw6t665+Q8k5o_2P8y7fxNV3s_SpQLD_toPg8Db_w@mail.gmail.com>
CC:     guoren@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        anup@brainfault.org, Atish Patra <Atish.Patra@wdc.com>,
        guoren@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, vincent.chen@sifive.com,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     penberg@gmail.com
Message-ID: <mhng-2092c5f2-ec27-4a8e-bb91-4c4ccdc1c5e1@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Jan 2021 02:11:35 PST (-0800), penberg@gmail.com wrote:
> On Sat, Jan 2, 2021 at 3:26 PM <guoren@kernel.org> wrote:
>>
>> From: Guo Ren <guoren@linux.alibaba.com>
>>
>> The patch fix commit: ad5d112 ("riscv: use vDSO common flow to
>> reduce the latency of the time-related functions").
>>
>> The GENERIC_TIME_VSYSCALL should be CONFIG_GENERIC_TIME_VSYSCALL
>> or vgettimeofday won't work.
>>
>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>> Cc: Atish Patra <atish.patra@wdc.com>
>> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
>> Cc: Vincent Chen <vincent.chen@sifive.com>
>
> Reviewed-by: Pekka Enberg <penberg@kernel.org>

Thanks, this is on fixes.
