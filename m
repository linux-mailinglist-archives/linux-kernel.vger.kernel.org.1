Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE94F2A7000
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 22:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732120AbgKDV65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 16:58:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54716 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727098AbgKDV6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 16:58:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604527098;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7mjZwPLaDvRK7gqbusRFvnTm5i/SsM/Ov+R4VsFUYjM=;
        b=FpmTyS7JpBsTwNj92aNC6kvFU0ApWGIZeuUD0mSt0pImtTlOERDtLQmJHlJs2aoSGtQWnm
        2IvJHhNmy0a3PxqSzumK+himQUc3wT+14ZZ9rIZF8g4pnAj2MM5CU5gGFVr6ArAD4m7Quj
        QE6afuEppcC3958IF19j9hqkdyDOr0Y=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-bw0m-gd3Mfq7dd5PlLR-Pw-1; Wed, 04 Nov 2020 16:58:16 -0500
X-MC-Unique: bw0m-gd3Mfq7dd5PlLR-Pw-1
Received: by mail-qv1-f71.google.com with SMTP id d41so13619160qvc.23
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 13:58:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=7mjZwPLaDvRK7gqbusRFvnTm5i/SsM/Ov+R4VsFUYjM=;
        b=VYW1GJO5CyHbB4vbaDgav/7Io5Ky8qLO4v8gI5JzF5WjVVKaj81PvAsp/Z23MvzOIX
         Htx6z2WGlAsw4f/Mj04w3KSSvC8XbsFLOEV6EgzhQc5uBxgXptEWaxoGX8AsZhfAqJnP
         AzLwlsXXlZA2DgkgnMmgmgDQA2SubUf+qsztHE6bMdOwe3AxeBx5HLIJ6lk0ZbBCYuAc
         Gh5JMqazEtQDSxTWQXV+bPpqJNqR7ggYowlEF6ZbEMy4HqPunKKR7bf4Hisqc3oDDTuM
         SbKaUdQ6TqNDUQO/mj7H+ivUOz917vZZ1CzXyi6QFQoQc8UQydpDTqREh28s6tTl2sGN
         qNzQ==
X-Gm-Message-State: AOAM530Eh8hwdeN+rIRsNuPvbiHg7AWdXCare32qYUcJXgHLEW/5Qcp0
        4XYB8/qhSlpbJ4cqFv1c3tsalQZrbMVWN0ctp0GtI2RXMDM4Syb/6Y7NLDc4jDryanK1cDjyhQR
        0zKtS503dkZD/Fub3jnuMplvz
X-Received: by 2002:a05:6214:943:: with SMTP id dn3mr33862199qvb.45.1604527095986;
        Wed, 04 Nov 2020 13:58:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyxSZm4vplpN0Yy5FprMLUzwx1P8wIztIZ0XeZy6PFsHKkN0jK/iuyznPLC3n2hCWarebqwgw==
X-Received: by 2002:a05:6214:943:: with SMTP id dn3mr33862190qvb.45.1604527095807;
        Wed, 04 Nov 2020 13:58:15 -0800 (PST)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id q7sm1153656qtd.49.2020.11.04.13.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 13:58:15 -0800 (PST)
Message-ID: <71dc852e52bfeafc8c03a6fa3cd5f3cdd4eb6609.camel@redhat.com>
Subject: Re: [git pull] drm next pull for 5.10-rc1
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>
Date:   Wed, 04 Nov 2020 16:58:14 -0500
In-Reply-To: <20201103222013.hypmzlq7uuqufe76@box>
References: <CAPM=9txyMmW1DWhS--SuYQu4qDK1GPzgHJwxbAfhHT=hUsPODA@mail.gmail.com>
         <20201103222013.hypmzlq7uuqufe76@box>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACK, I will send out a patch for this asap

On Wed, 2020-11-04 at 01:20 +0300, Kirill A. Shutemov wrote:
> On Thu, Oct 15, 2020 at 11:33:08AM +1000, Dave Airlie wrote:
> >       drm/nouveau/kms: Search for encoders' connectors properly
> 
> This commit (09838c4efe9a) broke boot for me. These two hunks in
> particular:
> 
> @ -2066,7 +2120,7 @@ nv50_disp_atomic_commit_tail(struct drm_atomic_state
> *state)
>                           outp->clr.mask, outp->set.mask);
> 
>                 if (outp->clr.mask) {
> -                       help->disable(encoder);
> +                       help->atomic_disable(encoder, state);
>                         interlock[NV50_DISP_INTERLOCK_CORE] |= 1;
>                         if (outp->flush_disable) {
>                                 nv50_disp_atomic_commit_wndw(state,
> interlock);
> @@ -2105,7 +2159,7 @@ nv50_disp_atomic_commit_tail(struct drm_atomic_state
> *state)
>                           outp->set.mask, outp->clr.mask);
> 
>                 if (outp->set.mask) {
> -                       help->enable(encoder);
> +                       help->atomic_enable(encoder, state);
>                         interlock[NV50_DISP_INTERLOCK_CORE] = 1;
>                 }
> 
> 
> I hacked up patch to use help->disable/help->enable if atomic_ versions
> are NULL. It worked.
> 
> In my setup I stepped onto nv50_msto_help->atomic_enable == NULL. But
> there are two more drm_encoder_helper_funcs in dispnv50/disp.c that don't
> have atomic_enable/disable set: nv50_dac_help, nv50_pior_help.
> 

-- 
Sincerely,
   Lyude Paul (she/her)
   Software Engineer at Red Hat
   
Note: I deal with a lot of emails and have a lot of bugs on my plate. If you've
asked me a question, are waiting for a review/merge on a patch, etc. and I
haven't responded in a while, please feel free to send me another email to check
on my status. I don't bite!

