Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36AA71E51FF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 01:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgE0Xyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 19:54:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:57812 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbgE0Xyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 19:54:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 32A3AAC11;
        Wed, 27 May 2020 23:54:54 +0000 (UTC)
Date:   Thu, 28 May 2020 01:54:42 +0200
From:   Borislav Petkov <bp@suse.de>
To:     kbuild test robot <lkp@intel.com>
Cc:     Marco Elver <elver@google.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [tip:locking/kcsan 12/12] /bin/bash: line 1: 61526 Segmentation
 fault  sparse ...
Message-ID: <20200527235442.GC1805@zn.tnic>
References: <202005280727.lXn1VnTw%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202005280727.lXn1VnTw%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 07:39:31AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/kcsan
> head:   a5dead405f6be1fb80555bdcb77c406bf133fdc8
> commit: a5dead405f6be1fb80555bdcb77c406bf133fdc8 [12/12] compiler_types.h: Optimize __unqual_scalar_typeof compilation time
> config: i386-randconfig-s002-20200527 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-13) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.1-240-gf0fe1cd9-dirty
>         git checkout a5dead405f6be1fb80555bdcb77c406bf133fdc8
>         # save the attached .config to linux build tree
>         make W=1 C=1 ARCH=i386 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):

I'll say.

Looking at the subject, that broke the 0day bot too. :-)

/me trims it.

Looks like we need __CHECKER__ ifdeffery somewhere but it is too late
for me to think straight so tomorrow...

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
