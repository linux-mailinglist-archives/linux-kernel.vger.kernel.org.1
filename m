Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE43300A01
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 18:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbhAVRmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 12:42:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:51218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729850AbhAVReC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 12:34:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E19B23A79;
        Fri, 22 Jan 2021 17:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611336801;
        bh=Zz7/sBdhG8IGiogtBKk0mTY8NegdDfBFJuOqnDNcMLA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RuJ+Df5lfmrPNDJ51PkcEYxRr+jpqXQweQhIQPESSUJFK0m1FLcTJcs5Q7UA7sZnF
         XK3A8YbaQIIAYHnH3igiGNR77G9IqJFjs1mARPv4qLPjSPXGN0QolPVyxGJ9WEv/u8
         Y/d9zwQtM+OKDg0GvUpb52T12cai/I+pyL/1NLce+tvUsGWlHPv+pPWCFpbhhgjqFO
         CAfQgtPaeed/fEFusGweDk+j3JPGtmdm5Vma2BXVOFOV0KOg+EZDAu3aDH14bf9Lqz
         zBMx1SGbfXMLA13aAyZqRImtyFqsubrdcHxpfC3+eBRet3kWN+UrTzHxNAzq14f1cD
         MpQYrozyRdepQ==
Date:   Fri, 22 Jan 2021 09:33:20 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Cc:     roopa@nvidia.com, nikolay@nvidia.com, davem@davemloft.net,
        natechancellor@gmail.com, ndesaulniers@google.com,
        bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] bridge: Use PTR_ERR_OR_ZERO instead if(IS_ERR(...)) +
 PTR_ERR
Message-ID: <20210122093320.6fbb5f11@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <1611307933-115887-1-git-send-email-abaci-bugfix@linux.alibaba.com>
References: <1611307933-115887-1-git-send-email-abaci-bugfix@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jan 2021 17:32:13 +0800 Jiapeng Zhong wrote:
> coccicheck suggested using PTR_ERR_OR_ZERO() and looking at the code.
> 
> Fix the following coccicheck warnings:
> 
> ./net/bridge/br_multicast.c:1295:7-13: WARNING: PTR_ERR_OR_ZERO can be
> used.
> 
> Reported-by: Abaci <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>

You need to CC netdev
