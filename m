Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37428279667
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 05:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbgIZDbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 23:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729225AbgIZDbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 23:31:37 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F502C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 20:31:37 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id u21so1283248eja.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 20:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UI5cEN8K/GeU1uj0Hlr3P0QJH4xnq6J/e8uw5E+CELg=;
        b=nFM9EXLswqbb5477o4UUgt06gbHZd30tqKoruqN9TU7ki2iygmPrxb7yud48jxEgZq
         AMdDChWJGTw00YcdVmLrbNsz96hgAYy9rLT8Q0eewH1VILl3IBRfLrHEAuRIrjY4TwNO
         a/fZ4xfdXd7wgLUEhzggKOZEVmSqrVywkt7nRGs7sNL6j0nuJQhoK00IBAhEs2IYCNU7
         RAPowAucxxNYdJYteLM9uVq9Y5T/f7buOcPqzEhhqz7OSigsqGF95NI1/MOQ6bjw21RE
         eIrb7wntjMtTIXAMQoss9yw159RS/dEAB3wDiNdJgcqObuKazZObmWqT2gO5VJIlKVmY
         wEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UI5cEN8K/GeU1uj0Hlr3P0QJH4xnq6J/e8uw5E+CELg=;
        b=Tte/c01XQg+8pV2BnCacBzAjFzaY54xnZVqUB9ZilRaAkbCkh+YjuKcbKhHCJFuSEi
         YFCMnuK0SXLsS2IfssJDIPom5KAT8YNzyuLSHqq+Lxw5hAJYIX/ZxWIuFM2CUKTx7EUs
         HatJC7mtcNrtW2lb+NJUbkxjRW3V3BVGLciqa9B6Aimw7liHBcWHOZPgxYT/AmnUXjrO
         zjaOxV4oqNmxFVhqdy5QANTYapHwtc5wLFWZGx6iA0azy7IqLXQwBUTk0tX+0hpJm6mw
         ORCiyCmqlLquWbeMDiuaigPbRrH6+qeDoX6Non1uijC6zNTHCa9HmpEZnufKZq4Gbtr/
         8ctA==
X-Gm-Message-State: AOAM531MTgjW5GYAy0G6fAPXEciPw2nmJKkVdNztb5E9kZ9dlJPLhAPJ
        kQAgbMERdxmEO1hOrvM2D5YBP7PtMK5sns1/qUY2a7UF5s7VNA==
X-Google-Smtp-Source: ABdhPJzT9T905L59sMxHvdd3yvvw2e/dtiHXcaPuK+9fYnGGItRqKC2gQWw5Zi1v0zAPXBfy/TsQ6vOApAyCmQ7bvxA=
X-Received: by 2002:a17:906:d7ab:: with SMTP id pk11mr5686686ejb.472.1601091096174;
 Fri, 25 Sep 2020 20:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <160106109960.30709.7379926726669669398.stgit@dwillia2-desk3.amr.corp.intel.com>
 <160106118486.30709.13012322227204800596.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200925192234.33ae92b75012c1f2bdd974b8@linux-foundation.org>
In-Reply-To: <20200925192234.33ae92b75012c1f2bdd974b8@linux-foundation.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 25 Sep 2020 20:31:24 -0700
Message-ID: <CAPcyv4gO0jiNGrZkn8VBh5ZJAUOFTn4LAs4CE9tB++0ryX_J=w@mail.gmail.com>
Subject: Re: [PATCH v5 15/17] device-dax: add an 'align' attribute
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Joao Martins <joao.m.martins@oracle.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 7:22 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 25 Sep 2020 12:13:04 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
>
> > Introduce a device align attribute.  While doing so, rename the region
> > align attribute to be more explicitly named as so, but keep it named as
> > @align to retain the API for tools like daxctl.
> >
> > Changes on align may not always be valid, when say certain mappings were
> > created with 2M and then we switch to 1G.  So, we validate all ranges
> > against the new value being attempted, post resizing.
> >
> > Link: https://lkml.kernel.org/r/159643105944.4062302.3131761052969132784.stgit@dwillia2-desk3.amr.corp.intel.com
> > Link: https://lore.kernel.org/r/20200716172913.19658-3-joao.m.martins@oracle.com
> > Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >
>
> The signoff chain implies that this was From:Joao.  Please clarify?

Yes, sorry, my script to squash the fix rewrote the author and I
failed to catch it. This indeed should be:

From: Joao Martins <joao.m.martins@oracle.com>

I double-checked, and it looks like this was the only one in the
series with that problem.
