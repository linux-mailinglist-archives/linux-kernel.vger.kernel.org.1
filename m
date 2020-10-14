Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D30F28E613
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 20:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbgJNSMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 14:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728527AbgJNSMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 14:12:36 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0EFC061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 11:12:36 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id x62so117659oix.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 11:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U0lFqbPV6LL+3GwiEtkYs6HjlksJ2EhlSuzlNyHvcVI=;
        b=qlOuxHbmfnviwPmX1bO8wzlktBayGkF63uafDr9hY8kJpSdj62TG4fVsjjYAqfpLAa
         eOJ5o1ejC1jLEUerPLiWX0uEMYhoJYuzkgzzkiIqtSSiCWbK/3EEpaf0B/yNVgdY8Nar
         ztcHd11qcw/11sAAHy4cgnD/FmognMNYCAzSs4Ikk09go9gMAb6YcRUAQqnYiJr8d4sF
         3AP2w6pqyyMAlpAdB0HfJq0aBbm3oS9EJbvkqQJF+bkW9/4voYbutktNCc8J+JxAbOmT
         +T4w1o+1mc2hYRibZRAnv2L6cA/JlJd3EMbiMq/aQjHHl8rat5ISgCHmvH9XjPVlMCp4
         haew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U0lFqbPV6LL+3GwiEtkYs6HjlksJ2EhlSuzlNyHvcVI=;
        b=E7ZcRLUeYewn0/aFOxgVj/rWREYU073MideKb2lxP1XnH/eUkNr23YxhlTIubF1Xyc
         uz2JORfHa8UMW/NZa0PZ7DHuIuWj90NhSOmocz6ohnZtn9s8JUiyn4v/zbKwDXJrIzaW
         dT7LEvFUItpw7enBLeJKU3u9S5yEEGc8FE7MeZwu6pVd65icz3pV7hE/L4UXJblZgqQy
         MHIoCUm8O1NIGRekRSjzvbrlPQg/mJuaGK1mWNpeWZK/cWE2PwDgI4vD4fxKr6fNtAid
         7xZIvOwfgOfD22O7lg+FZD5mYb51pYUmwmSnyLUstalYYOnF8z5zEriOief+p7fxwQwg
         7qSg==
X-Gm-Message-State: AOAM533A+iTI3TyV+H5m+PXj0LTSoPf3zs2672QphqgVi7DhxRi32iFe
        oIZWHO9OP7d3DqpBi96x7KDkuoYBj1dn6SjA3FebLbqH29JRDcji
X-Google-Smtp-Source: ABdhPJyxMwz1sSrHmeyBcEN1SOXdjxpmftjPs/yczF6BkFgXoj8r52TWyGQI+aHhOYgz5zw1DFKyAE/muv0oTgqfIrs=
X-Received: by 2002:aca:420a:: with SMTP id p10mr355873oia.117.1602699155252;
 Wed, 14 Oct 2020 11:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <20201014163738.117332-1-dwaipayanray1@gmail.com> <ea011df1e30ce445d51e128287e2c6c38de20949.camel@perches.com>
In-Reply-To: <ea011df1e30ce445d51e128287e2c6c38de20949.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Wed, 14 Oct 2020 23:42:09 +0530
Message-ID: <CABJPP5DrSL7GoZUWc7P02CfLHfTBmfpLxrVOVQ08KH3pPontoA@mail.gmail.com>
Subject: Re: [PATCH v2] checkpatch: add new exception to repeated word check
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 11:33 PM Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2020-10-14 at 22:07 +0530, Dwaipayan Ray wrote:
> > Recently, commit 4f6ad8aa1eac ("checkpatch: move repeated word test")
> > moved the repeated word test to check for more file types. But after
> > this, if checkpatch.pl is run on MAINTAINERS, it generates several
> > new warnings of the type:
>
> Perhaps instead of adding more content checks so that
> word boundaries are not something like \S but also
> not punctuation so that content like
>
>         git git://
>         @size size
>
> does not match?
>
>
Hi,
So currently the words are trimmed of non alphabets before the check:

while ($rawline =~ /\b($word_pattern) (?=($word_pattern))/g) {
my $first = $1;
my $second = $2;

where, the word_pattern is:
my $word_pattern = '\b[A-Z]?[a-z]{2,}\b';

So do you perhaps recommend modifying this word pattern to
include the punctuation as well rather than trimming them off?

Thanks,
Dwaipayan.
