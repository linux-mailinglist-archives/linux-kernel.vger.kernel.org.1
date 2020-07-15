Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4746F22149C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 20:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgGOSp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 14:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgGOSpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 14:45:55 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951DEC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 11:45:55 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id k7so1662036vso.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 11:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mawsonlakes-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XvKf4QD1e5O7xyUYt/0sELdWgljCyGRaCSrceoWQt+Q=;
        b=qMz7WzoAHpsJJrp8HFvA2RJHHayfYpLkrZ2VGJROXNjNKwGEc1InvqQjzcvig7RMCc
         SRYf+8np+N1CjIW+QUWaQXp7Tw3Nohx16STAfRbZDKL9T8ubj0qDren8vLkXZ2dY/j3X
         aggeOSCux0cuE34yxYkfw+vy5lcUje7zql/rxFSl31FQuhG4niYng+7EkiJTSfNfRIMw
         K507Y7FhFdRV1mzECF34upLleiUqmDTQDs8+h9kzjUjKWLpNY6P/YPmraumK07HLZW5R
         2JelTDSxBPny1dfNxx6UcgpmDxZBod/4v50ZDJg6OAhF2AjGWx4jq8dDiztrAXOgrb5Y
         /PFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XvKf4QD1e5O7xyUYt/0sELdWgljCyGRaCSrceoWQt+Q=;
        b=BYS+h//PcVoLE8fQWRDcshdET9ManJOmdxwIW6JEz/CC4vn++FMgpofydnaCZmm6lF
         sEjsjlcW+pynHLyQSlsDeqfjNmcpM89mKhjs1JVWv3M9U6EuGoljHkUnN9QCCE074Rwe
         GuW6p9Ca6ZIurXYPBrFeaQ3TPh5MgTDqxhbFrlYa/iey4HfNoSickDOE6sCLCkyzZ28z
         VaarTLPWhgBnCmgLRfOXPjDAf8igUozNnowtdxyAH+FUjGpfC/0935f6XMg0Sk6QwRSp
         F9hvgkVSwRg4hQj+gdaj6k6WUSc8JFeKUrE81K6Ycih+bxr8ApQ4ooDZswsiqhopqb/3
         Eh+A==
X-Gm-Message-State: AOAM533ytNsrSFxCrw2RG3WzaOnyjo0GghNmuIw3tW6hvjA9ISeIeFnx
        6wce76oHPRaQLIOIDkibDJQ0zDW9vZXoL42fy791rnkhqvD/qw==
X-Google-Smtp-Source: ABdhPJxWUmHU1k1z8iNd6QtA/VdH/Ye9kFZeDhtORdjCPldH03OKv8sfwI/GmuMB09HPERbxJH21y2IViwrM1khuRW4=
X-Received: by 2002:a67:ecc4:: with SMTP id i4mr477621vsp.228.1594838754652;
 Wed, 15 Jul 2020 11:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200715162204.104646-1-paul@mawsonlakes.org> <20200715114032.057fd63d@lwn.net>
 <CAGt04nb7Z436TWRWGuphQO2MzfwbZch3kUFqK4jy-9ib+JF2EA@mail.gmail.com>
In-Reply-To: <CAGt04nb7Z436TWRWGuphQO2MzfwbZch3kUFqK4jy-9ib+JF2EA@mail.gmail.com>
From:   Paul Schulz <paul@mawsonlakes.org>
Date:   Thu, 16 Jul 2020 04:15:43 +0930
Message-ID: <CAGt04nZLViVautnbeFFMbx=_=0eNbW3fz5AAVKi6wCXDHZn2rA@mail.gmail.com>
Subject: Re: [PATCH] sound/pci/hda: Changes 'blacklist/whitelist' to 'blocklist/allowlist'
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good news is that appears to be the only case of this particular usage
with MODULE_PARM_DESC
Searching for 'blacklist' and MODULE_PARM gives the following:

sound/pci/hda/hda_intel.c:183:MODULE_PARM_DESC(pm_blacklist, "Enable
power-management blacklist");
arch/x86/crypto/camellia_glue.c:1473:MODULE_PARM_DESC(force, "Force
module load, ignore CPU blacklist");
arch/x86/crypto/twofish_glue_3way.c:251:MODULE_PARM_DESC(force, "Force
module load, ignore CPU blacklist");
arch/x86/crypto/des3_ede_glue.c:467:MODULE_PARM_DESC(force, "Force
module load, ignore CPU blacklist");
arch/x86/crypto/blowfish_glue.c:423:MODULE_PARM_DESC(force, "Force
module load, ignore CPU blacklist");

On Thu, 16 Jul 2020 at 03:45, Paul Schulz <paul@mawsonlakes.org> wrote:
>
> Yep. +1 for logic
>
> On Thu, 16 Jul 2020 at 03:11, Jonathan Corbet <corbet@lwn.net> wrote:
> >
> > On Thu, 16 Jul 2020 01:52:04 +0930
> > Paul Schulz <paul@mawsonlakes.org> wrote:
> >
> > > -static bool pm_blacklist = true;
> > > -module_param(pm_blacklist, bool, 0644);
> > > -MODULE_PARM_DESC(pm_blacklist, "Enable power-management blacklist");
> > > +static bool pm_blocklist = true;
> > > +module_param(pm_blocklist, bool, 0644);
> > > +MODULE_PARM_DESC(pm_blocklist, "Enable power-management blocklist");
> >
> > This will break any user specifying this parameter now, which isn't
> > something you want to do, methinks...
> >
> > jon
