Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E742F2CCB54
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 01:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgLCA6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 19:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgLCA6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 19:58:21 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37F7C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 16:57:40 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id 2so430538ybc.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 16:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FkizqJ6c/Vsd/MpdMpQch0kvtzt0G2b1DvFErYdRhNc=;
        b=ET/Yjgf2Zgn7uXv460cwS3T1TrEshtsPxfSCW3+RCYoAUfNMcu3yFwHqIvUZ5wacq3
         uO9/mZGyURL9xLN/4Pbw4KCb3/Xd4UJWY7gc19vetRDrZA7eyYBydPKtJZDLQXZj/IEj
         KL4rBSRV6hsHNu+Wejivqtgcjt/NtvgtPVfyF6+2PUmA4PVI7OAIaSK/u1uTHglOHu9J
         kuGla5QCbL72F3Ytp35bsyVN8t3cR9pjE01cfOCAL39Ne3zUEXl0RanoYoUZm2JyM/0A
         7glr4C7F5evV6xw79fleXoMYwMb1D1/KncMQIfCm6WFa034dScI9CpM6EWQ3eQ/KJ2Of
         IFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FkizqJ6c/Vsd/MpdMpQch0kvtzt0G2b1DvFErYdRhNc=;
        b=L9bwX/xeQkU3xyHy+IEe5bbQh/+iZadoGnuFOLyMpfFePptHJkDwJ8uTqhTt1XseYb
         4fMBbLH9TIkFQsmhDAelQqFNDB43XNpBJ7ANWdbnHRs/ioxJ5aqUxk6fexNPwTi55ecM
         NocsWpSHj5QlZoTPjcUFyXWxm+EHD1i9s8rXFkJ74UH//GIWIcFJMo4jI6Sv8paZveg6
         E2a5QfZeLEbHMZpNRhG4vDahGCwb2s8WU2AlFwqDAwroGyveU1+9YhG+jMsXRZX88U4Q
         3LSzOnFcPBpHPGm4BBGIStIMVDgWFDIePEwu6qnSlSdtskNAbZfD43KGeeMR2yBskxrS
         GRGw==
X-Gm-Message-State: AOAM533MNhEH+GqnOgQFDnJtER7IsU2rq5SdsAUVX/33F+zMYhOiRMii
        t0soi3AzZXzTP/A0Hso8dnUtKl55AfJjzlcwyYA=
X-Google-Smtp-Source: ABdhPJx3ykm6Ub65Kx8LhCpIKFpTdhfVUAcZc+q11JZ3cp6vqbutIRcmG4ddusoIvOVs33lmOHKkpd/Cgv2loKNf/9k=
X-Received: by 2002:a25:df55:: with SMTP id w82mr1100249ybg.135.1606957059549;
 Wed, 02 Dec 2020 16:57:39 -0800 (PST)
MIME-Version: 1.0
References: <20201202075438.GA35516@spblnx124.lan>
In-Reply-To: <20201202075438.GA35516@spblnx124.lan>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 3 Dec 2020 01:57:28 +0100
Message-ID: <CANiq72=5+COhecuTxn4J4WQ7_MkXzOo=hN3FHHzYekjB0vLY6Q@mail.gmail.com>
Subject: Re: [PATCH] Documentation: fix typos found in process, dev-tools, and
 doc-guide subdirectories
To:     Andrew Klychkov <andrew.a.klychkov@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 2, 2020 at 8:56 AM Andrew Klychkov
<andrew.a.klychkov@gmail.com> wrote:
>
> Fix four typos in kcov.rst, sphinx.rst, clang-format.rst, and embargoed-hardware-issues.rst
>
> Signed-off-by: Andrew Klychkov <andrew.a.klychkov@gmail.com>
> ---
>  Documentation/dev-tools/kcov.rst                    | 2 +-
>  Documentation/doc-guide/sphinx.rst                  | 2 +-
>  Documentation/process/clang-format.rst              | 2 +-

Thanks!

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
