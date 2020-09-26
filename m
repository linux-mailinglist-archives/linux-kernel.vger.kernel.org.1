Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39672279C50
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 22:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgIZUPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 16:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgIZUPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 16:15:54 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEE7C0613CE;
        Sat, 26 Sep 2020 13:15:54 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 47DB1378;
        Sat, 26 Sep 2020 20:15:51 +0000 (UTC)
Date:   Sat, 26 Sep 2020 14:15:47 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Bailu Lin <bailu.lin@vivo.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Harry Wei <harryxiyou@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@vivo.com
Subject: Re: [PATCH] Documentation: Chinese translation of
 Documentation/arm64/perf.rst
Message-ID: <20200926141547.0ef26bdb@lwn.net>
In-Reply-To: <747aff97-8b24-5ac2-e46a-fe34b398deb6@linux.alibaba.com>
References: <20200926102242.3652-1-bailu.lin@vivo.com>
        <747aff97-8b24-5ac2-e46a-fe34b398deb6@linux.alibaba.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Sep 2020 22:35:51 +0800
Alex Shi <alex.shi@linux.alibaba.com> wrote:

> Why your patch repeatly has encoding issue which fails on 'git am'
> Could you like to check the problem before send out?
> Could you please fix your editor issue by Documentation/process/email-clients.rst
> or send patch by git send-email.
> 
> And please don't waste other time on meaningless issue again!

The way to be sure you have solved this kind of problem is to first email
the patch to you, then be sure that what you receive can be applied.
Please get to the point where that works, then I'll be glad to apply your
translations.

Thanks,

jon
