Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB06F1D53B2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 17:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgEOPKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 11:10:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:49870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728277AbgEOPKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 11:10:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF73D2076A;
        Fri, 15 May 2020 15:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589555438;
        bh=D6LeDgR+1gAiJOELm9U6DKJLT5pJy4kJssGSOYAl/ZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OrdCAO3haSRFPg/DselJskuyxT7YzART3RxKIHm9SZTu8m+rNgkkeWRnN7Y2vA1vZ
         my9m9UpCM70NcvXYmC9TZtBCgwdsB+zPrSMxJLk6AvQCAzYOrMM78PmE8SnqxWdnzY
         OkejeiCks5W/3NKDWg7DVRk36zecA5zBXvum5grs=
Date:   Fri, 15 May 2020 17:10:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        kernel test robot <rong.a.chen@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] kobject: Make sure the parent does not get released
 before its children
Message-ID: <20200515151036.GA2574646@kroah.com>
References: <20200513151840.36400-1-heikki.krogerus@linux.intel.com>
 <CAFd5g44d+VCSimjboPkf-NF1eCdbq6Uy+pabNftB8p5Lj2yc1A@mail.gmail.com>
 <e51d4ce4-42ba-8c89-21b4-082c7158a9a9@infradead.org>
 <20200514065415.GA1511@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514065415.GA1511@kuha.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 09:54:15AM +0300, Heikki Krogerus wrote:
> On Wed, May 13, 2020 at 04:14:51PM -0700, Randy Dunlap wrote:
> > On 5/13/20 2:30 PM, Brendan Higgins wrote:
> > > On Wed, May 13, 2020 at 8:18 AM Heikki Krogerus
> > > <heikki.krogerus@linux.intel.com> wrote:
> > >>
> > >> In the function kobject_cleanup(), kobject_del(kobj) is
> > >> called before the kobj->release(). That makes it possible to
> > >> release the parent of the kobject before the kobject itself.
> > >>
> > >> To fix that, adding function __kboject_del() that does
> > >> everything that kobject_del() does except release the parent
> > >> reference. kobject_cleanup() then calls __kobject_del()
> > >> instead of kobject_del(), and separately decrements the
> > >> reference count of the parent kobject after kobj->release()
> > >> has been called.
> > >>
> > >> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > >> Reported-by: kernel test robot <rong.a.chen@intel.com>
> > >> Fixes: 7589238a8cf3 ("Revert "software node: Simplify software_node_release() function"")
> > >> Cc: Brendan Higgins <brendanhiggins@google.com>
> > >> Cc: Randy Dunlap <rdunlap@infradead.org>
> > >> Suggested-by: "Rafael J. Wysocki" <rafael@kernel.org>
> > >> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > 
> > > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> > > Tested-by: Brendan Higgins <brendanhiggins@google.com>
> > > 
> > 
> > Acked-by: Randy Dunlap <rdunlap@infradead.org>
> > Tested-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thanks guys. Sorry about the mix-up.

I didn't get the chance to review this today, will do so on Monday,
thanks.

greg k-h
