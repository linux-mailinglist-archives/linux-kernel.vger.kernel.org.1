Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459492FBFC8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 20:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387698AbhASTFT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 19 Jan 2021 14:05:19 -0500
Received: from mail-ua1-f43.google.com ([209.85.222.43]:32836 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390832AbhASRzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 12:55:50 -0500
Received: by mail-ua1-f43.google.com with SMTP id k22so3329457ual.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 09:55:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Stocj1hJiSUyMpN8/XHAwp/pg2JCejqGaP8S1nhKqno=;
        b=YT7++0t4eYonCmQBHYvzO8BFV6/pcopsqs4VqsKQZvgG8yGayI7HiLHZjLro4OCm78
         lX4Exj//WNHUzx802JU/8nvIP5iCv4F7YVApGrjl1LgQRVxdvG9Oc+IAuaaNSuTZt0AQ
         eAaG4E/x3QpQZ3o6Mzmtm5/OXNVPt46ZiUvs0PiwWVgKxf84yyKzht42GhC9nuCwtZ/n
         y5UjVEOrpB5X7Hba6jMg5PawW3VhvZ7m3qyi9RYIwcawAR+wsj4iZiJCy1/YFzI2n0IU
         Fo8Z14h8Ok0TJaD0xo1UXUhlitz0YijnQX/cbFcHA73SPMYYZhVKHm2mteBcAWN/L7oe
         v4Wg==
X-Gm-Message-State: AOAM533+yYorTtGV3NcMknBgc4BBtn4IscDShhj0Q6dg/i8vuyn0kXoZ
        ogVQlyC1cBvoAO7tlCduG+oI6LkNEsM=
X-Google-Smtp-Source: ABdhPJyRY4WSglRArHzgMj/j9ySKfccwMGOsp/URciDE4jTSvhaqOvumdBwrMOu+CY8zYoThiMB5bQ==
X-Received: by 2002:a4a:81d2:: with SMTP id s18mr3608435oog.76.1611078388698;
        Tue, 19 Jan 2021 09:46:28 -0800 (PST)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com. [209.85.167.182])
        by smtp.gmail.com with ESMTPSA id j17sm3325256otj.52.2021.01.19.09.46.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 09:46:28 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id d203so22055605oia.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 09:46:27 -0800 (PST)
X-Received: by 2002:a54:4489:: with SMTP id v9mr570652oiv.154.1611078387805;
 Tue, 19 Jan 2021 09:46:27 -0800 (PST)
MIME-Version: 1.0
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
 <20191128145554.1297-5-linux@rasmusvillemoes.dk> <a80b9c70-f9f2-0f76-15d0-d7a1c926f485@csgroup.eu>
In-Reply-To: <a80b9c70-f9f2-0f76-15d0-d7a1c926f485@csgroup.eu>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Tue, 19 Jan 2021 11:46:16 -0600
X-Gmail-Original-Message-ID: <CADRPPNQLfw-JHLf1vpc6fB0DLAd9er2zM+BrxWQriujwTdx-sA@mail.gmail.com>
Message-ID: <CADRPPNQLfw-JHLf1vpc6fB0DLAd9er2zM+BrxWQriujwTdx-sA@mail.gmail.com>
Subject: Re: [PATCH v6 04/49] soc: fsl: qe: introduce qe_io{read,write}* wrappers
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Timur Tabi <timur@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Scott Wood <oss@buserror.net>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Qiang Zhao <qiang.zhao@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 11:35 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> Hi Rasmus,
>
> Le 28/11/2019 à 15:55, Rasmus Villemoes a écrit :
> > The QUICC engine drivers use the powerpc-specific out_be32() etc. In
> > order to allow those drivers to build for other architectures, those
> > must be replaced by iowrite32be(). However, on powerpc, out_be32() is
> > a simple inline function while iowrite32be() is out-of-line. So in
> > order not to introduce a performance regression on powerpc when making
> > the drivers work on other architectures, introduce qe_io* helpers.
> >
> > Also define the qe_{clr,set,clrset}bits* helpers in terms of these new
> > macros.
>
> Since commit https://github.com/linuxppc/linux/commit/894fa235eb4ca0bfa692dbe4932c2f940cdc8c1e
> ioread/iowrite wrappers are also inlined on PPC32, so this commit can now be reverted.

