Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FADC2CC6D8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 20:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731198AbgLBTkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 14:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbgLBTkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 14:40:35 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AB8C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 11:39:54 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id j1so151766pld.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 11:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ydi4HQEGdLPC3660hxYwWFPTfiyq1GhMzuxagXQLKoc=;
        b=SNZPyrcNQxL4shNNaTqdctbADzrIrNcVU2kNiPAwgHzuYrD1v4sH5o+XaiPFHfEWu4
         La0Z+Ezk7MAt0/LjIzA9frYjUcWv5OrHP0w0PTCduCqBym7swrktUNmKGui7fPyBg7lI
         jgZRr1qeGruTbZqVPompHtVRGka2n8QmhapnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ydi4HQEGdLPC3660hxYwWFPTfiyq1GhMzuxagXQLKoc=;
        b=jfovY8OK2DIAODOtPS8ymY8Pw5MmAy4sWAo0DJYcsi6b98IO8r7TsUl2HmYOAFvZKC
         6tRSzS/FmV/agZoFHHbbQR0bZU72dPF6ly02jCAOZF8OFehzdiJNvUj4e84QOyTfeVTN
         RSPXLXfth3wGrj4kGZT2VW7Dn3LFyhW7Le1kSdZtrx9fGt+yXpQ9ejiDJIQnS/cBj9I4
         5RgNLpQrvcehbSvJK5LS1VSpjDc3CPGJXwqvdiwDR5kjQJwZW3xE1xpNhgji1FL9j+Rc
         Mw+l6RGPzX9tjAGBd7BSqGoI2WkmAYPEgEcgXJpvVSwsXdI2Z9ro19LBRDHBoYNliAFv
         zqFw==
X-Gm-Message-State: AOAM533aFMTYEKTwJfZ5D2baS/KFeTcnoSQQMvxJDK5h0shCnr6RuuNO
        KEykWGy5w668sWR3IbU4DCP8Og==
X-Google-Smtp-Source: ABdhPJyXW2dAYf3/QbG5U8YKNCieGRaFaw0Onro5pbHAo/0jF8ZCaWAwjTq22yvdixETGWAgTA2Yrg==
X-Received: by 2002:a17:902:324:b029:d8:fdf3:af34 with SMTP id 33-20020a1709020324b02900d8fdf3af34mr4040690pld.70.1606937994498;
        Wed, 02 Dec 2020 11:39:54 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q5sm600820pff.36.2020.12.02.11.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:39:53 -0800 (PST)
Date:   Wed, 2 Dec 2020 11:39:52 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Randy Dunlap <rdunlap@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH v3] x86/pci: fix the function type for check_reserved_t
Message-ID: <202012021139.FC8F149@keescook>
References: <20201130193900.456726-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130193900.456726-1-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 11:39:00AM -0800, Sami Tolvanen wrote:
> e820__mapped_all is passed as a callback to is_mmconf_reserved,
> which expects a function of type:
> 
> typedef bool (*check_reserved_t)(u64 start, u64 end, unsigned type);
> 
> However, e820__mapped_all accepts enum e820_type as the last
> argument and this type mismatch trips indirect call checking with
> Clang's Control-Flow Integrity (CFI).
> 
> As is_mmconf_reserved only passes enum e820_type values for the
> type argument, change the typedef and the unused type argument in
> is_acpi_reserved to enum e820_type to fix the type mismatch.
> 
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
