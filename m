Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5D92B134B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 01:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgKMAes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 19:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgKMAes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 19:34:48 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99D4C0613D1;
        Thu, 12 Nov 2020 16:34:31 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id c20so6110149pfr.8;
        Thu, 12 Nov 2020 16:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P8TtnzNEhdL1QCglKeltAYHSPUZllVgYYEg6VbDdAHU=;
        b=oGh7cKqnLcwhcEG6ECHTrGrwtapz/35tLXsK7yJGn9yxHo34ZcJiljqrNkzKeq/bA3
         b/afwpLyR8vbuHs67B6vPxj3kjVNchBNe00DKJk3IwUmwScSHryOuWZLLyB6gyrBOW+P
         fKGhO+i/j0OA21gWNVEH1B1Nq6gk2kfOFmjm4dz8Hg58ZfCPtmX5Bu9/egwa1X3ioE3x
         mWP51tXBBgoKdRA/tdK9F+xx/RPZA6wQdm45KXp3N3FQQMjAOQ/U1IHQGaFhJUzWVblm
         YsyA11U6DpT9xemuFLWfFE4RV6vP2Dam5IA6CpcnXwge3agVLRwcLjjJ/M0zjv/5tgfv
         1Pbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P8TtnzNEhdL1QCglKeltAYHSPUZllVgYYEg6VbDdAHU=;
        b=Y1P3dLQoQ7uu/Ro737sL4otSyaAFw2Ks+MyjgieLxTnOk20fzJmBiTJHYLnuxtPgp1
         v5hZr7GxFZo6a9rz2KhMrux2N3h2n9YZ2RufTWgdhsSjp9c4fnMiR+QWCLP4FCt4PJ98
         wZoXh+f181lTwZBjfpU3rBcbQ9ogO9SqI8miUHEiO1AzXWpb3Sew8o+CmiczwKgT/Q0S
         k0jbXUl2C7dMokHY/Smm7OXid8Mr7WncJGOtVmOeRfvX7vN3B4FjtsZUYesrGz022XiM
         3cIlYcMYFd/cR7JA5ld3ICXUr2scA/rysGJObswlVA5/phOwPBoitPY5wi2Fc+LcwcEa
         qDPA==
X-Gm-Message-State: AOAM533Q+djSYzkyMk8pGMTAlxCghtL7A4oc6xOjqLlFaH7La2vMAm2J
        957ljiCVwDL0T4dep2ASEi0=
X-Google-Smtp-Source: ABdhPJz1ppPRVXyEQyquvcp3Dv8fodvoeP5O8Y52eu4o1MymuhkYt6ycVTzQC3Irlnh2prtaZx+2jw==
X-Received: by 2002:a17:90a:440d:: with SMTP id s13mr387147pjg.99.1605227671319;
        Thu, 12 Nov 2020 16:34:31 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91 (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id q72sm1132211pfq.62.2020.11.12.16.34.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Nov 2020 16:34:30 -0800 (PST)
Date:   Thu, 12 Nov 2020 16:34:20 -0800
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>,
        devicetree <devicetree@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Andrew Jeffery <andrew@aj.id.au>, Tao Ren <taoren@fb.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/4] ARM: dts: aspeed: Add Facebook Galaxy100 BMC
Message-ID: <20201113003419.GA12608@taoren-ubuntu-R90MNF91>
References: <20201111232330.30843-1-rentao.bupt@gmail.com>
 <CACPK8XdC8FRKOLQ9e583gVuDrL5829MOfx5L=O68dou6mjW_6g@mail.gmail.com>
 <20201112031828.GA4495@heinlein>
 <CACPK8Xf07AZNb3K76sDsZDHNOPuhpkkUGST0=RTCTS5BXgncmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8Xf07AZNb3K76sDsZDHNOPuhpkkUGST0=RTCTS5BXgncmA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 05:49:30AM +0000, Joel Stanley wrote:
> On Thu, 12 Nov 2020 at 03:18, Patrick Williams <patrick@stwcx.xyz> wrote:
> >
> > On Wed, Nov 11, 2020 at 11:34:10PM +0000, Joel Stanley wrote:
> > > On Wed, 11 Nov 2020 at 23:23, <rentao.bupt@gmail.com> wrote:
> > > >
> > > > From: Tao Ren <rentao.bupt@gmail.com>
> > > >
> > > > The patch series adds the initial version of device tree for Facebook
> > > > Galaxy100 (AST2400) BMC.
> > > >
> > > > Patch #1 adds common dtsi to minimize duplicated device entries across
> > > > Facebook Network AST2400 BMC device trees.
> > > >
> > > > Patch #2 simplfies Wedge40 device tree by using the common dtsi.
> > > >
> > > > Patch #3 simplfies Wedge100 device tree by using the common dtsi.
> > > >
> > > > Patch #4 adds the initial version of device tree for Facebook Galaxy100
> > > > BMC.
> > >
> > > Nice. They look good to me.
> > >
> > > Reviewed-by: Joel Stanley <joel@jms.id.au>
> > >
> > > Is there another person familiar with the design you would like to
> > > review before I merge?
> >
> > Also,
> >
> > Reviewed-by: Patrick Williams <patrick@stwcx.xyz>
> 
> Thanks. I have merged them into the aspeed tree for 5.11.
> 
> Cheers,
> 
> Joel

Thank you Joel.

BTW, I sent out another 2 patches for AST2500 dts earlier this week; not
sure if they were successfully delivered; if not, I will resend them
earlier next week.


Cheers,

Tao
