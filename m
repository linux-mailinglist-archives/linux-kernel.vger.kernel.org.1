Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5C8275818
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 14:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgIWMkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 08:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgIWMkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 08:40:16 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B22C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 05:40:16 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4BxHnp47KZzQlWZ;
        Wed, 23 Sep 2020 14:40:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id pP0aVxH-6YZz; Wed, 23 Sep 2020 14:40:11 +0200 (CEST)
Date:   Wed, 23 Sep 2020 14:40:10 +0200 (CEST)
From:   Hagen Paul Pfeifer <hagen@jauu.net>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Message-ID: <137056436.64108.1600864811088@office.mailbox.org>
In-Reply-To: <20200923123155.GA2516911@kernel.org>
References: <20200921201928.799498-2-hagen@jauu.net>
 <20200922200922.1306034-1-hagen@jauu.net>
 <20200923123155.GA2516911@kernel.org>
Subject: Re: [PATCH v2] perf script: add min, max to futex-contention
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.61 / 15.00 / 15.00
X-Rspamd-Queue-Id: 961F617E7
X-Rspamd-UID: 2483d5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 09/23/2020 2:31 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> Didn't apply here, I did it by hand, please check, probably some
> indentation artifact.

Probably you missed patch one of the patchset - the autopep8 formatting
one for the lock contention script?

> Thanks for the patch!

You are welcome Arnaldo!

Hagen
