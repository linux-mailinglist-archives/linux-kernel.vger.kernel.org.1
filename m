Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D7A202354
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jun 2020 13:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgFTL0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Jun 2020 07:26:19 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:1288 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727971AbgFTL0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 07:26:18 -0400
X-IronPort-AV: E=Sophos;i="5.75,258,1589234400"; 
   d="scan'208";a="352198204"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2020 13:26:14 +0200
Date:   Sat, 20 Jun 2020 13:26:14 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Bernard <bernard@vivo.com>
cc:     Markus Elfring <Markus.Elfring@web.de>, opensource.kernel@vivo.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
        =?ISO-8859-15?Q?Felix_K=FChling?= <Felix.Kuehling@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Subject: Re:Re: [PATCH v2] drm/amdkfd: Fix memory leaks according to error
 branches
In-Reply-To: <ANUAnQAuCEPyRKFA*ek664qj.3.1592651815407.Hmail.bernard@vivo.com>
Message-ID: <alpine.DEB.2.22.394.2006201324140.2918@hadrien>
References: <ANUAnQAuCEPyRKFA*ek664qj.3.1592651815407.Hmail.bernard@vivo.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1370080203-1592652375=:2918"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1370080203-1592652375=:2918
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 20 Jun 2020, Bernard wrote:

>
>
> From: Julia Lawall <julia.lawall@inria.fr>
> Date: 2020-06-20 17:37:19
> To:  Markus Elfring <Markus.Elfring@web.de>
> Cc:  Bernard Zhao <bernard@vivo.com>,opensource.kernel@vivo.com,amd-gfx@lists.freedesktop.org,dri-devel@lists.freedesktop.org,kernel-janitors@vger.kernel.org,linux-kernel@vger.kernel.org,Alex Deucher <alexander.deucher@amd.com>,"Christian König" <christian.koenig@amd.com>,"Felix Kühling" <Felix.Kuehling@amd.com>,Daniel Vetter <daniel@ffwll.ch>,David Airlie <airlied@linux.ie>
> Subject: Re: [PATCH v2] drm/amdkfd: Fix memory leaks according to error branches>
> >
> >On Sat, 20 Jun 2020, Markus Elfring wrote:
> >
> >> > The function kobject_init_and_add alloc memory like:
> >> > kobject_init_and_add->kobject_add_varg->kobject_set_name_vargs
> >> > ->kvasprintf_const->kstrdup_const->kstrdup->kmalloc_track_caller
> >> > ->kmalloc_slab, in err branch this memory not free. If use
> >> > kmemleak, this path maybe catched.
> >> > These changes are to add kobject_put in kobject_init_and_add
> >> > failed branch, fix potential memleak.
> >>
> >> I suggest to improve this change description.
> >>
> >> * Can an other wording variant be nicer?
> >
> >Markus's suggestion is as usual extremely imprecise.  However, I also find
> >the message quite unclear.
> >
> >It would be good to always use English words.  alloc and err are not
> >English words.  Perhaps most people will figure out what they are
> >abbreviations for, but it would be better to use a few more letters to
> >make it so that no one has to guess.
> >
> >Then there are a bunch of things that are connected by arrows with no
> >spaces between them.  The most obvious meaning of an arrow with no space
> >around it is a variable dereference.  After spending some mental effort,
> >one can realize that that is not what you mean here.  A layout like:
> >
> >   first_function ->
> >     second_function ->
> >       third_function
> >
> >would be much more readable.
> >
> >I don't know what "this patch maybe catched" means.  Is "catched" supposed
> >to be "caught" or "cached"?  Overall, the sentence could be "Kmemleak
> >could possibly detect this issue", or something like that.  But I don't
> >know what this means.  Did you detect the problem with kmemleak?  if you
> >did not detect the problem with kmemleak, and overall you don't know
> >whether kmemleak would detect the bug or not, is this information useful
> >at all for the patch?
>
> Hi:
>
> Kmemleak detected a memory leak as below:
> kobject_init_and_add->
> 	kobject_add_varg->
> 		kobject_set_name_vargs->
> 			kvasprintf_const->
> 				kstrdup_const->
> 					kstrdup->
> 						kmalloc_track_caller->
> 							kmalloc_slab
>
> If kobject_init_and_add is called, but kobject_put is not called in the error branch.
> This will be detected by kmemleak.

Thanks.  This is much more understandable.  The last part still seems a
bit hypothetical.  After the trace, which explain why you made the change,
just say what you did in the patch to fix the problem.

julia

>
> BR//Bernard
>
> >"These changes are to" makes a lot of words with no information.  While it
> >is perhaps not necessary to slavishly follow the rule about using the
> >imperative, if it is convenient to use the imperative, doing so eliminates
> >such meaningless phrases.
> >
> >memleak is also not an English word.  Memory leak is only a few more
> >characters, and doesn't require the reader to make the small extra effort
> >to figure out what you mean.
> >
> >julia
> >
> >>
> >> * Will the tag “Fixes” become helpful for the commit message?
> >>
> >> Regards,
> >> Markus
> >>
>
>
>
--8323329-1370080203-1592652375=:2918--
