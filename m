Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A332CBB10
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 11:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbgLBKxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 05:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729572AbgLBKxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 05:53:34 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28ACAC0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 02:52:54 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id k10so5924674wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 02:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fTk5ZoMxl2Dxqumf7u4Qnd2EaEr81+Im7mQ9sIqBUJU=;
        b=TROfNdG2KypZn9EpSOwlb9+diN74hPSLXGQFQ1K7Pe+I3/DKnL1tqa5zZmMI1p/5s5
         zOXTs0/elveQ17G20vtsR9I/fio5JV7+AZa0fIA1owX1JLoCEvgn7PoWBE0JTeG+AU2U
         T9CPjV+z7KGpuVj2SpTjm/4wTEswofei8ANOGlRfI4/5hVi3bKq8RnkRRVGa+PH0M36d
         sCe6/DCjx09MOA7ro4JUDAPbOA8/SjizGBLIlJ+pqZN7NNIFFDhhkNW9R3CeitbI/Nmp
         ZCPk7D+RBHgi09Niy5pGl+c4iVcgVNJB7xC0ERjosaBuqp72kr1nSwHyRmMcIfFmMzrX
         IU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fTk5ZoMxl2Dxqumf7u4Qnd2EaEr81+Im7mQ9sIqBUJU=;
        b=eqV6zioxysNPRSn4JUVwsRLCq1/99ene7de+lYvEICsZBk3ZOSCpMbKv0rFHNlNPYe
         5ZvXIJ0IyM1MSViM8Zi/fRo3bdqT6a+TgWQFW1hqYu0yjTSc7FHZ+9oivLfXTNSx2sC+
         iTYuyRE+1av5kEvgLe6ebZjshAd1jy6g2O5qwvDyaaVB03+uTO4vtwA36pFMS+j5xSXP
         uvMmr+y/IKTD6YdqrQr70rGEr9nzB3BQcKJSsVN7o4hRIhMbJKLZizpbZHCgjv6VMvm9
         fwjgQJZPL716cCjJj6AaU/NXngJYlsFLI7eb05s5mMwo4uf+6WhYoOe/v5JuQJVLtMkK
         EDCg==
X-Gm-Message-State: AOAM532uP7WkofAUfEhFiv+7e/ktPceuSyWnbP5qf1D42p9QOh3Dibij
        nqh77kPJ63W95DCj77TEtmFKnA==
X-Google-Smtp-Source: ABdhPJzJkfVaUHDiTtxDOSxfolOceqftBjklVDdbG5b242B+yUv0o+xUhYVkVeMB+gRkOP1olpqFGA==
X-Received: by 2002:a1c:99d3:: with SMTP id b202mr2559654wme.0.1606906372659;
        Wed, 02 Dec 2020 02:52:52 -0800 (PST)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id v64sm1605730wme.25.2020.12.02.02.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 02:52:51 -0800 (PST)
Date:   Wed, 2 Dec 2020 10:52:48 +0000
From:   Brendan Jackman <jackmanb@google.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 bpf-next 01/13] bpf: x86: Factor out emission of
 ModR/M for *(reg + off)
Message-ID: <20201202105248.GA9710@google.com>
References: <20201127175738.1085417-1-jackmanb@google.com>
 <20201127175738.1085417-2-jackmanb@google.com>
 <20201129011552.jbepegeeo2lqv6ke@ast-mbp>
 <20201201121437.GB2114905@google.com>
 <CAADnVQJci_Fqq7d6GbUtivcmSgnPLbkwuH9MN30BhFomff=5rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJci_Fqq7d6GbUtivcmSgnPLbkwuH9MN30BhFomff=5rg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Dec 01, 2020 at 09:50:00PM -0800, Alexei Starovoitov wrote:
> On Tue, Dec 1, 2020 at 4:14 AM Brendan Jackman <jackmanb@google.com> wrote:
> >
> > On Sat, Nov 28, 2020 at 05:15:52PM -0800, Alexei Starovoitov wrote:
> > > On Fri, Nov 27, 2020 at 05:57:26PM +0000, Brendan Jackman wrote:
> > > > +/* Emit the ModR/M byte for addressing *(r1 + off) and r2 */
> > > > +static void emit_modrm_dstoff(u8 **pprog, u32 r1, u32 r2, int off)
> > >
> > > same concern as in the another patch. If you could avoid intel's puzzling names
> > > like above it will make reviewing the patch easier.
> >
> > In this case there is actually a call like
> >
> >   emit_modrm_dstoff(&prog, src_reg, dst_reg)
> 
> emit_insn_prefix() ?

Ah sorry, I thought you were talking about the _arg_ names.

This isn't a prefix, but emit_insn_suffix sounds good.
