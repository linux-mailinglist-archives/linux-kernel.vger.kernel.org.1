Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5932277696
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 18:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgIXQW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 12:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgIXQW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:22:29 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118DDC0613CE;
        Thu, 24 Sep 2020 09:22:29 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D281F2CB;
        Thu, 24 Sep 2020 16:22:27 +0000 (UTC)
Date:   Thu, 24 Sep 2020 10:22:25 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] docs: cdomain.py: add support for two new Sphinx
 3.1+ tags
Message-ID: <20200924102225.46fbfafd@lwn.net>
In-Reply-To: <20200924181354.59087a8d@coco.lan>
References: <cover.1600945712.git.mchehab+huawei@kernel.org>
        <4b8a20013ca0b631724e8a986544ada08ac3dfd7.1600945712.git.mchehab+huawei@kernel.org>
        <20200924094335.65944316@lwn.net>
        <20200924181354.59087a8d@coco.lan>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Sep 2020 18:13:54 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> > How can this possibly work without a "global namespace" declaration in
> > markup_namespace()?  
> 
> ... While I'm not a python expert, the namespace variable is global
>     because it was defined outside the "markup_namespace" function.

Assignments within functions are *always* local unless declared global.

Try this:

	$ python3
	>>> x = 0
	>>> def y(v):
	>>>	x = v
	>>>
	>>> y(1)
	>>> x
	0
	>>>

So your assignment to "namespace" in markup_namespace() cannot change the
global, since it's not declared global.

jon
