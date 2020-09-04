Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1164125E357
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 23:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgIDVes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 17:34:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:44266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbgIDVer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 17:34:47 -0400
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B5F7208C7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 21:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599255287;
        bh=Uc26FcrDmvZH1JzVAlteB47fNbPqx1KDzA4Q0W8WdHA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mNYFu6XhOl1zdXpPtLc+wAVL2on5kPjoXnjpOzLmsZmqijEh9EEk9LX1njAwZjIdz
         1gPJ5DeugeC7Z+0n5xjXJ/xaTE3mGY4t3dNqq9dg+fNuARDsD3XIPyksudq7+FULJa
         nFJN2ziy7dtDvvvxrqVJd9iCiNscA3591ULVXkVY=
Received: by mail-vk1-f172.google.com with SMTP id k1so1990085vkb.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 14:34:47 -0700 (PDT)
X-Gm-Message-State: AOAM532No0zCjt/ygDWbhqKfX49Ip4h67wJ2Roh0p8QVE9bMFOyIha1y
        tQHhS0kdNt9cxFn0DVhCq0M6cQIkFqUgrMcJLIY=
X-Google-Smtp-Source: ABdhPJw3R00y3e8DVdnl7AuPREHHmtqYsziy2CbLfkGU0/BVnsQsW1/DduUcOR0oBprqG32+rY6RfWx+ZlgrrW+dTlg=
X-Received: by 2002:a05:6122:6bb:: with SMTP id r27mr6894542vkq.3.1599255286233;
 Fri, 04 Sep 2020 14:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAB=NE6VTTOcrH0mZaR2wVdzWFjYctzegeKFuSnx4NsssaKTHZA@mail.gmail.com>
In-Reply-To: <CAB=NE6VTTOcrH0mZaR2wVdzWFjYctzegeKFuSnx4NsssaKTHZA@mail.gmail.com>
From:   Luis Chamberlain <mcgrof@kernel.org>
Date:   Fri, 4 Sep 2020 15:34:34 -0600
X-Gmail-Original-Message-ID: <CAB=NE6UKbGYEvyHT7ZfvpOUgy43RM+aSwrrGh3De80QcY_HbUg@mail.gmail.com>
Message-ID: <CAB=NE6UKbGYEvyHT7ZfvpOUgy43RM+aSwrrGh3De80QcY_HbUg@mail.gmail.com>
Subject: Re: Dynamic source include for kconfig
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 4, 2020 at 9:24 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> Hey Masahiro,
>
> I ended up needing to do a dyanmic include of kconfig files to support
> custom / private vagrant boxes in a project I maintain.  I figured out
> a way to do it, and not sure if it was intended, but it works:
>
> https://github.com/mcgrof/kdevops/commit/404a55326198787758fac88af3c60dcaecf599fc
>
> A new helper for this sort of thing might be neat, if one follows a
> convention. Thoughts?

Nevermind, it never worked. The script was actually failing because it
had a typo, but it displayed the contents, and I made a mistake
thinking it had worked, but it never did.

 Luis
