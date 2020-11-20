Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB912BB467
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 20:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgKTSw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:52:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:34522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732044AbgKTSw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:52:56 -0500
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05B9D2242B;
        Fri, 20 Nov 2020 18:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605898376;
        bh=ODKIEs6TQROq+/bYka7PP8oDkQdzDlAIZxpdP3CCyOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bgoLiaoE0UsO8WsTGOWjPtVCp5DKeqcqtpKkHZo5Di5aq8eeD3fVXhuvzEl6WXIqp
         4Nv0vgDVVWw/jauOV7b/OajvNdpeEyyaCstPwmq94Vx7lmvTDkt1r7NtJ6zQoVRgZM
         d8zqbYUckUf0w9DSwPapvQmFg0wEDsuwmvJc5IgY=
Date:   Fri, 20 Nov 2020 10:52:54 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] random: initialize ChaCha20 constants with correct
 endianness
Message-ID: <X7gQhvFIuW9W0UyK@sol.localdomain>
References: <20200916045013.142179-1-ebiggers@kernel.org>
 <20200918204207.GC80112@mit.edu>
 <20200918215705.GA126697@gmail.com>
 <20201007035145.GD912@sol.localdomain>
 <20201026163354.GB858@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026163354.GB858@sol.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 09:33:54AM -0700, Eric Biggers wrote:
> On Tue, Oct 06, 2020 at 08:51:45PM -0700, Eric Biggers wrote:
> > On Fri, Sep 18, 2020 at 02:57:05PM -0700, Eric Biggers wrote:
> > > On Fri, Sep 18, 2020 at 04:42:07PM -0400, Theodore Y. Ts'o wrote:
> > 
> > Ted, any further feedback on this?  Are you planning to apply this patch?
> > 
> > - Eric
> 
> Ping.

Ping.
