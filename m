Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD242023EF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jun 2020 15:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgFTNVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Jun 2020 09:21:47 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:25008 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728064AbgFTNVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 09:21:46 -0400
X-IronPort-AV: E=Sophos;i="5.75,258,1589234400"; 
   d="scan'208";a="455762553"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2020 15:21:43 +0200
Date:   Sat, 20 Jun 2020 15:21:43 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Bernard Zhao <bernard@vivo.com>, opensource.kernel@vivo.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?ISO-8859-15?Q?Felix_K=FChling?= <Felix.Kuehling@amd.com>,
        =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v3] drm/amd: Fix memory leak according to error branch
In-Reply-To: <119b7d8c-b164-ef23-84cc-4904d34ac023@web.de>
Message-ID: <alpine.DEB.2.22.394.2006201520590.2918@hadrien>
References: <119b7d8c-b164-ef23-84cc-4904d34ac023@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1522092164-1592659303=:2918"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1522092164-1592659303=:2918
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sat, 20 Jun 2020, Markus Elfring wrote:

> > The function kobject_init_and_add alloc memory like:
> > kobject_init_and_add->kobject_add_varg->kobject_set_name_vargs
> > ->kvasprintf_const->kstrdup_const->kstrdup->kmalloc_track_caller
> > ->kmalloc_slab, in err branch this memory not free. If use
> > kmemleak, this path maybe catched.
> > These changes are to add kobject_put in kobject_init_and_add
> > failed branch, fix potential memleak.
> …
> > Changes since V2:
> > *remove duplicate kobject_put in kfd_procfs_init.
>
> Under which circumstances are going to improve this change description accordingly?

Bernard, please update the log message as well.  The mail you sent was
much more clear, but mail just gets lost over time.  The log message
itself should be improved.

julia

>
> Would you like to add the tag “Fixes” to the commit message?
>
> Regards,
> Markus
>
--8323329-1522092164-1592659303=:2918--
