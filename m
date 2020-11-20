Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10842BA19F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 06:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbgKTFDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 00:03:37 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33078 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgKTFDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 00:03:36 -0500
Received: by mail-qt1-f196.google.com with SMTP id i12so6354548qtj.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 21:03:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pi2oe6/BxPHqHcfD/n2FOnSt8intvrKAKlw7Go9DLCw=;
        b=ORj3zM8HFfgJ4eJBmgsgAUOMoCKx7rgwZekU/eJIyNSvvg8233LMc25Wt7aVQ+bbbv
         R5zzTS8wfvyzk3MVMY0sjBQlL8sS+07IVNus3VJMIF+poA76a4XVZrrrR1YW6L8GdHlz
         dte5M+c65xPYDxeho9FjH932RXedmkvv74Fh350e+NObdHDKy7wO65cLvBZwLRalJTGL
         Lh3g3KhsKYNhjLixjTxd2DXGtrTwWCD/U71Npns0LMXRYs7+f0/vQHr/M8FDtRSXbfWs
         HDRlDzQxL7GPUZ3MH+f0DtlgNULkGPZdV+4/G/WIxyDTuVretK+ZwiRsERYu29FrmxT8
         d9rQ==
X-Gm-Message-State: AOAM531Cu0WwSMNptEu+p1hmLK1GCeGQhs8pWAlQr8E+xWRQ4xDBZQVw
        hOMTNI/7MEj5gIUQtFwog3TV9NJkqFJEwozhTy/03pU0ANk=
X-Google-Smtp-Source: ABdhPJxY1c2aMolVfvvT9PFcWZSVhQNjQXgaGtPuLoiGf0LRkSie0w3FYSvtSaquvS/ukavW5zl3nbaBcj1r8cs0dnQ=
X-Received: by 2002:ac8:1288:: with SMTP id y8mr14224869qti.177.1605848615435;
 Thu, 19 Nov 2020 21:03:35 -0800 (PST)
MIME-Version: 1.0
References: <20201117150856.GA12240@mail.hallyn.com> <CALQRfL5UzUt0YkKDAguETmdXM7qsPC9sGmsgutQ-P2cymPte-w@mail.gmail.com>
 <alpine.LRH.2.21.2011201419210.20300@namei.org>
In-Reply-To: <alpine.LRH.2.21.2011201419210.20300@namei.org>
From:   "Andrew G. Morgan" <morgan@kernel.org>
Date:   Thu, 19 Nov 2020 21:03:23 -0800
Message-ID: <CALQRfL5usVijE_HxwgiW6qKKjLsJwqzcKU_W5C13B12qC-8c+A@mail.gmail.com>
Subject: Re: [PATCH] fix namespaced fscaps when !CONFIG_SECURITY
To:     James Morris <jmorris@namei.org>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        lkml <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Herv=C3=A9_Guillemet?= <herve@guillemet.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Andrew G. Morgan <morgan@kernel.org>

Works for me too.

On Thu, Nov 19, 2020 at 7:20 PM James Morris <jmorris@namei.org> wrote:
>
> On Tue, 17 Nov 2020, Andrew G. Morgan wrote:
>
> > Signed-off-by: Andrew G. Morgan <morgan@kernel.org>
>
> This should be Acked-by or Reviewed-by, unless this is your patch, or it
> came via your tree.
>
>
> --
> James Morris
> <jmorris@namei.org>
>