Yes.  That will be great.

>
> Christophe
>
> >
> > Reviewed-by: Timur Tabi <timur@kernel.org>
> > Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > ---
> >   include/soc/fsl/qe/qe.h | 34 +++++++++++++++++++++++++---------
> >   1 file changed, 25 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/soc/fsl/qe/qe.h b/include/soc/fsl/qe/qe.h
> > index a1aa4eb28f0c..9cac04c692fd 100644
> > --- a/include/soc/fsl/qe/qe.h
> > +++ b/include/soc/fsl/qe/qe.h
> > @@ -241,21 +241,37 @@ static inline int qe_alive_during_sleep(void)
> >   #define qe_muram_offset cpm_muram_offset
> >   #define qe_muram_dma cpm_muram_dma
> >
> > -#define qe_setbits_be32(_addr, _v) iowrite32be(ioread32be(_addr) |  (_v), (_addr))
> > -#define qe_clrbits_be32(_addr, _v) iowrite32be(ioread32be(_addr) & ~(_v), (_addr))
> > +#ifdef CONFIG_PPC32
> > +#define qe_iowrite8(val, addr)     out_8(addr, val)
> > +#define qe_iowrite16be(val, addr)  out_be16(addr, val)
> > +#define qe_iowrite32be(val, addr)  out_be32(addr, val)
> > +#define qe_ioread8(addr)           in_8(addr)
> > +#define qe_ioread16be(addr)        in_be16(addr)
> > +#define qe_ioread32be(addr)        in_be32(addr)
> > +#else
> > +#define qe_iowrite8(val, addr)     iowrite8(val, addr)
> > +#define qe_iowrite16be(val, addr)  iowrite16be(val, addr)
> > +#define qe_iowrite32be(val, addr)  iowrite32be(val, addr)
> > +#define qe_ioread8(addr)           ioread8(addr)
> > +#define qe_ioread16be(addr)        ioread16be(addr)
> > +#define qe_ioread32be(addr)        ioread32be(addr)
> > +#endif
> > +
> > +#define qe_setbits_be32(_addr, _v) qe_iowrite32be(qe_ioread32be(_addr) |  (_v), (_addr))
> > +#define qe_clrbits_be32(_addr, _v) qe_iowrite32be(qe_ioread32be(_addr) & ~(_v), (_addr))
> >
> > -#define qe_setbits_be16(_addr, _v) iowrite16be(ioread16be(_addr) |  (_v), (_addr))
> > -#define qe_clrbits_be16(_addr, _v) iowrite16be(ioread16be(_addr) & ~(_v), (_addr))
> > +#define qe_setbits_be16(_addr, _v) qe_iowrite16be(qe_ioread16be(_addr) |  (_v), (_addr))
> > +#define qe_clrbits_be16(_addr, _v) qe_iowrite16be(qe_ioread16be(_addr) & ~(_v), (_addr))
> >
> > -#define qe_setbits_8(_addr, _v) iowrite8(ioread8(_addr) |  (_v), (_addr))
> > -#define qe_clrbits_8(_addr, _v) iowrite8(ioread8(_addr) & ~(_v), (_addr))
> > +#define qe_setbits_8(_addr, _v) qe_iowrite8(qe_ioread8(_addr) |  (_v), (_addr))
> > +#define qe_clrbits_8(_addr, _v) qe_iowrite8(qe_ioread8(_addr) & ~(_v), (_addr))
> >
> >   #define qe_clrsetbits_be32(addr, clear, set) \
> > -     iowrite32be((ioread32be(addr) & ~(clear)) | (set), (addr))
> > +     qe_iowrite32be((qe_ioread32be(addr) & ~(clear)) | (set), (addr))
> >   #define qe_clrsetbits_be16(addr, clear, set) \
> > -     iowrite16be((ioread16be(addr) & ~(clear)) | (set), (addr))
> > +     qe_iowrite16be((qe_ioread16be(addr) & ~(clear)) | (set), (addr))
> >   #define qe_clrsetbits_8(addr, clear, set) \
> > -     iowrite8((ioread8(addr) & ~(clear)) | (set), (addr))
> > +     qe_iowrite8((qe_ioread8(addr) & ~(clear)) | (set), (addr))
> >
> >   /* Structure that defines QE firmware binary files.
> >    *
> >
