Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942A726ACC9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 20:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbgIOS7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 14:59:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39432 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727855AbgIORLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 13:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600189870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jdllYgXcaMq/QIGUvVdpzimMac8rDoBkoTtaWK/I/Ck=;
        b=OAObzZfdH0uyHKn/ShnfHiwyzEML5FiZvBX86fNLRzjSvnpH0RuQ9ckyFB6Cfyoh6Tdp62
        ydm+fOmAmKg8K2YD/2yYV0rLi0FEyhSNtVwC3jS++tIBmMgqAN+9Y7zvchL05MDs/b4IMa
        9iPKaVOZJ8AF73XC4dX+zgykrxwnWhI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-v9q4-WVeNcmFMAdkJ8IO9g-1; Tue, 15 Sep 2020 13:02:53 -0400
X-MC-Unique: v9q4-WVeNcmFMAdkJ8IO9g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E538B427FE;
        Tue, 15 Sep 2020 17:02:51 +0000 (UTC)
Received: from treble (ovpn-112-136.rdu2.redhat.com [10.10.112.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E05E319930;
        Tue, 15 Sep 2020 17:02:50 +0000 (UTC)
Date:   Tue, 15 Sep 2020 12:02:48 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>,
        "Li, Philip" <philip.li@intel.com>, x86-ml <x86@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [tip:x86/seves] BUILD SUCCESS WITH WARNING
 e6eb15c9ba3165698488ae5c34920eea20eaa38e
Message-ID: <20200915170248.gcv54pvyckteyhk3@treble>
References: <5f60c4e0.Ru0MTgSE9A7mqhpG%lkp@intel.com>
 <20200915135519.GJ14436@zn.tnic>
 <20200915141816.GC28738@shao2-debian>
 <20200915160554.GN14436@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200915160554.GN14436@zn.tnic>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 06:05:54PM +0200, Borislav Petkov wrote:
> On Tue, Sep 15, 2020 at 10:18:16PM +0800, Rong Chen wrote:
> > On Tue, Sep 15, 2020 at 03:55:19PM +0200, Borislav Petkov wrote:
> > > On Tue, Sep 15, 2020 at 09:42:56PM +0800, kernel test robot wrote:
> > > > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git  x86/seves
> > > > branch HEAD: e6eb15c9ba3165698488ae5c34920eea20eaa38e  KVM: nSVM: Avoid freeing uninitialized pointers in svm_set_nested_state()
> > > > 
> > > > Warning in current branch:
> > > > 
> > > > arch/x86/kernel/sev-es.o: warning: objtool: ist_exc_vmm_communication()+0x12: unreachable instruction
> > > > 
> > > > Warning ids grouped by kconfigs:
> > > > 
> > > > clang_recent_errors
> > > > `-- x86_64-randconfig-r001-20200913
> > > >     `-- arch-x86-kernel-sev-es.o:warning:objtool:ist_exc_vmm_communication():unreachable-instruction
> 
> Ok, I can't trigger this with gcc-9, gcc-10 and clang-10.
> 
> .config below says clang-12 so it could be some experimental
> bug^Wfeature :)
> 
> peterz says this has been fixed by:
> 
> 318af7b80b6a ("Revert "kbuild: use -flive-patching when CONFIG_LIVEPATCH is enabled"")
> 
> but that was reportedly for gcc.
> 
> Lemme Cc the people of interest and leave the rest in here for
> reference. Note that CONFIG_LIVEPATCH is enabled in that .config.

If somebody can share the .o file, I can take a look.

-- 
Josh

