Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8842A2A5A24
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 23:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbgKCWdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 17:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729342AbgKCWdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 17:33:04 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25038C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 14:33:04 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id k1so17592839ilc.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 14:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ejsEMZE12ZMPeUEYM3BbICPMz6/9Ge4yZTeoTKcT3Rk=;
        b=IV/gRBHXrqJXaXaox/aCL1f+pls6tDlZEklt8SD5gHSq2zuWQFyP/pv15b2TO2j92m
         +C49p2bf0p3LVE7wNein8NODT4AT1y51Pgab7f9ilpq5jRecJNxriAhfnLA+PTZp1QXr
         G3kCf8xEcvQisR8P4Xo04LE99gXTRYH9IVZx705rOJADL0hRkO3fZZb4loNeKDPQ5O8M
         Vxc+QIssU6ohhYPgwTBiiGd9T7OXqkWUjA2aBldTuoWeIbohR88nkEef7L+/LoWS/Vxp
         I0zBhYy6S3R2ziTaoZRTAjQCVe/Ou+aCu3c7NBKhbD714Enp2DmVnJeiBeYYAwAamnum
         AuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ejsEMZE12ZMPeUEYM3BbICPMz6/9Ge4yZTeoTKcT3Rk=;
        b=isExXWkw47E4aBU5ncnpFAMlQzYfYNK9RhjK0+VMz7V6I7e5nEHn99ai0mSocONZ4O
         ZBYtBVWMr3m1I5f7HxKJYDdNi6lSSGv8YLCYj11ifGHRElsnWIWh8oHofwiCt1cZZ3+m
         /U/EuDlN/jdXqoSAupBWBmLMkvT58KOznui8/lANlaqbgw83l3ZvJWQjFg/CtckOtQkW
         +UpGASVp1i6foepJqWKMD46CG76fzIyB6Tj9d9M9SlxDq8gnpkgNltC7HT0EwuQ/PKG0
         15/8wXgznj6DVycCN2YiLdqK8+pBazp/y5mGuxxsTaNKg+EMr4pV6xtFMGRn0cMOrTt7
         0NEg==
X-Gm-Message-State: AOAM530pXcsKss/XSfUst0af3cPYc7ruYkCwGBhx5at71r1dshuH2HEL
        IoRs/coyLRDnjSDr/gd6RNxsvTAWQUGNC/dMAWgE4u2F4PQ=
X-Google-Smtp-Source: ABdhPJxC6y9Lzomv24at2SUfWug80wRVJLiV0NOi0X/m/b1Dq9MortEGt/vxT+L9uhCUukULBx89zHSTrc+DKUx3BNU=
X-Received: by 2002:a92:8541:: with SMTP id f62mr4081248ilh.9.1604442783479;
 Tue, 03 Nov 2020 14:33:03 -0800 (PST)
MIME-Version: 1.0
References: <e457351a04e04aa084902fd5138d4cae@AcuMS.aculab.com>
 <20201102231420.1833852-1-ztong0001@gmail.com> <7d978bf40c5845e8b89a740250ba958a@AcuMS.aculab.com>
 <CAA5qM4C+UGB_SXW5OeWKPtNkXyVCfwwB_ct9wps0Lj6VhvTawg@mail.gmail.com> <2e1ec234135349c58993097b84ea10b2@AcuMS.aculab.com>
In-Reply-To: <2e1ec234135349c58993097b84ea10b2@AcuMS.aculab.com>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Tue, 3 Nov 2020 17:32:52 -0500
Message-ID: <CAA5qM4DnB+K4ESxeFrCtDRrpbCojngr0hcsdb_OSXKuChtN5Xg@mail.gmail.com>
Subject: Re: [PATCH v3] qnx4: qnx4_block_map error handling
To:     David Laight <David.Laight@aculab.com>
Cc:     Anders Larsen <al@alarsen.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 3, 2020 at 4:57 PM David Laight <David.Laight@aculab.com> wrote:
> You've put your hand into a bag of worms...
That's why I'd prefer minimal changes if possible at all.
