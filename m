Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC1F2DFF29
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgLUSDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgLUSDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:03:23 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB8FC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:02:42 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id d17so14652138ejy.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kMPwSByM5Ofrk9Kvk8b94+hVOdCU16NWvETZQDOg+ns=;
        b=RzcksibqGzUEPSFE0m8P+JWb11CJAU3jMWh0XO1JtfV/WtL4MjWV6XkqYK5EZ5Q2nU
         TrDmyMWHSL26YBIbESRADOXyfBW7UB2f3zCeuNcC+uzPKF1Rwww9NXaogzewXr3/tczT
         WNz6Yz6iyaqyz5eQbs0CIQPzpL191Qeth/q5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kMPwSByM5Ofrk9Kvk8b94+hVOdCU16NWvETZQDOg+ns=;
        b=PvhaUZiiAEcJRZBBCP7NvT8JvSHY2dPna6o83C6ZAik0UbuMELqZyMrBVmhWKUUF+l
         aiT2Ruxg7Iv9j24fcRY+pIho4mCX5dPCABTJ7KJE5zfohP513la+5lFZatQwwxaLBPHQ
         E1c8+/0ILBbglBUCBD+qtMqKzBT9xrbo89YO/NaiIMMf+m8iTNdBFz/p0SaB8o5GY5zh
         XV2wTRv2G+vA/sBXBYQQJsFqbsfPVVkbUWU0RiXwVcNHmUReUNxWGp5+RMlis3GynA/w
         hZ9R6/bOgBjeaUWMxJp6QfYpsmbEJIBu9i2fYvDEryMqklZ3rlipn6qVhIUSlxFQp1kL
         5E5w==
X-Gm-Message-State: AOAM533hfzMM3qd9HBa7HV60jEriPd5Alti0h6X1D5lfVqwqJ60mZ/4D
        /4QJmqqpAT6FRuDUdAOto0Fjlb2z8zrvBg==
X-Google-Smtp-Source: ABdhPJx44rZpudTHvD6TfUk3fr+Aup1rNnk9RhLLagmBBpElDskm8JzbAGhHZx4VhEej/xhHWD1+Mw==
X-Received: by 2002:a05:651c:48e:: with SMTP id s14mr8294210ljc.159.1608572286250;
        Mon, 21 Dec 2020 09:38:06 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id q16sm2149012lfb.8.2020.12.21.09.38.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Dec 2020 09:38:05 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id o17so25651369lfg.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 09:38:05 -0800 (PST)
X-Received: by 2002:a2e:9b13:: with SMTP id u19mr7549776lji.48.1608572285100;
 Mon, 21 Dec 2020 09:38:05 -0800 (PST)
MIME-Version: 1.0
References: <365031.1608567254@warthog.procyon.org.uk>
In-Reply-To: <365031.1608567254@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Dec 2020 09:37:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=whRD1YakfPKE72htDBzTKA73x3aEwi44ngYFf4WCk+1kQ@mail.gmail.com>
Message-ID: <CAHk-=whRD1YakfPKE72htDBzTKA73x3aEwi44ngYFf4WCk+1kQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] afs: Work around strnlen() oops with CONFIG_FORTIFIED_SOURCE=y
To:     David Howells <dhowells@redhat.com>
Cc:     Daniel Axtens <dja@axtens.net>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 8:14 AM David Howells <dhowells@redhat.com> wrote:
>
> CONFIG_FORTIFIED_SOURCE=y now causes an oops in strnlen() from afs (see
> attached patch for an explanation).  Is replacing the use with memchr() the
> right approach?  Or should I be calling __real_strnlen() or whatever it's
> called?

Ugh. No.

> AFS has a structured layout in its directory contents (AFS dirs are
> downloaded as files and parsed locally by the client for lookup/readdir).
> The slots in the directory are defined by union afs_xdr_dirent.  This,
> however, only directly allows a name of a length that will fit into that
> union.  To support a longer name, the next 1-8 contiguous entries are
> annexed to the first one and the name flows across these.

I htink the right fix would be to try to create a type that actually
describes that.

IOW, maybe the afs_xdr_dirent union could be written something like

  union afs_xdr_dirent {
          struct {
                  u8              valid;
                  u8              unused[1];
                  __be16          hash_next;
                  __be32          vnode;
                  __be32          unique;
                  u8              name[];
         } u;
          u8                      extended_name[32];
  } __packed;

instead, and have a big comment about how "name[]" is that
"16+overflow+next entries" thing?

I didn't check how you currently use that ->name thing (not a good
identifier to grep for..), so you might want some other model - like
using a separate union case for this "unconstrained name" case.

In fact, maybe that separate union struct is a better model anyway, to
act as even more of documentation about the different cases..

              Linus
