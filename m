Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D3B2473EA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 21:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391895AbgHQTDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 15:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389611AbgHQTC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 15:02:59 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A563C061342
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 12:02:58 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EAA2D154308F6;
        Mon, 17 Aug 2020 11:46:10 -0700 (PDT)
Date:   Mon, 17 Aug 2020 12:02:56 -0700 (PDT)
Message-Id: <20200817.120256.1925874893882136188.davem@davemloft.net>
To:     lee.jones@linaro.org
Cc:     kuba@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/30] Rid W=1 warnings in Networking
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200817092611.GW4354@dell>
References: <20200814113933.1903438-1-lee.jones@linaro.org>
        <20200814.204242.2048284550886688191.davem@davemloft.net>
        <20200817092611.GW4354@dell>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 17 Aug 2020 11:46:11 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 17 Aug 2020 10:26:11 +0100

> Are there any more sub-groups that I need to be aware of, besides
> wireless?  Or can everything else be grouped together?

Netfilter, mac802154, usually the Intel and Mellanox driver
maintainers take things in directly then send pull request to me...

There are probably several other examples.

