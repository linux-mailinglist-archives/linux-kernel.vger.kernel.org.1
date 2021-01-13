Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA6A2F50BB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 18:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbhAMRM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 12:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbhAMRMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 12:12:55 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37714C06179F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 09:12:15 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id e25so2306335wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 09:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=c7b4E16YOwgpza0HIydnpFyNMAoTuzbuWt8Po2GaTu8=;
        b=m+HZYJrqh0DnFL+2Ra1oBihA6B5f1/bGTOMg83bfd5JsRI55Pg6cOawpyYGVSenaVE
         oqsRkZEih94Lc5xrZivWic5I2fo+hBgV8CA/rw/XW8CdbxoWNCg1NoA/ozazJVBLxv/E
         dwgW4iQ/0yJUfbMPfpbiJOijdgndcqw6JEballW1qqGkfrgvMoAgDgXbJd8uD01jaVuc
         dEMZpau/AvxuZWMfbxltkg1MbihefKZiKT2+6eUQDD4Pp2d3QlWrC8ZnECKuu5MQeZ2U
         BUqh4Xg7Pt23+SWYKkb+cn5rL6k0h6lAnETwP6z5zduPBo4sQQ8+wnwHzE3vclmaPGS7
         Zl/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=c7b4E16YOwgpza0HIydnpFyNMAoTuzbuWt8Po2GaTu8=;
        b=RTvGOLhrA58uUajI93z7ea4kXRPHFdkb4DQhIafsmLDkPx6SqKLMtIKLOoIf/oVqvS
         8Shp9fSRWlmCB+zLwiS3F9hpNjNydkojI3zSha1+XQhs5ixz8CnGpOWDra14r/7HU40I
         prKGRPEBoQu+aTn4IUzNBVRCDkw7sN+/c0e5LsZmWOqMifB+pNnmUGq0VZr37Z+QGqiW
         djpNG48nGeZspPd99qJ1yONCudJRxkXAGthMt73P4ZxlOwu/jwz2IRvrUMsCLD7fplOo
         Oda2NpFcTu5Urz7vdZfDZS8fNYM11Ksa5t2VNJYp5ssqvIt00aHIQ5N70v+zYD/aFwDq
         +LKg==
X-Gm-Message-State: AOAM53340PdJB4di6SNzlom7fZWCm2b6kwlsD82mE1uyT0prspr2fe4v
        Y9YtKtgwv4nl0n0yhDTfogtm6A==
X-Google-Smtp-Source: ABdhPJzZ3LZrsLfZHiK6m5IEDbaQ3BoXy5i+lpcBWgVqY5sLOcN7RPj+H0NtaHgq93jnNZEQ32lqhw==
X-Received: by 2002:a05:600c:19cb:: with SMTP id u11mr251737wmq.110.1610557933899;
        Wed, 13 Jan 2021 09:12:13 -0800 (PST)
Received: from dell ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id r16sm4329471wrx.36.2021.01.13.09.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 09:12:13 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:12:11 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 1/1] docs: submitting-patches: Emphasise the
 requirement to Cc: stable when using Fixes: tag
Message-ID: <20210113171211.GF3975472@dell>
References: <20210113163315.1331064-1-lee.jones@linaro.org>
 <87bldssrzu.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bldssrzu.fsf@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jan 2021, Jani Nikula wrote:

> On Wed, 13 Jan 2021, Lee Jones <lee.jones@linaro.org> wrote:
> > Clear-up any confusion surrounding the Fixes: tag with regards to the
> > need to Cc: the stable mailing list when submitting stable patch
> > candidates.
> >
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: linux-doc@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> > v2:
> >  - Link to the 'stable-kernel-rules' document as per Greg's request
> >
> >  Documentation/process/submitting-patches.rst | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> > index 7c97ad580e7d0..7f48cccc75cdf 100644
> > --- a/Documentation/process/submitting-patches.rst
> > +++ b/Documentation/process/submitting-patches.rst
> > @@ -556,6 +556,11 @@ which stable kernel versions should receive your fix. This is the preferred
> >  method for indicating a bug fixed by the patch. See :ref:`describe_changes`
> >  for more details.
> >  
> > +Note: Attaching a Fixes: tag does not subvert the stable kernel rules
> > +process nor the requirement to Cc: stable@vger.kernel.org on all stable 
> > +patch candidates. For more information, please read
> > +:ref:`Documentation/process/stable-kernel-rules.rst <stable_kernel_rules>`
> 
> Has there been a process change, or should I take it that a Fixes: tag
> without Cc: stable *may* still end up being backported to stable?

The 'process' has not changed.  Cc:ing the stable mailing list has
been a requirement for years.  This patch clears up the misconception
that you (and I ... and many others by all accounts) hold that the
Fixes: tag is enough.

Fixes: only works when/if Greg and/or Sasha run their magical scripts
to scan for them.  By them doing so has "perpetuated a myth that this
was the proper thing to do".  It's not.

Greg got fed-up of people asking that same question, so I'm fixing
that and giving him something to point to and say "RTFD".

Hope that clears things up.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
