Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9A81DACBA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 09:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgETHz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 03:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETHz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 03:55:57 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B75CC061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 00:55:57 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id f4so1049369pgi.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 00:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/pJmK+O6ROVj4s7ndS7G+mQ5Ks/vgkYIiDJBpeL0ff0=;
        b=w6Fqc5RUEXUV2gSxof7w6N67mrIBP7dEAcmoR1w9p9j1cXZw+Dd7Qe0kP8VDYqkvXK
         gqVsBQAgODSjvKSC+pt5r1FW/CHCxHQNGu8Xb+9MGKJOxN/MbP/mx2Qb0CdNq4F8KpQp
         MLmhb1Xk0MwjsixiwPCDBgJb3xl7Yjjh5mN8K1MlyTLGZFggKUeg46wmEsCwNvN61lfA
         0xIMDgf6t8SipFl2kHt7a/opNAmi2MiFC4xtU49lQ+noZS6njIM7Jp//7jK+GEdogA2P
         ZzQgx9obIWD2L4ALEI48FeIoe4KLAoHiEO7UPKzZUcAa6UIw3NwkHsb21N8nOQ9NBBIQ
         zuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/pJmK+O6ROVj4s7ndS7G+mQ5Ks/vgkYIiDJBpeL0ff0=;
        b=tyjhhkkMJTztRi+lHH+Ju+LDezJ7kbmA4ZhkvXaVqaxuxqsarfM4apMIgrd030HtzJ
         G6a+f3L5SzsqAdmBgGdMruiLDdSXRkhJwE0TSvMkWTxYHwRSmmjS1f8se5OPESXYdFAw
         wvQvkQFNaUwMsphkwr2IDYmFxXICYwJkuC01GiD7amViEbP1juzcleWtirK17UIBjJGm
         UExOHcoxREa6CpcUXI/iWg2AS4LubH2N9bxhYXeHQheo3Z0VEhqR8wO/atntmysWHb/h
         Z+h1QP9AoZaclOl87fuI/QnIsLo+94rXHysSEK74/5PV5MfKuEAEK63trWnssugEnLJM
         E7xg==
X-Gm-Message-State: AOAM530UERU7AK05Un/Q3bobMuHwwIP2Zl2Ou5Iy6+gzJOPyUK5+k1ok
        eyA4HCWhASRi+IZe5nc15cPl
X-Google-Smtp-Source: ABdhPJzRmkifkHMLualmWHNu7RrfLqoam8frQTSzmQcZG6pKy4ae+CjDqwD5hLoxFhW+PxS064rZiw==
X-Received: by 2002:a63:cc12:: with SMTP id x18mr2910361pgf.140.1589961356846;
        Wed, 20 May 2020 00:55:56 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:91e:dd0a:7c30:1f7e:ebdb:aa2a])
        by smtp.gmail.com with ESMTPSA id w26sm196429pfj.20.2020.05.20.00.55.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 May 2020 00:55:56 -0700 (PDT)
Date:   Wed, 20 May 2020 13:25:51 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Joe Perches <joe@perches.com>
Cc:     gitster@pobox.com, git@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: Re: git-send-email: Ability to populate CC using more tags
Message-ID: <20200520075551.GA3155@Mani-XPS-13-9360>
References: <20200519184041.GB4397@Mani-XPS-13-9360>
 <f723cce2bcbccbfdf6ebc80d1e68ba4fe10c2aee.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f723cce2bcbccbfdf6ebc80d1e68ba4fe10c2aee.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 12:06:45PM -0700, Joe Perches wrote:
> On Wed, 2020-05-20 at 00:10 +0530, Manivannan Sadhasivam wrote:
> > Hello,
> > 
> > Currently 'git-send-email' lacks the ability to CC people described using
> > tags such as Acked-by and Reported-by etc...
> > 
> > While doing a bit of googling, I found a patch from Joe [1] but that doesn't
> > look like made its way. And in that discussion I didn't see any real objections
> > for the patch intention apart from the usage of the term 'trailers'.
> > 
> > So I'm just curious if Joe or anyone has plan to resubmit it! If not I may
> > do that.
> > 
> > PS: 'bylines' as mentioned by Joe seems reasonable to me.
> > 
> > Thanks,
> > Mani
> > 
> > [1] https://lkml.org/lkml/2016/8/30/650
> 
> You need to use the "--misc-by" option.
> 
> Perhaps you need to update your git version
> as that was added with:
> 
> commit ef0cc1df90f6b6c2987ab2db8e0ccf2cfc421edf
> Author: Rasmus Villemoes <rv@rasmusvillemoes.dk>
> Date:   Tue Oct 16 09:39:23 2018 +0200
> 
> send-email: also pick up cc addresses from -by trailers
> 

Ah, yes. This does the job :) I didn't notice this earlier.

Thanks,
Mani

> 
