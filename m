Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2076F22B794
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 22:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgGWUWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 16:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgGWUWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:22:43 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4DEC0619DC;
        Thu, 23 Jul 2020 13:22:43 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 60DDA2BA;
        Thu, 23 Jul 2020 20:22:43 +0000 (UTC)
Date:   Thu, 23 Jul 2020 14:22:42 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: watch_queue.rst: fix malformed inline literal
Message-ID: <20200723142242.5fd5760f@lwn.net>
In-Reply-To: <20200718165107.625847-2-dwlsalmeida@gmail.com>
References: <20200718165107.625847-1-dwlsalmeida@gmail.com>
        <20200718165107.625847-2-dwlsalmeida@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jul 2020 13:50:56 -0300
"Daniel W. S. Almeida" <dwlsalmeida@gmail.com> wrote:

>  To manage a watch list, the following functions are provided:
>  
> -  * ``void init_watch_list(struct watch_list *wlist,
> -			   void (*release_watch)(struct watch *wlist));``
> +  * ``void init_watch_list(struct watch_list *wlist, void (*release_watch)(struct watch *wlist));``
>  
>      Initialise a watch list.  If ``release_watch`` is not NULL, then this
>      indicates a function that should be called when the watch_list object is
> @@ -182,9 +181,9 @@ The following functions are provided to manage watches:
>      driver-settable fields in the watch struct must have been set before this
>      is called.
>  
> -  * ``int remove_watch_from_object(struct watch_list *wlist,
> -				   struct watch_queue *wqueue,
> -				   u64 id, false);``
> +  * ``int remove_watch_from_object(struct watch_list *wlist,``
> +				 ``struct watch_queue *wqueue,``
> +				 ``u64 id, false);``

This is very much the wrong fix; please just put the text into a literal
block instead.

Thanks,

jon
