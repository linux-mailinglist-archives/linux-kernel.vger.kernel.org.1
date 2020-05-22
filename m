Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960371DEE2B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 May 2020 19:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730700AbgEVRZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 May 2020 13:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730554AbgEVRZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 13:25:35 -0400
Received: from hera.aquilenet.fr (hera.aquilenet.fr [IPv6:2a0c:e300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3D6C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 10:25:35 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 9D2733BA9;
        Fri, 22 May 2020 19:25:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id f7N5Eo55GPMW; Fri, 22 May 2020 19:25:32 +0200 (CEST)
Received: from function (lfbn-bor-1-797-11.w86-234.abo.wanadoo.fr [86.234.239.11])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 6214F3B89;
        Fri, 22 May 2020 19:25:32 +0200 (CEST)
Received: from samy by function with local (Exim 4.93)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1jcBQJ-00HAVN-9Y; Fri, 22 May 2020 19:25:31 +0200
Date:   Fri, 22 May 2020 19:25:31 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Joe Perches <joe@perches.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        MugilRaj <dmugil2000@gmail.com>, devel@driverdev.osuosl.org,
        Kirk Reiser <kirk@reisers.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, linux-kernel@vger.kernel.org,
        Chris Brannon <chris@the-brannons.com>
Subject: Re: [PATCH] taging: speakup: remove volatile
Message-ID: <20200522172531.va2hi6jqog3a6473@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Joe Perches <joe@perches.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        MugilRaj <dmugil2000@gmail.com>, devel@driverdev.osuosl.org,
        Kirk Reiser <kirk@reisers.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, linux-kernel@vger.kernel.org,
        Chris Brannon <chris@the-brannons.com>
References: <1590138989-6091-1-git-send-email-dmugil2000@gmail.com>
 <20200522103406.GK30374@kadam>
 <6ab4139ec78928961a19e5fdbda139bb8cff9cb5.camel@perches.com>
 <20200522171312.s2ciifuxozwav2ym@function>
 <162676bb69044efadd31daa9ea49fc6fb9664297.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162676bb69044efadd31daa9ea49fc6fb9664297.camel@perches.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches, le ven. 22 mai 2020 10:22:03 -0700, a ecrit:
> > Put another way: I don't think putting any hint here would help, on the
> > contrary, somebody has to really look at what protection is needed,
> > without getting influenced by rules-of-thumb.
> 
> checkpatch newbies/robots will submit this change again otherwise.

Ah, ok, right.

I don't think removing volatiles is a thing for newbies, 

> Comment wording can always be improved.

I'd then suggest

/* TODO: determine what proper synchronization "volatile" should be
 * replaced with.  */

Samuel
