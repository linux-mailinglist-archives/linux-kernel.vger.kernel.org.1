Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F3A26AFC7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 23:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgIOVm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 17:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbgIOVbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:31:48 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737B7C06178C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:31:20 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id j3so2810730vsm.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dFv9Gx6tvlxqa0/RzOqnD6QC+ix0oiRzcNzkhnH/umg=;
        b=J6c70s4fTxjUka3LSjMXvXapX2EgOftb7Jx/0Me/tYRCMZ1Fry/85pl56tcuFKxXXy
         Hn6VPz59EluVLdwPyOMvouhWA0gghHAc7i5k+Vo3KoU8DIIoJBYX0MCA36yjVqUsJnNw
         N5pWQiuwt2wPnbYwhP6JiECPP4K3ptOVviZOYJouJ575MXwMfUWbT1DoyimZvjd3xaVN
         2jcrfwNX0HcUgam9EA21L7Ublef3WMLoaxVThb9bfzekMoL5rltMNUY349yGWo2GTcjG
         hQu9E1I4nysVbjWAd/dT2u2GTFGwOWuhUcVEaw/GmULzBI1/htO6DRfwVyem85s8CN4i
         LqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dFv9Gx6tvlxqa0/RzOqnD6QC+ix0oiRzcNzkhnH/umg=;
        b=gxIcXZ9c9XoKPnMSiexkXv3Sya2BSZHEm3k9MD5BbbdBDS8r0+sHrHBkJKdBdwfRvo
         OcpQF6qIyabWuhWs7G7npC7Spe+iC61r/KZNIbvM5aUKjhGvz3wOrvZXPAzSsAIk3hup
         J8Zx8FlcoABoG7hxOuPYef0mqDgKY9K5smc+H667/2q6g889CfH2QyQl2MkV1jDQClQJ
         Rj/elFReyoIY56lJXKrhIoodb8fkk0Zm66FIFdG+Re4S432jTjsOWixb33VSjKaU/75h
         3MHnylYJwAvrX6WJpz1JKaJ/w2R7haKakoJY8KELQUCrBZXQjcb9I80+T0vJSP88qv81
         mmjw==
X-Gm-Message-State: AOAM531Q9aFBN0cGKXsP79QcJ/+woE9MPF00Q4oLfu4tKeZosRo1AXUO
        VL+aucA4wflpe5QL1wFlC9gtf0GJfIGoCZjvacnA
X-Google-Smtp-Source: ABdhPJxLINW13QOxGnh3QVD4VYNyS7XfvbgeJoOWRLap1E8aGmIK5kjDY0bGJdnXxK0L10z9PeNWjBlMkrCVHhWnCqQ=
X-Received: by 2002:a67:e248:: with SMTP id w8mr2932477vse.40.1600205479121;
 Tue, 15 Sep 2020 14:31:19 -0700 (PDT)
MIME-Version: 1.0
References: <9f513eef618b6e72a088cc8b2787496f190d1c2d.1600203307.git.luto@kernel.org>
 <CAKwvOdnjHbyamsW71FJ=Cd36YfVppp55ftcE_eSDO_z+KE9zeQ@mail.gmail.com>
In-Reply-To: <CAKwvOdnjHbyamsW71FJ=Cd36YfVppp55ftcE_eSDO_z+KE9zeQ@mail.gmail.com>
From:   Bill Wendling <morbo@google.com>
Date:   Tue, 15 Sep 2020 14:31:07 -0700
Message-ID: <CAGG=3QUfqup=Uv1mdwe6qecsZFAqfZUxXX+a+CnJLvfufWUykA@mail.gmail.com>
Subject: Re: [PATCH] x86/smap: Fix the smap_save() asm
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Thelen <gthelen@google.com>,
        John Sperbeck <jsperbeck@google.com>,
        "# 3.4.x" <stable@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 2:24 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
> On Tue, Sep 15, 2020 at 1:56 PM Andy Lutomirski <luto@kernel.org> wrote:
> > Fixes: e74deb11931f ("x86/uaccess: Introduce user_access_{save,restore}()")
> > Cc: stable@vger.kernel.org
> > Reported-by: Bill Wendling <morbo@google.com> # I think
>
> LOL, yes, the comment can be dropped...though I guess someone else may
> have reported the problem to Bill?
>
I found this instance, but not the general issue. :-)

-bw
