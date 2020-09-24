Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF25277659
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 18:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbgIXQOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 12:14:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:41072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgIXQN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:13:59 -0400
Received: from coco.lan (ip5f5ad5c4.dynamic.kabel-deutschland.de [95.90.213.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18F572388A;
        Thu, 24 Sep 2020 16:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600964039;
        bh=hYhqt1zEygj1WJNEIIGL6rzLpB3sm1KkPrVfrQLZA8M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PvRqwecwPYLFRLPE/T1L6whxVNOnIuw5O5dIUK+AP0FWwfhyViN6WjXW5oAfDQlbM
         6ftTCxLYti0BC45lwSs4NkdAkoNZQkd3ZZPwws4pJJRq9wu7rTu2YF6pAuk/D4+eoV
         zwFemSgWkqFK55OH8eujQ+bv9AkAh3fVDtihnVWI=
Date:   Thu, 24 Sep 2020 18:13:54 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] docs: cdomain.py: add support for two new Sphinx
 3.1+ tags
Message-ID: <20200924181354.59087a8d@coco.lan>
In-Reply-To: <20200924094335.65944316@lwn.net>
References: <cover.1600945712.git.mchehab+huawei@kernel.org>
        <4b8a20013ca0b631724e8a986544ada08ac3dfd7.1600945712.git.mchehab+huawei@kernel.org>
        <20200924094335.65944316@lwn.net>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 24 Sep 2020 09:43:35 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> So I'm just getting into this and trying to understand what's really going
> on, but one thing jumped at me:
> 
> On Thu, 24 Sep 2020 13:22:04 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > +# Namespace to be prepended to the full name
> > +namespace = None

^^^ See here....

> > +
> > +#
> > +# Handle trivial newer c domain tags that are part of Sphinx 3.1 c domain tags
> > +# - Convert :c:expr:`foo` into ``foo``
> > +# - Store the namespace if ".. c:namespace::" tag is found
> > +
> > +RE_namespace = re.compile(r'^\s*..\s*c:namespace::\s*(\S+)\s*$')
> > +RE_expr = re.compile(r':c:expr:`([^\`]+)`')
> > +
> > +def markup_namespace(match):
> > +    namespace = match.group(1)
> > +
> > +    return ""
> > +  
> 
> How can this possibly work without a "global namespace" declaration in
> markup_namespace()?

... While I'm not a python expert, the namespace variable is global
    because it was defined outside the "markup_namespace" function.

-

On a quick check at the internet, this is supposed to work properly:

	https://www.programiz.com/python-programming/global-local-nonlocal-variables

-

In any cases, on my tests, this is working properly.

Anyway, I'm sending a version 2 of the series, addressing the
namespace for the remaining files under userspace-api/media.

You can try building the media books without and with the
patch series, in order to see the differences.

There are still ~200 warnings produced after that, but it
sounds that the remaining issues will require changes at
kernel-doc.


Thanks,
Mauro
