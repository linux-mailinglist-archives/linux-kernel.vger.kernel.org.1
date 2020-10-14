Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B6F28E9CC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 03:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388418AbgJOBTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 21:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388104AbgJOBTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:19:38 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D83BC051105
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 15:53:20 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id z2so1331924lfr.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 15:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9u2mhHcY3pY9y0h1f1D8mjxBc1UDKO7lgh+0IH/jA4Y=;
        b=E/v5G5HV93+1W4ZpS/VEGR4XVjhJ1Cziliaq421Y1vNYDKnUMeDn1lSbhTCyjPD4qn
         Ycb0GIFY8dVLWimGD6jGpxITZrHhe7xQpjsbikl7AnWc4mhoCouYfkP7/f4PH+VA3clz
         Cv+uRw1kdI5CfME+yVKJXQCOBYRkOHRUVhiFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9u2mhHcY3pY9y0h1f1D8mjxBc1UDKO7lgh+0IH/jA4Y=;
        b=DQek0jXUclij6fU0KVXWiANtP/DjUJrMTGDEBMlRKGEb/pkd/RbeaY2qBBIMMq+dwj
         3O5J+pnBHEe065wcuUDssoDrIMgkO94Ja/I7r3iaA2r/3nxPKtTJqEMrdSJdu0q7Y50X
         tw6V5vpndO40fUlXdDGUBUIrCgXsuZ9Hs3C/RDEkqTee/K6kBuzuXZSeqZ/noK8R601L
         b/C1XfMAQbszFsk1UMUMa3tzXgq7XCS8EOip4aYFc+tUXV2CTM8cuzrtHGWUpVLBrPjM
         w4B2ps/DKvamsSkIHsXEO995Tx85+L8/KSGCpSgnqWh0nHxp21ZR5QHjrrI3sWwtt1B8
         aRxg==
X-Gm-Message-State: AOAM532TglcZJny+svXs9AKQeVI/qV6CdQrQx0N2pfZYt447PUVZWvo4
        450TKjl0H4luWMChYt8FbEnHNWo4OCYtkg==
X-Google-Smtp-Source: ABdhPJyxsdm9mMAjCDu95LW9HR1bHmrjghAx+4EgImZAV5FMVGjfbrCaoCFZvQzX/62EFsobi+k4tw==
X-Received: by 2002:a19:892:: with SMTP id 140mr98818lfi.465.1602715998623;
        Wed, 14 Oct 2020 15:53:18 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id 9sm422448lju.128.2020.10.14.15.53.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 15:53:17 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id b1so1256209lfp.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 15:53:17 -0700 (PDT)
X-Received: by 2002:a19:4815:: with SMTP id v21mr94354lfa.603.1602715996898;
 Wed, 14 Oct 2020 15:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200724012512.GK2786714@ZenIV.linux.org.uk> <20200724012546.302155-1-viro@ZenIV.linux.org.uk>
 <20200724012546.302155-20-viro@ZenIV.linux.org.uk> <20201014222650.GA390346@zx2c4.com>
 <CAHk-=wgTrpV=mT_EZF1BbWxqezrFJRJcaDtuM58qXMXk9=iaZA@mail.gmail.com>
In-Reply-To: <CAHk-=wgTrpV=mT_EZF1BbWxqezrFJRJcaDtuM58qXMXk9=iaZA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 14 Oct 2020 15:53:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_rmS+kQvC9DccZy=UiUFJVFG9=fQajtfSCSP1h0Rofw@mail.gmail.com>
Message-ID: <CAHk-=wj_rmS+kQvC9DccZy=UiUFJVFG9=fQajtfSCSP1h0Rofw@mail.gmail.com>
Subject: Re: [PATCH v2 20/20] ppc: propagate the calling conventions change
 down to csum_partial_copy_generic()
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000abfabd05b1a965d0"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000abfabd05b1a965d0
Content-Type: text/plain; charset="UTF-8"

On Wed, Oct 14, 2020 at 3:51 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I think it's this instruction:
>
>         addi    r1,r1,16
>
> that should be removed from the function exit, because Al removed the
>
> -       stwu    r1,-16(r1)
>
> on function entry.
>
> So I think you end up with a corrupt stack pointer and basically
> random behavior.
>
> Mind trying that? (This is obviously all in
> arch/powerpc/lib/checksum_32.S, the csum_partial_copy_generic()
> function).

Patch attached to make it easier to test.

NOTE! This is ENTIRELY untested. My ppc asm is so rusty that I might
be barking entirely up the wrong tree, and I just made things much
worse.

                 Linus

--000000000000abfabd05b1a965d0
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_kg9zpmo10>
X-Attachment-Id: f_kg9zpmo10

IGFyY2gvcG93ZXJwYy9saWIvY2hlY2tzdW1fMzIuUyB8IDEgLQogMSBmaWxlIGNoYW5nZWQsIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMvbGliL2NoZWNrc3VtXzMyLlMg
Yi9hcmNoL3Bvd2VycGMvbGliL2NoZWNrc3VtXzMyLlMKaW5kZXggZWM1Y2QyZGVkZTM1Li4yN2Q5
MDcwNjE3ZGYgMTAwNjQ0Ci0tLSBhL2FyY2gvcG93ZXJwYy9saWIvY2hlY2tzdW1fMzIuUworKysg
Yi9hcmNoL3Bvd2VycGMvbGliL2NoZWNrc3VtXzMyLlMKQEAgLTIzNiw3ICsyMzYsNiBAQCBfR0xP
QkFMKGNzdW1fcGFydGlhbF9jb3B5X2dlbmVyaWMpCiAJc2x3aQlyMCxyMCw4CiAJYWRkZQlyMTIs
cjEyLHIwCiA2NjoJYWRkemUJcjMscjEyCi0JYWRkaQlyMSxyMSwxNgogCWJlcWxyKwljcjcKIAly
bHdpbm0JcjMscjMsOCwwLDMxCS8qIG9kZCBkZXN0aW5hdGlvbiBhZGRyZXNzOiByb3RhdGUgb25l
IGJ5dGUgKi8KIAlibHIK
--000000000000abfabd05b1a965d0--
