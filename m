Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC6F267D33
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 03:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgIMBxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 21:53:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbgIMBxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 21:53:36 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99C4321531;
        Sun, 13 Sep 2020 01:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599962016;
        bh=PjzXmyqEyFGs8XGac/zgQoQUD6983Hpweji7OwjCbP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Icud5A+iF5RdDwBJKEM0ktSZ44SHbdB63LIZKphjdpBfBUz65bcqV5vffTkYfzATh
         69PLzDJ7DLLAHc2mkavz5iblQFVkmC8ZK2A/3sVOd1m9EEr8O0Km6W3NfHQQRcwonr
         XNO0caj7Joyu8J90+Gc2KJHjrtlzfF9PaRHZXxsg=
Date:   Sun, 13 Sep 2020 09:53:30 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Wasim Khan <wasim.khan@oss.nxp.com>
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, V.sethi@nxp.com,
        Wasim Khan <wasim.khan@nxp.com>
Subject: Re: [PATCH 0/6] arch: arm64: Add label to pcie nodes
Message-ID: <20200913015330.GG25109@dragon>
References: <1599659076-28121-1-git-send-email-wasim.khan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599659076-28121-1-git-send-email-wasim.khan@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 07:14:30PM +0530, Wasim Khan wrote:
> From: Wasim Khan <wasim.khan@nxp.com>
> 
> This patch series adds label to pcie nodes
> so that they are easy to refer.
> 
> Wasim Khan (6):
>   arm64: dts: lx2160a: Add label to pcie nodes
>   arm64: dts: ls1012a: Add label to pcie nodes
>   arm64: dts: ls1043a: Add label to pcie nodes
>   arm64: dts: ls1046a: Add label to pcie nodes
>   arm64: dts: ls1028a: Add label to pcie nodes
>   arm64: dts: ls1088a: Add label to pcie nodes

Please squash them into one patch.

Shawn
