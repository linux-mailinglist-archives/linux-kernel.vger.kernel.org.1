Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3445728250A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 17:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbgJCPSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 11:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgJCPSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 11:18:06 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A502CC0613D0
        for <linux-kernel@vger.kernel.org>; Sat,  3 Oct 2020 08:18:06 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d1so5454715qtr.6
        for <linux-kernel@vger.kernel.org>; Sat, 03 Oct 2020 08:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3lHtCt0w283nQgWH715RcZfWnKuLjRS7WehMmHRVIcc=;
        b=SeyjLBcRIVrZTJZY0KLwWww1RJ6UuD7C6Oipr2TpswR9eN6F0w91vDK8/Zf5l9UwHh
         p6CLCpX08MonfdENPrVnfRSodVoVMuWL4XrlTh32Mw7MGu7hwjD6Frhv0L1cjyjhWvs7
         TMynocz19xnB8BmvBiNAjDw/h17SujylbtkafzKFvbdbgQFf4hH6YeP/S5J5YkPibDjN
         qPo9ezsnE3G+8mTZ80CEkf+K/D9VBj4Z4IP0DsKphS35pEQhNlT0gz881AKdxVdwpMj/
         9HpReSYmCj6af61qFsYDvLQVx+LehXpjJFgdquklLvTHAhXhO2HhpZr09qKCoVTqbF/7
         3EnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=3lHtCt0w283nQgWH715RcZfWnKuLjRS7WehMmHRVIcc=;
        b=melnn932GHzcS9HdQeJ/eovkDiCx3DWCiRtn70X3h0azD0auSbyXVsF29OANJ6Qcs/
         bMqIhMkBsOywy/7qIczJv4Uglfx2AZrWF2sk5VAMD4czBeeHh+j8u4vQMW9fRstpZBKB
         bV2jxcIGbiENePlqVklzBLdImyQHTMkhAJKixPS32lks2swND0VzWMbE7ZGGZaCuiLVj
         +pXpTIjYKWPmec8zob7qRsK0AlA6Ki7hLo5OoFP1py7YQ5eBYP1bSmdgV9q8qWV0U0kY
         /FK+8Vgl6dNh2qI4ewbl4yZGaQxToUbNExRL8G5DaAvMEYLZYgHDJMYMWlxPcfuIoQCL
         ZENg==
X-Gm-Message-State: AOAM530fYaj2l5orsUfdvepzaLGiAohs127iDkLmXkRKljzY+xxxtORK
        VBRpoiqXi65Uwew7AqWJXNA=
X-Google-Smtp-Source: ABdhPJwhfA2iPlKraNgvrPoYKdg94Nd3q96bEw9hZLqZVVT82wLRrGGuVWHNLDzex6SM+jZLCas7qw==
X-Received: by 2002:aed:2e05:: with SMTP id j5mr6820176qtd.94.1601738285790;
        Sat, 03 Oct 2020 08:18:05 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id d12sm3436343qka.34.2020.10.03.08.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 08:18:05 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 3 Oct 2020 11:18:03 -0400
To:     Gabriel C <nix.or.die@googlemail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.9-rc7
Message-ID: <20201003151803.GA614088@rani.riverdale.lan>
References: <CAHk-=wj1SJmva5pQxT-XZkMREOa+iJuy0K8-zua0K=vF-Jz7zw@mail.gmail.com>
 <CAEJqkgiq5ss9S4edHGb5x+YjhODF1HqBW-5qjHA8=AFnhX2tSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEJqkgiq5ss9S4edHGb5x+YjhODF1HqBW-5qjHA8=AFnhX2tSQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 03, 2020 at 04:23:15PM +0200, Gabriel C wrote:
> Am Mo., 28. Sept. 2020 um 00:00 Uhr schrieb Linus Torvalds
> <torvalds@linux-foundation.org>:
> Hello,
> 
> > Shortlog appended, but what I really hope you all will do is to give
> > it a nice good testing. One extra week or rc kernels will help, but
> > only if people actually try this out.
> >
> > So.. Please?
> 
> I'm a bit late testing, but the first thing I noticed is this warning:
> 
> ld: arch/x86/boot/compressed/head_64.o: warning: relocation in
> read-only section `.head.text'
> ld: warning: creating DT_TEXTREL in a PIE
> 
> The compiler is gcc 9.2.1 20200215, with default PIE enabled, ld version 2.35.1.
> The config used is the 64bit defconfig.
> 
> Best Regards,
> 
> Gabriel C.

You can ignore the warning for now, it is harmless: it's always been
there, but binutils-2.35 has enabled the warning by default. There are
patches in tip that should make this go away for v5.10.

Thanks.

https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=blob_plain;f=ld/NEWS;hb=refs/tags/binutils-2_35_1

* Add a configure option, --enable-textrel-check=[no|yes|warning|error],
  to decide what ELF linker should do by default with DT_TEXTREL in an
  executable or shared library.  Default to yes for Linux/x86 targets.
