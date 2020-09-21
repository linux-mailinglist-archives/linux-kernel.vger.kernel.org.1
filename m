Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9BD273319
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 21:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgIUTpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 15:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbgIUTpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 15:45:51 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A18C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 12:45:50 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id p24so3894569vsf.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 12:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iX2ZpXGFbNOu72F3q0KCqB8Y6bryK806FhnLUU2NMuk=;
        b=G6cAASsLIdBm7YhTBRLehSgS93d9xmCipqJcPtsYE6zI1r6uEQj8RuaqNhWKZm/MSh
         Djat2TbJzt5UKA0QvncwguQxKKMQ0agt0viVUQccQZn3EoyHE8g3ghfJQ6ywAlHnw+pO
         9qE+79PTCaUVi5hgMhQ7X7Bcox4VRzKIvSVhlwYN71gQ0OiTEIB5blID6x01UPtNGizf
         /P1XFDtVCB64JvdhHKuf6XRASxc7PgDU4lyqZ5eV5J8ZesE/8EGHZPFWXBr4ZGEiRTub
         S8y0kVvYfyfgyzL1MZ2Y1nQgr2Rap3Fk9D6NqiPPrieY3VqTUoskxJmiQES1ROkyc2bi
         HcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iX2ZpXGFbNOu72F3q0KCqB8Y6bryK806FhnLUU2NMuk=;
        b=avvx5uC2B+2Pb1JjEGtVztOV0mg9OejtvjXCUSb7DQzj5k4TIw/+709mWr1dYszWt0
         lwWMYmgVzVMa95ta4MEPLUJ/BZG5Z8Xc2xh2VNY1vV7ajmSr4ypIXxUEqbDnij8WwVEt
         4Qi4gd1vnwe5dKuW5h29maYdTpXPDImrVsVY2ElgNc2IIRS+91ckBgFie0yPLCf0jEh3
         rum+lf2N7he2vx65TyPHAfdgV8pt6Hprq8P3szfXuLDMHv9KUbGYlElOfrn4PtvfGvx/
         m23XpqcdftKmpIPzB06KaNII3rlaW48JIZ20Wb2ruR2eqCESGaZ6QeRACScDWuyCwhCE
         WN9w==
X-Gm-Message-State: AOAM533LBh385r7xF3Eb6OBSV/kFla2Z9BHvP3bt0AplIyRXCA8bj9J3
        5lyQLqp9LO6wQ7o0bdnZkNMulV63AKVTY0PA3d/1VA==
X-Google-Smtp-Source: ABdhPJxviktg8cUUe2JlqcrROxU1giGTaebOLk7jJ1ACqAQWlM2uhqXSKmHI3mvsQiPKOfbpu4LWXtjhBeGIsQSOogU=
X-Received: by 2002:a67:e991:: with SMTP id b17mr1266363vso.16.1600717549823;
 Mon, 21 Sep 2020 12:45:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600661418.git.yifeifz2@illinois.edu> <CAG48ez3Ofqp4crXGksLmZY6=fGrF_tWyUCg7PBkAetvbbOPeOA@mail.gmail.com>
 <OF8837FC1A.5C0D4D64-ON852585EA.006B677F-852585EA.006BA663@notes.na.collabserv.com>
In-Reply-To: <OF8837FC1A.5C0D4D64-ON852585EA.006B677F-852585EA.006BA663@notes.na.collabserv.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 21 Sep 2020 21:45:23 +0200
Message-ID: <CAG48ez3+fAjOsktPFmatFPx9cVCvvguQQT5UYbBS6zRZ0RK9WQ@mail.gmail.com>
Subject: Re: [RFC PATCH seccomp 0/2] seccomp: Add bitmap cache of
 arg-independent filter results that allow syscalls
To:     Hubertus Franke <frankeh@us.ibm.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>, bpf <bpf@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        YiFei Zhu <zhuyifei1999@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 9:35 PM Hubertus Franke <frankeh@us.ibm.com> wrote:
> I suggest we first bring it down to the minimal features we what and successively build the functions as these ideas evolve.
> We asked YiFei to prepare a minimal set that brings home the basic features. Might not be 100% optimal but having the hooks, the basic cache in place and getting a good benefit should be a good starting point
> to get this integrated into a linux kernel and then enable a larger experimentation.
> Does that make sense to approach it from that point ?

Sure. As I said, I don't think that the procfs part is a blocker - if
YiFei doesn't want to implement it now, I don't think it's necessary.
(But it would make it possible to write more precise tests.)

By the way: Please don't top-post on mailing lists - instead, quote
specific parts of a message and reply below those quotes. Also, don't
send HTML mail to kernel mailing lists, because they will reject it.
