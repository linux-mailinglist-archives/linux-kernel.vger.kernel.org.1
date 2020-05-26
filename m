Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F5E1C0917
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 23:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgD3VXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 17:23:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:40378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbgD3VXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:23:12 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 302412166E;
        Thu, 30 Apr 2020 21:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588281792;
        bh=64VkPdoiN0OePS1AJNJImnN0TBSj5RZkl5WHr7pH2zc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QAitjNdyFZAKZsl9w/HSamjjGQ43tPG20k8YV2BhA6BAzLoL8vXNaWoF9UMgfQlOl
         pz18SKiCyaRhywDfyy1jCV0/LK15E/q4uBqFP8Tx1y3f51UjeysrNXGr/bRGdaLgLN
         gix2QWqIln1sTlUAN7qwXwkBNh3ycqNJqvImuaK4=
Date:   Thu, 30 Apr 2020 14:23:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/gup.c: Handle error at earliest for incorrect
 nr_pages value
Message-Id: <20200430142311.091b82235141ca47b9c6475a@linux-foundation.org>
In-Reply-To: <1588277518-21425-1-git-send-email-jrdr.linux@gmail.com>
References: <1588277518-21425-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 May 2020 01:41:58 +0530 Souptick Joarder <jrdr.linux@gmail.com> wrote:

> As per documentation, pin_user_pages_fast() & get_user_pages_fast()
> will return 0, if nr_pages <= 0. But this can be figure out only after
> going inside the internal_get_user_pages_fast().
> 
> This can be handled early. Adding a check for the same.

Calling get_user_pages() for (nrpages <= 0) is a nonsensical thing to
do so it isn't a thing we should care to optimize.  Adding new checks
will actually slow down the use cases which we *do* care about.  And it
adds more code.

