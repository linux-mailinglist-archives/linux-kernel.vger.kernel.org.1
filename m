Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558B9211336
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 21:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgGATE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 15:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgGATE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 15:04:56 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82E6C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 12:04:55 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id s16so8903746lfp.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 12:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LfIJEhCwwu+fefbhHCXDCs/F8dmiQuAFEN1MZjUcMz4=;
        b=Xp5heb7W/4/4YHhd6hrXqdqlT6vB2rGBK+UHi9fgP2clCojJL2rpuiKJrMidehTB92
         Uk7pvtmw/pRoDnZeAmUPp7WzsCo3AuslBYwFz+JT3MAB5c3PCtPlhSbYhYJBFmzQh90Z
         glSR0lZ5wSPIUk8NeOG7Pq++Can0uDy0S3XD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LfIJEhCwwu+fefbhHCXDCs/F8dmiQuAFEN1MZjUcMz4=;
        b=AtWVLD3G3suz1BrPJNJMNiHmYWknEJb0PVbwKUxOChTZOpaMEwIbK366cV6GK9MhqH
         8oF8s69+PxEUTWFg7lY0UC0BRDItrCfH1B3jHdxMAmfxTyCovqyCgFaUiVUiMwidpzTK
         J5/lAokQN0GiPoJ5hFtXXK33WkbAhVBZ546ln7Fopt66MnMP+ybm44VHBdoyoCvkBxTx
         H6cCMgtopX2YYfqqzfzDm4U/d606CaYFEBVXUnlsRnG3BCMyAofzemkwAtpTCfUGoBn1
         aCVctyoqqlPi7HvOTIFimqGFnPttrBj5h8/z40BmskYWv+Yj3nYfwwzmkqw8agxRP2Kh
         y2qw==
X-Gm-Message-State: AOAM530rHPfCDt/9AHN/I7n73QYY8AWU8Om5BgjBUte1H0ShDdct9Uby
        2nhyng6CKcLoQ4jBFRoZ92O5CfrD4G4=
X-Google-Smtp-Source: ABdhPJypN18E9hVr2JA2TydS7JbnHkkxr+xJV46WW8U90cMbrlsz7U4LWKREIueycAJnB1BxYzITjg==
X-Received: by 2002:a19:23cc:: with SMTP id j195mr15996270lfj.210.1593630293585;
        Wed, 01 Jul 2020 12:04:53 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id v20sm2348004lfe.46.2020.07.01.12.04.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 12:04:52 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id h19so28514454ljg.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 12:04:52 -0700 (PDT)
X-Received: by 2002:a2e:9b42:: with SMTP id o2mr13730506ljj.102.1593630292231;
 Wed, 01 Jul 2020 12:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjc-ktbOr7ZHMY8gfAmHxUK+aMdDsQjeh+BvmQwnQfN_g@mail.gmail.com>
 <20200701184131.GI2786714@ZenIV.linux.org.uk>
In-Reply-To: <20200701184131.GI2786714@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Jul 2020 12:04:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_2v9m+yZioE4vOLGW1mc9SBa5+++LdeJ86aEeB5OXcw@mail.gmail.com>
Message-ID: <CAHk-=wj_2v9m+yZioE4vOLGW1mc9SBa5+++LdeJ86aEeB5OXcw@mail.gmail.com>
Subject: Re: objtool clac/stac handling change..
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 11:41 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Rather nasty for ppc; they have separate user_read_access_end() and
> user_write_access_end().

That's actually for the access granting. Shutting the access down ends
up always doing the same thing anyway..

                 Linus
