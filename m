Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65042A074A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgJ3OA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgJ3OA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:00:57 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCD4C0613CF;
        Fri, 30 Oct 2020 07:00:57 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 434942DC;
        Fri, 30 Oct 2020 14:00:57 +0000 (UTC)
Date:   Fri, 30 Oct 2020 08:00:56 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     "=?UTF-8?B?TsOtY29sYXM=?= F. R. A. Prado" <nfraprado@protonmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org, andrealmeid@collabora.com
Subject: Re: [PATCH v2 1/5] docs: automarkup.py: Use new C roles in Sphinx 3
Message-ID: <20201030080056.6cd9d1f8@lwn.net>
In-Reply-To: <5053e824-625b-5a76-d862-2c855c79c427@collabora.com>
References: <20201013231218.2750109-1-nfraprado@protonmail.com>
        <20201013231218.2750109-2-nfraprado@protonmail.com>
        <5053e824-625b-5a76-d862-2c855c79c427@collabora.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Oct 2020 14:33:52 +0100
Dafna Hirschfeld <dafna.hirschfeld@collabora.com> wrote:

> > +RE_struct = re.compile(r'\b(struct)\s+([a-zA-Z_]\w+)', flags=re.ASCII)
> > +RE_union = re.compile(r'\b(union)\s+([a-zA-Z_]\w+)', flags=re.ASCII)
> > +RE_enum = re.compile(r'\b(enum)\s+([a-zA-Z_]\w+)', flags=re.ASCII)
> > +RE_typedef = re.compile(r'\b(typedef)\s+([a-zA-Z_]\w+)', flags=re.ASCII)  
> 
> I use ubuntu 18.04, my default python is 2.7,
> when running 'make htmldocs' with that fix I get:
> 
> AttributeError: 'module' object has no attribute 'ASCII'

Argh...it seems that re.ASCII is Python3 only.

For the short term, I guess we'll need to hack in some sort of workaround.
The not-so-long-term intent, though, is to leave Python 2 behind.

Thanks for the report,

jon
