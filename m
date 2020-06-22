Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFCC62043FD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 00:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731625AbgFVWpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 18:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731503AbgFVWo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:44:59 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CEFC061573;
        Mon, 22 Jun 2020 15:44:58 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B0DCE1296C088;
        Mon, 22 Jun 2020 15:44:58 -0700 (PDT)
Date:   Mon, 22 Jun 2020 15:44:58 -0700 (PDT)
Message-Id: <20200622.154458.2067869648476467711.davem@davemloft.net>
To:     clabbe@baylibre.com
Cc:     linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH] sparc: piggyback: handle invalid image
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1591775719-28390-1-git-send-email-clabbe@baylibre.com>
References: <1591775719-28390-1-git-send-email-clabbe@baylibre.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 22 Jun 2020 15:44:58 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corentin Labbe <clabbe@baylibre.com>
Date: Wed, 10 Jun 2020 07:55:19 +0000

> With an old elftoaout, the generation of tftpboot.img fail with "lseek:
> invalid argument".
> This is due to offset being negative.
> 
> Instead of printing this error message, let's print a better one.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Applied, thank you.
