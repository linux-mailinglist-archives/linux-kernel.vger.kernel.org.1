Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EED42F9EE9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 12:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403776AbhARL5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 06:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389306AbhARLo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 06:44:29 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7993CC061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 03:43:35 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id q20so10047510pfu.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 03:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ipwUR8PxhfU+Q1ZYePZ+2uiR+ifyi9sSeLsGzpWteYI=;
        b=OHKSFORq3aPYGXkNol6QFJwUarkQu0y4jqiN55AZhYAk4QEd6YLrfzcLgHPB5tPKXC
         yeysszVwrjRPmRmSSCZ5M9PisvELHCllPwNsS5H4MQ9RedwFcXzyZHBN6jRVTdpyAVo0
         83yyJR2bTfTtyrW++Vk+fst4cxW1vBzu48YzELoTTRLnCaID56mrpGpaltyUdma8GvVI
         ndSrDGFCBdsv3Jr/PxGkEEyFfTidTBfWlX7/yT2woQMykTe0WCMGjlwj7HJqpATO3ijE
         erOZzHEWp2LJbskJMRMuRzgn5lhZ3oaJplrPwlAy2u36PHG9qWMRIxnlIeRnvHBwuXYx
         h1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ipwUR8PxhfU+Q1ZYePZ+2uiR+ifyi9sSeLsGzpWteYI=;
        b=Lnuk6sOvXq3GaTHRjoZIGmSvUc71qs/+vZlHJGnMgQbZGUHcFIE1Bm1NI//1pxsbsS
         a2N9qs0DY0V+iX4CotddGy+mWIkHBeanRUJfc7PS7UgTRYmoLRQOYjLwnPmcj8Lqb6R3
         YRGLgyW36Ewan5N+qT9lX6K2oPFtNpU2G7flAPevNuGqNdQSMuTIkE6bJrHqPA+EiU/m
         iM7k0iO4C3u1l2HbDytE0GUBsA5iU3rofT3FNkrPgWDiMsmqAOEr6OnQCtcH2sppxs/L
         V1QNvu1YyfPgQUfh2Zo7eIGK0kqSdS3LQ2HO7/DjmH/6JhxiydMLsWEvcr0bUG8KME/a
         R/sw==
X-Gm-Message-State: AOAM530LuBRommuWnzw97wuytw99uWoDZhjUcHlsQKGwPtmBX6C1/31D
        7CKkF8B3c07KEXO6EqpXtxE=
X-Google-Smtp-Source: ABdhPJyRWp0u0IfEBMogxiAcjrN+/YzGe+K9aa50ZJwZvou9FRGAuFZUe70rTLST1fnFWgA9yxTTgw==
X-Received: by 2002:a63:c205:: with SMTP id b5mr25375887pgd.281.1610970215062;
        Mon, 18 Jan 2021 03:43:35 -0800 (PST)
Received: from localhost (g238.115-65-210.ppp.wakwak.ne.jp. [115.65.210.238])
        by smtp.gmail.com with ESMTPSA id s21sm15439461pga.12.2021.01.18.03.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 03:43:34 -0800 (PST)
Date:   Mon, 18 Jan 2021 20:43:31 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v2] drivers/soc/litex: Add restart handler
Message-ID: <20210118114331.GF2002709@lianli.shorne-pla.net>
References: <20210104164500.1311091-1-geert@linux-m68k.org>
 <CAMuHMdXG_B-3y1MWh64T6LU3Gmo6UQGGWU8EbLApjDeXVLL3GQ@mail.gmail.com>
 <20210114020311.GE2002709@lianli.shorne-pla.net>
 <CAMuHMdWnrPBAh_U43C7jA8wDvyAegqCM3OP++NkkiT1Co5yjkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWnrPBAh_U43C7jA8wDvyAegqCM3OP++NkkiT1Co5yjkQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 02:48:49PM +0100, Geert Uytterhoeven wrote:
> Hi Stafford,
> 
> On Thu, Jan 14, 2021 at 3:03 AM Stafford Horne <shorne@gmail.com> wrote:
> > On Mon, Jan 04, 2021 at 05:49:03PM +0100, Geert Uytterhoeven wrote:
> > > On Mon, Jan 4, 2021 at 5:45 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > Let the LiteX SoC Controller a register a restart handler, which resets
> > > > the LiteX SoC by writing 1 to CSR_CTRL_RESET_ADDR.
> > > >
> > > > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > ---
> > > > Tested with linux-on-litex-vexriscv.
> > > >
> > > > This patch is based on upstream, i.e. not on top of Gabriel Somlo's
> > > > "[PATCH v5 0/4] drivers/soc/litex: support 32-bit subregisters, 64-bit
> > > > CPUs"
> > > > (https://lore.kernel.org/lkml/20201227161320.2194830-1-gsomlo@gmail.com/)
> > >
> > > Bummer, and that's why the RESET_REG_* definitions are no longer
> > > next to the SCRATCH_REG_* definitions :-(
> >
> > If it helps I have accepted Gabriel's patches and put them onto for-next.
> >
> >   https://github.com/openrisc/linux/commits/for-next
> >
> > I am happy to take and test a patch based on that.  Or I can do the adjustments
> > to base the patch on that myself.  Let me know.
> 
> Thanks for letting me know! V3 sent.

Hi Geert,

I don't seem to see v3 anywhere.  Where did you send it and what is the subject?

-Stafford
