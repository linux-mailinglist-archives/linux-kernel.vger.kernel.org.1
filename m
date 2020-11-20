Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3F42B9FDB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 02:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgKTBi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 20:38:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:39092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbgKTBiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 20:38:25 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D7FE22254;
        Fri, 20 Nov 2020 01:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1605836303;
        bh=fI3OFn4/MPzQQUhoSEfmcQ0XlREd/wkMaiDhT1k1Vo8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tjjAOYbdQif6viMS1sxE8BL5CSogvVVgKKG9WbdvRTgHogC1nsVyfEE42+80VAYun
         ro0RumyMDgmt489QPnBCo2cz3YWasKzdxaowC0CbuGfvckw+7VA4i6AVK5CRV+EReg
         AowOV9RRK74+8uDtYU3Kw5KAsrBirpZFOmxieUCM=
Date:   Thu, 19 Nov 2020 17:38:22 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     laniel_francis@privacyrequired.com
Cc:     linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dja@axtens.net,
        keescook@chromium.org, Daniel Micay <danielmicay@gmail.com>
Subject: Re: [PATCH v6 1/5] string.h: detect intra-object overflow in
 fortified string functions
Message-Id: <20201119173822.779c253bd946f7da30155cc8@linux-foundation.org>
In-Reply-To: <20201119164915.10618-2-laniel_francis@privacyrequired.com>
References: <20201119164915.10618-1-laniel_francis@privacyrequired.com>
        <20201119164915.10618-2-laniel_francis@privacyrequired.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Nov 2020 17:49:11 +0100 laniel_francis@privacyrequired.com wrote:

> From: Daniel Axtens <dja@axtens.net>
> 
> ...
> 
> Cc: Daniel Micay <danielmicay@gmail.com>
> Cc: Kees Cook <keescook@chromium.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Daniel Axtens <dja@axtens.net>

This patch should have your signoff as well, as per
Documentation/process/submitting-patches.rst "Developer's Certificate
of Origin 1.1".

I think it would be best to send out a v7 to address this and the cover
letter issue, please.

