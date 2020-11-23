Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0042C18AF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 23:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733081AbgKWWoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 17:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732746AbgKWWoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 17:44:15 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AB5C061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 14:44:14 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id c66so16419140pfa.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 14:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=aeFmHuQ71qpkk8WFbx0vB9YSioxBoTe5G0IGShlBu/Y=;
        b=Y9wXKBxRq04EmFAXeOFr6U0EZwDKpZiVjypgQwCk/rJtX70gKtCsKOd5ATsj7nAQxT
         hMKmZl9+AyyUFStQ6D8FJ/FoJL0y5XcEGtSKtbitDFDHL+OYiSrZFM1NKRMtDamrNt6e
         S5Y4H9bsc26ZHdXEVHWA4MsVeaW5K69QiIwvqRFSrUBq6tyksKmlR4KNTMeZqay7fLXo
         7RawHKx/knrG9yFIwpJsWgG5KHENuCNSTy8MEslQG1oTN1gZP/Q6mjZh8lkOGg1QNwlV
         79S4efoYuQAyiRiBfntw8eRFTItvmY1shAW386crlS4bx4x4CayVIt2MWTIU/sr+960e
         CRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=aeFmHuQ71qpkk8WFbx0vB9YSioxBoTe5G0IGShlBu/Y=;
        b=cw9co4OKma4KZ7K/L+/rq4NVxmnnorwFSsn2I20b+WPXMTwh0pQ+8m48sMcZdSRGXL
         ysIJX7h/YjspCgLF/mHS9J3gey2hsC+v5R9LudlU6SZsdXKvdmi0jPxHdf9M58uL1t2z
         QnT1UD/P7HiZRsh4MZIfw5otJjzmACL4vqF7inlveMsDjNp7UWgveLTMoIbOrhb8SRMQ
         BOR1RBTJ5Mx09zkfydUdlv2+xSN5jTIw1gyCgzvyYdTWknEHGIBE6JiktfLge5aqmCqp
         /57GxWJfLI/EmKUOBHYrqTlkAAcfRodCchqQG1dHOjAX3MsMrsZSwGDP8f/oRZN6yg5k
         2czQ==
X-Gm-Message-State: AOAM530NaJeALJrXZE7SZK61X6FgbPHmRFFauiG4j48/tAprlZzTEGiC
        gjGqyesRsZi29Z/lczcmB4yw0A==
X-Google-Smtp-Source: ABdhPJwYfmE5EvFal+GMyPietDS/iPKLbtUbMYNvvdkPKl5edA0+wfv5uIXqTW6x2TTEJ5imlE67QQ==
X-Received: by 2002:a17:90a:5d17:: with SMTP id s23mr1335224pji.208.1606171453594;
        Mon, 23 Nov 2020 14:44:13 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id 64sm13011192pfe.0.2020.11.23.14.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 14:44:13 -0800 (PST)
Date:   Mon, 23 Nov 2020 15:44:11 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>, od@zcrc.me,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: Add module parameter 'auto_boot'
Message-ID: <20201123224411.GA528846@xps15>
References: <20201115115056.83225-1-paul@crapouillou.net>
 <20201120223701.GF4137289@xps15>
 <P4T5KQ.W5BP830SCRPW1@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <P4T5KQ.W5BP830SCRPW1@crapouillou.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 21, 2020 at 06:38:49PM +0000, Paul Cercueil wrote:
> Hi Mathieu,
> 
> Le ven. 20 nov. 2020 à 15:37, Mathieu Poirier <mathieu.poirier@linaro.org> a
> écrit :
> > Hi Paul,
> > 
> > On Sun, Nov 15, 2020 at 11:50:56AM +0000, Paul Cercueil wrote:
> > >  Until now the remoteproc core would always default to trying to
> > > boot the
> > >  remote processor at startup. The various remoteproc drivers could
> > >  however override that setting.
> > > 
> > >  Whether or not we want the remote processor to boot, really depends
> > > on
> > >  the nature of the processor itself - a processor built into a WiFi
> > > chip
> > >  will need to be booted for the WiFi hardware to be usable, for
> > > instance,
> > >  but a general-purpose co-processor does not have any predeterminated
> > >  function, and as such we cannot assume that the OS will want the
> > >  processor to be booted - yet alone that we have a single do-it-all
> > >  firmware to load.
> > > 
> > 
> > If I understand correctly you have various remote processors that use
> > the same firmware
> > but are serving different purposes - is this correct?
> 
> That's the opposite actually. I have one remote processor which is
> general-purpose, and as such userspace may or may not want it started at
> boot time - depending on what it wants to do with it. The kernel shouldn't
> decide itself whether or not the remote processor should be started, because
> that's policy.
> 
> > 
> > >  Add a 'auto_boot' module parameter that instructs the remoteproc
> > > whether
> > >  or not it should auto-boot the remote processor, which will default
> > > to
> > >  "true" to respect the previous behaviour.
> > > 
> > 
> > Given that the core can't be a module I wonder if this isn't something
> > that
> > would be better off in the specific platform driver or the device
> > tree...  Other
> > people might have an opinion as well.
> 
> Hardcoded in the platform driver or flagged in the device tree, doesn't
> change the fundamental problem - it should be up to the userspace to decide
> whether or not the remote processor should boot.

That is why I suggested to add the module parameter to the platform
driver(s) that needs it.  That way user space may decide to do whatever it
wants based on the scenario to enact.  

I see your point of view about putting the setting in the core but that is
introducing drawbacks when dealing with more than one remote processor on the
same system.

Thanks,
Mathieu

> 
> Cheers,
> -Paul
> 
> > 
> > >  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > >  ---
> > >   drivers/remoteproc/remoteproc_core.c | 7 ++++++-
> > >   1 file changed, 6 insertions(+), 1 deletion(-)
> > > 
> > >  diff --git a/drivers/remoteproc/remoteproc_core.c
> > > b/drivers/remoteproc/remoteproc_core.c
> > >  index dab2c0f5caf0..687b1bfd49db 100644
> > >  --- a/drivers/remoteproc/remoteproc_core.c
> > >  +++ b/drivers/remoteproc/remoteproc_core.c
> > >  @@ -44,6 +44,11 @@
> > > 
> > >   #define HIGH_BITS_MASK 0xFFFFFFFF00000000ULL
> > > 
> > >  +static bool auto_boot = true;
> > >  +module_param(auto_boot, bool, 0400);
> > >  +MODULE_PARM_DESC(auto_boot,
> > >  +		 "Auto-boot the remote processor [default=true]");
> > >  +
> > >   static DEFINE_MUTEX(rproc_list_mutex);
> > >   static LIST_HEAD(rproc_list);
> > >   static struct notifier_block rproc_panic_nb;
> > >  @@ -2176,7 +2181,7 @@ struct rproc *rproc_alloc(struct device *dev,
> > > const char *name,
> > >   		return NULL;
> > > 
> > >   	rproc->priv = &rproc[1];
> > >  -	rproc->auto_boot = true;
> > >  +	rproc->auto_boot = auto_boot;
> > >   	rproc->elf_class = ELFCLASSNONE;
> > >   	rproc->elf_machine = EM_NONE;
> > > 
> > >  --
> > >  2.29.2
> > > 
> 
> 
