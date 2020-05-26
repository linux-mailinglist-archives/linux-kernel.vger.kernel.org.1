Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919BE1D4714
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 09:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgEOHaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 03:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726434AbgEOHaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 03:30:17 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC25C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 00:30:17 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id l73so3720524pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 00:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=Zry/fghQEm9+2SmdAD9KYKq3yHSvQsjUQtQVB34xriA=;
        b=SHm0yMQt7M+jtPhtNKafVJznR2euW6fSXaD469u9JcMFSiDRJhy5vfa66OiUnAVWdS
         Kf8+t8fk9waQwBCVM3cVql0YoCJeGk/vEv0ZRnNgjDUiLKlZ1yLOq07q8KMnuS53iN3u
         haQHu6aK2wZizHrgHEz8ObRTVcKM6jpXeONA1N2lWrjedIzYEaJ7u8E7lXqIMJcJTPa0
         waHhBTmbKqcuVBHo20mOU/J5nprfCNRe938LDJGGLWyMMf61DX88W501kIkcbqjcvZQ/
         TffY7/gDQRqo3iHgtb3gpirbUf01RYvHC+bmHFh5MWJaoHWryjRZNLgsnJ92bYOJy36n
         nKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=Zry/fghQEm9+2SmdAD9KYKq3yHSvQsjUQtQVB34xriA=;
        b=QQfrUzw6Fpme+IDQsJagi7ndzyYqee+tcicFbxwiq3fUOWyDK90dXxCxzxtr0EXiiG
         jlA/SxltewQ+GPtmK1nDyrhN+2idIkCVW9moMjxbaoZNuQUcIKeNmpgCF++x/GlEcHS6
         ZN1slz9zDZMp7sk8yaH8XUTV0o3CbKU3Xun/5rmSbnrIZNiGwa9dJ2qXD9WdJfoAtDO/
         KSwkDCzU/KLBKv4iBULsjITTWtYeiKOOamOArbQTbOPJk0p+dbnlkMpfZ416qkZJQ+hc
         inCmxkPHzXWLWgasAbQKLcPFcqBLBRwlZM2y4/BMXNDWg23wJWQiWUjMnzkixAou4mUG
         6knA==
X-Gm-Message-State: AOAM530ffan6/zsXaLc1JElDljkz3veCTGXrLn3jY/dK/aowb7Fm0cRq
        0bcwA9Ot46p+d5ytek8gppI=
X-Google-Smtp-Source: ABdhPJwTflk1hrM+EFdHaLzv2AEsYLQc7675Kfjh5Y+cvzisBrlsBZUJrYfwB2C2EKLGsncle8IvBw==
X-Received: by 2002:a17:902:fe8d:: with SMTP id x13mr2452917plm.198.1589527816555;
        Fri, 15 May 2020 00:30:16 -0700 (PDT)
Received: from localhost ([61.68.67.54])
        by smtp.gmail.com with ESMTPSA id b16sm1168625pfp.89.2020.05.15.00.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 00:30:16 -0700 (PDT)
Date:   Fri, 15 May 2020 17:30:09 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 2/2] powerpc/rtas: Implement reentrant rtas call
To:     Allison Randal <allison@lohutok.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leonardo Bras <leobras.c@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nadav Amit <namit@vmware.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20200514235138.150722-1-leobras.c@gmail.com>
        <20200514235138.150722-3-leobras.c@gmail.com>
In-Reply-To: <20200514235138.150722-3-leobras.c@gmail.com>
MIME-Version: 1.0
Message-Id: <1589525800.2asfsw2zlu.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Leonardo Bras's message of May 15, 2020 9:51 am:
> Implement rtas_call_reentrant() for reentrant rtas-calls:
> "ibm,int-on", "ibm,int-off",ibm,get-xive" and  "ibm,set-xive".
>=20
> On LoPAPR Version 1.1 (March 24, 2016), from 7.3.10.1 to 7.3.10.4,
> items 2 and 3 say:
>=20
> 2 - For the PowerPC External Interrupt option: The * call must be
> reentrant to the number of processors on the platform.
> 3 - For the PowerPC External Interrupt option: The * argument call
> buffer for each simultaneous call must be physically unique.
>=20
> So, these rtas-calls can be called in a lockless way, if using
> a different buffer for each cpu doing such rtas call.

What about rtas_call_unlocked? Do the callers need to take the rtas=20
lock?

Machine checks must call ibm,nmi-interlock too, which we really don't=20
want to take a lock for either. Hopefully that's in a class of its own
and we can essentially ignore with respect to other rtas calls.

The spec is pretty vague too :(

"The ibm,get-xive call must be reentrant to the number of processors on=20
the platform."

This suggests ibm,get-xive can be called concurrently by multiple
processors. It doesn't say anything about being re-entrant against any=20
of the other re-entrant calls. Maybe that could be reasonably assumed,
but I don't know if it's reasonable to assume it can be called=20
concurrently with a *non-reentrant* call, is it?

> For this, it was suggested to add the buffer (struct rtas_args)
> in the PACA struct, so each cpu can have it's own buffer.

You can't do this, paca is not limited to RTAS_INSTANTIATE_MAX.
Which is good, because I didn't want you to add another 88 bytes to the=20
paca :) Can you make it a pointer and allocate it separately? Check
the slb_shadow allocation, you could use a similar pattern.

The other option would be to have just one more rtas args, and have the=20
crashing CPU always that. That would skirt the re-entrancy issue -- the
concurrency is only ever a last resort. Would be a bit tricker though.

Thanks,
Nick
