Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B263123AE75
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Aug 2020 22:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbgHCUxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 16:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgHCUxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 16:53:31 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76314C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 13:53:31 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id t6so28237582ljk.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 13:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=boqqlPEphuqFOJvJXYWvtssstb3e5GfHxvP4UX5Sq5c=;
        b=KoLB4qo00ttZ2rb6l5YXNE1gls5lSCPrNhMgqClS0lvY/JPsH9QzjORUdh/XfpVP9d
         llAyfafcZTRGmbD3dCIvElgiiL5Wmg1ePatuFMFxwUHOf39YQbD87hnmiBrhYtv6T491
         lr09HtKaYwZyX7qWtmxXfWf0EEMNi9ni6Qxns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=boqqlPEphuqFOJvJXYWvtssstb3e5GfHxvP4UX5Sq5c=;
        b=Ixr1XhqcLMSARJrCMA1YMcsyvyiN7nDXbGjG8sWPfFet029WBRzTAniFaPBTfXHPj8
         8UksCnJECtQn2Q4ipRGP5fi0uFJ0zUmYOoK35pAWWLh9yHOljpg1S9Jt92NDxe8/k6/S
         SSIOxhNm1+FkBaHsEkiGz/P17NABH1bgZZQdPgg0Y/t7NVzzBG2O/zEg6dOyT340pb3P
         fuIPgyKwo+YUmQ0YZjdoy6NHpm23NYBeXpP1nzgJQGpMFb2zNvtJFxJG63hahTUnW491
         SCZvLCMiDQHSWy0UGke39MV2KW6iHXAvBm4+LsUG1pDOf8shm/2hNC7jX/Vhr4+sYJ9g
         uXSg==
X-Gm-Message-State: AOAM5332p3SGAkGm3r3hn9vFpXahAqyQNP3bvCcQKFOl37IKEzWiOFBS
        FDV0LUXKGe1dXdd8DUOJdIa8B+3xHv4=
X-Google-Smtp-Source: ABdhPJwyAKA8O/AzPOokuMxroSCk98dghHhYuYH7c2M+yxbO06vpX0otZQnvoSFtPVOiZLTwKngtqw==
X-Received: by 2002:a05:651c:d0:: with SMTP id 16mr8604043ljr.313.1596488009601;
        Mon, 03 Aug 2020 13:53:29 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id p11sm5296833lfo.71.2020.08.03.13.53.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2020 13:53:28 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id c15so3885722lfi.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 13:53:28 -0700 (PDT)
X-Received: by 2002:ac2:46d0:: with SMTP id p16mr9624647lfo.142.1596488008455;
 Mon, 03 Aug 2020 13:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <50466810-9148-e245-7c1e-e7435b753582@kernel.dk> <CAHk-=wgaxWMA7DVTQq+KxqaWHPDrXDuScX9orzRgxdi7SBfmoA@mail.gmail.com>
In-Reply-To: <CAHk-=wgaxWMA7DVTQq+KxqaWHPDrXDuScX9orzRgxdi7SBfmoA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Aug 2020 13:53:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjztm0K9e_62KZj9vJXhmid-=euv-pOHg97LUbHyPKwzA@mail.gmail.com>
Message-ID: <CAHk-=wjztm0K9e_62KZj9vJXhmid-=euv-pOHg97LUbHyPKwzA@mail.gmail.com>
Subject: Re: [GIT PULL] io_uring changes for 5.9-rc1
To:     Jens Axboe <axboe@kernel.dk>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 3, 2020 at 1:48 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I've pushed out my merge of this thing [..]

It seems I'm not the only one unhappy with the pull request.

For some reason I also don't see pr-tracker-bot being all happy and
excited about it. I wonder why.

                     Linus
