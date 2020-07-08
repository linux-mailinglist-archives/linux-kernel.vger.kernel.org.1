Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B62218C68
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 18:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730531AbgGHQAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 12:00:00 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:34698 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730179AbgGHP77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:59:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0E5E28EE1D9;
        Wed,  8 Jul 2020 08:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1594223998;
        bh=wqk55O2VC/Slr4lVR3r5mJCWnsiLDjFN52OqFL8PToM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=B1VYJdPqFQS+fqqY5rdrSizfLkmTMBloNay1fdTmef1GfIr5qSpMaM/9Z2Kwp1Jfl
         YMOA9nrMyFPKUXP7Q0mZc3G/ORxbR+PhOI9juZpCpHcC7YuQJiLNT5ZFWya4Pb94Xt
         KheBxppUY/WoSIt0r7n5/YBsx8YjMsH1alNeNEqc=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4TxuoJRcRocU; Wed,  8 Jul 2020 08:59:57 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 29F768EE12E;
        Wed,  8 Jul 2020 08:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1594223997;
        bh=wqk55O2VC/Slr4lVR3r5mJCWnsiLDjFN52OqFL8PToM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GkIbqh4j2vhdw1VTdraa3DFeRdfvYkxyIsXKasakocl9hy7o6/dksAOmGvDJwcf6q
         jR6m83Rn8RfzfXbggCzkMrDm88NlYrkPpWE6mzI20MbDO/mwgITLQNskicNzSUcXNf
         bfsbM5rJ3iskElHX/5K8LlyWYiqKij0UER5blm4Y=
Message-ID: <1594223995.4349.28.camel@HansenPartnership.com>
Subject: Re: [Tech-board-discuss] [PATCH v2] CodingStyle: Inclusive
 Terminology
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Joe Perches <joe@perches.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        SeongJae Park <sjpark@amazon.de>, linux-kernel@vger.kernel.org,
        tech-board-discuss@lists.linuxfoundation.org,
        Chris Mason <clm@fb.clm>, Dave Airlie <airlied@redhat.com>,
        torvalds@linux-foundation.org
Date:   Wed, 08 Jul 2020 08:59:55 -0700
In-Reply-To: <b15e2652aba06dbe244f5ed447e6e96f12302198.camel@perches.com>
References: <159419296487.2464622.863943877093636532.stgit@dwillia2-desk3.amr.corp.intel.com>
         <b15e2652aba06dbe244f5ed447e6e96f12302198.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-07-08 at 04:04 -0700, Joe Perches wrote:
> On Wed, 2020-07-08 at 00:23 -0700, Dan Williams wrote:
> > Linux maintains a coding-style and its own idiomatic set of
> > terminology.
> > Update the style guidelines to recommend replacements for the terms
> > master/slave and blacklist/whitelist.
> > 
> > Link: http://lore.kernel.org/r/159389297140.2210796.135901422546687
> > 87525.stgit@dwillia2-desk3.amr.corp.intel.com
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Acked-by: Randy Dunlap <rdunlap@infradead.org>
> > Acked-by: Dave Airlie <airlied@redhat.com>
> > Acked-by: Kees Cook <keescook@chromium.org>
> > Acked-by: SeongJae Park <sjpark@amazon.de>
> > Signed-off-by: Olof Johansson <olof@lixom.net>
> > Signed-off-by: Chris Mason <clm@fb.clm>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> > Changes since v1 [1]
> > - Drop inclusive-terminology.rst, it is in the lore archives if the
> >   arguments are needed for future debates, but otherwise no
> > pressing
> >   need to carry it in the tree (Linus, James)

Acked-by: James Bottomley <James.Bottomley@HansenPartnership.com>

> Where did Linus publicly state this was unnecessary?

https://lists.linuxfoundation.org/pipermail/tech-board-discuss/2020-July/000412.html

James


