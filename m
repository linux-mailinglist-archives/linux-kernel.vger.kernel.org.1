Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8605A274BC8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 00:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgIVWAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 18:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgIVWAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 18:00:32 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFD4C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 15:00:31 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id m5so19749221lfp.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 15:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=86q55Tr0QudFzxfkcEZ2vlbQ/9CqhlRA2bDGJM6FWDw=;
        b=gHe08sYsW2kD/eMobC5Q8fjgyZfiZaL3Ih/BA4UJ70CyoUJ7b1lDCnI0aTglZzmSWf
         IGqsLkG9kl5G3Vg+JyoL/DIti0Y5FyTXckHKhu+SMBjBcfw/Gb/JxN8yREZkjgu554yN
         /ikktke2+yZ49YxkOKHXaOA/+qbBUXz7JY6yPWdhMid+ttQ9B5ivAr7Vz5U7CPhTu5sB
         Pz5GeJm/1A3Wsz6/r488N9A7X2PjgCa2jrqA06ssulDxajcTYKQZIxNYW2mzpcR4pmC0
         MM1wt0ZryZHbQ6ZZ2Dz24r9Z8Q7C7g6Lmf5D4+eZwH2qiEz0TBO7uvvzPjtQMlcCMmwN
         Br/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=86q55Tr0QudFzxfkcEZ2vlbQ/9CqhlRA2bDGJM6FWDw=;
        b=bUMIW2wWJ81qpTQfOhHEx8hCYC7qM11GCrj0GHxP3kUkOr353WhbVg2OQridp7pQ6X
         +54YEg1ECmG2xzEdSaBgb3armsj49qtRA/vd13owkIzdCfok2PeOcPwDTJapEI3WTP6d
         G7pMseRRLcFCXKVfsduIC3NHPIY/2cso70G/Rmo7DDqOZAmb9VlD9Koh9YwPhHpjWyUU
         Wtf8ujI4chVJf05ZeoL1fi658aIt+vXqns1J4u2VKi2iEev2sIEJnjMDIH8gQdoecwKA
         6JcN1UrAwFDD1UjPYAVoEQ6Zk6unICCQaHz2nFHu9B3VvgHy/PUgzxucijQDChFKGDcF
         hkFw==
X-Gm-Message-State: AOAM5313k/Tu9+UbHAQ1BR6xiTpMqr4i1ufR6xZ0+LtjVT5WaVlMqEoj
        OQGe1R8scxp7I7XsQNt0rns=
X-Google-Smtp-Source: ABdhPJxkzTZP2kgKbBgtwOMplc6I6l7NMB/i3VNjG4/fapnJgL+JKhvrt7HAmbikS+KE3opddnG8Kw==
X-Received: by 2002:a19:7912:: with SMTP id u18mr2570752lfc.298.1600812030118;
        Tue, 22 Sep 2020 15:00:30 -0700 (PDT)
Received: from rikard (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id o3sm3919719lfb.168.2020.09.22.15.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 15:00:29 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
X-Google-Original-From: Rikard Falkeborn <rikard.falkeborn>
Date:   Wed, 23 Sep 2020 00:00:24 +0200
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/8] mfd: intel: Constify static struct resource
Message-ID: <20200922220024.GA66604@rikard>
References: <20200922192659.14535-1-rikard.falkeborn@gmail.com>
 <20200922192659.14535-3-rikard.falkeborn@gmail.com>
 <CAHp75VfQNs=JvhPn6rWvvSdUn2a4PZtQ8LWndQoJ54W7ebrtsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfQNs=JvhPn6rWvvSdUn2a4PZtQ8LWndQoJ54W7ebrtsA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 12:31:28AM +0300, Andy Shevchenko wrote:
> On Tue, Sep 22, 2020 at 10:32 PM Rikard Falkeborn
> <rikard.falkeborn@gmail.com> wrote:
> >
> > Constify a number of static struct resource. The only usage of the
> > structs are to assign their address to the resources field in the
> > mfd_cell struct. This allows the compiler to put them in read-only
> > memory. Done with the help of Coccinelle.
> 
> How had you tested this?
> 

It's compile-tested only.

Rikard
