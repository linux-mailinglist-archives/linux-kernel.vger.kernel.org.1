Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C15E2775A4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 17:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgIXPnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 11:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbgIXPnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 11:43:39 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA66C0613CE;
        Thu, 24 Sep 2020 08:43:38 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3EF72382;
        Thu, 24 Sep 2020 15:43:37 +0000 (UTC)
Date:   Thu, 24 Sep 2020 09:43:35 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] docs: cdomain.py: add support for two new Sphinx
 3.1+ tags
Message-ID: <20200924094335.65944316@lwn.net>
In-Reply-To: <4b8a20013ca0b631724e8a986544ada08ac3dfd7.1600945712.git.mchehab+huawei@kernel.org>
References: <cover.1600945712.git.mchehab+huawei@kernel.org>
        <4b8a20013ca0b631724e8a986544ada08ac3dfd7.1600945712.git.mchehab+huawei@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So I'm just getting into this and trying to understand what's really going
on, but one thing jumped at me:

On Thu, 24 Sep 2020 13:22:04 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> +# Namespace to be prepended to the full name
> +namespace = None
> +
> +#
> +# Handle trivial newer c domain tags that are part of Sphinx 3.1 c domain tags
> +# - Convert :c:expr:`foo` into ``foo``
> +# - Store the namespace if ".. c:namespace::" tag is found
> +
> +RE_namespace = re.compile(r'^\s*..\s*c:namespace::\s*(\S+)\s*$')
> +RE_expr = re.compile(r':c:expr:`([^\`]+)`')
> +
> +def markup_namespace(match):
> +    namespace = match.group(1)
> +
> +    return ""
> +

How can this possibly work without a "global namespace" declaration in
markup_namespace()?

jon
