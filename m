Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67BC1C0B7B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 03:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgEABJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 21:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727114AbgEABJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 21:09:25 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA29C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 18:09:25 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id e18so402250oot.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 18:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=iXrA9vjDFeyBPogW8X3baa2NAT1RG1h/25KrkcOYPyk=;
        b=EtQaTk0BIrN9hgAUH4jSlTrl+Q207os/So9AiKENej0LuanW8nWejAFjXnLoZlmeR4
         +ti2sYQdpgMPGJECSbnhUmrLXyLoZY6Kug+Vm8v5u1KYOm1/Kof/C8kPVXJDo6GYJVf4
         /Q0lpeQZtlf2xXJWWy/sLQ3Xob7UIbAf89bbCTboOcJ6FeSnst/Er7gUIummoUP9f9wX
         q973lmYcW9qE/wrQVMDaIkcwYZVY15iim0spYQ5SosKYH51UVqU+4baaNY/+xgBjJ5D+
         9xQTGq50SIxOcD8i9g20HwegFCYPdStZGHBi9DYnzp1jfK+2yDry22p+gi7cjRubBQSP
         u0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=iXrA9vjDFeyBPogW8X3baa2NAT1RG1h/25KrkcOYPyk=;
        b=QJF0fI4brYEFiF+tFooY3uTidf5UEv0sF5A5GDO1p54Ai9Jkij90bZ1K3VJCKRx718
         4zLPgGNkkpDESP7couNzdXf0o4TVHDdtBC0WMFlqzhudJSEkOqJbYYpiwXZhnhGHOs1V
         0S7OPb6LGpV8TOyk9pSaHEjId/Iu796eZqeBeIcl+1IHqqxceEtZYVBgcOLaq4LEZZB0
         Cb5UJt57Sby4VTrmdodC5wItNq74jhOGKLkSo33UBgXG8KFtBabkDYaOhByodtKO6fn2
         bb+V+aLthiNPPVDvsd2/ZgWSWnPEjfK6UTrR8STtPHyh1/zk14mEPcej+xca5RT2zqhq
         iKjg==
X-Gm-Message-State: AGi0PuZP1ebcn19MDZ2piUCFr7jJXQRPSvAqeG+1NvybGjbTsccAuQQY
        vBJhGY1V7ODIwRMlNY10ZBcQpA==
X-Google-Smtp-Source: APiQypJ+scBXw7K9Y+l1S2jlTS7e2TRgQUfk+9D2W+8cSGXvUZp1msNhnPw4lHxV9WnTP0XblZiwag==
X-Received: by 2002:a4a:8253:: with SMTP id t19mr1736955oog.69.1588295364238;
        Thu, 30 Apr 2020 18:09:24 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id p17sm36208oot.17.2020.04.30.18.09.22
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 30 Apr 2020 18:09:22 -0700 (PDT)
Date:   Thu, 30 Apr 2020 18:09:03 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Yang Shi <yang.shi@linux.alibaba.com>
cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        kirill.shutemov@linux.intel.com, hughd@google.com,
        aarcange@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [linux-next PATCH 1/2] mm: khugepaged: add exceed_max_ptes_*
 helpers
In-Reply-To: <cc8ac985-73a5-698f-f108-fb2d8410d14c@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.2004301751490.1725@eggly.anvils>
References: <1588200982-69492-1-git-send-email-yang.shi@linux.alibaba.com> <20200430215932.5w5dck3rnieppzqa@box> <cc8ac985-73a5-698f-f108-fb2d8410d14c@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Apr 2020, Yang Shi wrote:
> On 4/30/20 2:59 PM, Kirill A. Shutemov wrote:
> > On Thu, Apr 30, 2020 at 06:56:21AM +0800, Yang Shi wrote:
> > > The max_ptes_{swap|none|shared} are defined to tune the behavior of
> > > khugepaged.  The are checked at a couple of places with open coding.
> > > Replace the opencoding to exceed_pax_ptes_{swap|none_shared} helpers to
> > > improve the readability.
> > > 
> > > Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > Cc: Hugh Dickins <hughd@google.com>
> > > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > > Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> > > ---
> > >   mm/khugepaged.c | 27 +++++++++++++++++++++------
> > >   1 file changed, 21 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > index a02a4c5..0c8d30b 100644
> > > --- a/mm/khugepaged.c
> > > +++ b/mm/khugepaged.c
> > > @@ -339,6 +339,21 @@ struct attribute_group khugepaged_attr_group = {
> > >   };
> > >   #endif /* CONFIG_SYSFS */
> > >   +static inline bool exceed_max_ptes_none(unsigned int *nr_ptes)
> > > +{
> > > +	return (++(*nr_ptes) > khugepaged_max_ptes_none);
> > > +}
> > > +
> > > +static inline bool exceed_max_ptes_swap(unsigned int *nr_ptes)
> > > +{
> > > +	return (++(*nr_ptes) > khugepaged_max_ptes_swap);
> > > +}
> > > +
> > > +static inline bool exceed_max_ptes_shared(unsigned int *nr_ptes)
> > > +{
> > > +	return (++(*nr_ptes) > khugepaged_max_ptes_shared);
> > > +}
> > > +
> > Frankly, I find this ugly and confusing. Open-coded version is more
> > readable to me.

Wow, yes, I strongly agree with Kirill.

> 
> I'm sorry you feel that way. I tend to agree that dereference looks not good.
> The open-coded version is not hard to understand to me either.
> 
> They are checked at a couple of different places with different variables,
> i.e. unmapped vs swap, and with different comparisons, > vs <=. I just
> thought the helpers with unified name started with "exceed_" may make it more
> self-explained and readable. Anyway this totally depends on taste and I
> really don't insist on this change.
