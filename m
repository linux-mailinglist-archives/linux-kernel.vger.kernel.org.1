Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED182B8609
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 21:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgKRUwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 15:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgKRUwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 15:52:53 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8577C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 12:52:52 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id y16so3895292ljh.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 12:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nMc5uiI5eZzBhbuytw1AZBYaSdLgIJONP3ItXWrU8VQ=;
        b=l7mEYJXqS/wM7V3LjJdAcBUBJ6232rcpViwTQEOZjXyqUNoUUKRPw+1FbhnvpZiMYz
         DIHEgUMMKZNEYPs+aWts7iFeuoNFB8q1UiQDJHP8vFwTcUBDWRpt7ygWcGJwhXZBIgtT
         Q0lFCFv/zEcaevQ2PFo9bSngJnXjbzmWivfH29lNIxSGbv8EmuF86qw5nVUt6OetAGeq
         +BPhl3y3X3ABDff+ujbJOSGzdusEJfwOtJ45P8QK4nEpf2mdb9rU8SN67MVe4r+YOGM2
         CmPDV6E2TSMy46cwttMdUqpNp+hSFO/Zw/QFGKjLN8oFKizzTTz3eMEAUcIfDU7M+TNv
         ZNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nMc5uiI5eZzBhbuytw1AZBYaSdLgIJONP3ItXWrU8VQ=;
        b=fGCBVRzXILKDEspUA6nIwSANlllli4QW86H1QTT5orgAQXqOv+uVYf19M9+Af1zW8W
         uo1JlQuhdVm360HZKacoje4lPX2NIkYkUyxycI+o6YxGr9beU7mMsKgpBhXXrTay6ffp
         Q4wqOlnb3gg7zt50i6z/29CLmJ3Z5XJZkBh2mtp7FjNrQ5ULJjNXJzhgou8KWHGRQ47k
         rPViiZUK8cdlbbzAhV6wmd6YSMJIxmqzbtDNdObjX+0EJgNxeyHiqpWUuRcef7fRO0Fz
         gWxXm5Jgzeizrrm7kiH4BaYtJEvRQ+8gI/LbDfBnN2AKlMm59VL/G3/T3KCDCqg9sCSo
         r3Fw==
X-Gm-Message-State: AOAM532OyKDeax8sWnWtQlh7RdH0KA1n7qpOUssvOTiJSrD5+o05TR/J
        hh7AxzQknLfmngiBjTLgaAJzMhXDinOI2BvDmFg=
X-Google-Smtp-Source: ABdhPJy9Vbb/fkGXh32qruhjyVCcLHvkl2RzeBKkvqMKzv7LQfwz//aOcWhTHMddJSVx6pTBT5a2EIKhaY/gogpxOME=
X-Received: by 2002:a2e:8e6c:: with SMTP id t12mr4855520ljk.441.1605732771379;
 Wed, 18 Nov 2020 12:52:51 -0800 (PST)
MIME-Version: 1.0
References: <20201118124035.96976-1-dwaipayanray1@gmail.com>
 <457730448c84136be089748bea69abd2254e3832.camel@perches.com>
 <CABJPP5CqKjY3_mfkJEsHX_8Zc7q1TRCgA4T54sTEZBiKgPS+OQ@mail.gmail.com>
 <754e240d1c88274ce2d94a5b6dbcfff1cc8c9508.camel@perches.com>
 <CABJPP5CHofzA46FHe3eJrgjQBTcaoCkR=dc29xxK80oFZJVfoQ@mail.gmail.com>
 <12b44d3a477de314320dc9d26b26576875525f27.camel@perches.com>
 <CABJPP5DTBkuzEjs28wufdnOXf61-T=wtoZWiTya_idXfJ92eNQ@mail.gmail.com> <c69f32af186d672c9370750985914b889f6a5b14.camel@perches.com>
In-Reply-To: <c69f32af186d672c9370750985914b889f6a5b14.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Thu, 19 Nov 2020 02:22:20 +0530
Message-ID: <CABJPP5DiUXErqQCuiWz1ALXQ7+2O4tVOMLQJTZHkCz_GqdM2Qg@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: add --fix option for OPEN_BRACE issues
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > The difference here is that you are dealing with a $stat context and
> > > the existing --fix entries are just for single line fixes.
> > >
> >
> > Hi,
> > Ya I understand that. Though I am dealing with $stat content,
> > I am also directly accessing $rawlines here.
> > So I think that should have the proper patch line format, starting
> > with + or - or so.
> >
> > So in this case if the error is triggered, checking for /^+/ should be done
> > becase it would be wrong to fix the others with /^[- ]/
> >
> > Is there something else that I am not getting here?
>
> $stat does not include lines that are skipped if the lines start with -
>
> Patch context may be:
>
> line    content
>
> 1               func(...
> 2       -            original arguments);
> 3       +            changed);
>
> where $stat does not include the 'original arguments' changed line
>
>         func(...,
>              changed);
>
> but the $rawlines[] entries are consecutive.
>
> Anyway, this needs to be handled very carefully if handled at all.
>
> I think it's easier to avoid handling these cases and let the
> patch submitter fix it manually if appropriate.
>

Thanks. I get your point now. It seems it's much more complex than
I thought it to be. I will avoid working on this one then.

Thanks & Regards,
Dwaipayan.
