Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4D2228BDB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 00:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgGUWNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 18:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbgGUWNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 18:13:50 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D59C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 15:13:50 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id j10so364859qtq.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 15:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=kalVxG8ANnjjy1Dw3YQgCDZ3CtnSjchvQLTtFWwGZEI=;
        b=HI4DG4OlYWFjQ61OejwTOZ7oTYLG7hjW1DsiY3koJJZ8BKbWFzFLCdDota/JQWSQMg
         5RSHdXAyc62g8Z6RiwbcjsW1QsCnWfAYao7+sX3Tn6e1k56NU+qS10UmEcbR3WAnU/5c
         lUVY9P0VC5T1cPJdjm48ChMbUwGlhqtikkZ2x9DCwLGte83hXvlC0PjNGk8zpVzIq5XY
         mwm2cZfmcjMXuqOgY1ut0BXI3nV3HQwwRQr7l0D7uYqY/xB+h3aDVxTIICyRbOpmlyuy
         P+LcjWw5Eo168umDZpGtAXcF7iHXSLgEmwUty7BPuqtntmRIPeXsLqWVvTg42iaQCjqW
         ux/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=kalVxG8ANnjjy1Dw3YQgCDZ3CtnSjchvQLTtFWwGZEI=;
        b=QZY1g2javA4KljoPxgsiijvFbAK5GizFACOcaT17UEzGShsMdZyZuaehe4QoYei7pc
         Ge1qT3wKjX23BZK+RmYw07nQj1RGh0MkxsF2yT2MxDxH6D9aw8LQeyp9UDQFXazclHr3
         YnSRDeSZ+qtngeeOLnHoC2fGWSSo4Hle4DWqtw/DPrvohGiu7kIQo+Ro9MSK8oqexz/G
         NLb7Jp1PISGU4flgGpBrgt0Keylpmwt6Xc4nCU0AoKQkcHCyt0uEsYlVJs8krkxL7EB5
         peeOI1VY3FM2PVATg2u/BDyZVe8NcCUbZr920o4HpR+Qu+D3LZzt5tGQ6ZIabHIkOFzP
         LriQ==
X-Gm-Message-State: AOAM531ePIJKm4DFk5zDYu5AIeXkxrgIXstoG5VhYZ3rW+btjt2aURNZ
        TQFcE0Ue/ADMVOHi2/PET9zYe1JS
X-Google-Smtp-Source: ABdhPJx0yMa8t58yf/qnLF46Y5HIlOeGBFaAKUODUY+XylBgXMuqyo16Q2hhte1VcrtBV2DZouIbCA==
X-Received: by 2002:ac8:32b8:: with SMTP id z53mr31042917qta.273.1595369629394;
        Tue, 21 Jul 2020 15:13:49 -0700 (PDT)
Received: from LeoBras (179-125-153-225.dynamic.desktop.com.br. [179.125.153.225])
        by smtp.gmail.com with ESMTPSA id g4sm22116489qtp.89.2020.07.21.15.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 15:13:48 -0700 (PDT)
Message-ID: <0f4c2d84d0958e98e7ada53c25750fe548cadf0b.camel@gmail.com>
Subject: Re: [PATCH v4 5/7] powerpc/iommu: Move iommu_table cleaning routine
 to iommu_table_clean
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Joel Stanley <joel@jms.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Tue, 21 Jul 2020 19:13:42 -0300
In-Reply-To: <51235292-a571-8792-c693-d0dc6faeb21c@ozlabs.ru>
References: <20200716071658.467820-1-leobras.c@gmail.com>
         <20200716071658.467820-6-leobras.c@gmail.com>
         <51235292-a571-8792-c693-d0dc6faeb21c@ozlabs.ru>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-07-21 at 14:59 +1000, Alexey Kardashevskiy wrote:
> 
> On 16/07/2020 17:16, Leonardo Bras wrote:
> > Move the part of iommu_table_free() that does struct iommu_table cleaning
> > into iommu_table_clean, so we can invoke it separately.
> > 
> > This new function is useful for cleaning struct iommu_table before
> > initializing it again with a new DMA window, without having it freed and
> > allocated again.
> > 
> > Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> > ---
> >  arch/powerpc/kernel/iommu.c | 30 ++++++++++++++++++------------
> >  1 file changed, 18 insertions(+), 12 deletions(-)
> > 
> > diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> > index 9704f3f76e63..c3242253a4e7 100644
> > --- a/arch/powerpc/kernel/iommu.c
> > +++ b/arch/powerpc/kernel/iommu.c
> > @@ -735,21 +735,10 @@ struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid,
> >  	return tbl;
> >  }
> >  
> > -static void iommu_table_free(struct kref *kref)
> > +static void iommu_table_clean(struct iommu_table *tbl)
> 
> iommu_table_free() + iommu_init_table() + set_iommu_table_base() should
> work too, why new helper?

iommu_table_free() also frees the tbl, which would need allocate it
again (new address) and to fill it up again, unnecessarily. 
I think it's a better approach to only change what is needed.

> There is also iommu_table_clear() which does a different thing so you
> need a better name.

I agree.
I had not noticed this other function before sending the patchset. What
would be a better name though? __iommu_table_free()? 

> Second, iommu_table_free
> use and it would be ok as we would only see this when hot-unplugging a
> PE because we always kept the default window.
> Btw you must be seeing these warnings now every time you create DDW with
> these patches as at least the first page is reserved, do not you?

It does not print a warning.
I noticed other warnings, but not this one from iommu_table_free():
/* verify that table contains no entries */
if (!bitmap_empty(tbl->it_ma
p, tbl->it_size))
	pr_warn("%s: Unexpected TCEs\n", __func__);

Before that, iommu_table_release_pages(tbl) is supposed to clear the 
bitmap, so this only tests for a tce that is created in this short period.

> Since we are replacing a table for a device which is still in the
> system, we should not try messing with its DMA if it already has
> mappings so the warning should become an error preventing DDW. It is
> rather hard to trigger in practice but I could hack a driver to ask for
> 32bit DMA mask first, map few pages and then ask for 64bit DMA mask, it
> is not illegal, I think. So this needs a new helper - "bool
> iommu_table_in_use(tbl)" - to use in enable_ddw(). Or I am overthinking
> this?... Thanks,

As of today, there seems to be nothing like that happening in the
driver I am testing. 
I spoke to Brian King on slack, and he mentioned that at the point DDW
is created there should be no allocations in place.

But I suppose some driver could try to do this.

Maybe a better approach would be removing the mapping only if the
default window is removed (at the end of enable_ddw, as an else to
resetting the default DMA window), and having a way to add more
mappings to those pools. But this last part doesn't look so simple, and
it would be better to understand if it's necessary investing work in
this.

What do you think?

Best regards,


