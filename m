Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAD621E462
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 02:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgGNAQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 20:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgGNAQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 20:16:44 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504E7C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 17:16:44 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DE28712981644;
        Mon, 13 Jul 2020 17:16:43 -0700 (PDT)
Date:   Mon, 13 Jul 2020 17:16:43 -0700 (PDT)
Message-Id: <20200713.171643.716090096150298542.davem@davemloft.net>
To:     rakeshs.lkm@gmail.com
Cc:     sbhatta@marvell.com, sgoutham@marvell.com, jerinj@marvell.com,
        rsaladi2@marvell.com, kuba@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 0/2] Interrupt handler support for NPA and NIX
 in
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200713122640.4155-1-rakeshs.lkm@gmail.com>
References: <20200713122640.4155-1-rakeshs.lkm@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 13 Jul 2020 17:16:44 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Networking patches must be submitted to netdev@vger.kernel.org in order to
be reviewed and considered.

Thank you.
