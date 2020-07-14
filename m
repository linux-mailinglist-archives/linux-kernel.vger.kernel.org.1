Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89BDA21F16E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 14:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgGNMgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 08:36:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:51576 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbgGNMgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:36:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 13E47AD3A;
        Tue, 14 Jul 2020 12:36:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 49B501E12C9; Tue, 14 Jul 2020 14:36:15 +0200 (CEST)
Date:   Tue, 14 Jul 2020 14:36:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>, jack@suse.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: DISKQUOTA
Message-ID: <20200714123615.GH23073@quack2.suse.cz>
References: <20200708171905.15396-1-grandmaster@al2klimov.de>
 <20200713113044.3af1002c@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713113044.3af1002c@lwn.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 13-07-20 11:30:44, Jonathan Corbet wrote:
> On Wed,  8 Jul 2020 19:19:05 +0200
> "Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:
> 
> >  The interface uses generic netlink framework (see
> > -http://lwn.net/Articles/208755/ and http://people.suug.ch/~tgr/libnl/ for more
> > +https://lwn.net/Articles/208755/ and http://people.suug.ch/~tgr/libnl/ for more
> 
> That other link is 404, no reason to keep it around...

I've already queued a patch that replaces the second link with a working
one...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
