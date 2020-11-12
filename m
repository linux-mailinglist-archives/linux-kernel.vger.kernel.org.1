Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428F72AFE95
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 06:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgKLFjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 00:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgKLF0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 00:26:05 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F64C0613D4;
        Wed, 11 Nov 2020 21:26:05 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id z1so2183694plo.12;
        Wed, 11 Nov 2020 21:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pJfnnhc7tEjJrgDlvsROK+XxTP5/LN/c7M7Xz2gFhuY=;
        b=cLaWQgCXWWPpgY9ONzvSCnmnAPabiqAORFxX6sOR8VfxA5OB28xfNq/XAQ6zKD1vLD
         PlwvOirnn/fkKn7hV6fhSfmKzQAg5PD82tuUzSgCBEYJtlnnskcRNM9+EvlBB0BbAC3w
         fbCJBdSo/U0mBkQMZVlNBIMq3B8FweCIeFGbLPyUSsxe7mWmNe7YahVvWf1oKzLgUOo1
         BwcYVML60q1cNyqrsiR/XwDQTgsZxTvZCvOrou52daqqtn0KsKAXYT5rVm8dlm0JHVcZ
         XZ1Zpgdx5kN1p1pFCrJdTIQa/b4Irn+o1icRGLeiYjOZ+amiqAJkHuiJr1K2y01BamJo
         rwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pJfnnhc7tEjJrgDlvsROK+XxTP5/LN/c7M7Xz2gFhuY=;
        b=cYGv0FZp5nlqdzi0P2PRZ/S+BZY2oNdlqiUg9kwRISVYqFpfIVETmBvyV20iZ7jYep
         H+zxc8VTYPj7acEo7A8VclaqKP2q/Mhzio5nF6h/UBVnfkoI/ED5aLyySfKltURrlWZl
         BzXa5vpoF2oilUl3rZ3fkrYrUu7tWOxD+Jd0DpOFS9uTpPYyfRlKLplBUbEHfLU4iMIi
         4+lVXaSmpJneSPglWVtEs5iGShJ8xE7p/6Ez3WxDw8cLVzx1PF3JtFwnIPqeClbIuB/8
         0Lw5xH8g/PHiC+RUfnZNpg+GyUryf7Wj8MO3XcwZ48HBmTS3rZ3CzOldtIa8E18dGJsN
         VavQ==
X-Gm-Message-State: AOAM533uXKEiidpwzFsDgvGMak6X1U9RvADSll6CQ46KIcVuwHE+GWEF
        yHEX+FNllmpmMMH5dlE7RR4=
X-Google-Smtp-Source: ABdhPJz2becez7wcvS0QDgwSyIvzMgEOqMClu/htOGVz/O9iygHBqxAF+/ujEBEHTvHr8b/rhG11Zg==
X-Received: by 2002:a17:902:c254:b029:d6:ac10:6d50 with SMTP id 20-20020a170902c254b02900d6ac106d50mr25751204plg.48.1605158764968;
        Wed, 11 Nov 2020 21:26:04 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91 (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id r6sm4468364pjd.39.2020.11.11.21.26.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Nov 2020 21:26:04 -0800 (PST)
Date:   Wed, 11 Nov 2020 21:25:57 -0800
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Patrick Williams <patrick@stwcx.xyz>
Cc:     Joel Stanley <joel@jms.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Andrew Jeffery <andrew@aj.id.au>, Tao Ren <taoren@fb.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/4] ARM: dts: aspeed: Add Facebook Galaxy100 BMC
Message-ID: <20201112052556.GA3533@taoren-ubuntu-R90MNF91>
References: <20201111232330.30843-1-rentao.bupt@gmail.com>
 <CACPK8XdC8FRKOLQ9e583gVuDrL5829MOfx5L=O68dou6mjW_6g@mail.gmail.com>
 <20201112031828.GA4495@heinlein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112031828.GA4495@heinlein>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 09:18:28PM -0600, Patrick Williams wrote:
> On Wed, Nov 11, 2020 at 11:34:10PM +0000, Joel Stanley wrote:
> > On Wed, 11 Nov 2020 at 23:23, <rentao.bupt@gmail.com> wrote:
> > >
> > > From: Tao Ren <rentao.bupt@gmail.com>
> > >
> > > The patch series adds the initial version of device tree for Facebook
> > > Galaxy100 (AST2400) BMC.
> > >
> > > Patch #1 adds common dtsi to minimize duplicated device entries across
> > > Facebook Network AST2400 BMC device trees.
> > >
> > > Patch #2 simplfies Wedge40 device tree by using the common dtsi.
> > >
> > > Patch #3 simplfies Wedge100 device tree by using the common dtsi.
> > >
> > > Patch #4 adds the initial version of device tree for Facebook Galaxy100
> > > BMC.
> > 
> > Nice. They look good to me.
> > 
> > Reviewed-by: Joel Stanley <joel@jms.id.au>
> > 
> > Is there another person familiar with the design you would like to
> > review before I merge?
> 
> Also,
> 
> Reviewed-by: Patrick Williams <patrick@stwcx.xyz>
> 
> -- 
> Patrick Williams

Thank you Patrick!

Cheers,

Tao
