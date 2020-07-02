Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC8B211704
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 02:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgGBAIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 20:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbgGBAIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 20:08:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99E3C08C5C1;
        Wed,  1 Jul 2020 17:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=itjXWeaWl+zoa6+Nj8NLNZzan7LY+vRjjEzZZHqOrYM=; b=Fp6Gy8ho+HdQ37oJzO5GcfbzPO
        tK7QdXC2EBz0292qLZmdskbeO1Ty2g01IgVzQaLZSMeC8zx6+wd05QSflw931WXEz+uBRdKrz35IN
        IicFK8/euW9rhv7Ovj3mtRuWyt4BD7/IM2R3BP/T8Nz3h2zIawgGeOe4JtvUCHPzx29QaYKwaq/XX
        8kjuMV+rOVgU0y1f61KhO+bdl6b1/4Bz4REU9kgTDSkgYJMrZC3hQka5RO3Py3fp76wMtbcVA0Rxm
        /I1VJq+tympjYY42JqiQF8Qya5gs1ovHHHFMoCNpO6SN82JEz61cXSd5JFTthuOZ0Q1nMgcJC6ctO
        i0HwZD/Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqmmR-0003Uc-22; Thu, 02 Jul 2020 00:08:43 +0000
Date:   Thu, 2 Jul 2020 01:08:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Markus Elfring <Markus.Elfring@web.de>, linux-doc@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Julia Lawall <julia.lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [v2] Documentation: Coccinelle: fix typos and command example
Message-ID: <20200702000843.GV25523@casper.infradead.org>
References: <0616dd0c-bb86-be2b-3dc6-1c695a92c3ca@infradead.org>
 <c2c1dec0-2bd1-b0e2-1aa4-38d0e954d5ba@web.de>
 <efc8b0c9-db3b-3c9c-d876-897b53a9e278@infradead.org>
 <2a3940de-6a81-1aff-8109-53c1c5a6aa1b@web.de>
 <f2aaa91a-f935-bc2d-26f2-712576c1bbd7@infradead.org>
 <2f80fb10-dc7f-29be-dc3e-2715f8bafc6d@web.de>
 <dfa2ed9f-fe68-58d1-c3d0-ac436f9bee09@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfa2ed9f-fe68-58d1-c3d0-ac436f9bee09@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 07:52:58AM -0700, Randy Dunlap wrote:
> On 7/1/20 6:32 AM, Markus Elfring wrote:
> >>> How do you think about to use the following command variant
> >>> for the adjustment of the software documentation?
> >>>
> >>> +    make C=1 CHECK='scripts/coccicheck' 'path/to/file.o'
> >>
> >> I don't understand the reason for that change...
> 
> IOW, your "patch" needs justification and/or explanation. It was missing that info.

What Markus is trying so completely ineptly to say is that
  make C=1 CHECK=scripts/coccicheck path/to/file.c
doesn't work.  You need to use the .o suffix to check the .c file.

