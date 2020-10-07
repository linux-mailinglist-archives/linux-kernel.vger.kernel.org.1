Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CC0286052
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 15:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgJGNjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 09:39:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:45684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728177AbgJGNjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 09:39:03 -0400
Received: from coco.lan (ip5f5ad5a2.dynamic.kabel-deutschland.de [95.90.213.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E4A3206DD;
        Wed,  7 Oct 2020 13:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602077942;
        bh=eHBZM3e+OsoNoiBsGa6VPI5CvFUAkYu3cfJMwsq7vzQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zdXD+EwJrcZznzdEW4k/95S8eSi5VbPkfk6IlgMaG9eI0WQPedJvKli6QOzbCEEDb
         joT1qm/JSIrTbcISfaYk7fYTQ/xHICosBOoVPQONHXNIcie0kcSUaCOcrTt1I1lkND
         ivFzujgBk0hbaUlvIToke+M91eWVpMzTjqHGM0oM=
Date:   Wed, 7 Oct 2020 15:38:54 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] script: add a script for checking doc problems with
 external functions
Message-ID: <20201007153854.17712cd3@coco.lan>
In-Reply-To: <0b3f06aca033deb1fe3b1635ff3932e7b3f4127a.camel@perches.com>
References: <20201005125920.27a7768d@coco.lan>
        <e40a32900dba6b8e7a1f41838ee8caeb1ef1c1b3.1601985151.git.mchehab+huawei@kernel.org>
        <87tuv6igwg.fsf@intel.com>
        <0b3f06aca033deb1fe3b1635ff3932e7b3f4127a.camel@perches.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 07 Oct 2020 01:32:31 -0700
Joe Perches <joe@perches.com> escreveu:

> On Wed, 2020-10-07 at 11:23 +0300, Jani Nikula wrote:
> > On Tue, 06 Oct 2020, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:  
> > > While not all EXPORT_SYMBOL*() symbols should be documented,
> > > it seems useful to have a tool which would help to check what
> > > symbols aren't documented.
> > > 
> > > This is a first step on this direction. The tool has some
> > > limitations. Yet, it could be useful for maintainers to check
> > > about missing documents on their subsystems.  
> > 
> > Seems like this should be part of checkpatch.pl somehow.  
> 
> I don't see how.

Just sent a third version of the script. It should now be able to check
if the RST files have the exported symbols as well:

<snip>
$ scripts/check_docs_external_symbols lib/debugobjects.c
lib/debugobjects.c: export symbol debug_object_active_state not documented at: Documentation/core-api/debug-objects.rst
</snip>

It also checks if an exported symbol has duplicated entries at
kernel-doc as well.

The check logic for it is somewhat complex. so, I won't doubt that
there are some other hidden bugs.

Also, as right now, the script is slow, if one wants to run it
for the entire Kernel.

Thanks,
Mauro
