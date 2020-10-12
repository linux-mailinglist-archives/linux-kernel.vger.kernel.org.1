Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E7E28B61B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbgJLNYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgJLNYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:24:16 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C66C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 06:24:16 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id q21so15777042ota.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 06:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mC7xtiAV5MQw6msfzLlDYJwQehhrCEkuAMgCJCdFGcc=;
        b=UPZ+CXo1UV5jOGxJY7P+xbNAFkLhkVGYY1xnlSuZ2ChviI45NV8sb21mTxMuRgbLpB
         ZM02/KS3bX/yPLL3ql7ZQOF/PwJEqLuVbm9bojoWzDOVBBwIz4AwoqJZ7XBnN0880OZT
         IKYT72xbIrgQLGp1UPGULvPX06+wfl/Qi7isHHGJwYsglIzVBVu+9bwQdOlhFlKKgICG
         E1x2cE6wXLw6iJkRmt4Sb2ssxSFucElcyAg8tNyY9GELHk+KZyDpp9GNZ6VjY9dEW+u/
         Apz6hKqETjM6IefYaHtw2giItRk193NON9R/yY+tNP0rBFNxoQgxkaplTqUK6qPkQ6e7
         PXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mC7xtiAV5MQw6msfzLlDYJwQehhrCEkuAMgCJCdFGcc=;
        b=pvrIx+k5kABGrw033iyV6pBoFuGD1lIKL5RMieUG5L0pl7/UK+QIqqk77RKlwBJ3+x
         aMxa9nAkQ/4Kj08RlpGyiqKCrc/Fv0GNKd9oLJJxFyUiKV2g4z5Re2pUFSduHvko61mQ
         RuR7GjmJbnmA3O5N6GuoYZwkWulsqJAyWZdLixG++80T/QluZzngbJAH8KnAsqYR4gQR
         NFwBuizypVb7fDCtreRs+WBsnTqehrWeBPtLo8FgD8/I7L7HBNXlC4AX4rh+JVyqBsjY
         62w6yX+6ThstzdIIqmuYKwMahyRFyj/vNeJe8wVXy/FL0Ma//2eW7bsgil8Tx06F8aI/
         OQ6Q==
X-Gm-Message-State: AOAM533wc2x/dD7RVrT+zt2Tz0djxEwwLDVZKjA4BESi3RWaj0abYydg
        gNwWqWap/5ZTHn1FWrrmYlU=
X-Google-Smtp-Source: ABdhPJympHYSIcwrRgVlC4dzn9r0ckdyy8oL+eOYjn08DRUgdHICzJxfdKIA24xGebtYK3RtFReRMg==
X-Received: by 2002:a05:6830:4d:: with SMTP id d13mr18526530otp.67.1602509055933;
        Mon, 12 Oct 2020 06:24:15 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 81sm8681701oti.79.2020.10.12.06.24.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Oct 2020 06:24:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 12 Oct 2020 06:24:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: parsers: bcm63xx: Do not make it modular
Message-ID: <20201012132414.GB6394@roeck-us.net>
References: <20200928161617.2a1b2244@xps13>
 <20200929172726.30469-1-f.fainelli@gmail.com>
 <20201011141447.GA9215@roeck-us.net>
 <20201012090420.6a07599c@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012090420.6a07599c@xps13>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 09:04:20AM +0200, Miquel Raynal wrote:
> Hi Guenter,
> 
> Guenter Roeck <linux@roeck-us.net> wrote on Sun, 11 Oct 2020 07:14:47
> -0700:
> 
> > On Tue, Sep 29, 2020 at 10:27:21AM -0700, Florian Fainelli wrote:
> > > With commit 91e81150d388 ("mtd: parsers: bcm63xx: simplify CFE
> > > detection"), we generate a reference to fw_arg3 which is the fourth
> > > firmware/command line argument on MIPS platforms. That symbol is not
> > > exported and would cause a linking failure.
> > > 
> > > The parser is typically necessary to boot a BCM63xx-based system anyway
> > > so having it be part of the kernel image makes sense, therefore make it
> > > 'bool' instead of 'tristate'.
> > > 
> > > Fixes: 91e81150d388 ("mtd: parsers: bcm63xx: simplify CFE detection")
> > > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>  
> > 
> > What happened with this patch ? The build failure is still seen in mainline
> > and in next-20201009.
> 
> It has been applied on mtd/next:
> https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/log/?h=mtd/next
> (I don't remember when though)

Hmm, lets see ...

Ah, I see: mips:allmodconfig now fails to build in -next for a different
reason.

Error log:
In file included from <command-line>:
arch/mips/mm/init.c: In function 'mem_init':
include/linux/compiler_types.h:319:38: error: call to '__compiletime_assert_331'
	declared with attribute error: BUILD_BUG_ON failed: IS_ENABLED(CONFIG_32BIT) && (_PFN_SHIFT > PAGE_SHIFT)

I'll send a separate report on that (if it wasn't reported before).

Anyway, any reason for not applying this fix to mainline, ie why the
mips:allmodconfig build failure was not fixed in v5.9 ?

Guenter
