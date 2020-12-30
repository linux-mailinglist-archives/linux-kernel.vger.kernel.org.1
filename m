Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E29C2E7CCC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 22:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgL3VoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 16:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgL3VoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 16:44:04 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8540C061573
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 13:43:24 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id z11so15051915qkj.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 13:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MHAGjQt9ritApkqt6RGeoNtDT77YQoOVvjyTVHtT+3g=;
        b=gdhHhCOSKiJu9ssv21NlgVOZgjqGA7klsE/doI6LO95h1q147zlEf0ia1QPmCWpaOW
         WOwTMR6GFVbSJMxcm58ILD9HcSUynOYxTyYL3sdj7OQdqRPDZ2EtLsSjKlWd2DFrrwCb
         2kqLBKnRIYZWEd1wth0vzRC04GeyAgZxZ+vF6yByxfbzBzFNkmjwKrvQPkKYmPXWrPkk
         a4LDNiBGXkhg4Dju4Gf8EW0x7WLfmJxvQR04hZKKc9Y8o+xRz5GJhsBiiFCpm5SKz+oj
         BiHY47x1aXNW9xdoM/BYCxta7+phX38YY5BPX9sy3JxczaR7nK5p9se1J5J4UXpO9GHt
         z4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MHAGjQt9ritApkqt6RGeoNtDT77YQoOVvjyTVHtT+3g=;
        b=ASu9AWcy2g671cgitpHTMVxE4BVYqqhFqNGFruiM2JcOzpL/lteu5fFNMtmiiu/HN4
         1BYdzDtnBMhEMrmlOElEIaaJN5wHhYy0Or4ZXBim5jqqUqcnHX8h8X78co5txLXnKaWO
         CxQlJjCbi6v9K3D/zONbmbgBi9LDXiFbV4k1Pi0NBhPu+aTKVK2ADRrUXajM7tWbL7Sq
         DEJHVHckOesyVjymu9RwJQziqZfADKPRoX7C65lO2XGrvHRYXn2PuT8COdpfyLw7F6G+
         ZJ7epl8Zb2IqX/eBmuzAZp37StIWng/KPI/vMs2ZNWFv4ILg5pjGOaJQvPiXAmgX98uI
         KZGw==
X-Gm-Message-State: AOAM531C/ZgqzgLYpYxd5lChiLx006b19RHpvJHuc/U1f5VpBC6Sb8oi
        xJCgAuZmmCMLEz2L1xpOnHo=
X-Google-Smtp-Source: ABdhPJyuasQOd1EF0EG5fgz9yVihgXhzj3QGyamnG8i9FOy9owqSH4h7MwP048Iu4Y8EfYyf6hReUw==
X-Received: by 2002:a37:e108:: with SMTP id c8mr55768855qkm.305.1609364603815;
        Wed, 30 Dec 2020 13:43:23 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id b15sm22343588qta.75.2020.12.30.13.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Dec 2020 13:43:23 -0800 (PST)
Date:   Wed, 30 Dec 2020 14:43:21 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Nicolas Pitre <npitre@baylibre.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] i3c/master/mipi-i3c-hci: re-fix __maybe_unused attribute
Message-ID: <20201230214321.GA1961980@ubuntu-m3-large-x86>
References: <20201230154304.598900-1-arnd@kernel.org>
 <orno9ppp-no44-4rp5-s6-58n46rsps045@onlyvoer.pbz>
 <20201230214053.GB110311@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230214053.GB110311@piout.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 30, 2020 at 10:40:53PM +0100, Alexandre Belloni wrote:
> On 30/12/2020 16:23:56-0500, Nicolas Pitre wrote:
> > On Wed, 30 Dec 2020, Arnd Bergmann wrote:
> > 
> > > From: Arnd Bergmann <arnd@arndb.de>
> > > 
> > > clang warns because the added __maybe_unused attribute is in
> > > the wrong place:
> > > 
> > > drivers/i3c/master/mipi-i3c-hci/core.c:780:21: error: attribute declaration must precede definition [-Werror,-Wignored-attributes]
> > > static const struct __maybe_unused of_device_id i3c_hci_of_match[] = {
> > >                     ^
> > > include/linux/compiler_attributes.h:267:56: note: expanded
> > > 
> > > Fixes: 95393f3e07ab ("i3c/master/mipi-i3c-hci: quiet maybe-unused variable warning")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > Acked-by: Nicolas Pitre <npitre@baylibre.com>
> > 
> > This might be the 3rd patch from 3 different people fixing the same 
> > thing. Looks like I3C maintainer is on vacation. Please feel free to 
> > send this trivial fix upstream some other way.
> > 
> 
> Isn't it already upstream?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=95393f3e07ab53855b91881692a4a5b52dcdc03c

This patch is fixing that one, the attribute was added between the
struct type, causing a new warning for clang.

I sent a fix for this earlier too, I do not care which one goes in as
long as one does so:

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

Cheers,
Nathan
