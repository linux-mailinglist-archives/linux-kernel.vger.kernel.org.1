Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDFF8269A0D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 02:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgIOADY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 20:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgIOADX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 20:03:23 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8E4C06174A;
        Mon, 14 Sep 2020 17:03:23 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C09C0128EC88D;
        Mon, 14 Sep 2020 16:46:35 -0700 (PDT)
Date:   Mon, 14 Sep 2020 17:03:21 -0700 (PDT)
Message-Id: <20200914.170321.1710628974878239639.davem@davemloft.net>
To:     mfwitten@gmail.com
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] openprom: Fix 'opiocnextprop'; ensure integer
 conversions; use string size
From:   David Miller <davem@davemloft.net>
In-Reply-To: <a5515efeaad94666a87f264dbf65bdbd@gmail.com>
References: <a5515efeaad94666a87f264dbf65bdbd@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [2620:137:e000::1:9]); Mon, 14 Sep 2020 16:46:35 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Witten <mfwitten@gmail.com>
Date: Fri, 04 Sep 2020 19:40:00 -0000

> @@ -34,10 +34,10 @@ EXPORT_SYMBOL(of_console_options);
>  int of_getintprop_default(struct device_node *np, const char *name, int def)
>  {
>  	struct property *prop;
> -	int len;
> +	int size;
>  
> -	prop = of_find_property(np, name, &len);
> -	if (!prop || len != 4)
> +	prop = of_find_property(np, name, &size);
> +	if (!prop || size != 4)
>  		return def;

This is just changing the variable name and makes no functional change
at all, and therefore is gratuitous.

Please only include pure functional changes that fix the bug(s) in
question.

If there are multiple bugs, please fix one bug per patch and include a
detailed explanation of each bug fix in the body of the commit
message.

Thank you.
