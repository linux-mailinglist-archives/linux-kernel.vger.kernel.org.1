Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D10C2E8B9D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 11:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbhACKMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 05:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbhACKMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 05:12:33 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC662C061573;
        Sun,  3 Jan 2021 02:11:52 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id h16so24189415edt.7;
        Sun, 03 Jan 2021 02:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L8zc+Hq2WA1BSA4ok1MpCWxUZ6tLQD6JKTFLYm6lrhE=;
        b=jMYWm1FFOkqoQcpOCbSVg5+nFpPYq+vqHQ6QzgOAwJe7753Sw+ZNrYfHPSPM07Mh2V
         tHLW5fv8fiKYjZEo3kOZv15snm65SRwnRhUDq8JOTrqZm11wkpOJyzBCxzMxwbdqrd6q
         zE5Wluvp+ZxchFTMoPLZ5YJtAycnwAnNayCLLWYJ4wsHV6985D609TuCJGNt2+bS9w0i
         GiQXTaUTyP9s0SVwlYJZrUKY20YY20Ykmf9PD4pWOdan+lO8BRKcAO9QIiF7tW7rJpqS
         f3Rdosl0gNWbfem8QzJUuTDSIHcr2dqSr3RYT5u5U9CVFsztN6qJRM/2GIqf4S+yw4d0
         Lj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L8zc+Hq2WA1BSA4ok1MpCWxUZ6tLQD6JKTFLYm6lrhE=;
        b=fjZl7PzlTwg7poPyfLUN9ilALyRF9+88fu/qhQyucd9dkju98HFwlOH+noQU6uzuSB
         4+IvZiXKIT6gWnv7Tt2UspOPFbangXzeynZzY1J/cfm8OfepVF1imeLimghqMsJXEhsK
         K8ct+Yaf3PVORyABWKKlYdWI0NSbQhCRgmkr8BINqHDXJtlyWAqzvQ78yXcChG6wRXwf
         mHDCr3lPNm9EQR+t8KVjk5pS+hjswBUyrnyxtCYnzvltLepbec7cLLitDb6AB6k7YGBb
         TKuDRGSV0L7xi7fOLmLkxsFi5FEZ8l9KjO2j/0dCOvo/bSHmplT16ATtOxPFR57UjocX
         222A==
X-Gm-Message-State: AOAM530cCVf7mJhc4ivMh2ekX7HPO/a+d2jRRyqAXBztKUTj4d09XFFV
        RY7LH6MJgSkTgAcJ89AzL8Qt82ZK5rwW65Dh+Us=
X-Google-Smtp-Source: ABdhPJyjc4wxyuyr5DpVrBvoavb8dgO6FNjz6ZjtDREOtcytq2OneIKiL94S+FJHdVO7UDi+Jz+Q3EUnQr14pbMQoyk=
X-Received: by 2002:aa7:d99a:: with SMTP id u26mr67681244eds.32.1609668711489;
 Sun, 03 Jan 2021 02:11:51 -0800 (PST)
MIME-Version: 1.0
References: <1609593874-64422-1-git-send-email-guoren@kernel.org>
In-Reply-To: <1609593874-64422-1-git-send-email-guoren@kernel.org>
From:   Pekka Enberg <penberg@gmail.com>
Date:   Sun, 3 Jan 2021 12:11:35 +0200
Message-ID: <CAOJsxLGwdrw6t665+Q8k5o_2P8y7fxNV3s_SpQLD_toPg8Db_w@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fixup CONFIG_GENERIC_TIME_VSYSCALL
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@wdc.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-csky@vger.kernel.org,
        Vincent Chen <vincent.chen@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 2, 2021 at 3:26 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> The patch fix commit: ad5d112 ("riscv: use vDSO common flow to
> reduce the latency of the time-related functions").
>
> The GENERIC_TIME_VSYSCALL should be CONFIG_GENERIC_TIME_VSYSCALL
> or vgettimeofday won't work.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Atish Patra <atish.patra@wdc.com>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> Cc: Vincent Chen <vincent.chen@sifive.com>

Reviewed-by: Pekka Enberg <penberg@kernel.org>
