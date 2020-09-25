Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2882D279287
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbgIYUpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbgIYUp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:45:26 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B900C0613CE;
        Fri, 25 Sep 2020 13:45:26 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BEB2B13B65D1E;
        Fri, 25 Sep 2020 13:28:37 -0700 (PDT)
Date:   Fri, 25 Sep 2020 13:45:22 -0700 (PDT)
Message-Id: <20200925.134522.130367831393016171.davem@davemloft.net>
To:     mfwitten@gmail.com
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] openprom: Fix 'opiocnextprop'; ensure integer
 conversions; use string size
From:   David Miller <davem@davemloft.net>
In-Reply-To: <859f327c79da4d9c945e50568805456c@gmail.com>
References: <a5515efeaad94666a87f264dbf65bdbd@gmail.com>
        <20200914.170321.1710628974878239639.davem@davemloft.net>
        <859f327c79da4d9c945e50568805456c@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [2620:137:e000::1:9]); Fri, 25 Sep 2020 13:28:37 -0700 (PDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Witten <mfwitten@gmail.com>
Date: Fri, 25 Sep 2020 20:20:20 -0000

> Are we trying to improve the code or not?

Do you want me to apply your patch or not?

I want to see the most minimal code change necessary to fix the bug,
so we can easily backport it to -stable releases etc.

If you want to perform a variable name or other similar cosmetic
improvement, you can send a follow-up patch that does so.

Thank you.
