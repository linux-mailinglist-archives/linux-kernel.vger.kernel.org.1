Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372692A7AB5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 10:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgKEJjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 04:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgKEJji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 04:39:38 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA89C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 01:39:38 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id x13so1019273pfa.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 01:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=microgate-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=oWc2JpKVx8F8Nkb3UQGZG1Q/MGfCQA65/EO0uJuKYUk=;
        b=H/nfvoy5/2pegQCbmtLoKeHnSqT2rHlUCeU456TMKEHsC3q09uoulnrpqzTdWBtm43
         mZtJ9AMTg2kEctsXGd9jW9cyywao/9vr3bd7ZaHbHB17bljvEakYxt0ozyFTo7Oly3SE
         GpPcHEKg1DgDn2LKuigaHTlaDp+gSg8B2Vf4tZyy1t/VbU3TAwkbjuFvdNVaNBanVuAZ
         fUnau2tchnXu3T5q/wg8YcviUUmB9+eVqNTl1AFWMJ7t339OEQqB33olr6PxiPxXmCEH
         GCPEvhJL2GzuAlPbNx3NL+8pgx+D1VEYoZWA8AqrKUzgECucX+oL1CM7VLrSTinHY+Zc
         sMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=oWc2JpKVx8F8Nkb3UQGZG1Q/MGfCQA65/EO0uJuKYUk=;
        b=tQ9MqqVKQ3ORrkpoaSH+SI6C7VtjxJEVJVP9eCoykSH+BuXLa7pr0jzYY+5lVC/nSg
         UHC3Wj+erpjVYfeijhUpTNocpmC0H0XabALfJCi9BiWR7tOlRXp4MPSVYOy88qOPUhRo
         7LTpc27c7oLRvlIbCgug3d2Cpljrx+c0f8qna7gqzzsQK88JHKJkmOhYw0A671FBta27
         gX9B9AFfspHfW6pPSD5TTAyH2Ei+XFYYNxqslGnghY9lkuI8vCiAtjzgRtOCKiYxr1tR
         kgGnTQ98mXjLwdpQLkxxenFYLaG1yonsJLiibunNFpQe5+jO+068GmvHwvNkMA7oFeTY
         CChw==
X-Gm-Message-State: AOAM532IPXhzCbiQIqicQo+8/a849HkWk1qmEXfuEfeDfWI+Cg3jDvjN
        6LbIEspbuCy4eP92tzCsmG88VQ==
X-Google-Smtp-Source: ABdhPJzaKR47DT0UpoeoRWqcm5CjST9B3zAKqI+5lwBm/08wEpJskZVFrja8eJ1Ca5LiIZ2/DUHMHA==
X-Received: by 2002:a17:90a:8d81:: with SMTP id d1mr1598317pjo.174.1604569178187;
        Thu, 05 Nov 2020 01:39:38 -0800 (PST)
Received: from [192.168.1.77] (c-208-53-111-167.customer.broadstripe.net. [208.53.111.167])
        by smtp.gmail.com with ESMTPSA id l5sm992562pjm.22.2020.11.05.01.39.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2020 01:39:37 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.15\))
Subject: Re: [PATCH 27/36] tty: synclinkmp: Mark never checked 'readval' as
 __always_unused
From:   Paul Fulghum <paulkf@microgate.com>
In-Reply-To: <a95f8d0d-28ef-7351-cdbb-7da5ad8aa9ad@kernel.org>
Date:   Thu, 5 Nov 2020 01:39:36 -0800
Cc:     Lee Jones <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org Mailing List" 
        <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <69E3975E-A4D0-4472-80F0-9FAB2E0024FA@microgate.com>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-28-lee.jones@linaro.org>
 <0a4043ee-dad5-7691-8c67-db73d3c12f52@kernel.org>
 <20201105084341.GZ4488@dell>
 <a95f8d0d-28ef-7351-cdbb-7da5ad8aa9ad@kernel.org>
To:     Jiri Slaby <jirislaby@kernel.org>
X-Mailer: Apple Mail (2.3445.104.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 5, 2020, at 1:10 AM, Jiri Slaby <jirislaby@kernel.org> wrote:
>=20
> OK, let the loop alone. I would bet a half a pig that noone is able to =
test this driver. But one has to write this for someone to raise and =
admit they are still using it. In fact, there are _4_ google replies to =
"Microgate Corporation" "SyncLink Multiport Adapter" "lspci".



The hardware used with synclink.c and synclinkmp.c has not been =
manufactured for 15 years and was low volume. The chances of either =
driver still being in use is very low. Not even Microgate (me) has the =
ability to test either anymore (no hardware). I don=E2=80=99t know the =
policy about driver removal, but I think both could be removed without =
upsetting anyone.

synclink_gt.c is still in production and the driver still actively used.

If there are no objections to removing the the old drivers =
(synclink.c/synclink_mp.c) I could make a patch to do so tomorrow (it is =
1:30am here now). Nothing eliminates niggling warnings like removing =
dead code.









