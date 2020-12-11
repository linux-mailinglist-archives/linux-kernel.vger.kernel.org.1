Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9604D2D6DBA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 02:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390726AbgLKBso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 20:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390683AbgLKBsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 20:48:39 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44A9C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 17:47:59 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id n7so6084083pgg.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 17:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=fA3qErY5xWtluykmP171Qn295o/oLmlgFbu/oLQ6EYU=;
        b=BkB8McS41LHbQfbR5XFx7gpaMm0wLA8+/dGBqOeJ/bO6i8JBz2Jm3oNfR/o/pumZfg
         FUj7RcMwZ4VDu4qIb2lbTqzMgEp45T0zL4UcPh4/oYuIH4at+9rScAnKQcuDTrhD5pN/
         xf0z+tS+jRmmQnwuQTjVo+twinS6+DP28y7h/MV5HDRTKvZ6h4Ttc3JBMB0XTBvi2IBu
         stnZDYdWgwRy6juvNby4nGOaHJZIkrGx27VybvEbXyyzR4uIphqmYPdh5NUJRdVleSLV
         0nhrP/EjMS//IUzXWOGZX28goJlNHl8pZv+YG5JukdpPtziVxNkP7jxOzb4xr6NcL/Jy
         QTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=fA3qErY5xWtluykmP171Qn295o/oLmlgFbu/oLQ6EYU=;
        b=Tbg3cs57SdDkzPj56GZ4HxvPLTOq2MzfjjKfk1fUTcdRKdwbukAVePD4dmhFg4wX7U
         NYx31HUnCVa1Djgr0/dF9J61KcnJyimx6lUTnBrfMGzXtx+Y0DUQ2vTzM0Bh01LDasaC
         HDjb/0TFkW/bLwY4jgT8HUfLxiqkiw6MdZzbnbgG8R1LhC/vVjBkU/Sfn056T2I18tCg
         npA6Hoh+J39hkyWh2nt/Q3G8id2bgLCsxBL1ojMx2TLr2lr8Zm3ScN+ayws+iGbuFLrU
         UXg6Djdxdi/6g93cR2DpI100yf3U+rXGtBFvMQcyHRjhFmfZJtaN32gGv17In8VdYQWh
         +Mqw==
X-Gm-Message-State: AOAM530TGMXpeMET61/TMRF6ZPXoSIm9MPeHkjYs07HsGOBx1i+X8W5P
        Fo+oqIe+4RaE18INZhXXST2rCQ==
X-Google-Smtp-Source: ABdhPJw2xx8Obho74Imst8OWUtZv32cQkKCQwZoys+cHZFd+IuxekDBxbleOpirENmy/BAtWF3VKfg==
X-Received: by 2002:a63:4c41:: with SMTP id m1mr9306781pgl.427.1607651279205;
        Thu, 10 Dec 2020 17:47:59 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id q23sm8007344pfg.18.2020.12.10.17.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 17:47:58 -0800 (PST)
Date:   Thu, 10 Dec 2020 17:47:58 -0800 (PST)
X-Google-Original-Date: Thu, 10 Dec 2020 17:47:52 PST (-0800)
Subject:     Re: [PATCH] riscv: Fixed kernel test robot warning
In-Reply-To: <871rg0cajt.fsf@igel.home>
CC:     jrdr.linux@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, guoren@linux.alibaba.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     schwab@linux-m68k.org
Message-ID: <mhng-0e645b05-d32f-42ea-874a-4c91273f5bb6@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Dec 2020 12:22:46 PST (-0800), schwab@linux-m68k.org wrote:
> On Dez 09 2020, Souptick Joarder wrote:
>
>> On Wed, Dec 9, 2020 at 1:21 AM Andreas Schwab <schwab@linux-m68k.org> wrote:
>>>
>>> On Dez 09 2020, Souptick Joarder wrote:
>>>
>>> > Kernel test robot throws below warning -
>>> >
>>> >    arch/riscv/kernel/asm-offsets.c:14:6: warning: no previous prototype
>>> > for 'asm_offsets' [-Wmissing-prototypes]
>>> >       14 | void asm_offsets(void)
>>> >          |      ^~~~~~~~~~~
>>> >
>>> > This patch should fixed it.
>>>
>>> Or rename it to main, like most other asm-offsets files.
>>
>> Few asm-offsets files named it as foo(). Does a rename to main() will
>> work straight forward ?
>
> Calling it main will suppress the warning, but other than that it is
> completely irrelevant how you call it.

Ya, I think it doesn't really matter so I'm just going to take this as is.
It's on for-next (being a bit paranoid, as we're so late in the cycle).
