Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97420269B30
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 03:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgIOBbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 21:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgIOBav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 21:30:51 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBFDC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 18:30:50 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id z19so1335363lfr.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 18:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=m3o6b/k3yrLqkCmTP0xXwX/jdoe71VYTinCKqcJ05H4=;
        b=AkADhMHXxgOTVfD0/TUy1c3LAkpeOQnfCV2MItm1Z6Iw+jFEC4vf500mHsod8UW7i6
         FGk3rgliqSsPwPXJ6T5RzwgnApeTfQXWOtqjEKJfY4jAEv6WFPx01kBikJXCfMTYj0xM
         ZMfG93srm+NVJ1gpKRjz8FvCpP51YHU4OLUbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=m3o6b/k3yrLqkCmTP0xXwX/jdoe71VYTinCKqcJ05H4=;
        b=fgkk8ciMHOdZOC77KJas47l2XUkrQdmRkhGENN1t3mY33z/M5YH/H/DUS4tdkygnEq
         2WVGz0ICNAq52RezhHzaG0v3aB3J8aHr6k1D18Ju5an6QWxZHsKCF+jO/MBsVtO1um04
         9MfzSqobEEJBEl+iaMUmOY10+wxBITiQDcX4kzBsOCYIU8WzlpKi/fyg2kdk00fJp83D
         2WcGlqc1YU7o1LK3d73WxM9Fersn2pknS9M8g8uSSntdZtkGz+MWG97SbYy0AVZ4N48/
         mL1Hk4vPt1GvQgqGjnK0r7u+vEcUojJboRTCrlG6peYqt+KhCPiZRvmvsDGQ5kmrrlvP
         ZxIw==
X-Gm-Message-State: AOAM531bG4LF9JBTYQOEdDNfQlc2FVUOPoqTKUyMMw0t+qV+HRmiHTc1
        4iUqImmAjCPsdi8It6guRj3b5LmjlSZYaw==
X-Google-Smtp-Source: ABdhPJwbhh2nqhpgPplmg6hSz1rOws+LM5truvgksNK/L3T/yV2i3eqaBPx1T53QKnDSqL6R5w7Emw==
X-Received: by 2002:a19:be0b:: with SMTP id o11mr5499482lff.117.1600133449084;
        Mon, 14 Sep 2020 18:30:49 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 78sm4032012lfn.20.2020.09.14.18.30.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 18:30:48 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id k25so1360447ljk.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 18:30:47 -0700 (PDT)
X-Received: by 2002:a2e:84d6:: with SMTP id q22mr5453216ljh.70.1600133447386;
 Mon, 14 Sep 2020 18:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <git-mailbomb-linux-master-50145474f6ef4a9c19205b173da6264a644c7489@kernel.org>
 <c9cd22ec-60dc-d761-b488-d3a1392708c0@infradead.org> <20200915012800.GA17809@Gentoo>
In-Reply-To: <20200915012800.GA17809@Gentoo>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Sep 2020 18:30:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjRDiiqq558v-uqyzSbU2GCL0noxu8gjCW8J3NWXEJBLA@mail.gmail.com>
Message-ID: <CAHk-=wjRDiiqq558v-uqyzSbU2GCL0noxu8gjCW8J3NWXEJBLA@mail.gmail.com>
Subject: Re: fbcon: remove soft scrollback code (missing Doc. patch)
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Yuan Ming <yuanmingbuaa@gmail.com>, Willy Tarreau <w@1wt.eu>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        NopNop Nop <nopitydays@gmail.com>,
        =?UTF-8?B?5byg5LqR5rW3?= <zhangyunhai@nsfocus.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 6:28 PM Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
>
> Documentation/admin-guide/kernel-parameters.txt:        no-scroll       [VGA] Disables scrollback.

So this one at least should be still valid.

But these:

> Documentation/fb/fbcon.rst:2. fbcon=scrollback:<value>[k]
> Documentation/fb/fbcon.rst:     The scrollback buffer is memory that is used to preserve display
> Documentation/fb/matroxfb.rst:   with 'video=scrollback:0'.
> Documentation/fb/sstfb.rst:  disable software scrollback, as it can oops badly ...
> Documentation/fb/vesafb.rst:            * You'll get scrollback (the Shift-PgUp thing),
> Documentation/fb/vesafb.rst:              the video memory can be used as scrollback buffer

now look stale.

            Linus
