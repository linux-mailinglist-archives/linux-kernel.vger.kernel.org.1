Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2CDE2D49EA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 20:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387603AbgLITOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 14:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387441AbgLITOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 14:14:42 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7F3C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 11:14:02 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id a9so4659848lfh.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 11:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z3Nmrur31MwA2YAFkLrqIIvFJlFJK1KzSVW0MgYqjnU=;
        b=iF8p7WSVKFaLPoiil/apBE7Bc/WIgYkkC2eeoVYJyiSsI93Shgjg2pmgj5T42cFNdT
         dQVofMSyw/O7oowlMT0vQ1v9J6nvT5o0lYVaPwlYwvdR2TSfvxKirHUV9mUSQpwQ0rCj
         LYzfVONNcmJCuJemyMspDvLrySVvj5A434PDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z3Nmrur31MwA2YAFkLrqIIvFJlFJK1KzSVW0MgYqjnU=;
        b=ryTKFNcmgZxAI65BWf3DBFVVPG1nmQqf077semkBeQLz9ejrH2tAYLktPGMSU8eQ+e
         0cYExGD0JNO+FM3X//HPjdxhvzvHZuFMi6eWsq9R9jpsIbUAG0G84uZ5Vh4IWofvjKpZ
         6OQ9ET4/kLdSyBYfzGW05L88ArvoraZZXqV5Dn24d34x0k4Oruhvq6XHUZdToRgkVWUT
         M3gzfA045E2v2RTsrJpB3aIKYP/REl41fBxRso6RnvqYGCTzn97a/q0LNwpvzgJPzrRH
         MKIALVJnUxmrdBg+GhQHDwvnSHsCeVEcfY6hTc167e2u8WUEUL7oedyX4PZ9tjqypHDV
         7zbA==
X-Gm-Message-State: AOAM531RaTYr2gfizxX8rsQZWiDvWKXw36XakYattj5H5qAjjkAKcyqU
        T/FKL0B4Bz2B0Ry3cSAXbh0A0ddV92ALiw==
X-Google-Smtp-Source: ABdhPJwXLhmao2aInxeqVFeeNpAD5tbmcjsnnKLpEOjqoPZs7XOitRCEr6jpZrl5KmDht5JXOjGbWA==
X-Received: by 2002:a19:c5:: with SMTP id 188mr1447127lfa.511.1607541240479;
        Wed, 09 Dec 2020 11:14:00 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id n22sm10687lfe.230.2020.12.09.11.13.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 11:13:59 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id y19so4583668lfa.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 11:13:59 -0800 (PST)
X-Received: by 2002:a19:7d85:: with SMTP id y127mr1439263lfc.253.1607541239067;
 Wed, 09 Dec 2020 11:13:59 -0800 (PST)
MIME-Version: 1.0
References: <87r1on1v62.fsf@x220.int.ebiederm.org> <20201120231441.29911-15-ebiederm@xmission.com>
 <20201207232900.GD4115853@ZenIV.linux.org.uk> <877dprvs8e.fsf@x220.int.ebiederm.org>
 <20201209040731.GK3579531@ZenIV.linux.org.uk> <877dprtxly.fsf@x220.int.ebiederm.org>
 <20201209142359.GN3579531@ZenIV.linux.org.uk> <87o8j2svnt.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <87o8j2svnt.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Dec 2020 11:13:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiUMHBHmmDS3_Xqh1wfGFyd_rdDmpZzk0cODoj1i7_VOA@mail.gmail.com>
Message-ID: <CAHk-=wiUMHBHmmDS3_Xqh1wfGFyd_rdDmpZzk0cODoj1i7_VOA@mail.gmail.com>
Subject: Re: [PATCH] files: rcu free files_struct
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jann@thejh.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 9, 2020 at 10:05 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> -                               struct file * file = xchg(&fdt->fd[i], NULL);
> +                               struct file * file = fdt->fd[i];
>                                 if (file) {
> +                                       rcu_assign_pointer(fdt->fd[i], NULL);

This makes me nervous. Why did we use to do that xchg() there? That
has atomicity guarantees that now are gone.

Now, this whole thing should be called for just the last ref of the fd
table, so presumably that atomicity was never needed in the first
place. But the fact that we did that very expensive xchg() then makes
me go "there's some reason for it".

Is this xchg() just bogus historical leftover? It kind of looks that
way. But maybe that change should be done separately?

              Linus
