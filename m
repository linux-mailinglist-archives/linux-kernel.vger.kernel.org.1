Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0CEE2CDEA6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 20:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbgLCTSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 14:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgLCTSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 14:18:20 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9202C061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 11:17:34 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id o1so2196467qtp.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 11:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=mEdRneYpfbUi98zNntUQNKQ2H6JBdHd09u2mqkK+vgw=;
        b=KOxgV2SOIXW3Z/fxcWUyP4RforAO0+vjI32EDsZbWyUmmW/OBUzRvR+jdQ3SE29o0w
         XMqW2a2cW/uXEqkhPCs617b1tz9iJvae+K7QzjIJhoCRSYBqPz5P6ydYbaNyzxgAdhGF
         T1D81y6xq7s5YAarFPI21bdSNcaHL+07HwYnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=mEdRneYpfbUi98zNntUQNKQ2H6JBdHd09u2mqkK+vgw=;
        b=Q5Di9pSZQH7dHTGh8K27bz81hAZ22NITiJ1lYF8dD/dj7pU7+6WaJA5af1VG3G6Tun
         mUpSHLs83ARX5RF+F+kzCRKQTFsyIQ4PYBaAkCulM5U2spkK/XFrU/N2uWWW2GMhSqqp
         73QL3Tzzb9mcyWP6UsjD1Af/y4genFtfCbYZSs427iyIU157RPklQoWXXmrTWS/NkBRc
         oc49AAobnmPwUpetHKAOQ2qdQBvvgBU9UQvbaxuC26WAd2UbnaAbFO4e4stCWT2PSWBO
         GS6i/K+RHw7b5PcZrZ/qrQzPkrlR6j8ZJZVCzA5mQ+mhVN5zNcJRLiI3cqn1MldsHFRR
         HntA==
X-Gm-Message-State: AOAM533tb3RQSXkSf0yTV4peTXgR3/z1DiRCArSak4kgI/pwKWI3X+Vf
        QUr/2dlqNzllnQuGcrOWB83Pk96ASCst3Jr8
X-Google-Smtp-Source: ABdhPJz8iSjD1x8VLHhjJxtXMLdGlj+hJ1g6O92fs0rzspYmrXDO+GqCEdKFTb8FIRIwplwaoDuyxQ==
X-Received: by 2002:ac8:7551:: with SMTP id b17mr4809456qtr.35.1607023053727;
        Thu, 03 Dec 2020 11:17:33 -0800 (PST)
Received: from chatter.i7.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id o125sm2507034qke.56.2020.12.03.11.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 11:17:33 -0800 (PST)
Date:   Thu, 3 Dec 2020 14:17:31 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Ksummit-discuss] crediting bug reports and fixes folded into
 original patch
Message-ID: <20201203191731.bpzvwqfldhcjhzfy@chatter.i7.local>
Mail-Followup-To: Joe Perches <joe@perches.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <ea32eb02-5e44-0469-772b-34b5cb882543@suse.cz>
 <694039d6e386d999fd74d038cf2627f5b3b0ca71.camel@HansenPartnership.com>
 <3c11134905f06185dda4e9125f2fb7fd30fff979.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3c11134905f06185dda4e9125f2fb7fd30fff979.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 08:55:54AM -0800, Joe Perches wrote:
> Perhaps automate a mechanism to capture that information as
> git notes for the patches when applied.

Git notes have a limited usefulness for this -- they are indeed part of 
the repository, but they aren't replicated unless someone does a 
--mirror clone (or specifically fetches refs/notes/*). If the goal is to 
improve visibility for contributors, then putting this info into a git 
note will hardly make more difference than providing a Link: that 
someone has to follow to a list archival service.

I can offer the following proposal:

- kernel.org already monitors all mailing lists that are archived on 
  lore.kernel.org for the purposes of pull request tracking 
  (pr-tracker-bot).
- in the near future, we will add a separate process that will 
  auto-explode all pull requests into individual patches and add them
  to a separate public-inbox archive (think of it as another 
  transparency log, since pull requests are transient and opaque).

We can additionally:

- identify all Link: and Message-Id: entries in commit messages, 
  retrieve the threads they refer to, and archive them as part of the 
  same (or adjacent) transparency log.

This offers an improvement over the status quo, because if 
lore.kernel.org becomes unavailable, someone would have to have access 
to all backend archive repositories it is currently tracking in order to 
be able to reconstitute relevant conversations -- whereas with this 
change, it should be sufficient to just have the copy of the 
transparency log to have a fully self-contained high-relevancy archive 
of both individual commits and conversations that happened around them.

I'm just not sure if this will help with the subject of the 
conversation, or if it does not serve the goal of recognizing developer 
contributions by making them more visible.

-K
