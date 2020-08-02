Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A5D2356BD
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Aug 2020 13:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgHBLvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Aug 2020 07:51:39 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:50772 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgHBLvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 07:51:33 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 16A0E1C0BD4; Sun,  2 Aug 2020 13:51:31 +0200 (CEST)
Date:   Sun, 2 Aug 2020 13:51:24 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        peterz@infradead.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: Should perf version match kernel version?
Message-ID: <20200802115124.GA1044@bug>
References: <20200729155647.xte33krus3mak3wu@altlinux.org>
 <20200729160220.GB2655@hirez.programming.kicks-ass.net>
 <7CEC30D2-0C1E-4E88-A1D2-35C121EB1013@gmail.com>
 <20200729175704.gsbh4gkbqxas5j2t@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729175704.gsbh4gkbqxas5j2t@altlinux.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >We strive to have it all compatible, older perf should work on newer
> > >kernel and newer perf should work on older kernel.
> > >
> > >How well it's all tested is another.
> > >
> > >Personally I often use a very old perf.
> > 
> > Yeah, never was a requirement, if you find some problem using a new perf on an old kernel or the other way around, please report.
> 
> That's great to know. Thanks for the answers!

Someone should tell debian, AFAICT they believe perf version == kernel version is a 
requirement...and so says their manpage.

										Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
