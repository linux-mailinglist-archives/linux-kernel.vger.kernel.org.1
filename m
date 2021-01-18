Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4142F9D37
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 11:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389545AbhARKwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 05:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388834AbhARK3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:29:24 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8DFC061575
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 02:28:43 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id d14so18138621qkc.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 02:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OYvmTRg9VE7k01lzg0q32naiEw2p5pLxGQxdorBtVnw=;
        b=ClbixE/QsyqzNAERa//lgLOmnVaRUAjOsueI76HBS0V78wDFr348XZ5b6a/wx2KK1D
         yK/nx7Gwf3d18eBuTKRXhGRenoIexM73Pt0pKj+q/mdz8sTxoUyWYv5u3zsz5XEuHvDC
         UcVOcgQohj/QFUuG5Xx0V4hFE92NQI2r9tuCa4aDkWf1vPeeq/W3Go20hiECBSnQkiHe
         gdHsrAalmY2wYVhMSUrQSbRDYI4Vb7Q7OZ3rt6DcHhu5IXrPZ3MXDjgacFxhdcgzWUmV
         deubTsKZiWNdvMMD5WhVCVG98gSrA2JuPK7GsqXQ5MW8br4xwVD94BtFAwBrCsP2t/2E
         +bQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OYvmTRg9VE7k01lzg0q32naiEw2p5pLxGQxdorBtVnw=;
        b=FOEaQZG088Vst3dOaIbvJqMUFIHzXvCZLOqK6o0BVAhaFdrMsnRXKPYPYlwFMhnI0m
         Poq+f5IYsJLoqEu4LA9us3CnrWJ4D8jgtwGAqQle3tsx6h3ZvwhpOZInc4mtp1y7hoqj
         irEEvCU2KLLGEboeNWRp6j3NnpTKDEYmbC5s7Q/uIJfvZPTR44qWAXxw6K2VbuO4Ifeg
         3jRVPgStS2ED9XRJcLqMTWG8pvG7Rf/nHa2m8aaJMfX2qd0nu+E3AGSW0wDktfp+KL/Q
         e+pWs3zAgUN8L6jYL0OlGChZ4frU7DtPAYK9NnPMFwT1oIYaQXf02X3Ml+aZOMs3EJCF
         DwSQ==
X-Gm-Message-State: AOAM530jUIfXgt8BCeZUaMliHtuUSJawaQtBZ0aDO9jX50QhXFNN/Mco
        AKeBQAyQB+6Pw41EagelmrfmG/rCjxC2sJhfk6u/XQ==
X-Google-Smtp-Source: ABdhPJwy3S6sxRUzs4imz+5+Etq1UBkEdt+ZlrwL59WULCFwjkPvS7bfzW/4HFxkgp7SCJ2KpFBUSTI+Z4sVAXmI3SY=
X-Received: by 2002:a37:a747:: with SMTP id q68mr23815802qke.352.1610965722962;
 Mon, 18 Jan 2021 02:28:42 -0800 (PST)
MIME-Version: 1.0
References: <20210118092159.145934-1-elver@google.com> <20210118092159.145934-2-elver@google.com>
In-Reply-To: <20210118092159.145934-2-elver@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 18 Jan 2021 11:28:31 +0100
Message-ID: <CAG_fn=U7C16Nx6rCfo2eN0yOxOjOBdHr7UU5wmMZtuCVad+ZnA@mail.gmail.com>
Subject: Re: [PATCH mm 2/4] kfence, x86: add missing copyright and description header
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 10:22 AM Marco Elver <elver@google.com> wrote:
>
> Add missing copyright and description header to KFENCE source file.
>
> Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
