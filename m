Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0124218F88
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 20:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgGHSOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 14:14:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgGHSOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 14:14:07 -0400
Received: from embeddedor (unknown [201.162.240.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4BD520760;
        Wed,  8 Jul 2020 18:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594232046;
        bh=7dXnrSdNo3mR2eRfQtUcUioXGNY6rLTR4PxhcaEmK5M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aCsfligRbF9gZkPNMIuA7cziVFU6a8zmaBDG+cTssZHTjd1Pxy8nVavtCMeiwfuw/
         AJUcIKVfudJMSOxkElKxRa+rGzYbozvUmmaNbGMPbopLfWOintVMFG2rhld0ra8ZGz
         UlIm3dF/CLOq6FsOeI7F0Nt4KKbGxRn8QjNLj7xw=
Date:   Wed, 8 Jul 2020 13:19:35 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Ben Skeggs <skeggsb@gmail.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH][next] drm/nouveau: Use fallthrough pseudo-keyword
Message-ID: <20200708181935.GE11533@embeddedor>
References: <20200707173628.GA29695@embeddedor>
 <CACAvsv4ahps=4gWwGXwvHFZOTBg1ubW86t3++dN4fAJ6JsBhDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACAvsv4ahps=4gWwGXwvHFZOTBg1ubW86t3++dN4fAJ6JsBhDw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 01:22:35PM +1000, Ben Skeggs wrote:
> On Wed, 8 Jul 2020 at 03:31, Gustavo A. R. Silva <gustavoars@kernel.org> wrote:
> >
> > Replace the existing /* fall through */ comments and its variants with
> > the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
> > fall-through markings when it is the case.
> I really like this!  I was not a fan of explicitly marking those with comments.
> 

:)

> Thank you, taken in my tree.

Thanks, Ben.
--
Gustavo
