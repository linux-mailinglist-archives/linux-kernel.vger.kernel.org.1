Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448CB2F79F6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 13:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388370AbhAOMms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 07:42:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:49538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388283AbhAOMmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 07:42:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DD11206CB;
        Fri, 15 Jan 2021 12:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610714522;
        bh=aGrB4k5ATKT6A9t16vBJEcOUKX5Ro/bXYB3+BrVkkFI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GfLPepF66gFALyyae4U0jruw+7mn3PhQOHTxfa2LEgdgG7vRptk5tjtwwifqr0IXB
         7KUw3aQZ8vZybOleEjINEViCmXPV4SOc9d3/jvBhgAVSPHuxQD86m1+iBqQH1qy8LP
         nGwujMcaalZfLXTMg4hLQhpgHXUKVobavNQZCu4E/JgsshbLB1dVoTssnm96DQ7sgW
         9BczYYpWWpbR0YzLfu6gd3ZxC6fbOs/t/CNzzSDFWrHmkscsU4845nyqTQsUt7BLvA
         casVqGN04YhgYWggVkuP2yLMA60Zhdb+YGmCjim1eq67x+XkmI6fyUgj2c8IcHlRDx
         8v3cOC/n5Nzpw==
Date:   Fri, 15 Jan 2021 13:41:57 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 00/10] Fix documentation warnings at linux-next
Message-ID: <20210115134157.54c4956e@coco.lan>
In-Reply-To: <20210115133623.16e19b48@coco.lan>
References: <CAKXUXMziQ2H7_oiVSxbt1=bDFkjLQYOiOgd00YGyDnCTVDhbqA@mail.gmail.com>
        <20210115104947.71d99e87@coco.lan>
        <CAKXUXMxRp4tRbMi4+P6pW4Zom7vZ0hfAWX47+aQ7nunLmyYpUQ@mail.gmail.com>
        <20210115133623.16e19b48@coco.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 15 Jan 2021 13:36:23 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Em Fri, 15 Jan 2021 13:05:56 +0100
> Lukas Bulwahn <lukas.bulwahn@gmail.com> escreveu:
> 
> > On Fri, Jan 15, 2021 at 10:49 AM Mauro Carvalho Chehab
> > <mchehab+huawei@kernel.org> wrote:  
> > >
> > > Hi Lukas,
> > >
> > > Em Fri, 15 Jan 2021 07:12:38 +0100
> > > Lukas Bulwahn <lukas.bulwahn@gmail.com> escreveu:
> > >    
> > > > [reduced the recipient list to the main responsible ones and list]
> > > >
> > > > Hi Mauro, hi Jonathan,
> > > >
> > > > We both, Mauro and I, have been submitting patches to address the
> > > > documentation warnings on linux-next. If it is okay with you, Mauro, I
> > > > would like to take responsibility for the task to send out the patches
> > > > to address all warnings on linux-next in make htmldocs and follow up
> > > > with all the discussions. I can also provide a short weekly summary
> > > > (probably always on Friday) on what is pending where and what I could
> > > > not resolve by myself.
> > > >
> > > > Is that okay for you?
> > > >
> > > > If at some point I do not have the time to take care anymore, I will
> > > > let you know.    
> > >
> > > Yeah, sure!
> > >
> > > Anyway, after applying the patches I sent this week, the warnings
> > > I'm getting are all due to the validation scripts I wrote. So, if
> > > everything gets merged (either yours or my version), we'll have zero
> > > Sphinx/kernel-doc warnings again.
> > >    
> > 
> > It is a never ending story... I already have seen two new warnings on
> > today's linux-next and sent out patches.  
> 
> Yes, I know. After 5.10, it is easier to track new stuff, as
> Sphinx/kernel-doc warnings were all shut up there.
> 
> >   
> > > $ scripts/documentation-file-ref-check
> > > $ scripts/get_abi.pl validate    
> > 
> > I will also try out those two scripts, but I cannot commit to
> > follow-up on all of those yet.   
> 
> Yeah, some of those are not trivial to address.
> 
> FYI, those are called by default after make allmodconfig/allyesconfig.
> 
> > I am also looking into addressing all
> > kerneldoc warnings, even if not pulled in by make htmldocs.  
> 
> Make sense. There are lots of kerneldoc warnings for files that 
> aren't currently part of the docs building system. It makes sense to
> fix those and add them to the Sphinx build logic.
> 
> Here, I have a local script that checks for those:
> 
> 	for i in $(git grep -h "\.\.\s*kernel-doc::" Documentation/|cut -d':' -f 3|grep -vE "\bsource$"|sort|uniq); do
> 		./scripts/kernel-doc --none $i
> 	done
> 
> It reports 101 warnings against next-20210114.

In time: those are for the ones that are included, but that
doesn't have all symbols added. I have another one somewhere
that does a more deeply check. I submitted it as a RFC sometime
ago to the docs ML:

	https://git.linuxtv.org/mchehab/experimental.git/tree/scripts/docs_check_exports?h=doc_export_symbol&id=3f7d1e1b0bcdbe1d95eaa4b256259dfaa08faece

Such script checks only exported symbols.

Thanks,
Mauro
