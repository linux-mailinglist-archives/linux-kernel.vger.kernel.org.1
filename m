Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7901F1C53
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 17:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbgFHPmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 11:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730237AbgFHPmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 11:42:53 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6377CC08C5C2;
        Mon,  8 Jun 2020 08:42:53 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CB3A735A;
        Mon,  8 Jun 2020 15:42:52 +0000 (UTC)
Date:   Mon, 8 Jun 2020 09:42:51 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     paulmck@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH] docs/memory-barriers.txt/kokr:
 smp_mb__{before,after}_atomic(): update Documentation
Message-ID: <20200608094251.0606f296@lwn.net>
In-Reply-To: <20200606083746.20869-1-sjpark@amazon.de>
References: <20200606083746.20869-1-sjpark@amazon.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  6 Jun 2020 10:37:46 +0200
SeongJae Park <sj38.park@gmail.com> wrote:

> Translate this commit to Korean:
> 
>   39323c64b8a9 ("smp_mb__{before,after}_atomic(): update Documentation")
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> Reviewed-by: Yunjae Lee <lyj7694@gmail.com>

Applied, thanks.

jon
