Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D91D287569
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 15:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730373AbgJHNtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 09:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbgJHNtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 09:49:46 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B74C061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 06:49:44 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id y198so7069029qka.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 06:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FkMYH6TyR6cj4WQohzJOKWRIWg7AZV+5PUb2z1CUQeg=;
        b=kfojQ/UlM6L0iTuILtNdmiuLMrR/hYAvYq3iKVAC5CaP1s7WZRpTc3bQimmUn76hGa
         7saTV5tEJxNpYly/yH9t0ypwkTalJzyNkS6y782kiLVeqSxRJFjvfF2BaqmCgkUICRIe
         HyfOcfE5ZZy3H9Xr72YmpIzbDZaqza0wGPhTiOentueZynCFkldzq0Peu5wiZWEoJcts
         lBImG5T8W1eIuKqU8CZPi05K24+hEzYhWNP4BXf5pvgBJcUGfu8T/A28gl58WxKWPGfK
         GdBQkJWGFyVtAIZ/dhNjOfhxbStKuMSbnvZ+rRiW4rD5PrrRl8oG8f60ldIZHOc8FYBQ
         a05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=FkMYH6TyR6cj4WQohzJOKWRIWg7AZV+5PUb2z1CUQeg=;
        b=BXrHtkFM8Kdss6ydvYiOrxx/RVOGTZGp9ptxdXQxXjDEVWrxpnvIsSnC+dTaDuuhAw
         oOktM4QCU4XFfxg69oyPSNFLSZr8x3J4U4ss1xnon2SnaX2N7i/ezrF3XvHS47MjDFOR
         0y9AMERT/X3kymfASRQsmw7oG9bB5AsS9Lfrz6kPqc9AqYCpX8bnQlhWy+kINnVhFrAZ
         ABHysR64U8ulDyWcfe/0+R1UNOA5ZIoWHKDPqitQuyclxKftEoiagavnpDTn8Fn0SK+B
         7ZdsLmH+rbks3r7/SAfM9Xrgr0Hb5MNCLfKGX6VJ7spTv93J5c/fjEfiJuWJFyMVXmw9
         YV0A==
X-Gm-Message-State: AOAM531rqyb0wsx8w2wLIuC3KFkOnUr1r7R4SAPZVo8apVBLUw3a/zLs
        xSeZR6mVMz4qUDWlxqQJaCA=
X-Google-Smtp-Source: ABdhPJxVEA1OmLg3l08KylzqYZBLUKOsYDOjaPkwUXCqlxSALqOZwM/Sayr/c+PNYIF/1rNzaN/img==
X-Received: by 2002:a05:620a:4156:: with SMTP id k22mr7853305qko.441.1602164984052;
        Thu, 08 Oct 2020 06:49:44 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a5sm4135584qkb.60.2020.10.08.06.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 06:49:43 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 8 Oct 2020 09:49:42 -0400
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] x86/boot/64: Change add_identity_map() to take size
 for ease of use
Message-ID: <20201008134942.GC2429573@rani.riverdale.lan>
References: <20201007195351.776555-1-nivedita@alum.mit.edu>
 <20201007195351.776555-4-nivedita@alum.mit.edu>
 <20201008091412.GF3209@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201008091412.GF3209@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 11:14:12AM +0200, Joerg Roedel wrote:
> On Wed, Oct 07, 2020 at 03:53:49PM -0400, Arvind Sankar wrote:
> > Change back the arguments of add_identity_map() to (start, size) instead
> > of (start, end). This reverts
> > 
> >   21cf2372618e ("x86/boot/compressed/64: Change add_identity_map() to take start and end")
> > 
> > since we will soon have more callers that know the size rather than the
> > end address.
> > 
> > This also makes the #PF handler print the original CR2 value in case of
> > error, instead of after aligning to PMD_SIZE.
> > 
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > ---
> >  arch/x86/boot/compressed/ident_map_64.c | 11 ++++-------
> >  1 file changed, 4 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
> > index 063a60edcf99..070cda70aef3 100644
> > --- a/arch/x86/boot/compressed/ident_map_64.c
> > +++ b/arch/x86/boot/compressed/ident_map_64.c
> > @@ -90,8 +90,9 @@ static struct x86_mapping_info mapping_info;
> >  /*
> >   * Adds the specified range to the identity mappings.
> >   */
> > -static void add_identity_map(unsigned long start, unsigned long end)
> > +static void add_identity_map(unsigned long start, unsigned long size)
> >  {
> > +	unsigned long end = start + size;
> 
> This has been discussed during the SEV-ES patch-review already and we
> settled on making add_identity_map() take start and end as parameter, as
> that is what kernel_ident_mapping_init() also takes as parameters.
> 
> So please keep it that way :)
> 
> Regards,
> 
> 	Joerg

At the time, it was one caller knowing end and one knowing size, but now
there are two more callers that only know the size, so it seemed easier
to have add_identity_map() do the conversion.

Thanks.
