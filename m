Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833761E4DDB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 21:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgE0TG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 15:06:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbgE0TG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 15:06:26 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA26B2078C;
        Wed, 27 May 2020 19:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590606385;
        bh=aG2AdqsO+CyEMtyrHhPK09QZxRhGgxhiWdKnLjkZ3co=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=vda/BOl/7s8cKLqRnRSdBNZScYvIpTuDdK/zG0cH/MQl+p6hap9UgqzlB3sU14j7Q
         PhKwh1t6C0GCWdMr5vmR1gNk1KLId9jU+UAxmuXzbd8bEfE3cQsEhuLCUTCfm/jwXv
         SHbVfwauPCXrQfxRtE4pf66Nb1gQ1ZzvZxbpJDvU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1590590362-11570-1-git-send-email-yangtiezhu@loongson.cn>
References: <1590590362-11570-1-git-send-email-yangtiezhu@loongson.cn>
Subject: Re: [PATCH v4 1/2] clk: hisilicon: Use correct return value about hisi_reset_init()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Michael Turquette <mturquette@baylibre.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Date:   Wed, 27 May 2020 12:06:24 -0700
Message-ID: <159060638492.88029.3855641102752089121@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tiezhu Yang (2020-05-27 07:39:21)
> The return value about hisi_reset_init() is not correct, fix it.
>=20
> Fixes: e9a2310fb689 ("reset: hisilicon: fix potential NULL pointer derefe=
rence")

hisi_reset_init() returns NULL on error in that commit. This patch
doesn't make sense.

> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>
