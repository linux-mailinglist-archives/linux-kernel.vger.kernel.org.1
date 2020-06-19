Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3AC201B22
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 21:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387583AbgFSTUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 15:20:47 -0400
Received: from ms.lwn.net ([45.79.88.28]:55246 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733142AbgFSTUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:20:46 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 886DE23B;
        Fri, 19 Jun 2020 19:20:46 +0000 (UTC)
Date:   Fri, 19 Jun 2020 13:20:45 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Joe Perches <joe@perches.com>
Cc:     linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: Fix most typos
Message-ID: <20200619132045.6120f4eb@lwn.net>
In-Reply-To: <9587fe318ac88299131e751a07bdd1f4b69ae0de.camel@perches.com>
References: <9587fe318ac88299131e751a07bdd1f4b69ae0de.camel@perches.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jun 2020 16:07:32 -0700
Joe Perches <joe@perches.com> wrote:

> These are the typos found in scripts/spelling.txt for
> most of the Documentation/ tree.
> 
> Scripted with:
> 
> $ cat scripts/spelling.txt | \
>   grep -v -P "^\s*\#" | \
>   while read line ; do \
>     from=$(echo $line | cut -f1 -d'|'); \
>     to=$(echo $line | cut -f3 -d'|'); \
>     echo "from: $from to: $to" ; \
>     git grep -w --name-only $from | \
>     xargs sed -i "s/\b$from\b/$to/" ; \
>     git checkout scripts/spelling.txt ; \
>   done
> 
> And some removal of inappropriate conversions
> in Documentation/translations and a few files
> where the conversions were incorrect.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

So this fails badly against current docs-next...any chance of a redo?

Thanks,

jon
