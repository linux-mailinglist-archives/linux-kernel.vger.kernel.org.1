Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E77204883
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 06:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732348AbgFWEJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 00:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732293AbgFWEJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 00:09:03 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAC3C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 21:09:03 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 799E4120F940C;
        Mon, 22 Jun 2020 21:09:02 -0700 (PDT)
Date:   Mon, 22 Jun 2020 21:09:01 -0700 (PDT)
Message-Id: <20200622.210901.99981901710126146.davem@davemloft.net>
To:     likaige@loongson.cn
Cc:     benve@cisco.com, _govind@gmx.com, yangtiezhu@loongson.cn,
        lixuefeng@loongson.cn, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] net/cisco: Fix a sleep-in-atomic-context bug in
 enic_init_affinity_hint()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1592831473-21280-1-git-send-email-likaige@loongson.cn>
References: <1592831473-21280-1-git-send-email-likaige@loongson.cn>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 22 Jun 2020 21:09:02 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Networking changes must be submitted with netdev@vger.kernel.org

Thank you.
