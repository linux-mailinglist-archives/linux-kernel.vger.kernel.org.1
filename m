Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B42F2D4FE9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 01:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731332AbgLJAvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 19:51:01 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:52316 "EHLO
        mail.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbgLJAeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 19:34:10 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477:9e51:a893:b0fe:602a])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id 248C34D259C1A;
        Wed,  9 Dec 2020 16:33:26 -0800 (PST)
Date:   Wed, 09 Dec 2020 16:33:25 -0800 (PST)
Message-Id: <20201209.163325.803492801566380865.davem@davemloft.net>
To:     zhengyongjun3@huawei.com
Cc:     kuba@kernel.org, linux-afs@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next] net: mlx5: convert comma to semicolon
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20201209133441.1119-1-zhengyongjun3@huawei.com>
References: <20201209133441.1119-1-zhengyongjun3@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Wed, 09 Dec 2020 16:33:26 -0800 (PST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zheng Yongjun <zhengyongjun3@huawei.com>
Date: Wed, 9 Dec 2020 21:34:41 +0800

> Replace a comma between expression statements by a semicolon.
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

Applied.
