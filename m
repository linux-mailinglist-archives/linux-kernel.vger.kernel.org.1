Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55855304E97
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389146AbhA0Am6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 19:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392188AbhAZR67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 12:58:59 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B616FC06178B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 09:56:12 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id i63so10859162pfg.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 09:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=49OfVhE6yUIYau/W+C0A+f0GHRQbjZMk200/UCnt3K8=;
        b=lm6Av3vx6keX17wsHI34YsUFn71zlQOVF/k29/xxOcx0wQNEBZBAJYjbXDsmult15O
         qEhk7RMn4rXh2Fwdha3zUWYBySxiLah6gS11Yoz+L6X61BLabG6+mrsn/fFmyNJW7VSW
         8W3kEOxyfsPXkINt/HGjvHIMOai4+4x9gIWUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=49OfVhE6yUIYau/W+C0A+f0GHRQbjZMk200/UCnt3K8=;
        b=sOWa1mw6DCRsH9NjaO0LA8ffkKH0jFz4jFSOVbIh9TomzQIQNDILwpgZzZTEqyc7mP
         QRJh715BrWpgYOv169j6gepdyN+dZZxRCqtD+/jKjtJerfyd9AEO3vghP1kdxIeCUl83
         caX6z3Mn3AXqm6SdLggcVKt5fGQOg5zWdQb0TOHRUj5HPgt/+EO7ATgaCK9hXwg2rTa9
         T/Fde8akg6x5/Vo6NCJmA6fZS8qaw+ZKOXWxbW7pGu5MveNJFVnEu2XRImjgviX3KNbJ
         3KYfBBXoHJu+8wXxBPU+mjbIZJN1AekRDuh6zwk+P8t0mboCVUuJw6MnGwpLAYvfW+UV
         e/3Q==
X-Gm-Message-State: AOAM5337Ga6fbuY38/dzwVbq9naajeRqp4pMJgVgVSVsfvbJKnQVPsJq
        fFdi4MeLUA1DJzWhcXRWTURdsYaqEQug3g==
X-Google-Smtp-Source: ABdhPJw4hSgbw4HDAJRlyJdZcMFq3MdSNUNHP0bouDMZZWMFMNRrbouvqLSWcwnQkUMvsOmc+Joy1A==
X-Received: by 2002:a63:db0d:: with SMTP id e13mr6714733pgg.343.1611683772344;
        Tue, 26 Jan 2021 09:56:12 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x14sm20060251pfj.15.2021.01.26.09.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 09:56:11 -0800 (PST)
Date:   Tue, 26 Jan 2021 09:56:10 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Justin Forbes <jforbes@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: [PATCH RFC] gcc-plugins: Handle GCC version mismatch for OOT
 modules
Message-ID: <202101260955.F83D191B@keescook>
References: <efe6b039a544da8215d5e54aa7c4b6d1986fc2b0.1611607264.git.jpoimboe@redhat.com>
 <202101251401.F18409FDD1@keescook>
 <20210125221953.wng3gk3qc32eahil@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125221953.wng3gk3qc32eahil@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 04:19:53PM -0600, Josh Poimboeuf wrote:
> On Mon, Jan 25, 2021 at 02:03:07PM -0800, Kees Cook wrote:
> > On Mon, Jan 25, 2021 at 02:42:10PM -0600, Josh Poimboeuf wrote:
> > > When a GCC version mismatch is detected, print a warning and disable the
> > > plugin.  The only exception is the RANDSTRUCT plugin which needs all
> > > code to see the same struct layouts.  In that case print an error.
> > 
> > I prefer this patch as-is: only randstruct needs a hard failure. The
> > others likely work (in fact, randstruct likely works too).
> 
> I'm curious about this last statement, why would randstruct likely work?
> 
> Even struct module has '__randomize_layout', wouldn't basic module init
> go splat?

No; the seed is part of the generate includes -- you'll get the same
layout with the same seed.

-- 
Kees Cook
