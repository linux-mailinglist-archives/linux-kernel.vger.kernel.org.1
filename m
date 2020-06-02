Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0121EC4E7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 00:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730327AbgFBW2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 18:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730310AbgFBW2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 18:28:46 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E52C08C5C0;
        Tue,  2 Jun 2020 15:28:46 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477:9e51:a893:b0fe:602a])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D84AE1277CC77;
        Tue,  2 Jun 2020 15:28:45 -0700 (PDT)
Date:   Tue, 02 Jun 2020 15:28:45 -0700 (PDT)
Message-Id: <20200602.152845.987253288774299345.davem@davemloft.net>
To:     aishwaryarj100@gmail.com
Cc:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, kuba@kernel.org, mcoquelin.stm32@gmail.com,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: Drop condition with no effect
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200602104405.28851-1-aishwaryarj100@gmail.com>
References: <20200602104405.28851-1-aishwaryarj100@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 02 Jun 2020 15:28:46 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aishwarya Ramakrishnan <aishwaryarj100@gmail.com>
Date: Tue,  2 Jun 2020 16:14:04 +0530

> As the "else if" and "else" branch body are identical the
> condition has no effect. So removing "else if" condition.
> 
> Signed-off-by: Aishwarya Ramakrishnan <aishwaryarj100@gmail.com>

I'm not applying these patches, the conditional tests serve as
documentation.
