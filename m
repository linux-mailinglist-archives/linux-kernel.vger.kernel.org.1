Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38FBC1FA3A0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 00:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgFOWiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 18:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgFOWiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:38:19 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DE6C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:38:19 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id q2so10334425vsr.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uB0HaPwXy50jpF9rLf6Va8RuH3FYVyhSdvvt08br5zU=;
        b=X3FDwr9nZuJCmTh8GMOnY3FLyA7+HVUEP8pR16yq4aXwBt2APUy+WQlUH7WXO0w1yO
         K9as3TCf0flU3QG2pe9+qgtngay4G9A79ycQaoQ4ShA7R+KHuuMILpAkdyspjt4fvz6b
         6DskIBmOoDOnE5ANKPtw3rJuuPoEMNorRI16aJuahLNR+o/RI1Ik23dHdVKZ53W8GhiO
         J1khFgOVTEgwxS3L+AUhna+J37YyTVU2rP6BqVu+sLwyJQw2uq4WV6kfNIneyfyzlld3
         1owtRTKd697eSOPCJApkFir0AjBBvikH2FdzrTguRztSShfhAO2U/NyeEMkDfaUHROTb
         wA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uB0HaPwXy50jpF9rLf6Va8RuH3FYVyhSdvvt08br5zU=;
        b=nVr5GvlTnoZvgdUbn4OK15Ne+Gnd7OxHUq9g+uC0wF2RTTrY65FSGTrXtzur1/OLDz
         FwwpDUNZLkl79viQkMjjHXCUt6ih+hXN0YJu6839PZvH7DDXDj0sZRAM5HXoSSrJOHV/
         hFBBE1YlyV+3FRdFZrHm4NePA4+Z/CLRcmBndvsJ2mSmXmVm4pmobwit8wRTuIiYncf4
         y4mSBHari6ERTeuCd9sITmdSM5Waw1N5qJQ29QSzEW5q+0wUtCh1ginFJdpfggdauUdK
         8v0PqwD+S/tDHsVUhi0lz8PSna5eg3ok7p0tWeUI9gg9wmyQKdW++APvR55oKPdmNMKe
         sRPQ==
X-Gm-Message-State: AOAM5305QCOv2noHakbumez7IC/rw/2VZAF1t6YkhXp+FheutjSu1Hy8
        r3YzZdmIYcVEpHKiVF4JdqcGMF6qlE7i1mDtR2c=
X-Google-Smtp-Source: ABdhPJyqW3jvG9hiix79BPnCB5e/t/YfkMU4SWUOaw1QLk2myo2b7g+Q0rTbLC0jk3VQQRfnIaMWXgzp6zg1dAxZEDU=
X-Received: by 2002:a67:c511:: with SMTP id e17mr20082140vsk.210.1592260698905;
 Mon, 15 Jun 2020 15:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
 <20200613155738.2249399-11-jim.cromie@gmail.com> <20200615133740.GG31238@alley>
In-Reply-To: <20200615133740.GG31238@alley>
From:   jim.cromie@gmail.com
Date:   Mon, 15 Jun 2020 16:37:52 -0600
Message-ID: <CAJfuBxwtbgOFvo3k+_ucwTQkek8mo1f-AF6_u7qKDF6tBBGV+Q@mail.gmail.com>
Subject: Re: [PATCH v2 10/24] dyndbg: refactor parse_linerange out of ddebug_parse_query
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>, akpm@linuxfoundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 7:37 AM Petr Mladek <pmladek@suse.com> wrote:
>
> On Sat 2020-06-13 09:57:24, Jim Cromie wrote:
> > make the code-block reusable to later handle "file foo.c:101-200" etc.
>
> > This should be a 90%+ code-move, with minimal adaptations; reindent,
> > and scafolding.
>
> This sentence sounds like the author did some hidden
> microoptimizations and potentially broke the code.
> It made me nervous.
>
> But in fact, I do not see any real change except that the variable
> "first" does not longer need to be defined. So, it is just a code move.
>
> In this case, I usually write:
>
> This patch does not change the existing behavior.

I see your point.

it was code move, reindent, add function wrapper, add call, compile
I just dont recall if I had to touch anything else, add/move var decls etc.
