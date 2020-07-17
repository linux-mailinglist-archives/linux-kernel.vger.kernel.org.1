Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6A7224498
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 21:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgGQTu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 15:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgGQTu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 15:50:29 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09671C0619D2;
        Fri, 17 Jul 2020 12:50:29 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 28211728;
        Fri, 17 Jul 2020 19:50:28 +0000 (UTC)
Date:   Fri, 17 Jul 2020 13:50:27 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>, mchehab@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/25] Documentation: watch_queue.rst: fix sphinx
 warnings
Message-ID: <20200717135027.15d8bdb4@lwn.net>
In-Reply-To: <cf5f2227-c473-442b-7ad4-5ca3718a6672@infradead.org>
References: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
        <20200717185624.2009393-13-dwlsalmeida@gmail.com>
        <cf5f2227-c473-442b-7ad4-5ca3718a6672@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jul 2020 12:42:52 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> > -  * ``int remove_watch_from_object(struct watch_list *wlist,
> > -				   struct watch_queue *wqueue,
> > -				   u64 id, false);``
> > +  * ``int remove_watch_from_object(struct watch_list *wlist,``
> > +				 ``struct watch_queue *wqueue,``
> > +				 ``u64 id, false);``
> >  
> >      Remove a watch from a watch list, where the watch must match the specified
> >      watch queue (``wqueue``) and object identifier (``id``).  A notification
> >   
> 
> Wow. If that's what it takes, well, OK, but it's sad IMHO.

It seems like it might be better to remove the quoting altogether?  Either
that or just make a literal block.

jon
