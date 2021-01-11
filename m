Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9172F2235
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 22:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388135AbhAKVvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 16:51:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:50498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726499AbhAKVvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 16:51:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 55A0022CB2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 21:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610401834;
        bh=6K4g2Uv9ooqYhX8N6OYj5wg12cA2W2s8vyAhdysAY6U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ve/yKYDsQEvjmUUhfyxiNHx/NLgE+CTuy6/t1O9v4kF+c8xUAFgkLCKsivq3uPm+M
         jycHXFx3VCsWK8bVXSqyoKRoieId4SIYYUjD4H8baDCFoWeEoHqIFL9wrZo8KB7flF
         hvy9LLdj1vn3JEIUuo282M3oFRvnUaqa4u21e/0hWGaPGL3YYYkxH/LN6r+4aekucd
         m4gxqEg9luIpIfmynNVoc2NhjWgiEUz5XkzUusikt+tooOYcz6shmOikV4nlBkeJmh
         JYDt+07pbLwQh9bo203yACGzFEu98xLkXITfE5S2D1DYIAET40rwLXfgbytQj/qeUK
         Mct0WhMB/L5yA==
Received: by mail-oi1-f182.google.com with SMTP id s2so206392oij.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 13:50:34 -0800 (PST)
X-Gm-Message-State: AOAM532BOIuQGIs3suHauSo1M3/erR6deOT1tfJi4TyVvCxmJcLgktxh
        nlYaVd7pn9cR/EqLxM3rh3KyKKX0j4GhQ7Ob8OQ=
X-Google-Smtp-Source: ABdhPJy1Uix/VBSc8YSdfYCcreJSTe62jCUS6AtKtKyqASycpTmSLtW5yR0ykUftas75fX4w33hlVMqG6iRJkFzqBAQ=
X-Received: by 2002:aca:fd91:: with SMTP id b139mr496612oii.67.1610401833593;
 Mon, 11 Jan 2021 13:50:33 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <034ff035-9c58-336d-c8f5-80bf40ad2fc1@free.fr> <yw1xpn2bcrhe.fsf@mansr.com>
In-Reply-To: <yw1xpn2bcrhe.fsf@mansr.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 11 Jan 2021 22:50:16 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3mPHbh9ScEsF=L9HTofM5k72OQP-tA920o_r9ru-naDg@mail.gmail.com>
Message-ID: <CAK8P3a3mPHbh9ScEsF=L9HTofM5k72OQP-tA920o_r9ru-naDg@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 6:29 PM M=C3=A5ns Rullg=C3=A5rd <mans@mansr.com> wr=
ote:
> Marc Gonzalez <marc.w.gonzalez@free.fr> writes:
> >
> > Waiting for his take on the matter.
> >
> > I can point out some device-specific drivers that would become
> > useless if tango support were dropped.
>
> I have tango3 and tango4 boards.  Can't say I'm using them for anything,
> though.  With the entire platform dead at the vendor level, removal
> seems like a reasonable choice.

Ok, thanks for confirming.

      Arnd
