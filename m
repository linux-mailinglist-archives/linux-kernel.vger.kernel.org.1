Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6B82E6CF2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 02:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730569AbgL2BL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 20:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730280AbgL2BL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 20:11:27 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA279C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 17:10:46 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id v5so8079802qtv.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 17:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jTblGVy12KttnCpCdJ35MVlE2TQ4BSno7et+Y7H5Mfg=;
        b=j9heRQVh+jzLspOpfU+dZ9v5/6Yj4OgxBhU4m/3bCIK52i36ADCx9E3y8Cb+Za1Xbk
         VvFFevVP0fTjYWjeOVYlmirhCGyXErQlr5EiB7WkWvngFsLeTQ6iNO7txJquQqC7W4zA
         pahrsdYaVf2uocS5iyV4Fs7SsHVusLSg5u/rSP8nuW3cvCtsXuhHXlC1vXcDb/K/hIEj
         YsLDodEMgkmahlL1SL0a3ti/iUtKR4c03lVRnc/7kc9wxIqd0XqK1h8OScYsBFLBSJiu
         F6oY07OLzpdrlpHOIufpNKb70jQ23lGOtq31TydflOmFr2FHdqDu1nu+BPlQwOXGH0lW
         m5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jTblGVy12KttnCpCdJ35MVlE2TQ4BSno7et+Y7H5Mfg=;
        b=Dlt3x0zf7QTHxLPmPJU8hHqCn+XjwcCLp4RDiVHqanJ5V9pFiRqsTXFMJns6fzgg/z
         I11FLEcRZydArup9OCpRl0JFGXNpRqBEdzoDLdTbRe/gbJN3CcX1YrRTOhUswvAfqJ21
         xSPLA2mpxT3h8IusVlySdOjMyg73/YM1/EaD+bWQrE7uOGvgqVAYxIn+cF3wFuPQ2QLz
         s89vFXjx1hlvkpTjdf2Nr92QcNbF19OhnQ7fOfMqUdWqrqEdOJCrQ5Ikg+LPHfXTWkvD
         eyH6sXVMJ1e+8KHIzJTtDwXpjr05HXPMX5ZhelyUctECw2grWpNUz6wKtHQjvD1jBbCI
         jSag==
X-Gm-Message-State: AOAM5328tHpBIgBIfKLNFBZttze7wqP32UQV7Cdzacm5cGIBMxdGpnaY
        xHcdAPVhbqOWz+j6BgrWlQdQcM8v5UV0xrYDRFs=
X-Google-Smtp-Source: ABdhPJytjvaYrurpuqAHSjl12rETbCix8KlKt/uoQw+UZHZHfkmwyxpaTa/cAiCJAv+urriOgPavUVfxHZwHLlT5RU8=
X-Received: by 2002:ac8:58d1:: with SMTP id u17mr46735628qta.158.1609204245809;
 Mon, 28 Dec 2020 17:10:45 -0800 (PST)
MIME-Version: 1.0
References: <20201228130853.1871516-1-jannh@google.com>
In-Reply-To: <20201228130853.1871516-1-jannh@google.com>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Tue, 29 Dec 2020 10:10:34 +0900
Message-ID: <CAAmzW4P9OQTh0TYfKUc6Q6z1j0-ewfmOD3c18b9tHPNy0T45hQ@mail.gmail.com>
Subject: Re: [PATCH] mm, slub: Consider rest of partial list if acquire_slab() fails
To:     Jann Horn <jannh@google.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 12=EC=9B=94 28=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 10:10,=
 Jann Horn <jannh@google.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> acquire_slab() fails if there is contention on the freelist of the page
> (probably because some other CPU is concurrently freeing an object from t=
he
> page). In that case, it might make sense to look for a different page
> (since there might be more remote frees to the page from other CPUs, and =
we
> don't want contention on struct page).
>
> However, the current code accidentally stops looking at the partial list
> completely in that case. Especially on kernels without CONFIG_NUMA set,
> this means that get_partial() fails and new_slab_objects() falls back to
> new_slab(), allocating new pages. This could lead to an unnecessary
> increase in memory fragmentation.
>
> Fixes: 7ced37197196 ("slub: Acquire_slab() avoid loop")
> Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Thanks.
