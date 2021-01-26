Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCB4304F60
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S317761AbhA0BQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 20:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729983AbhAZSYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:24:22 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9407AC061573
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:23:37 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id h7so24058710lfc.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XtdgBPFahvgaELlSOmyvXzuSR0oQfBLE9eTEerXiFA8=;
        b=lSo1AsVUyrsXbkHnBucUDSimt05Cl2UqekyycnK2RHLnjXD56t+PZYrWtLfee7rHiQ
         XgoVDzoQGihwgUBK0zg1sSi1fRdV4UFgpcfnDqtHZCDADS330Xd0dZt+qx470fUj4ZTU
         yZZ2nA0/Dm8CWoIgfYSEoduOaKZbaHysPjMt4Acxzlbdj20D8AezAXdnMIcynAx5qAHG
         cejXIwxOBC6dSswd0FiM/XFhY1ZUKaIYvgvXdoWNfH+P2GfPotSGDiDqYTd1thPay4gI
         vwtneCh7eoejDempUCF0AoazI3jmpzsrKDBDJxioaji80pjI0uwLJNAuMrEkqnzXe3/L
         87Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XtdgBPFahvgaELlSOmyvXzuSR0oQfBLE9eTEerXiFA8=;
        b=QoTyRU11joVZgl4EpHQO8F+WFNVwxKY8ro+gmqcfxT+P6RuN90MxBui7R2skJH4dsI
         8c9xmtvAmTgt5PIiHx2cyEvtGTM+/uyqNC+LxBgfyKEz7qnCJCi5kFhnJq3ajVOMw4lQ
         vbsp5ZnXIOMkpbe4m5QaT3OHvMZ45oI4i4bjGiT1ocR6HLPjJaAjRli2RGpX7f6mpxQA
         kCKeMBcCkXDS4TwuwF8dI8f2CqCJ4L4AGIFFxmSJ2Qvam5jJwKtrEobMrZ4GDU46LqaL
         fEg3cqzo1QmtSYpFUR0K51ZEGyAaco6vAFkf8uL2nMo0f4DwfWmgakBuUf9xzlChn4QH
         UQ8w==
X-Gm-Message-State: AOAM532ctL3kvnPjDr+sPoo4NRUFLdVLt54JhYVarkMOugI0aha0Qo7/
        WruMna4p9WTd3WJfeyEeKKMFgY6pp7b14/nPsPYvmYFaCvZL5yUD
X-Google-Smtp-Source: ABdhPJxaca0rDSSokMd1hynWG7C9UfvWR/MNXrzMTuUeUuZRk776I9D4E5D5CFDZEcArAeqDuT6+jTIoQzeb70qpZXo=
X-Received: by 2002:ac2:5e73:: with SMTP id a19mr3131600lfr.23.1611685415729;
 Tue, 26 Jan 2021 10:23:35 -0800 (PST)
MIME-Version: 1.0
References: <20200914133626.hlsvu5kces3wsirr@google.com> <20210125200756.1249239-1-oupton@google.com>
 <87pn1ska6c.wl-maz@kernel.org>
In-Reply-To: <87pn1ska6c.wl-maz@kernel.org>
From:   Oliver Upton <oupton@google.com>
Date:   Tue, 26 Jan 2021 10:23:25 -0800
Message-ID: <CAOQ_QshK6HoaLqbaCVEgOPACK==Wb3-ADUhoUeQ0W67bK9zqqw@mail.gmail.com>
Subject: Re: [BUG]: KVM: arm64: Fix symbol dependency in __hyp_call_panic_nvhe
To:     Marc Zyngier <maz@kernel.org>
Cc:     Sasha Levin <sashal@kernel.org>, dbrazdil@google.com,
        hns@goldelico.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 12:56 PM Marc Zyngier <maz@kernel.org> wrote:
> - Cherry-pick 9fd339a45be5 ("arm64: Work around broken GCC 4.9
>   handling of "S" constraint"), which works around this particular GCC
>   bug
>
> - Cherry-pick dca5244d2f5b ("compiler.h: Raise minimum version of GCC
>   to 5.1 for arm64"), which forbids GCC 4.9 as it has been
>   demonstrated to mis-compile the kernel (and this patch is targeting
>   stable anyway)

If the latter is hitting stable then it sounds like high time to throw
out my broken GCC. Thanks Marc!

--
Oliver
