Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04B02FF5D0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 21:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbhAUU1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 15:27:40 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:38145 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbhAUU1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 15:27:06 -0500
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 10LKPtem002737
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 05:25:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 10LKPtem002737
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1611260755;
        bh=TGDEN9pmSRIy6YUhrB8GBtFyx5S59M8SOxGz9mKZCJc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oyu/OApfFFxwUPoQhTeTm338rceNQHGhaZoKsUN4oB2HZHr+gPcTs2rfTsA9O2DLH
         W5XIPdMgKDQIjQDrH5AQYAyol8dOpFP6FO3Q77OvZ4oCC6ZQvqFPkCu0KGcXAmtVzm
         p4pZ8ZKstYj5Ph/JKq8cYjM2ytZMawIQvTdVc8rPhEy3h5KccDIHaIN04R5wI9OhFE
         3VT0dv3a1khT48oPgKjZQD78N8E9/SvVFOzVUgvR8mrg0/1JkfPepEh5hQaryJGdMp
         TE3evRzHZbqtLEEa70v/9sFUK/lEmZiDIfmYyLpYnDbBFqHJrH1EO0O1jFnDF5Cgmk
         xS1Eaq/+ziHDA==
X-Nifty-SrcIP: [209.85.210.169]
Received: by mail-pf1-f169.google.com with SMTP id i63so2206599pfg.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 12:25:55 -0800 (PST)
X-Gm-Message-State: AOAM532YN4d4ZR+9nI1/WN0Ku4RuDvGDq9APj6fev1abRinVTVpVu9HC
        n6ZoDBp5V8VnZzvTsk89R2cyQbsW7QSDFzZYBcQ=
X-Google-Smtp-Source: ABdhPJzEoPC794gFRdP3Y/3kfJDhpIC/QIqF+xCoFfil8DtQ4mWtISiH649wh228u227PF7Io6+yNZ8Sk4SC9jixxDk=
X-Received: by 2002:a63:575e:: with SMTP id h30mr866105pgm.7.1611260754728;
 Thu, 21 Jan 2021 12:25:54 -0800 (PST)
MIME-Version: 1.0
References: <20210121170736.2266-1-scott.branden@broadcom.com>
In-Reply-To: <20210121170736.2266-1-scott.branden@broadcom.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 22 Jan 2021 05:25:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQEvej1_UrS6s1+vwdei8cK1UW8b5erYc-6Ggu25oC0cg@mail.gmail.com>
Message-ID: <CAK7LNAQEvej1_UrS6s1+vwdei8cK1UW8b5erYc-6Ggu25oC0cg@mail.gmail.com>
Subject: Re: [PATCH] diffconfig: use python3 instead of python in Shebang line
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Finn Behrens <me@kloenk.de>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 2:17 AM Scott Branden
<scott.branden@broadcom.com> wrote:
>
> Use python3 instead of python in diffconfig Shebang line.
> python2 was sunset January 1, 2000 and environments do not need
> to support python any more.
>
> Fixes: b24413180f56 ("tweewide: Fix most Shebang lines")
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  scripts/diffconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/diffconfig b/scripts/diffconfig
> index 627eba5849b5..d5da5fa05d1d 100755
> --- a/scripts/diffconfig
> +++ b/scripts/diffconfig
> @@ -1,4 +1,4 @@
> -#!/usr/bin/env python
> +#!/usr/bin/env python3
>  # SPDX-License-Identifier: GPL-2.0
>  #
>  # diffconfig - a tool to compare .config files.
> --
> 2.17.1
>

Just from curiosity, what problem is this solving?

Is there a distribution where 'python' does not exist,
but 'python3' does ?


-- 
Best Regards
Masahiro Yamada
